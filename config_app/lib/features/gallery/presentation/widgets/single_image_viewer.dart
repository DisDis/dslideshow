import 'dart:async';

import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/src/gallery/gallery_encoded_cache.dart';
import 'package:config_app/src/gallery/gallery_image_widget.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:flutter/material.dart';

class SingleImageViewer extends StatefulWidget {
  const SingleImageViewer({
    super.key,
    required this.uri,
    this.item,
    this.session,
    this.onRevisionMismatch,
  });
  final Uri uri;
  final GalleryItem? item;
  final GallerySession? session;
  final VoidCallback? onRevisionMismatch;
  @override
  State<SingleImageViewer> createState() => _SingleImageViewerState();
}

class _SingleImageViewerState extends State<SingleImageViewer> {
  MediaImageLoader? _ownedLoader;
  GalleryDecodePool? _ownedPool;

  @override
  void initState() {
    super.initState();
    if (widget.session == null) {
      _ownedLoader = MediaImageLoader(cache: createGalleryEncodedCache());
      _ownedPool = GalleryDecodePool();
    }
  }

  @override
  void didUpdateWidget(SingleImageViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.session == null && _ownedLoader == null) {
      _ownedLoader = MediaImageLoader(cache: createGalleryEncodedCache());
      _ownedPool = GalleryDecodePool();
    } else if (widget.session != null && _ownedLoader != null) {
      _ownedPool?.close();
      unawaited(_ownedLoader!.close());
      _ownedLoader = null;
      _ownedPool = null;
    }
  }

  @override
  void dispose() {
    _ownedPool?.close();
    if (_ownedLoader != null) unawaited(_ownedLoader!.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item ?? GalleryItem(uri: widget.uri, title: '');
    // Non-opaque dialogs leave this image visible. Overlay disables tickers
    // only when a covering opaque route makes the retained page offstage.
    final routeActive = TickerMode.valuesOf(context).enabled;
    return InteractiveViewer(
      minScale: 1,
      maxScale: 5,
      child: GalleryImage(
        loader: widget.session?.loader ?? _ownedLoader!,
        decodePool: widget.session?.decodePool ?? _ownedPool!,
        request: item.imageRequest(),
        active: routeActive,
        priority: GalleryImagePriority.fullscreen,
        fit: BoxFit.contain,
        onRevisionMismatch: widget.onRevisionMismatch,
        errorBuilder: (context, retry) => Center(
          child: IconButton(
            icon: Icon(
              Icons.broken_image,
              color: Theme.of(context).colorScheme.error,
              size: 50,
            ),
            tooltip: context.localizations.retry_button,
            onPressed: retry,
          ),
        ),
      ),
    );
  }
}
