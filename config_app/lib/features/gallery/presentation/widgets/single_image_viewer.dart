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
        imageUrl: uri.toString(),
        fit: BoxFit.contain,
        placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white),
        errorWidget: (context, url, error) => const Icon(Icons.broken_image, color: Colors.grey, size: 50),
      ),
    );
  }
}

