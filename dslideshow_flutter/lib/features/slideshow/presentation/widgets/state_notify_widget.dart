import 'package:flutter/material.dart';

class StateNotify extends StatefulWidget {
  final bool isPaused;

  const StateNotify({super.key, this.isPaused = false});

  @override
  StateNotifyState createState() => StateNotifyState();
}

class StateNotifyState extends State<StateNotify> with TickerProviderStateMixin {
  late AnimationController _controller;
  late bool _isPaused;

  StateNotifyState();

  @override
  void initState() {
    super.initState();
    _isPaused = widget.isPaused;
    _controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    if (_isPaused) {
      _controller.forward().orCancel.then((value) => _controller.reverse());
    }
  }

  set isPaused(bool value) {
    if (_isPaused == value) {
      return;
    }
    setState(() {
      _isPaused = value;
    });
    play();
  }

  void play() {
    _controller.reset();
    _controller.forward().orCancel.then((value) => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
//  Future<void> _playAnimation() async {
//    try {
//      await _controller.forward().orCancel;
//      await _controller.reverse().orCancel;
//    } on TickerCanceled {
//      // the animation got canceled, probably because we were disposed
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return _StaggerAnimation(controller: _controller.view, isPaused: _isPaused);
  }
}

class _StaggerAnimation extends StatelessWidget {
  final bool? isPaused;
  // ignore: unused_element
  _StaggerAnimation({required this.controller, this.isPaused})
      :

        // Each animation defined here transforms its value during the subset
        // of the controller's duration defined by the animation's interval.
        // For example the opacity animation transforms its value during
        // the first 10% of the controller's duration.

        opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              0.3,
              curve: Curves.ease,
            ),
          ),
        ),
        opacityIcon = Tween<double>(
          begin: 0.1,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.3,
              0.500,
              curve: Curves.ease,
            ),
          ),
        ),
        size = Tween<double>(
          begin: 100.0,
          end: 200.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.4,
              0.70,
              curve: Curves.easeIn,
            ),
          ),
        );

  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> opacityIcon;
  final Animation<double> size;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Opacity(
      opacity: opacity.value,
      child: Container(
        color: const Color.fromARGB(125, 133, 133, 133),
        child: Opacity(
          opacity: opacityIcon.value,
          child: Center(
            child: Icon(
              isPaused! ? Icons.pause : Icons.play_arrow,
              size: size.value,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
