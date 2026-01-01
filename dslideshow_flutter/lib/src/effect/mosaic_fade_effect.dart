import 'dart:math';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MosaicFadeEffect extends MediaSliderItemEffect {
  final int gridSize;
  late final List<double> _startTimes;
  
  // Длительность угасания одного квадратика относительно всей анимации (0.0 - 1.0).
  // 0.2 означает, что квадратик будет гаснуть 20% от времени всей анимации.
  final double fadeFraction; 

  MosaicFadeEffect({
    this.gridSize = 10,
    this.fadeFraction = 0.3, // Квадратик гаснет быстро, но не мгновенно
  }) {
    // Генерируем случайное время старта для каждого квадрата.
    // Максимальное время старта = 1.0 - fadeFraction, чтобы успеть погаснуть до конца.
    final random = Random();
    final maxStartTime = 1.0 - fadeFraction;
    
    _startTimes = List.generate(
      gridSize * gridSize,
      (_) => random.nextDouble() * maxStartTime,
    );
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
        // 1. Слой назначения (лежит внизу)
        nextWidget,

        // 2. Слой текущий с маской прозрачности
        // Мы оборачиваем currentWidget в наш спец-виджет
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

// --- Виджет-обертка для RenderObject ---
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
      ..startTimes = startTimes
      ..fadeFraction = fadeFraction;
  }
}

// --- RenderObject (Вся магия здесь) ---
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

  // Сеттеры для обновления параметров
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
    _startTimes = value; // Ссылку обновляем, перерисовка вызовется прогрессом
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

    // Если анимация закончилась (progress=1.0), то старый слой должен исчезнуть целиком.
    // Мы просто ничего не рисуем -> полная пустота (прозрачность).
    if (_progress >= 1.0) return;

    // Если анимация не началась, рисуем ребенка как есть (полная видимость)
    if (_progress <= 0.0) {
      context.paintChild(child!, offset);
      return;
    }

    // 1. Создаем слой. Это обязательно для смешивания.
    context.canvas.saveLayer(offset & size, Paint());

    // 2. Рисуем картинку (CurrentWidget)
    context.paintChild(child!, offset);

    // 3. Подготавливаем кисть для "вырезания"
    // dstIn оставляет пиксели картинки только там, где мы нарисуем маску.
    // Прозрачность маски переносится на картинку.
    final Paint maskPaint = Paint()..blendMode = BlendMode.dstIn;

    final double cellW = size.width / _gridSize;
    final double cellH = size.height / _gridSize;

    // Проходим по всем квадратикам
    for (int i = 0; i < _startTimes.length; i++) {
      final double startTime = _startTimes[i];
      final double endTime = startTime + _fadeFraction;

      double alpha = 1.0;
      
      if (_progress >= endTime) {
        alpha = 0.0; // Полностью исчез
      } else if (_progress > startTime) {
        // Линейная интерполяция
        final double localProgress = (_progress - startTime) / _fadeFraction;
        alpha = 1.0 - localProgress;
      }

      // ВАЖНОЕ ИСПРАВЛЕНИЕ:
      // Мы должны рисовать маску, если alpha < 1.0.
      // Если alpha == 1.0, рисовать не обязательно (картинка и так видна).
      // Но если alpha == 0.0, мы ОБЯЗАНЫ нарисовать прозрачный квадрат, чтобы стереть картинку.
      
      if (alpha < 1.0) {
        maskPaint.color = Colors.black.withOpacity(alpha);
        
        final int col = i % _gridSize;
        final int row = i ~/ _gridSize;

        // Рисуем прямоугольник.
        // Добавляем +1.0 к размеру, чтобы гарантированно перекрыть стыки (anti-aliasing)
        context.canvas.drawRect(
          Rect.fromLTWH(
            offset.dx + col * cellW,
            offset.dy + row * cellH,
            cellW + 1.0, 
            cellH + 1.0,
          ),
          maskPaint,
        );
      }
    }

    // 4. Применяем слой
    context.canvas.restore();
  }
}