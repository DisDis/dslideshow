import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonsHintWidget extends StatelessWidget {
  final SlideShowButtons buttons;
  
  // Цвета HUD
  static const Color _kHudColor = Colors.cyanAccent;
  static const Color _kHudBg = Color(0xCC000000); // 80% Black

  const ButtonsHintWidget({
    required this.buttons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonsHintBloc, ButtonsHintState>(
      builder: (context, state) {
        if (!state.isShow) return const SizedBox.shrink();

        return Container(
          decoration: BoxDecoration(
            color: _kHudBg,
            border: Border.all(color: _kHudColor.withAlpha((255.0 * 0.5).round()), width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHudButton(state.button0Icon, state.button0isPush),
              const SizedBox(width: 12),
              _buildHudButton(state.button1Icon, state.button1isPush),
              const SizedBox(width: 12),
              _buildHudButton(state.button2Icon, state.button2isPush),
              const SizedBox(width: 12),
              _buildHudButton(state.button3Icon, state.button3isPush),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHudButton(IconData icon, bool isPressed) {
    final color = isPressed ? Colors.yellowAccent : _kHudColor;
    
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isPressed ? color.withAlpha((255.0 * 0.2).round()): Colors.transparent,
        border: Border.all(
          color: isPressed ? color : color.withAlpha((255.0 * 0.3).round()),
          width: 2
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 40.0,
        color: color,
      ),
    );
  }
}