import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_debug_action.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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

  const BlinkAnimation(
      {Key? key, this.countBlink: 3, this.milliseconds: 1500, required this.child, this.hideAfterBlink: true})
      : super(key: key);
  @override
  _BlinkAnimationState createState() => _BlinkAnimationState(countBlink, milliseconds, hideAfterBlink, child);
}

class CommonHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Container();
    return Container(
      child: StoreConnector<GlobalState, Store<GlobalState>>(
        converter: (store) => store,
        builder: (context, Store<GlobalState> store) => Stack(
          children: <Widget>[
            if (!isLinuxEmbedded) Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => store.dispatch(ChangeDebugAction(!store.state.isDebug!)),
                child: Container(color: Colors.transparent, width: 30, height: 30),
              ),
            ),
            Row(
              children: <Widget>[
                if (store.state.storageStatus == StorageStatusEnum.off)
                  BlinkAnimation(
                    key: const Key('cloud_off'),
                    child: Icon(
                      Icons.cloud_off,
                      size: 24.0,
                      color: Colors.red,
                    ),
                    hideAfterBlink: false,
                  )
                else if (store.state.storageStatus == StorageStatusEnum.download)
                  BlinkAnimation(
                    key: const Key('cloud_download'),
                    child: Icon(
                      Icons.cloud_download,
                      size: 24.0,
                      color: Colors.white,
                    ),
                  )
                else if (store.state.storageStatus == StorageStatusEnum.done)
                  BlinkAnimation(
                      key: const Key('cloud_done'),
                      child: Icon(
                        Icons.cloud_done,
                        size: 24.0,
                        color: Colors.white,
                      )),
                if (store.state.hasInternet!)
                  BlinkAnimation(
                      key: const Key('hasInternet'),
                      child: Icon(
                        Icons.signal_wifi_4_bar,
                        size: 24.0,
                        color: Colors.white,
                      ))
                else
                  BlinkAnimation(
                    key: const Key('noInternet'),
                    child: Icon(
                      Icons.signal_wifi_off,
                      size: 24.0,
                      color: Colors.red,
                    ),
                    hideAfterBlink: false,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BlinkAnimationState extends State<BlinkAnimation> with SingleTickerProviderStateMixin {
  static final _opacityTween = Tween<double>(begin: 0, end: 1);
  late Animation<double> animation;
  late AnimationController controller;
  int countBlink;
  final int milliseconds;
  final Widget child;
  final bool hideAfterBlink;

  _BlinkAnimationState(this.countBlink, this.milliseconds, this.hideAfterBlink, this.child);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: _opacityTween.evaluate(animation),
            child: this.child,
          );
        });
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: this.milliseconds), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        countBlink--;
        if (countBlink != 0) {
          controller.forward();
        } else {
          controller.value = hideAfterBlink ? 0 : 1;
          controller.stop(canceled: true);
        }
      }
      setState(() {});
    });
    controller.forward();
  }
}
