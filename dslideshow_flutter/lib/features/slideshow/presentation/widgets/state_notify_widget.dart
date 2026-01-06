import 'package:flutter/material.dart';

class StateNotify extends StatefulWidget {
  final bool isPaused;

  const StateNotify({super.key, this.isPaused = false});

  @override
  StateNotifyState createState() => StateNotifyState();
}

class StateNotifyState extends State<StateNotify>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late bool _isPaused;

  StateNotifyState();

  @override
  void initState() {
    super.initState();
    // Инициализируем локальное состояние из виджета
    _isPaused = widget.isPaused;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Если изначально пауза - показываем анимацию
    if (_isPaused) {
      _controller.forward().orCancel.then((value) => _controller.reverse());
    }
  }

  // --- ДОБАВЛЕНО: Реакция на изменение параметров извне ---
  @override
  void didUpdateWidget(StateNotify oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Если пришел новый статус паузы, обновляем состояние и запускаем анимацию
    if (widget.isPaused != oldWidget.isPaused) {
      // Используем сеттер или логику обновления напрямую
      _updatePausedState(widget.isPaused);
    }
  }
  // --------------------------------------------------------

  // Логика обновления перенесена в отдельный метод (или можно оставить в сеттере)
  void _updatePausedState(bool value) {
    if (_isPaused == value) {
      return;
    }
    setState(() {
      _isPaused = value;
    });
    play();
  }

  // Сеттер оставляем для совместимости, если вдруг где-то еще используется GlobalKey,
  // но теперь он вызывает _updatePausedState
  set isPaused(bool value) => _updatePausedState(value);

  void play() {
    _controller.reset();
    _controller.forward().orCancel.then((value) => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _StaggerAnimation(controller: _controller.view, isPaused: _isPaused);
  }
}

class _StaggerAnimation extends StatelessWidget {
  final bool? isPaused;

  _StaggerAnimation({required this.controller, this.isPaused})
    : opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.3, curve: Curves.ease),
        ),
      ),
      opacityIcon = Tween<double>(begin: 0.1, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.3, 0.500, curve: Curves.ease),
        ),
      ),
      size = Tween<double>(begin: 100.0, end: 200.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.4, 0.70, curve: Curves.easeIn),
        ),
      );

  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> opacityIcon;
  final Animation<double> size;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Opacity(
      opacity: opacity.value,
      child: Container(
        color: const Color.fromARGB(125, 133, 133, 133),
        child: Opacity(
          opacity: opacityIcon.value,
          child: Center(
            child: Icon(
              // Используем isPaused для выбора иконки
              (isPaused ?? false) ? Icons.pause : Icons.play_arrow,
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
    return AnimatedBuilder(builder: _buildAnimation, animation: controller);
  }
}
