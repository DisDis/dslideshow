import 'package:cached_network_image/cached_network_image.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/image_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/slideshow_loader_widget.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:dslideshow_flutter/effect.dart';

class SlideshowPreview extends StatefulWidget {
  final SlideShowConfig config;
  const SlideshowPreview({super.key, required this.config});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  SlideshowPreviewState createState() => SlideshowPreviewState();
}

class SlideshowPreviewState extends State<SlideshowPreview>
    with TickerProviderStateMixin {

  bool get isItemChanging => _currentWidget != _nextWidget;
  late AnimationController _mediaItemLoopController;
  late AnimationController _effectController;

  late Effect currentEffect = Effect.fadeEffect;
  late MediaSliderItemEffect _currentEffect = currentEffect.createEffect(); // =

  late Duration transitionTime;
  late Duration displayTime;
  final int displayTimeMs = 1000;

  Widget _currentWidget = slideShowLoaderWidget;
  Widget _nextWidget = slideShowLoaderWidget;
  Widget _transitionWidget = slideShowLoaderWidget;

  @override
  void initState() {
    super.initState();

    transitionTime = Duration(milliseconds: widget.config.transitionTimeMs);
    displayTime = Duration(milliseconds: displayTimeMs);//widget.config.displayTimeMs

    _effectController =
        AnimationController(duration: transitionTime, vsync: this);

    _effectController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentWidget = _nextWidget;
        });
      }
    });

    _mediaItemLoopController =
        AnimationController(duration: displayTime, vsync: this);

    _mediaItemLoopController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fetchNextMediaItem();
      }
    });

    // _mediaItemLoopController.forward();
    _fetchNextMediaItem();
  }

  @override
  void dispose() {
    _effectController.dispose();
    _mediaItemLoopController.dispose();
    super.dispose();
  }

  final List<MediaItem> _mediaItems = [];

  Future<MediaItem> _getNextItem() async {
    if (_mediaItems.isEmpty) {
      final items = [
        Uri.parse('https://yavuzceliker.github.io/sample-images/image-1.jpg'),
        Uri.parse('https://yavuzceliker.github.io/sample-images/image-6.jpg'),
        Uri.parse('https://yavuzceliker.github.io/sample-images/image-2.jpg'),
      ];
      _mediaItems.addAll(items.map((e) => MediaItem(e.path, e)));
    }
    return _mediaItems
        .removeLast(); //removeAt(_rnd.nextInt(_mediaItems.length));
  }

//
  void _fetchNextMediaItem() async {
    var mediaItem = await _getNextItem();
    Widget itemWidget;
    itemWidget = CachedNetworkImage(
      imageUrl: mediaItem.uri.toString(),
      errorWidget: (BuildContext context, String url, error) {
        return Row(
          children: [
            Text(context.localizations.not_found_with_id(mediaItem.id!)),
            const Icon(Icons.error)
          ],
        );
      },
    );

    if (itemWidget is ImageWidget) {
      // ignore: use_build_context_synchronously
      await itemWidget.precache(context);
    }
    // ignore: use_build_context_synchronously
    final size = MediaQuery.of(context).size;
    final screenW = size.width;
    final screenH = size.height;
    _nextWidget = SizedBox(width: screenW, height: screenH, child: itemWidget);
    _transitionWidget = AnimatedBuilder(
        key: const Key('anim'),
        animation: _effectController,
        builder: (_, __) {
          return _currentEffect.createTransformWidget(context, _currentWidget,
              _nextWidget, _effectController, screenW, screenH);
        },
        child: slideShowLoaderWidget);

    _effectController.reset();
    _mediaItemLoopController.reset();
    _mediaItemLoopController.stop();
    setState(() {});
    try {
      await _effectController.forward().orCancel;
    } catch (_) {}
    try {
      await _mediaItemLoopController.forward();
    } catch (_) {}
    _currentEffect = currentEffect.createEffect();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(children: [
      // --- BACKGROUND ---
      Container(
        width: size.width,
        height: size.height,
        color: AppColors.slideshowBackground,
        child: !isItemChanging ? _currentWidget : _transitionWidget,
      ),
      Positioned(
        bottom: 10,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: AppColors.slideshowInfoPanel,
          child: Column(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton<Effect>(
                  value: currentEffect,
                  onChanged: onChanged,
                  items: Effect.values.map((item) {
                    return DropdownMenuItem<Effect>(
                      value: item,
                      child: Text(
                        item.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Text(
                context.localizations.transition_display_times(
                  widget.config.transitionTimeMs,
                  displayTimeMs /*widget.config.displayTimeMs*/,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )
    ]);
  }

  void onChanged(Effect? value) {
    currentEffect = value!;
    setState(() {});
   }
}
