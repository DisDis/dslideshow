import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/config/domain/effect_settings_validation.dart';
import 'package:config_app/features/config/presentation/sessions/asset_photo_slide_session.dart';
import 'package:config_app/features/config/presentation/sessions/preview_photo.dart';
import 'package:config_app/features/config/presentation/sessions/preview_transition.dart';
import 'package:config_app/features/config/presentation/wigdgets/effect_label.dart';
import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/slide_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

enum _PreviewPhase { idle, preparing, transitioning, failed }

class SlideshowPreview extends StatefulWidget {
  final SlideShowConfig config;
  final Effect? selectedEffect;

  const SlideshowPreview({
    super.key,
    required this.config,
    this.selectedEffect,
  });

  @override
  State<SlideshowPreview> createState() => SlideshowPreviewState();
}

class SlideshowPreviewState extends State<SlideshowPreview>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  static final _log = Logger('SlideshowPreview');
  static const _emptyInput = EffectSlideInput(
    view: ColoredBox(color: Colors.black),
  );

  late final FixedAnimationController _controller;
  Timer? _hold;
  Timer? _updateDebounce;
  Effect currentEffect = Effect.fadeEffect;
  AssetPhotoSlideSession? _current, _next;
  final _retired = <SlideSession>{};
  PreviewTransition? _transition;
  PreviewPhotoPair? _repeatPair;
  _PreviewPhase _phase = _PreviewPhase.idle;
  late String _configSignature;
  bool _active = false, _routeActive = true, _resumed = true, _paused = false;
  int _index = 0, _generation = 0;
  PreviewAspectRatio _aspect = PreviewAspectRatio.frame;

  Size get _deviceSize => Size(2560, 2560 / _aspect.ratio);
  Duration get _transitionTime => Duration(
    milliseconds:
        (currentEffect.options.durationMs == 0
                ? widget.config.effects.safeDefaultDurationMs
                : currentEffect.options.durationMs)
            .clamp(1, 3600000),
  );
  Duration get _displayTime =>
      Duration(milliseconds: widget.config.displayTimeMs.clamp(1, 3600000));

  @override
  void initState() {
    super.initState();
    currentEffect = widget.selectedEffect?.canonical ?? currentEffect;
    _configSignature = jsonEncode(widget.config.toJson());
    _controller = FixedAnimationController(
      vsync: this,
      duration: _transitionTime,
      animationBehavior: AnimationBehavior.preserve,
    )..addStatusListener(_onStatus);
    WidgetsBinding.instance.addObserver(this);
    _resumed =
        WidgetsBinding.instance.lifecycleState == null ||
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeActive = TickerMode.valuesOf(context).enabled;
    _syncActivity();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _resumed = state == AppLifecycleState.resumed;
    _syncActivity();
  }

  void _syncActivity() {
    final next = _resumed && _routeActive;
    if (next == _active) return;
    _active = next;
    if (!next) {
      _cancelPending();
      final previous = _current;
      setState(() {
        _current = null;
        _repeatPair = null;
      });
      if (previous != null) _retire(previous);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _active && !_paused) unawaited(_loadNext());
      });
    }
  }

  @override
  void didUpdateWidget(covariant SlideshowPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentEffect = widget.selectedEffect?.canonical ?? currentEffect;
    final signature = jsonEncode(widget.config.toJson());
    if (signature != _configSignature ||
        oldWidget.selectedEffect != widget.selectedEffect) {
      _configSignature = signature;
      _updateDebounce?.cancel();
      _updateDebounce = Timer(const Duration(milliseconds: 150), () {
        if (mounted && _active && !_paused) unawaited(_loadNext());
      });
    }
  }

  void _release(SlideSession session) {
    unawaited(
      session.dispose().catchError((Object error, StackTrace stack) {
        _log.warning('Preview slide disposal failed', error, stack);
      }),
    );
  }

  void _retire(SlideSession session) {
    session.setActivity(
      role: SlideSessionRole.outgoing,
      playing: false,
      screenOn: _active,
    );
    _retired.add(session);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_retired.remove(session)) _release(session);
    });
  }

  void _updateActivity() {
    _current?.setActivity(
      role: _phase == _PreviewPhase.transitioning
          ? SlideSessionRole.outgoing
          : SlideSessionRole.current,
      playing: _active && !_paused && _phase != _PreviewPhase.preparing,
      screenOn: _active,
    );
    _next?.setActivity(
      role: _phase == _PreviewPhase.transitioning
          ? SlideSessionRole.incoming
          : SlideSessionRole.pending,
      playing: _active && !_paused,
      screenOn: _active,
    );
  }

  void _cancelPending() {
    ++_generation;
    _hold?.cancel();
    _hold = null;
    _controller.stop();
    final pending = _next;
    final visible = _phase == _PreviewPhase.transitioning;
    _next = null;
    _transition = null;
    _phase = _PreviewPhase.idle;
    // Freeze the outgoing pose while a new pair is being prepared.
    _current?.setActivity(
      role: SlideSessionRole.current,
      playing: false,
      screenOn: _active,
    );
    if (pending != null) {
      if (visible) {
        _retire(pending);
      } else {
        // A pending session has never been mounted: cancel preparation now.
        _release(pending);
      }
    }
  }

  void _onStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed ||
        _phase != _PreviewPhase.transitioning ||
        !mounted ||
        !_active ||
        _paused) {
      return;
    }
    final previous = _current;
    setState(() {
      _current = _next;
      _next = null;
      _transition = null;
      _phase = _PreviewPhase.idle;
    });
    _updateActivity();
    if (previous != null) _retire(previous);
    _scheduleNext();
  }

  void _scheduleNext() {
    _hold?.cancel();
    if (_active && !_paused) {
      _hold = Timer(_displayTime, () => unawaited(_loadNext()));
    }
  }

  bool _accepts(int generation, SlideSession session) =>
      mounted &&
      _active &&
      !_paused &&
      generation == _generation &&
      identical(_next, session) &&
      !session.disposed;

  void _repeat() {
    _updateDebounce?.cancel();
    unawaited(_loadNext(repeat: _repeatPair));
  }

  Future<void> _loadNext({PreviewPhotoPair? repeat}) async {
    if (!mounted || !_active || _paused) return;
    _cancelPending();
    final generation = _generation;
    final selectedEffect = currentEffect;
    final selectedDuration = _transitionTime;
    final fallbackDuration = Duration(
      milliseconds: widget.config.effects.safeDefaultDurationMs,
    );
    final size = _deviceSize;
    // The editor mutates its draft in place. Keep this operation's settings fixed.
    final config = widget.config.copyWith(
      photoMotion: PhotoMotionConfig.fromJson(
        widget.config.photoMotion.toJson(),
      ),
    );
    setState(() => _phase = _PreviewPhase.preparing);
    AssetPhotoSlideSession? pending;
    try {
      // The effect editor and Repeat start from a newly prepared source photo.
      if (repeat != null ||
          (widget.selectedEffect != null && _current == null)) {
        final index = repeat?.fromIndex ?? _index++;
        pending = AssetPhotoSlideSession(
          repeat?.from ??
              PreviewPhoto.values[index % PreviewPhoto.values.length],
          sequenceIndex: index,
          config: config,
          size: size,
          vsync: this,
        );
        _next = pending;
        final ready = await pending.prepare(context);
        if (!_accepts(generation, pending)) return;
        if (!ready) throw StateError('Preview source preparation unavailable');
        pending.commitPreparation();
        final previous = _current;
        setState(() {
          _current = pending;
          _next = null;
        });
        _updateActivity();
        if (previous != null) _retire(previous);
      }
      if (!mounted) return;
      final index = repeat?.toIndex ?? _index++;
      pending = AssetPhotoSlideSession(
        repeat?.to ?? PreviewPhoto.values[index % PreviewPhoto.values.length],
        sequenceIndex: index,
        config: config,
        size: size,
        vsync: this,
      );
      _next = pending;
      final ready = await pending.prepare(context);
      if (!_accepts(generation, pending)) return;
      if (!ready) throw StateError('Preview target preparation unavailable');

      final outgoing = _current?.createEffectInput(size) ?? _emptyInput;
      final candidate = pending.createEffectInput(size);
      var effect = selectedEffect.createEffect(seed: 42);
      var supported = effect.supportsInputs(outgoing, candidate);
      if (!supported) effect = Effect.fadeEffect.createEffect(seed: 42);
      await effect.prepare();
      if (!_accepts(generation, pending)) return;
      pending.commitPreparation();
      final incoming = pending.createEffectInput(size);
      if (!effect.supportsInputs(outgoing, incoming)) {
        effect = Effect.fadeEffect.createEffect(seed: 42);
        supported = false;
      }
      final source = _current;
      _repeatPair = source == null
          ? null
          : PreviewPhotoPair(
              from: source.photo,
              fromIndex: source.sequenceIndex,
              to: pending.photo,
              toIndex: pending.sequenceIndex,
            );
      final transition = PreviewTransition(
        effect: effect,
        outgoing: outgoing,
        incoming: incoming,
        duration: supported ? selectedDuration : fallbackDuration,
      );
      setState(() {
        _transition = transition;
        _phase = _PreviewPhase.transitioning;
      });
      _updateActivity();
      _controller.duration = transition.duration;
      _controller.forward(from: 0);
    } catch (error, stack) {
      if (!mounted || generation != _generation) return;
      if (pending != null && !identical(_next, pending)) return;
      final failed = _next;
      _next = null;
      if (failed != null) _release(failed);
      _log.warning('Preview asset preparation failed', error, stack);
      setState(() {
        _transition = null;
        _phase = _PreviewPhase.failed;
      });
      _updateActivity();
      // Retry is explicit; a broken asset must not cause an automatic load loop.
    }
  }

  void onChanged(Effect? effect) {
    if (effect == null) return;
    setState(() => currentEffect = effect.canonical);
    unawaited(_loadNext());
  }

  void _togglePause() {
    setState(() {
      _paused = !_paused;
      if (_paused) _cancelPending();
    });
    _updateActivity();
    if (!_paused) {
      if (_current == null) {
        unawaited(_loadNext());
      } else {
        _scheduleNext();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ++_generation;
    _hold?.cancel();
    _updateDebounce?.cancel();
    _controller.dispose();
    final sessions = <SlideSession>{
      ?_current,
      ?_next,
      ..._retired,
    };
    _current = _next = null;
    _transition = null;
    _retired.clear();
    for (final session in sessions) {
      _release(session);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        DevicePreviewViewport(
          aspectRatio: _aspect.ratio,
          child: ColoredBox(
            color: Colors.black,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final transition = _transition;
                return transition == null
                    ? _current?.view ?? _emptyInput.view
                    : transition.effect.createTransformWidget(
                        context,
                        transition.outgoing,
                        transition.incoming,
                        _controller,
                        _deviceSize.width,
                        _deviceSize.height,
                      );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l.preview_local_controls,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        if (widget.selectedEffect == null)
          DropdownButtonFormField<Effect>(
            key: const ValueKey('preview-effect'),
            initialValue: Effect(currentEffect.type),
            isExpanded: true,
            decoration: InputDecoration(labelText: l.preview_effect),
            onChanged: onChanged,
            items: [
              for (final effect in Effect.values)
                DropdownMenuItem(
                  value: effect,
                  child: Text(
                    effectLabel(context, effect),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<PreviewAspectRatio>(
                key: const ValueKey('preview-aspect'),
                initialValue: _aspect,
                isExpanded: true,
                decoration: InputDecoration(labelText: l.preview_aspect),
                onChanged: (value) {
                  if (value == null || value == _aspect) return;
                  setState(() => _aspect = value);
                  unawaited(_loadNext());
                },
                items: [
                  for (final aspect in PreviewAspectRatio.values)
                    DropdownMenuItem(value: aspect, child: Text(aspect.label)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              key: const ValueKey('preview-pause'),
              tooltip: _paused ? l.preview_resume : l.preview_pause,
              onPressed: _togglePause,
              icon: Icon(_paused ? Icons.play_arrow : Icons.pause),
            ),
          ],
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          key: const ValueKey('preview-repeat'),
          onPressed: _paused || _phase == _PreviewPhase.preparing
              ? null
              : _repeat,
          icon: const Icon(Icons.replay),
          label: Text(l.preview_repeat),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 4,
          child: _phase == _PreviewPhase.preparing
              ? const LinearProgressIndicator(minHeight: 4)
              : null,
        ),
        if (_phase == _PreviewPhase.failed)
          Text(
            l.preview_failed,
            key: const ValueKey('preview-error'),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        const SizedBox(height: 8),
        Text(
          l.transition_display_times(
            _transitionTime.inMilliseconds,
            widget.config.displayTimeMs,
          ),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
