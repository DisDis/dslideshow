import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/cameras_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/special_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/special_screen_renderers.dart';
import 'package:flutter/material.dart';

class SpecialScreenPreview extends StatefulWidget {
  final SpecialScreenConfig config;
  final SpecialScreenRenderer? renderer;
  const SpecialScreenPreview({super.key, required this.config, this.renderer});
  @override
  State<SpecialScreenPreview> createState() => _SpecialScreenPreviewState();
}

class _SpecialScreenPreviewState extends State<SpecialScreenPreview>
    with WidgetsBindingObserver {
  SpecialScreenSession? _session;
  String _signature = '';
  Timer? _debounce;
  bool _loading = true,
      _ready = false,
      _active = false,
      _routeActive = true,
      _resumed = true;
  int _cameraIndex = 0, _generation = 0;

  @override
  void initState() {
    super.initState();
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
    final active = _resumed && _routeActive;
    if (_active == active) return;
    _active = active;
    if (_active) {
      _start();
    } else {
      ++_generation;
      _debounce?.cancel();
      _session?.dispose();
      _session = null;
      setState(() {
        _loading = false;
        _ready = false;
      });
    }
  }

  @override
  void didUpdateWidget(covariant SpecialScreenPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (jsonEncode(widget.config.toJson()) != _signature ||
        widget.renderer != oldWidget.renderer) {
      _debounce?.cancel();
      ++_generation;
      _session?.setActive(false);
      if (_active) _debounce = Timer(const Duration(milliseconds: 400), _start);
    }
  }

  Future<void> _start() async {
    if (!_active) return;
    final generation = ++_generation;
    _debounce?.cancel();
    _signature = jsonEncode(widget.config.toJson());
    _session?.dispose();
    final renderer =
        widget.renderer ??
        SpecialScreenRenderers.definitions[widget.config.type];
    final session = renderer?.createSession(
      widget.config.clone(),
      _cameraIndex,
    );
    _session = session;
    setState(() {
      _loading = true;
      _ready = false;
    });
    try {
      final ready = await session?.prepare() ?? false;
      if (!mounted || !_active || generation != _generation) return;
      session?.setActive(ready);
      if (session is CamerasScreenSession) _cameraIndex = session.cameraIndex;
      setState(() {
        _loading = false;
        _ready = ready;
      });
    } catch (_) {
      if (mounted && _active && generation == _generation) {
        setState(() {
          _loading = false;
          _ready = false;
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ++_generation;
    _debounce?.cancel();
    _session?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final options = widget.config.options;
    final renderer =
        widget.renderer ??
        SpecialScreenRenderers.definitions[widget.config.type];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DevicePreviewViewport(
          child: ColoredBox(
            color: Colors.black,
            child: _ready && _session != null && renderer != null
                ? renderer.build(_session!)
                : !_loading && options is CamerasScreenOptions
                ? Center(
                    child: Text(
                      l.special_no_image,
                      style: const TextStyle(color: Colors.white, fontSize: 64),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        if (_loading) const LinearProgressIndicator(),
        if (!_loading && !_ready)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              l.special_preview_unavailable,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
              textAlign: TextAlign.center,
            ),
          ),
        if (options is CamerasScreenOptions &&
            options.mode == CameraDisplayMode.sequence &&
            options.cameras.length > 1)
          TextButton.icon(
            onPressed: _active
                ? () {
                    _cameraIndex++;
                    _start();
                  }
                : null,
            icon: const Icon(Icons.skip_next),
            label: Text(l.special_next_camera),
          ),
      ],
    );
  }
}
