import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/photo_motion.dart';
import 'package:flutter/material.dart';

const photoMotionProbeName = 'PhotoMotion-KenBurns';

/// Uses the production camera with the same bounded clock as all benchmark runs.
class PhotoMotionProbe extends MediaSliderItemEffect {
  final path = PhotoMotionPath(seed: 42);
  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) => page;
  @override
  Widget createTransformWidget(
    BuildContext context,
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) => PhotoMotionFrame(
    path: path,
    progress: controller.value,
    child: current.view,
  );
}
