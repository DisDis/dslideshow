import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleImageViewer extends StatelessWidget {
  final Uri uri;
  const SingleImageViewer({super.key, required this.uri});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1.0,
      maxScale: 5.0,
      child: CachedNetworkImage(
        filterQuality: FilterQuality.high,
        imageUrl: uri.toString(),
        fit: BoxFit.contain,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(
          Icons.broken_image,
          color: Theme.of(context).colorScheme.error,
          size: 50,
        ),
      ),
    );
  }
}
