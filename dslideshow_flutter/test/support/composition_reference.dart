// Frozen pre-optimization compositions for independent pixel regression.
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';

class ReferenceAccordionEffect extends MediaSliderItemEffect {
  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) {
    return page;
  }

  @override
  Widget createTransformWidget(
    BuildContext context,
    EffectSlideInput currentInput,
    EffectSlideInput nextInput,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    final double progress = controller.value;

    // --- ЛОГИКА ---
    // Мы не обрезаем картинки (ClipRect), мы их сплющиваем (Scale X).
    // Чтобы картинка не стала просто узкой полоской посередине,
    // мы используем Alignment.

    // 1. Current (Левая часть): Сжимается от 100% до 0%.
    // Привязка: CenterLeft (чтобы уезжала влево).
    Widget buildCurrent() {
      return Align(
        alignment: Alignment.centerLeft,
        child: Transform(
          alignment: Alignment.centerLeft, // Сжимаем к левому краю
          // Масштабируем только по оси X (width)
          transform: Matrix4.identity()
            ..scaleByDouble(1.0 - progress, 1.0, 1.0 - progress, 1.0),
          child: SizedBox(
            // Важно! Заставляем виджет думать, что он все еще на весь экран,
            // чтобы контент внутри сжимался (эффект гармошки), а не перестраивался.
            width: screenW,
            height: screenH,
            child: currentInput.view,
          ),
        ),
      );
    }

    // 2. Next (Правая часть): Растет от 0% до 100%.
    // Привязка: CenterRight (чтобы росла от правого края навстречу левому).
    Widget buildNext() {
      return Align(
        alignment: Alignment.centerRight,
        child: Transform(
          alignment: Alignment.centerRight, // Растягиваем от правого края
          transform: Matrix4.identity()
            ..scaleByDouble(progress, 1.0, progress, 1.0),
          child: SizedBox(
            width: screenW,
            height: screenH,
            child: nextInput.view,
          ),
        ),
      );
    }

    // --- ТЕНИ ДЛЯ ОБЪЕМА ---
    // При сжатии гармошки складки обычно темнеют.

    // Тень для сжимающегося (Current)
    Widget buildCurrentShadow() {
      return Align(
        alignment: Alignment.centerLeft,
        child: Transform(
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()
            ..scaleByDouble(1.0 - progress, 1.0, 1.0 - progress, 1.0),
          child: SizedBox(
            width: screenW,
            height: screenH,
            // Тень становится темнее по мере сжатия
            child: Container(
              color: Colors.black.withAlpha((255.0 * (progress * 0.5)).round()),
            ),
          ),
        ),
      );
    }

    // Тень для растущего (Next)
    Widget buildNextShadow() {
      return Align(
        alignment: Alignment.centerRight,
        child: Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()
            ..scaleByDouble(progress, 1.0, progress, 1.0),
          child: SizedBox(
            width: screenW,
            height: screenH,
            // Тень светлеет по мере расширения
            child: Container(
              color: Colors.black.withAlpha(
                (255.0 * ((1.0 - progress) * 0.5)).round(),
              ),
            ),
          ),
        ),
      );
    }

    // Z-Order здесь не важен, так как они не пересекаются (занимают разные области экрана).
    // Но для порядка:
    return Stack(
      fit: StackFit.expand,
      children: [
        buildCurrent(),
        buildCurrentShadow(),
        buildNext(),
        buildNextShadow(),
      ],
    );
  }
}

class ReferenceLiquidMorphEffect extends MediaSliderItemEffect {
  final int waveCount;
  final double waveIntensity;
  final _WaveGeometry _geometry;
  ReferenceLiquidMorphEffect({this.waveCount = 12, this.waveIntensity = 15})
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
    EffectSlideInput currentInput,
    EffectSlideInput nextInput,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) => Stack(
    fit: StackFit.expand,
    children: [
      Transform.scale(
        scale: 1 + 0.1 * controller.value,
        child: currentInput.view,
      ),
      ClipPath(
        clipper: _LiquidRevealClipper(
          controller.value,
          waveIntensity,
          _geometry,
        ),
        child: nextInput.view,
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
