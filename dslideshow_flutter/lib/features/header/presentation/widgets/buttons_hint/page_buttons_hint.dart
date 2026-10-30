import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/button_hint_action.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Keeps the four physical slots in their configured position on access pages.
class PageButtonsHint extends StatelessWidget {
  const PageButtonsHint({
    super.key,
    required this.frontend,
    required this.buttons,
    required this.bindings,
  });
  final FrontendService frontend;
  final SlideShowButtons buttons;
  final Map<ButtonType, ButtonHintBinding> bindings;
  @override
  Widget build(BuildContext context) => Positioned(
    left: buttons.hintOffsetX.toDouble(),
    top: buttons.hintOffsetY.toDouble(),
    child: BlocProvider(
      create: (_) => ButtonsHintBloc.contextual(frontendService: frontend),
      child: IgnorePointer(child: ButtonsHintWidget(bindings: bindings)),
    ),
  );
}
