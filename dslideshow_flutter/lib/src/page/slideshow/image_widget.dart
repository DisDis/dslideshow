import 'dart:io';

import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/src/page/slideshow/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageWidget extends StatelessWidget implements ItemWidget{
  final Image _image;
  final MediaItem item;

  ImageProvider get provider => _image.image;

  ImageWidget(this.item) :_image = Image.file(
      new File(item.uri.toFilePath()),
      fit: BoxFit.contain);

  @override
  Widget build(BuildContext context) => _image;


}
