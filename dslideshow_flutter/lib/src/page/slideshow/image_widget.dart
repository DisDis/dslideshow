import 'dart:io';

import 'package:dslideshow_backend/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageWidget extends StatelessWidget {
  final File mediaFile;

  ImageWidget(MediaItem item) : this.mediaFile = new File(item.uri.path);

  @override
  Widget build(BuildContext context) => Image.file(mediaFile);
}
