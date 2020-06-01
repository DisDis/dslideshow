library fluttercarouselslider;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:media_slider_widget/media_slider_item_effect.dart';

typedef Widget MediaSlideBuilder(int index);

class MediaSlider extends StatefulWidget {
  final MediaSlideBuilder slideBuilder;
  final List<Widget> children;
  final int itemCount;
  final MediaSliderItemEffect slideEffect;
  final bool isAutoPlay;
  final Duration timeout;

  final Duration transitionTime;
  final Curve transitionCurve;

  final bool unlimitedMode;
  final ScrollPhysics scrollPhysics;
  final Axis scrollDirection;

  MediaSlider({
    Key key,
    @required this.children,
    @required this.slideEffect,
    this.isAutoPlay = false,
    this.timeout = const Duration(seconds: 5),
    this.transitionTime = const Duration(seconds: 2),
    this.transitionCurve = Curves.easeOutQuad,
    this.scrollPhysics = const BouncingScrollPhysics(),
    this.scrollDirection = Axis.horizontal,
    this.unlimitedMode = false,
  })  : slideBuilder = null,
        itemCount = children.length,
        super(key: key);

  MediaSlider.builder({
    Key key,
    @required this.slideBuilder,
    @required this.slideEffect,
    @required this.itemCount,
    this.isAutoPlay = false,
    this.timeout = const Duration(seconds: 5),
    this.transitionTime = const Duration(seconds: 2),
    this.transitionCurve = Curves.easeOutQuad,
    this.scrollPhysics = const BouncingScrollPhysics(),
    this.scrollDirection = Axis.horizontal,
    this.unlimitedMode = false,
  })  : children = null,
        super(key: key);

  @override
  State<StatefulWidget> createState() => MediaSliderState(isPlaying: isAutoPlay);
}

class MediaSliderState extends State<MediaSlider> {
  PageController _pageController;
  Timer _timer;
  int _currentPage = 0;
  double _pageDelta = 0;
  bool _isPlaying;

  MediaSliderState({bool isPlaying = false}) : _isPlaying = isPlaying;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          itemCount: widget.unlimitedMode ? null : widget.itemCount,
          controller: _pageController,
          scrollDirection: widget.scrollDirection,
          physics: widget.scrollPhysics,
          itemBuilder: (context, index) {
            index = index % widget.itemCount;
            Widget slide = widget.children == null ? widget.slideBuilder(index) : widget.children[index];
            return widget.slideEffect.transform(context, slide, index, _currentPage, _pageDelta, widget.itemCount);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (_isPlaying) {
      _timer = Timer.periodic(widget.timeout, (timer) {
        _pageController.nextPage(
          duration: widget.transitionTime,
          curve: widget.transitionCurve,
        );
      });
    }
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page.floor() % widget.itemCount;
        _pageDelta = _pageController.page - _pageController.page.floor();
      });
    });
  }

  void nextSlide() {
    _pageController.nextPage(
      duration: widget.transitionTime,
      curve: widget.transitionCurve,
    );
  }

  void previousSlide() {
    _pageController.previousPage(
      duration: widget.transitionTime,
      curve: widget.transitionCurve,
    );
  }

  void setPlaying(bool playing) {
    if (_timer != null) {
      _timer.cancel();
    }
    if (playing) {
      _timer = Timer.periodic(widget.timeout, (timer) {
        _pageController.nextPage(
          duration: widget.transitionTime,
          curve: widget.transitionCurve,
        );
      });
    }
  }
}
