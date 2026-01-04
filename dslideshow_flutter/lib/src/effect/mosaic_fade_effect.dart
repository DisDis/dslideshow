import 'dart:math';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// --- Направления эффекта ---
enum MosaicDirection {
  random,
  topLeft,    // leftUp
  topRight,   // rightUp
  bottomLeft, // leftDown
  bottomRight // rightDown
}

// --- Обновленный MosaicFadeEffect ---
class MosaicFadeEffect extends MediaSliderItemEffect {
  final int gridSize;
  final double fadeFraction;
  final MosaicDirection direction;
  
  // Здесь храним расписание исчезновения для каждой клетки
  late final List<double> _startTimes;

  MosaicFadeEffect({
    this.gridSize = 100,
    this.fadeFraction = 0.3, 
    this.direction = MosaicDirection.random,
  }) {
    _calculateStartTimes();
  }

  void _calculateStartTimes() {
    final random = Random();
    // Максимальное время начала анимации квадрата, чтобы он успел погаснуть к концу (1.0)
    final maxStartTime = 1.0 - fadeFraction;
    final int count = gridSize * gridSize;
    
    _startTimes = List<double>.filled(count, 0.0);

    for (int i = 0; i < count; i++) {
      final int col = i % gridSize;
      final int row = i ~/ gridSize;
      
      double normalizedScore = 0.0;

      if (direction == MosaicDirection.random) {
        normalizedScore = random.nextDouble();
      } else {
        // Логика направлений
        // Мы вычисляем дистанцию от нужного угла
        double dist = 0.0;
        final double maxDist = (gridSize - 1) * 2.0; // Макс сумма координат (x+y)

        switch (direction) {
          case MosaicDirection.topLeft:
            dist = (col + row).toDouble();
            break;
          case MosaicDirection.bottomRight:
            // Инверсия topLeft
            dist = maxDist - (col + row);
            break;
          case MosaicDirection.topRight:
             // Чем больше X и меньше Y, тем раньше (или наоборот, зависит от угла)
             // TopRight это (max, 0). Дистанция от (0,0) до (x,y) в манхэттенском виде для правого угла:
             // start ~ (maxCol - col) + row
             dist = ((gridSize - 1 - col) + row).toDouble();
            break;
          case MosaicDirection.bottomLeft:
            // BottomLeft это (0, max). 
            // start ~ col + (maxRow - row)
            dist = (col + (gridSize - 1 - row)).toDouble();
            break;
          default:
            dist = 0;
        }
        
        // Нормализуем от 0.0 до 1.0
        double linearPos = dist / maxDist;
        
        // Добавляем шум (Jitter), чтобы линия не была идеально ровной
        // 80% влияет позиция, 20% влияет случайность
        double noise = random.nextDouble();
        normalizedScore = (linearPos * 0.8) + (noise * 0.2);
      }
      
      // Записываем итоговое время старта
      _startTimes[i] = normalizedScore * maxStartTime;
    }
  }

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage,
      double pageDelta, double screenW, double screenH) {
    return page;
  }

  @override
  Widget createTransformWidget(
    BuildContext context,
    Widget currentWidget,
    Widget nextWidget,
    AnimationController controller,
    double screenW,
    double screenH,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        nextWidget,
        _MosaicFadeLayer(
          progress: controller.value,
          gridSize: gridSize,
          startTimes: _startTimes,
          fadeFraction: fadeFraction,
          child: currentWidget,
        ),
      ],
    );
  }
}

// --- RenderObject Widget ---
class _MosaicFadeLayer extends SingleChildRenderObjectWidget {
  final double progress;
  final int gridSize;
  final List<double> startTimes;
  final double fadeFraction;

  const _MosaicFadeLayer({
    required Widget child,
    required this.progress,
    required this.gridSize,
    required this.startTimes,
    required this.fadeFraction,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMosaicFadeLayer(
      progress: progress,
      gridSize: gridSize,
      startTimes: startTimes,
      fadeFraction: fadeFraction,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderMosaicFadeLayer renderObject) {
    renderObject
      ..progress = progress
      ..gridSize = gridSize
      ..startTimes = startTimes // Ссылка на список
      ..fadeFraction = fadeFraction;
  }
}

// --- RenderObject Implementation (с исправленным багом) ---
class _RenderMosaicFadeLayer extends RenderProxyBox {
  double _progress;
  int _gridSize;
  List<double> _startTimes;
  double _fadeFraction;

  _RenderMosaicFadeLayer({
    required double progress,
    required int gridSize,
    required List<double> startTimes,
    required double fadeFraction,
    RenderBox? child,
  })  : _progress = progress,
        _gridSize = gridSize,
        _startTimes = startTimes,
        _fadeFraction = fadeFraction,
        super(child);

  set progress(double value) {
    if (_progress != value) {
      _progress = value;
      markNeedsPaint();
    }
  }

  set gridSize(int value) {
    if (_gridSize != value) {
      _gridSize = value;
      markNeedsPaint();
    }
  }

  set startTimes(List<double> value) {
    _startTimes = value;
    markNeedsPaint(); 
  }
  
  set fadeFraction(double value) {
    if (_fadeFraction != value) {
      _fadeFraction = value;
      markNeedsPaint();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    if (_progress >= 1.0) return; // Полностью исчез

    if (_progress <= 0.0) {
      context.paintChild(child!, offset);
      return;
    }

    context.canvas.saveLayer(offset & size, Paint());
    context.paintChild(child!, offset);

    final Paint maskPaint = Paint()..blendMode = BlendMode.dstIn;
    final double cellW = size.width / _gridSize;
    final double cellH = size.height / _gridSize;

    for (int i = 0; i < _startTimes.length; i++) {
      final double startTime = _startTimes[i];
      final double endTime = startTime + _fadeFraction;

      double alpha = 1.0;
      if (_progress >= endTime) {
        alpha = 0.0;
      } else if (_progress > startTime) {
        final double localProgress = (_progress - startTime) / _fadeFraction;
        alpha = 1.0 - localProgress;
      }

      // Исправленное условие: рисуем, если прозрачность не полная (1.0).
      // Если alpha == 0.0, рисуем прозрачный квадрат, чтобы стереть.
      if (alpha < 1.0) {
        maskPaint.color = Colors.black.withAlpha((255.0 * alpha).round());
        
        final int col = i % _gridSize;
        final int row = i ~/ _gridSize;

        context.canvas.drawRect(
          Rect.fromLTWH(
            offset.dx + col * cellW,
            offset.dy + row * cellH,
            cellW + 1.0, // Перекрытие стыков
            cellH + 1.0,
          ),
          maskPaint,
        );
      }
    }
    context.canvas.restore();
  }
}