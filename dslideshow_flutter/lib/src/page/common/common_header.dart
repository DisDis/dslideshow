import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_bloc.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_event.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A builder that builds a widget given a child.
///
/// The child should typically be part of the returned widget tree.
///
/// Used by [AnimatedBuilder.builder], as well as [WidgetsApp.builder] and
/// [MaterialApp.builder].
///
/// See also:
///
///  * [WidgetBuilder], which is similar but only takes a [BuildContext].
///  * [IndexedWidgetBuilder], which is similar but also takes an index.
///  * [ValueWidgetBuilder], which is similar but takes a value and a child.
typedef BlinkTransitionBuilder = Widget Function(BuildContext context, Widget child, Animation<Color> animation);

class BlinkAnimation extends StatefulWidget {
  final int countBlink;
  final int milliseconds;
  final Widget child;
  final bool hideAfterBlink;

  const BlinkAnimation({
    super.key,
    this.countBlink = 3,
    this.milliseconds = 1500,
    required this.child,
    this.hideAfterBlink = true,
  });
  @override
  BlinkAnimationState createState() => BlinkAnimationState();
}

class CommonHeaderWidget extends StatelessWidget {
  const CommonHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SlideshowBloc, SlideshowState, IndicatorState>(selector: (state) {
      return IndicatorState(
          storageStatus: state.storageStatus, isDebug: state.isDebug, isPaused: state.isPaused, isMenu: state.isMenu, hasInternet: state.hasInternet);
    }, builder: (context, state) {
      return Stack(
        children: <Widget>[
          if (!isLinuxEmbedded)
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  final bloc = BlocProvider.of<SlideshowBloc>(context);
                  bloc.add(SlideshowDebugEvent(!state.isDebug));
                },
                child: Container(color: Colors.transparent, width: 30, height: 30),
              ),
            ),
          Row(
            children: <Widget>[
              if (state.storageStatus == StorageStatusEnum.off)
                const BlinkAnimation(
                  key: Key('cloud_off'),
                  hideAfterBlink: false,
                  child: Icon(
                    Icons.cloud_off,
                    size: 24.0,
                    color: Colors.red,
                  ),
                )
              else if (state.storageStatus == StorageStatusEnum.download)
                const BlinkAnimation(
                  key: Key('cloud_download'),
                  child: Icon(
                    Icons.cloud_download,
                    size: 24.0,
                    color: Colors.white,
                  ),
                )
              else if (state.storageStatus == StorageStatusEnum.done)
                const BlinkAnimation(
                    key: Key('cloud_done'),
                    child: Icon(
                      Icons.cloud_done,
                      size: 24.0,
                      color: Colors.white,
                    )),
              if (state.hasInternet)
                const BlinkAnimation(
                    key: Key('hasInternet'),
                    child: Icon(
                      Icons.signal_wifi_4_bar,
                      size: 24.0,
                      color: Colors.white,
                    ))
              else
                const BlinkAnimation(
                  key: Key('noInternet'),
                  hideAfterBlink: false,
                  child: Icon(
                    Icons.signal_wifi_off,
                    size: 24.0,
                    color: Colors.red,
                  ),
                ),
              if (state.isPaused)
                const BlinkAnimation(
                  key: Key('isPaused'),
                  hideAfterBlink: false,
                  child: Icon(
                    Icons.pause_circle,
                    size: 24.0,
                    color: Colors.red,
                  ),
                )
            ],
          ),
        ],
      );
    });
  }
}

class BlinkAnimationState extends State<BlinkAnimation> with SingleTickerProviderStateMixin {
  static final _opacityTween = Tween<double>(begin: 0, end: 1);
  late Animation<double> animation;
  late AnimationController controller;

  BlinkAnimationState();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: _opacityTween.evaluate(animation),
            child: widget.child,
          );
        });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    int countBlink = widget.countBlink;
    controller = AnimationController(duration: Duration(milliseconds: widget.milliseconds), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        countBlink--;
        if (countBlink != 0) {
          controller.forward();
        } else {
          controller.value = widget.hideAfterBlink ? 0 : 1;
          controller.stop(canceled: true);
        }
      }
      setState(() {});
    });
    controller.forward();
  }
}
