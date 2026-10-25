import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

class LiquidMorphEffect extends MediaSliderItemEffect {
  final int waveCount;
  final double waveIntensity;
  final _WaveGeometry _geometry;
  LiquidMorphEffect({this.waveCount = 12, this.waveIntensity = 15})
    : assert(waveCount > 0),
      assert(waveIntensity >= 0),
      _geometry = _WaveGeometry(waveCount);

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
  ) => Stack(
    fit: StackFit.expand,
    children: [
      Transform.scale(scale: 1 + 0.1 * controller.value, child: currentWidget),
      ClipPath(
        clipper: _LiquidRevealClipper(
          controller.value,
          waveIntensity,
          _geometry,
        ),
        child: nextWidget,
      ),
    ],
  );
}

class _WaveGeometry {
  final List<Offset> unit = [];
  final List<double> waveSin = [];
  final List<double> waveCos = [];
  _WaveGeometry(int count) {
    for (var angle = 0.0; angle < math.pi * 2; angle += 0.05) {
      unit.add(Offset(math.cos(angle), math.sin(angle)));
      waveSin.add(math.sin(angle * count));
      waveCos.add(math.cos(angle * count));
    }
  }
}

class _LiquidRevealClipper extends CustomClipper<Path> {
  final double progress;
  final double intensity;
  final _WaveGeometry geometry;
  _LiquidRevealClipper(this.progress, this.intensity, this.geometry);
  @override
  Path getClip(Size size) {
    final path = Path();
    if (progress <= 0) return path;
    if (progress >= 1) return path..addRect(Offset.zero & size);
    final center = size.center(Offset.zero);
    final radius = size.longestSide == 0
        ? 0.0
        : math.sqrt(size.width * size.width + size.height * size.height) /
              1.8 *
              progress;
    final phase = progress * math.pi * 4;
    final phaseSin = math.sin(phase);
    final phaseCos = math.cos(phase);
    final amplitude = intensity * (1 - progress);
    for (var i = 0; i < geometry.unit.length; i++) {
      final wave =
          geometry.waveSin[i] * phaseCos + geometry.waveCos[i] * phaseSin;
      final point =
          center + geometry.unit[i] * math.max(0.0, radius + wave * amplitude);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    return path..close();
  }

  @override
  bool shouldReclip(covariant _LiquidRevealClipper old) =>
      old.progress != progress ||
      old.intensity != intensity ||
      !identical(old.geometry, geometry);
}
