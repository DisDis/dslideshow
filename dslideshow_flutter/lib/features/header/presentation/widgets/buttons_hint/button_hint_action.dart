import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'button_hint_action.freezed.dart';

enum ButtonHintAction { back, returnUnconfirmed, checkConnection, retry }

extension ButtonHintActionPresentation on ButtonHintAction {
  IconData get icon => switch (this) {
    ButtonHintAction.back => Icons.arrow_back,
    ButtonHintAction.returnUnconfirmed => Icons.exit_to_app,
    ButtonHintAction.checkConnection => Icons.refresh,
    ButtonHintAction.retry => Icons.replay,
  };

  String label(AppLocalizations l10n) => switch (this) {
    ButtonHintAction.back => l10n.configPageReturn,
    ButtonHintAction.returnUnconfirmed => l10n.configPageReturnAnyway,
    ButtonHintAction.checkConnection => l10n.configPageCheck,
    ButtonHintAction.retry => l10n.configPageRetry,
  };
}

@freezed
abstract class ButtonHintBinding with _$ButtonHintBinding {
  const factory ButtonHintBinding({
    required ButtonHintAction action,
    @Default(true) bool enabled,
  }) = _ButtonHintBinding;
}
