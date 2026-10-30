import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/button_hint_action.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonsHintWidget extends StatelessWidget {
  const ButtonsHintWidget({this.bindings, super.key});
  final Map<ButtonType, ButtonHintBinding>? bindings;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ButtonsHintBloc, ButtonsHintState>(
        builder: (context, state) {
          if (!state.isShow) return const SizedBox.shrink();
          return Container(
            decoration: BoxDecoration(
              color: ThemeColors.buttonsHintBackgroundColor,
              border: Border.all(
                color: ThemeColors.buttonsHintColor.withValues(alpha: .5),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final button in ButtonType.values) ...[
                  if (button != ButtonType.button0)
                    const SizedBox(width: ThemeSettings.buttonHintDividerSize),
                  _slot(context, state, button),
                ],
              ],
            ),
          );
        },
      );

  Widget _slot(
    BuildContext context,
    ButtonsHintState state,
    ButtonType button,
  ) {
    final binding = bindings?[button];
    final icon = bindings == null
        ? switch (button) {
            ButtonType.button0 => state.button0Icon,
            ButtonType.button1 => state.button1Icon,
            ButtonType.button2 => state.button2Icon,
            ButtonType.button3 => state.button3Icon,
          }
        : binding?.action.icon;
    final pressed = switch (button) {
      ButtonType.button0 => state.button0isPush,
      ButtonType.button1 => state.button1isPush,
      ButtonType.button2 => state.button2isPush,
      ButtonType.button3 => state.button3isPush,
    };
    final enabled = bindings == null || (binding?.enabled ?? false);
    final activePress = pressed && enabled;
    final color = !enabled
        ? ThemeColors.buttonsHintColor.withValues(alpha: .3)
        : activePress
        ? ThemeColors.buttonsHintPressedColor
        : ThemeColors.buttonsHintColor;
    final slot = Container(
      key: ValueKey(button),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: activePress ? color.withValues(alpha: .2) : Colors.transparent,
        border: Border.all(
          color: activePress ? color : color.withValues(alpha: .3),
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: icon == null
          ? const SizedBox.square(dimension: ThemeSettings.buttonHintIconSize)
          : Icon(icon, size: ThemeSettings.buttonHintIconSize, color: color),
    );
    if (binding == null) return slot;
    return Semantics(
      enabled: enabled,
      label: binding.action.label(AppLocalizations.of(context)),
      child: slot,
    );
  }
}
