import 'dart:async';

import 'package:flutter/material.dart';

import 'media_image_loader.dart';
import 'gallery_payload_provider.dart';

/// Limits submissions to the engine independently of HTTP slots. A running
/// decode keeps its permit even when its viewport consumer disappears.
final class GalleryDecodePool {
  GalleryDecodePool({this.maxActive = 2});
  final int maxActive;
  final _queue = <_DecodeJob>[];
  int _active = 0;
  bool _closed = false;

  Future<GalleryDecodedImage> prepare(
    ImageProvider provider,
    bool Function() needed,
  ) {
    final job = _DecodeJob(provider, needed);
    job.result.future.ignore();
    if (_closed) {
      job.result.completeError(const GalleryImageCancelled());
    } else {
      _queue.add(job);
      _drain();
    }
    return job.result.future;
  }

  void prune() {
    for (final job in _queue.toList()) {
      if (!job.needed()) {
        _queue.remove(job);
        job.result.completeError(const GalleryImageCancelled());
      }
    }
  }

  void _drain() {
    prune();
    while (!_closed && _active < maxActive && _queue.isNotEmpty) {
      final job = _queue.removeAt(0);
      _active++;
      Future<void> decode() async {
        GalleryDecodedImage? decoded;
        try {
          decoded = GalleryDecodedImage(
            job.provider.resolve(ImageConfiguration.empty),
          );
          await decoded.firstFrame;
          if (_closed || !job.needed()) {
            decoded.dispose();
            job.result.completeError(const GalleryImageCancelled());
          } else {
            job.result.complete(decoded);
          }
        } catch (error, stack) {
          decoded?.dispose();
          job.result.completeError(error, stack);
        } finally {
          _active--;
          scheduleMicrotask(_drain);
        }
      }

      unawaited(decode());
    }
  }

  void close() {
    _closed = true;
    for (final job in _queue) {
      job.result.completeError(const GalleryImageCancelled());
    }
    _queue.clear();
  }
}

final class _DecodeJob {
  _DecodeJob(this.provider, this.needed);
  final ImageProvider provider;
  final bool Function() needed;
  final result = Completer<GalleryDecodedImage>();
}

/// The decoded stream itself is handed to the view. Re-resolving the provider
/// would decode oversized originals twice when ImageCache cannot retain them.
final class GalleryDecodedImage {
  GalleryDecodedImage(this.stream) {
    _listener = ImageStreamListener(
      (info, _) {
        _frame?.dispose();
        _frame = info;
        if (!_first.isCompleted) _first.complete();
        onChanged?.call();
      },
      onError: (Object error, StackTrace? stack) {
        failed = true;
        if (!_first.isCompleted) _first.completeError(error, stack);
        onChanged?.call();
      },
    );
    stream.addListener(_listener);
  }
  final ImageStream stream;
  final _first = Completer<void>();
  late final ImageStreamListener _listener;
  ImageInfo? _frame;
  bool failed = false;
  bool _disposed = false;
  VoidCallback? onChanged;
  Future<void> get firstFrame => _first.future;
  ImageInfo? get frame => _frame;

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    onChanged = null;
    stream.removeListener(_listener);
    _frame?.dispose();
    _frame = null;
  }
}

/// Network ownership is outside ImageCache. The Flutter Image only receives an
/// already downloaded local payload; pending/keepAlive listeners cannot keep an
/// off-screen HTTP download alive.
class GalleryImage extends StatefulWidget {
  const GalleryImage({
    super.key,
    required this.loader,
    required this.decodePool,
    required this.request,
    required this.errorBuilder,
    this.active = true,
    this.priority = GalleryImagePriority.visible,
    this.distance = 0,
    this.fit = BoxFit.cover,
    this.decodeWidth,
    this.onRevisionMismatch,
  });

  final MediaImageLoader loader;
  final GalleryDecodePool decodePool;
  final GalleryImageRequest request;
  final bool active;
  final GalleryImagePriority priority;
  final int distance;
  final BoxFit fit;
  final int? decodeWidth;
  final Widget Function(BuildContext, VoidCallback) errorBuilder;
  final VoidCallback? onRevisionMismatch;

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  GalleryImageLease? _lease;
  GalleryDecodedImage? _decoded;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void didUpdateWidget(GalleryImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.loader != widget.loader ||
        oldWidget.request.key != widget.request.key ||
        oldWidget.active != widget.active ||
        oldWidget.decodeWidth != widget.decodeWidth) {
      _release();
      _start();
    } else {
      _lease?.updatePriority(widget.priority, distance: widget.distance);
    }
  }

  bool _current(GalleryImageLease lease) =>
      mounted &&
      widget.active &&
      !widget.loader.isClosed &&
      identical(_lease, lease);

  void _start() {
    _failed = false;
    _decoded = null;
    if (!widget.active) return;
    if (widget.loader.isClosed) {
      _failed = true;
      return;
    }
    final lease = _lease = widget.loader.acquire(
      widget.request,
      priority: widget.priority,
      distance: widget.distance,
    );
    unawaited(_load(lease));
  }

  Future<void> _load(GalleryImageLease lease) async {
    GalleryEncodedImage? data;
    try {
      data = await lease.result;
      if (!_current(lease)) return;
      var provider = galleryPayloadProvider(data);
      provider = ResizeImage.resizeIfNeeded(widget.decodeWidth, null, provider);
      // A file cache lease must survive an in-progress decoder even if the tile
      // disappears. The pool retains its slot through the actual first frame.
      final releaseSource = widget.loader.retainForDecode(data);
      GalleryDecodedImage decoded;
      try {
        decoded = await widget.decodePool.prepare(
          provider,
          () => _current(lease),
        );
      } finally {
        releaseSource();
      }
      if (!_current(lease)) {
        decoded.dispose();
        return;
      }
      decoded.onChanged = () {
        if (_current(lease)) setState(() {});
      };
      setState(() => _decoded = decoded);
    } on GalleryImageCancelled {
      // No user-facing error for demand which has disappeared.
    } catch (error) {
      if (!_current(lease)) return;
      if (error is GalleryImageHttpException && error.statusCode == 409) {
        widget.onRevisionMismatch?.call();
      }
      // A corrupt encoded payload must not poison every subsequent retry.
      try {
        await widget.loader.invalidate(widget.request.key);
      } catch (_) {
        // A closing scope or unavailable disk must not create an unhandled
        // cleanup future or replace the useful user-facing image failure.
      }
      if (_current(lease)) setState(() => _failed = true);
    }
  }

  void _release() {
    _lease?.dispose();
    _lease = null;
    _decoded?.dispose();
    _decoded = null;
    widget.decodePool.prune();
  }

  @override
  void dispose() {
    _release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed || (_decoded?.failed ?? false)) {
      return widget.errorBuilder(context, () {
        _release();
        setState(_start);
      });
    }
    final frame = _decoded?.frame;
    if (frame == null) {
      return const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return RawImage(
      image: frame.image,
      scale: frame.scale,
      fit: widget.fit,
      filterQuality: widget.fit == BoxFit.contain
          ? FilterQuality.high
          : FilterQuality.low,
    );
  }
}
