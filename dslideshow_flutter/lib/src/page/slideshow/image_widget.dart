import 'dart:io';
import 'dart:typed_data';

import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/src/page/slideshow/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as ip;

class ImageWidget extends StatelessWidget implements ItemWidget{
  static final Logger _log = Logger('ImageWidget');
  Image _image;
  Image _imageCover;
  final MediaItem item;

  static bool _isGif(MediaItem item) => item.uri == null ? false : path.extension(item.uri.path).toLowerCase() == '.gif';

  ImageWidget(this.item) : super(key: Key('img:${item.uri.toFilePath()}')) {
    if (_isGif(item)) {
      _image =
          Image.memory(
              new File(item.uri.toFilePath()).readAsBytesSync(),
              fit: BoxFit.contain, filterQuality: FilterQuality.high);
      _imageCover = _image;
    } else {

      /*
       case BoxFit.contain:
      sourceSize = inputSize;
      if (outputSize.width / outputSize.height > sourceSize.width / sourceSize.height)
        destinationSize = Size(sourceSize.width * outputSize.height / sourceSize.height, outputSize.height);
      else
        destinationSize = Size(outputSize.width, sourceSize.height * outputSize.width / sourceSize.width);
      break;

      case BoxFit.cover:
       if (outputSize.width / outputSize.height > inputSize.width / inputSize.height) {
        sourceSize = Size(inputSize.width, inputSize.width * outputSize.height / outputSize.width);
      } else {
        sourceSize = Size(inputSize.height * outputSize.width / outputSize.height, inputSize.height);
      }
      destinationSize = outputSize;
      * */



      _image = Image.memory(
          new File(item.uri.toFilePath()).readAsBytesSync(),
          fit: /*BoxFit.contain*/ BoxFit.none, filterQuality: FilterQuality.none);
      _imageCover = Image.memory(new File(item.uri.toFilePath()).readAsBytesSync(),
               fit: BoxFit.cover /*none*/, cacheWidth: 640, filterQuality: FilterQuality.high, isAntiAlias: false);

    }
  }

  @override
  Widget build(BuildContext context) => _image;

  Future<void> precache(BuildContext context) async {
    /*if (_isGif(item)) {
      return Future.wait([precacheImage(_image.image, context)]);
    }
    final outputSize = MediaQuery.of(context).size;
    _log.info('Output size: $outputSize');

    ip.Image imageSrc = ip.decodeImage( new File(item.uri.toFilePath()).readAsBytesSync());
    final inputSize = Size(imageSrc.width.toDouble(), imageSrc.height.toDouble());

    Size destinationSize;

    if (outputSize.width / outputSize.height > inputSize.width / inputSize.height)
      destinationSize = Size(inputSize.width * outputSize.height / inputSize.height, outputSize.height);
    else
      destinationSize = Size(outputSize.width, inputSize.height * outputSize.width / inputSize.width);

    Size sourceSize;
    if (outputSize.width / outputSize.height > inputSize.width / inputSize.height) {
      sourceSize = Size(inputSize.width, inputSize.width * outputSize.height / outputSize.width);
    } else {
      sourceSize = Size(inputSize.height * outputSize.width / outputSize.height, inputSize.height);
    }

    final imageContain = ip.copyResize(imageSrc, width: destinationSize.width.truncate(), height: destinationSize.height.truncate());

    ip.Image imageCoverWithBlur = ip.gaussianBlur(ip.copyResize(imageSrc,width: sourceSize.width.truncate(), height: sourceSize.height.truncate(), interpolation: ip.Interpolation.cubic), 10);
    var output = ip.Image(outputSize.width.truncate(), outputSize.height.truncate());
    output = ip.copyInto(output, imageCoverWithBlur, dstX: ((outputSize.width.truncate() - imageCoverWithBlur.width) / 2).truncate(), dstY: ((outputSize.height.truncate() - imageCoverWithBlur.height) / 2).truncate());
    output = ip.copyInto(output, imageContain, dstX: ((outputSize.width.truncate() - imageContain.width) / 2).truncate(), dstY: ((outputSize.height.truncate() - imageContain.height) / 2).truncate());
    _image = Image.memory(Uint8List.fromList(ip.encodePng(output)), fit: BoxFit.none, filterQuality: FilterQuality.none);*/
    return Future.wait([precacheImage(_image.image, context), precacheImage(_imageCover.image, context)]);
  }


}
