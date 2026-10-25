import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/cameras_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/special_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/special_screen_renderers.dart';
import 'package:flutter/material.dart';

class SpecialScreenPreview extends StatefulWidget {
  final SpecialScreenConfig config;
  const SpecialScreenPreview({super.key, required this.config});
  @override
  State<SpecialScreenPreview> createState() => _SpecialScreenPreviewState();
}

class _SpecialScreenPreviewState extends State<SpecialScreenPreview> {
  SpecialScreenSession? _session;
  String _signature = '';
  Timer? _debounce;
  bool _loading = true;
  bool _ready = false;
  int _cameraIndex = 0;
  int _generation = 0;
  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void didUpdateWidget(covariant SpecialScreenPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (jsonEncode(widget.config.toJson()) != _signature) {
      _debounce?.cancel();
      _generation++;
      _session?.setActive(false);
      _debounce = Timer(const Duration(milliseconds: 400), _start);
    }
  }

  Future<void> _start() async {
    final generation = ++_generation;
    _signature = jsonEncode(widget.config.toJson());
    _session?.dispose();
    final renderer = SpecialScreenRenderers.definitions[widget.config.type];
    _session = renderer?.createSession(widget.config.clone(), _cameraIndex);
    setState(() {
      _loading = true;
      _ready = false;
    });
    try {
      final ready = await _session?.prepare() ?? false;
      if (!mounted || generation != _generation) return;
      _session?.setActive(ready);
      if (_session is CamerasScreenSession) {
        _cameraIndex = (_session as CamerasScreenSession).cameraIndex;
      }
      setState(() {
        _loading = false;
        _ready = ready;
      });
    } catch (_) {
      if (mounted && generation == _generation) {
        setState(() {
          _loading = false;
          _ready = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _generation++;
    _debounce?.cancel();
    _session?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final options = widget.config.options;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: ClipRect(
            child: ColoredBox(
              color: Colors.black,
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _ready && _session != null
                  ? SpecialScreenRenderers.definitions[widget.config.type]!
                        .build(_session!)
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          l.special_preview_unavailable,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ),
        ),
        if (options is CamerasScreenOptions &&
            options.mode == CameraDisplayMode.sequence &&
            options.cameras.length > 1)
          TextButton.icon(
            onPressed: () {
              _cameraIndex++;
              _start();
            },
            icon: const Icon(Icons.skip_next),
            label: Text(l.special_next_camera),
          ),
      ],
    );
  }
}
