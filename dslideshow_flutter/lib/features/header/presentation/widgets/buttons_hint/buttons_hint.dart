import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonsHintWidget extends StatelessWidget {
  final SlideShowButtons buttons;
  const ButtonsHintWidget({
    required this.buttons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonsHintBloc, ButtonsHintState>(builder: (context, state) {
      return state.isShow
          ? Row(
              children: [
                Icon(
                  state.button0Icon,
                  size: 40.0,
                  color: state.button0isPush ? state.pushColor : state.normalColor,
                ),
                Icon(
                  state.button1Icon,
                  size: 40.0,
                  color: state.button1isPush ? state.pushColor : state.normalColor,
                ),
                Icon(
                  state.button2Icon,
                  size: 40.0,
                  color: state.button2isPush ? state.pushColor : state.normalColor,
                ),
                Icon(
                  state.button3Icon,
                  size: 40.0,
                  color: state.button3isPush ? state.pushColor : state.normalColor,
                ),
              ],
            )
          : Container();
    });
  }
}
