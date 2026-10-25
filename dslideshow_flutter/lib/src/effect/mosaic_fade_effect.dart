import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';
import 'mosaic_mask.dart';
import 'mosaic_schedule.dart';
export 'mosaic_schedule.dart' show MosaicDirection, MosaicBackend;

class MosaicFadeEffect extends MediaSliderItemEffect {
  final MosaicSchedule schedule;
  final MosaicBackend backend;
  ui.FragmentProgram? _program;

  int get gridSize => schedule.gridSize;
  double get fadeFraction => schedule.fadeFraction;
  final MosaicDirection direction;

  MosaicFadeEffect({
    int gridSize = 100,
    double fadeFraction = 0.3,
    this.direction = MosaicDirection.random,
    int? seed,
    this.backend = MosaicBackend.canvas,
  }) : schedule = MosaicSchedule(
         gridSize: gridSize,
         fadeFraction: fadeFraction,
         direction: direction,
         seed: seed,
       );

  @override
  Future<void> prepare() async {
    if (backend == MosaicBackend.shader) {
      _program = await loadMosaicProgram();
    } else {
      schedule.prepareCanvasOrder();
    }
  }

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
    Widget currentWidget,
    Widget nextWidget,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        nextWidget,
        MosaicMask(
          schedule: schedule,
          progress: controller.value,
          program: _program,
          child: currentWidget,
        ),
      ],
    );
  }
}
