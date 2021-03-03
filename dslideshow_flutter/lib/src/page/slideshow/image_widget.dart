import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/src/page/slideshow/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

class ImageWidget extends StatelessWidget implements ItemWidget{
  static final Logger _log = Logger('ImageWidget');
  Image _image;
  final MediaItem item;
  final SlideShowConfig _config;

  // Image get image => _image;
  // Image get imageCover => _imageCover;

  bool get isGif => item.uri == null ? false : path.extension(item.uri.path).toLowerCase() == '.gif';

  ImageWidget(this.item, this._config) : super(key: Key('img:${item.uri.toFilePath()}')) {
    if (isGif) {
      _image =
          Image.memory(
              new File(item.uri.toFilePath()).readAsBytesSync(),
              fit: BoxFit.contain, filterQuality: FilterQuality.high);
    }
  }

  @override
  Widget build(BuildContext context) => _image!=null? _image : Container();

  Future<void> precache(BuildContext context) async {
    if (isGif) {
      return precacheImage(_image.image, context);
    }
    ui.Image imageSrc = await loadImageFromFile(new File(item.uri.toFilePath()));
    final recorder = ui.PictureRecorder();
    final paintBlur = Paint();
    if (_config.isBlurredBackground && _config.backgroundBlurSigma > 0) {
      paintBlur.imageFilter = ui.ImageFilter.blur(sigmaX: _config.backgroundBlurSigma.toDouble(), sigmaY: _config.backgroundBlurSigma.toDouble());
    }
    paintBlur.color = Color.fromRGBO(0, 0, 0, _config.backgroundOpacity);

    Canvas canvas = Canvas(recorder);
    canvas.drawColor(Color.fromRGBO(_config.backgroundColorR, _config.backgroundColorG, _config.backgroundColorB, 1.0), BlendMode.color);
    final outputSize = MediaQuery.of(context).size;

    // Cover
    if (_config.isBlurredBackground) {
      paintImage(canvas: canvas,
          inputPaint: paintBlur,
          image: imageSrc,
          rect: ui.Rect.fromLTWH(0, 0, outputSize.width, outputSize.height),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          isAntiAlias: true);
    }


    // Contain
    paintImage(canvas: canvas, image: imageSrc,
        rect: ui.Rect.fromLTWH(0,0,outputSize.width,outputSize.height), fit: BoxFit.contain, filterQuality: FilterQuality.high, isAntiAlias: true);


    final outputImage = await recorder.endRecording().toImage(outputSize.width.truncate(), outputSize.height.truncate());
    final byteData = await outputImage.toByteData(format: ui.ImageByteFormat.png);
    _image = Image.memory(byteData.buffer.asUint8List());
    return precacheImage(_image.image, context);
  }

  /// Paints an image into the given rectangle on the canvas.
  ///
  /// The arguments have the following meanings:
  ///
  ///  * `canvas`: The canvas onto which the image will be painted.
  ///
  ///  * `rect`: The region of the canvas into which the image will be painted.
  ///    The image might not fill the entire rectangle (e.g., depending on the
  ///    `fit`). If `rect` is empty, nothing is painted.
  ///
  ///  * `image`: The image to paint onto the canvas.
  ///
  ///  * `scale`: The number of image pixels for each logical pixel.
  ///
  ///  * `colorFilter`: If non-null, the color filter to apply when painting the
  ///    image.
  ///
  ///  * `fit`: How the image should be inscribed into `rect`. If null, the
  ///    default behavior depends on `centerSlice`. If `centerSlice` is also null,
  ///    the default behavior is [BoxFit.scaleDown]. If `centerSlice` is
  ///    non-null, the default behavior is [BoxFit.fill]. See [BoxFit] for
  ///    details.
  ///
  ///  * `alignment`: How the destination rectangle defined by applying `fit` is
  ///    aligned within `rect`. For example, if `fit` is [BoxFit.contain] and
  ///    `alignment` is [Alignment.bottomRight], the image will be as large
  ///    as possible within `rect` and placed with its bottom right corner at the
  ///    bottom right corner of `rect`. Defaults to [Alignment.center].
  ///
  ///  * `centerSlice`: The image is drawn in nine portions described by splitting
  ///    the image by drawing two horizontal lines and two vertical lines, where
  ///    `centerSlice` describes the rectangle formed by the four points where
  ///    these four lines intersect each other. (This forms a 3-by-3 grid
  ///    of regions, the center region being described by `centerSlice`.)
  ///    The four regions in the corners are drawn, without scaling, in the four
  ///    corners of the destination rectangle defined by applying `fit`. The
  ///    remaining five regions are drawn by stretching them to fit such that they
  ///    exactly cover the destination rectangle while maintaining their relative
  ///    positions.
  ///
  ///  * `repeat`: If the image does not fill `rect`, whether and how the image
  ///    should be repeated to fill `rect`. By default, the image is not repeated.
  ///    See [ImageRepeat] for details.
  ///
  ///  * `flipHorizontally`: Whether to flip the image horizontally. This is
  ///    occasionally used with images in right-to-left environments, for images
  ///    that were designed for left-to-right locales (or vice versa). Be careful,
  ///    when using this, to not flip images with integral shadows, text, or other
  ///    effects that will look incorrect when flipped.
  ///
  ///  * `invertColors`: Inverting the colors of an image applies a new color
  ///    filter to the paint. If there is another specified color filter, the
  ///    invert will be applied after it. This is primarily used for implementing
  ///    smart invert on iOS.
  ///
  ///  * `filterQuality`: Use this to change the quality when scaling an image.
  ///     Use the [FilterQuality.low] quality setting to scale the image, which corresponds to
  ///     bilinear interpolation, rather than the default [FilterQuality.none] which corresponds
  ///     to nearest-neighbor.
  ///
  /// The `canvas`, `rect`, `image`, `scale`, `alignment`, `repeat`, `flipHorizontally` and `filterQuality`
  /// arguments must not be null.
  ///
  /// See also:
  ///
  ///  * [paintBorder], which paints a border around a rectangle on a canvas.
  ///  * [DecorationImage], which holds a configuration for calling this function.
  ///  * [BoxDecoration], which uses this function to paint a [DecorationImage].
  ///  decoration_image.dart
  void paintImage({
    Canvas canvas,
    Rect rect,
    ui.Image image,
    String debugImageLabel,
    double scale = 1.0,
    ColorFilter colorFilter,
    BoxFit fit,
    Alignment alignment = Alignment.center,
    Rect centerSlice,
    //ImageRepeat repeat = ImageRepeat.noRepeat,
    bool flipHorizontally = false,
    bool invertColors = false,
    FilterQuality filterQuality = FilterQuality.low,
    bool isAntiAlias = false,
    Paint inputPaint = null
  }) {
    ImageRepeat repeat = ImageRepeat.noRepeat;
    assert(canvas != null);
    assert(image != null);
    assert(alignment != null);
    //assert(repeat != null);
    assert(flipHorizontally != null);
    assert(isAntiAlias != null);
    if (rect.isEmpty)
      return;
    Size outputSize = rect.size;
    Size inputSize = Size(image.width.toDouble(), image.height.toDouble());
    Offset sliceBorder;
    if (centerSlice != null) {
      sliceBorder = Offset(
        centerSlice.left + inputSize.width - centerSlice.right,
        centerSlice.top + inputSize.height - centerSlice.bottom,
      );
      outputSize = outputSize - sliceBorder as Size;
      inputSize = inputSize - sliceBorder as Size;
    }
    fit ??= centerSlice == null ? BoxFit.scaleDown : BoxFit.fill;
    assert(centerSlice == null || (fit != BoxFit.none && fit != BoxFit.cover));
    final FittedSizes fittedSizes = applyBoxFit(fit, inputSize / scale, outputSize);
    final Size sourceSize = fittedSizes.source * scale;
    Size destinationSize = fittedSizes.destination;
    if (centerSlice != null) {
      outputSize += sliceBorder/*!*/;
      destinationSize += sliceBorder;
      // We don't have the ability to draw a subset of the image at the same time
      // as we apply a nine-patch stretch.
      assert(sourceSize == inputSize, 'centerSlice was used with a BoxFit that does not guarantee that the image is fully visible.');
    }

    /*if (repeat != ImageRepeat.noRepeat && destinationSize == outputSize) {
      // There's no need to repeat the image because we're exactly filling the
      // output rect with the image.
      repeat = ImageRepeat.noRepeat;
    }*/
    final Paint paint =  inputPaint==null? (Paint()..isAntiAlias = isAntiAlias ): inputPaint..isAntiAlias = isAntiAlias;
    if (colorFilter != null)
      paint.colorFilter = colorFilter;
    if (sourceSize != destinationSize) {
      paint.filterQuality = filterQuality;
    }
    paint.invertColors = invertColors;
    final double halfWidthDelta = (outputSize.width - destinationSize.width) / 2.0;
    final double halfHeightDelta = (outputSize.height - destinationSize.height) / 2.0;
    final double dx = halfWidthDelta + (flipHorizontally ? -alignment.x : alignment.x) * halfWidthDelta;
    final double dy = halfHeightDelta + alignment.y * halfHeightDelta;
    final Offset destinationPosition = rect.topLeft.translate(dx, dy);
    final Rect destinationRect = destinationPosition & destinationSize;

    // Set to true if we added a saveLayer to the canvas to invert/flip the image.
    bool invertedCanvas = false;
    // Output size and destination rect are fully calculated.
    /*if (!kReleaseMode) {
      final ImageSizeInfo sizeInfo = ImageSizeInfo(
        // Some ImageProvider implementations may not have given this.
        source: debugImageLabel ?? '<Unknown Image(${image.width}×${image.height})>',
        imageSize: Size(image.width.toDouble(), image.height.toDouble()),
        displaySize: outputSize,
      );
      assert(() {
        if (debugInvertOversizedImages &&
            sizeInfo.decodedSizeInBytes > sizeInfo.displaySizeInBytes + debugImageOverheadAllowance) {
          final int overheadInKilobytes = (sizeInfo.decodedSizeInBytes - sizeInfo.displaySizeInBytes) ~/ 1024;
          final int outputWidth = outputSize.width.toInt();
          final int outputHeight = outputSize.height.toInt();
          FlutterError.reportError(FlutterErrorDetails(
            exception: 'Image $debugImageLabel has a display size of '
                '$outputWidth×$outputHeight but a decode size of '
                '${image.width}×${image.height}, which uses an additional '
                '${overheadInKilobytes}kb.\n\n'
                'Consider resizing the asset ahead of time, supplying a cacheWidth '
                'parameter of $outputWidth, a cacheHeight parameter of '
                '$outputHeight, or using a ResizeImage.',
            library: 'painting library',
            context: ErrorDescription('while painting an image'),
          ));
          // Invert the colors of the canvas.
          canvas.saveLayer(
            destinationRect,
            Paint()..colorFilter = const ColorFilter.matrix(<double>[
              -1,  0,  0, 0, 255,
              0, -1,  0, 0, 255,
              0,  0, -1, 0, 255,
              0,  0,  0, 1,   0,
            ]),
          );
          // Flip the canvas vertically.
          final double dy = -(rect.top + rect.height / 2.0);
          canvas.translate(0.0, -dy);
          canvas.scale(1.0, -1.0);
          canvas.translate(0.0, dy);
          invertedCanvas = true;
        }
        return true;
      }());
      // Avoid emitting events that are the same as those emitted in the last frame.
      if (!_lastFrameImageSizeInfo.contains(sizeInfo)) {
        final ImageSizeInfo? existingSizeInfo = _pendingImageSizeInfo[sizeInfo.source];
        if (existingSizeInfo == null || existingSizeInfo.displaySizeInBytes < sizeInfo.displaySizeInBytes) {
          _pendingImageSizeInfo[sizeInfo.source!] = sizeInfo;
        }
        if (debugOnPaintImage != null) {
          debugOnPaintImage!(sizeInfo);
        }
        SchedulerBinding.instance!.addPostFrameCallback((Duration timeStamp) {
          _lastFrameImageSizeInfo = _pendingImageSizeInfo.values.toSet();
          if (_pendingImageSizeInfo.isEmpty) {
            return;
          }
          developer.postEvent(
            'Flutter.ImageSizesForFrame',
            <String, Object>{
              for (ImageSizeInfo imageSizeInfo in _pendingImageSizeInfo.values)
                imageSizeInfo.source!: imageSizeInfo.toJson()
            },
          );
          _pendingImageSizeInfo = <String, ImageSizeInfo>{};
        });
      }
    }*/

    final bool needSave = repeat != ImageRepeat.noRepeat || flipHorizontally;
    if (needSave)
      canvas.save();
    if (repeat != ImageRepeat.noRepeat)
      canvas.clipRect(rect);
    if (flipHorizontally) {
      final double dx = -(rect.left + rect.width / 2.0);
      canvas.translate(-dx, 0.0);
      canvas.scale(-1.0, 1.0);
      canvas.translate(dx, 0.0);
    }
    if (centerSlice == null) {
      final Rect sourceRect = alignment.inscribe(
        sourceSize, Offset.zero & inputSize,
      );
      //if (repeat == ImageRepeat.noRepeat)
      {
        canvas.drawImageRect(image, sourceRect, destinationRect, paint);
      }/* else {
        for (final Rect tileRect in _generateImageTileRects(rect, destinationRect, repeat))
          canvas.drawImageRect(image, sourceRect, tileRect, paint);
      }*/
    } else {
      //if (repeat == ImageRepeat.noRepeat)
      {
        canvas.drawImageNine(image, centerSlice, destinationRect, paint);
      } /*else {
        for (final Rect tileRect in _generateImageTileRects(rect, destinationRect, repeat))
          canvas.drawImageNine(image, centerSlice, tileRect, paint);
      }*/
    }
    if (needSave)
      canvas.restore();

    if (invertedCanvas) {
      canvas.restore();
    }
  }

  ///load ui.Image from File
  ///[file] Image file
  static Future<ui.Image> loadImageFromFile(File file) async {
    Uint8List bytes = file.readAsBytesSync();
    return await uint8ListToImage(bytes);
  }

  ///transfer Unit8List to ui.Image
  ///[bytes] Uint8List bytes
  static Future<ui.Image> uint8ListToImage(Uint8List bytes) async {
    ImageProvider provider = MemoryImage(bytes);
    return await loadImageFromProvider(provider);
  }

  // ///load ui.Image from asset
  // ///[asset] asset path
  // static Future<ui.Image> loadImageFromAsset(String asset) async {
  //   ByteData data = await rootBundle.load(asset);
  //   var codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return fi.image;
  // }

  ///load ui.Image from ImageProvider
  ///[provider] ImageProvider
  static Future<ui.Image> loadImageFromProvider(
      ImageProvider provider, {
        ImageConfiguration config = ImageConfiguration.empty,
      }) async {
    Completer<ui.Image> completer = Completer<ui.Image>();
    ImageStreamListener listener;
    ImageStream stream = provider.resolve(config);
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      final ui.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(listener);
    });
    stream.addListener(listener);
    return completer.future;
  }

}
