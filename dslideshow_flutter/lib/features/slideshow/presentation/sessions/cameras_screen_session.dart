import 'dart:async';
import 'dart:typed_data';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/src/service/camera_snapshot_client.dart';
import 'package:flutter/painting.dart';

import 'special_screen_session.dart';

class CamerasScreenSession extends SpecialScreenSession {
  final CameraSnapshotClient client;
  int cameraIndex;
  final images = <int, Uint8List>{};
  final failed = <int>{};
  final _requests = <String>{};
  final _imagePreparations = <Completer<void>, VoidCallback>{};
  Timer? _timer;
  int _generation = 0;
  int _request = 0;
  bool _refreshing = false;
  CamerasScreenOptions get options => config.options as CamerasScreenOptions;
  CamerasScreenSession(
    super.config, {
    this.cameraIndex = 0,
    CameraSnapshotClient? client,
  }) : client = client ?? CameraSnapshotClient();
  @override
  Future<bool> prepare() async {
    if (options.cameras.isEmpty) return false;
    final generation = _generation;
    if (options.mode == CameraDisplayMode.sequence) {
      for (var offset = 0; offset < options.cameras.length; offset++) {
        final index = (cameraIndex + offset) % options.cameras.length;
        await _load(index, generation);
        if (closed || generation != _generation) return false;
        if (images.containsKey(index)) {
          cameraIndex = index;
          return true;
        }
      }
    } else {
      await Future.wait(
        List.generate(
          options.cameras.length,
          (index) => _load(index, generation),
        ),
      );
    }
    return !closed && generation == _generation && images.isNotEmpty;
  }

  Future<void> _load(int index, int generation) async {
    if (closed || generation != _generation) return;
    final key = '${config.id}-${_request++}';
    _requests.add(key);
    try {
      final bytes = await client.fetch(key, options.cameras[index]);
      if (closed || generation != _generation) return;
      await _prepareImage(bytes);
      if (closed || generation != _generation) {
        MemoryImage(bytes).evict();
        return;
      }
      final previous = images[index];
      if (previous != null) MemoryImage(previous).evict();
      images[index] = bytes;
      failed.remove(index);
    } catch (_) {
      if (!closed && generation == _generation) failed.add(index);
    } finally {
      _requests.remove(key);
    }
    if (!closed && generation == _generation) notifyListeners();
  }

  Future<void> _prepareImage(Uint8List bytes) async {
    final stream = MemoryImage(bytes).resolve(ImageConfiguration.empty);
    final completion = Completer<void>();
    final listener = ImageStreamListener(
      (info, _) {
        info.dispose();
        if (!completion.isCompleted) completion.complete();
      },
      onError: (Object error, StackTrace? stack) {
        if (!completion.isCompleted) completion.completeError(error, stack);
      },
    );
    _imagePreparations[completion] = () {
      stream.removeListener(listener);
      MemoryImage(bytes).evict();
    };
    try {
      stream.addListener(listener);
      await completion.future;
    } catch (_) {
      MemoryImage(bytes).evict();
      rethrow;
    } finally {
      _imagePreparations.remove(completion);
      stream.removeListener(listener);
    }
  }

  void _cancelPreparations() {
    for (final entry in _imagePreparations.entries.toList()) {
      entry.value();
      if (!entry.key.isCompleted) {
        entry.key.completeError(StateError('Image preparation cancelled'));
      }
    }
    _imagePreparations.clear();
  }

  @override
  void setActive(bool value) {
    if (closed || (active == value && (value || _requests.isEmpty))) return;
    super.setActive(value);
    _timer?.cancel();
    if (!value) {
      _generation++;
      for (final key in _requests.toList()) {
        client.cancel(key);
      }
      _cancelPreparations();
    } else if (!closed && options.refreshIntervalMs > 0) {
      _timer = Timer.periodic(
        Duration(milliseconds: options.refreshIntervalMs),
        (_) => _refresh(),
      );
    }
  }

  Future<void> _refresh() async {
    if (_refreshing || closed || !active) return;
    _refreshing = true;
    try {
      final indices = options.mode == CameraDisplayMode.sequence
          ? [cameraIndex]
          : List.generate(options.cameras.length, (i) => i);
      final generation = _generation;
      await Future.wait(indices.map((i) => _load(i, generation)));
    } finally {
      _refreshing = false;
    }
  }

  @override
  void dispose() {
    if (closed) return;
    _timer?.cancel();
    _generation++;
    _cancelPreparations();
    client.dispose();
    for (final bytes in images.values) {
      MemoryImage(bytes).evict();
    }
    images.clear();
    super.dispose();
  }
}
