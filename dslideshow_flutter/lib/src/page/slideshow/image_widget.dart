import 'dart:io';

import 'package:dslideshow_backend/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageWidget extends StatelessWidget {
  final Image _image;

  ImageProvider get provider => _image.image;

  ImageWidget(MediaItem item) :_image = Image.file(new File(item.uri.path));

  @override
  Widget build(BuildContext context) => _image;
}
