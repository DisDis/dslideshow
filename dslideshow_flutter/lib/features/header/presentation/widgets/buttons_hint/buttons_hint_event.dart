part of 'buttons_hint_bloc.dart';

@freezed
sealed class ButtonsHintEvent with _$ButtonsHintEvent {
  const factory ButtonsHintEvent.show({required bool isShow}) =
      ButtonsHintShowEvent;
  const factory ButtonsHintEvent.buttonChanged({
    required ButtonType button,
    required ButtonEventType type,
  }) = ButtonsHintButtonChanged;
  const factory ButtonsHintEvent.clearPress({required ButtonType button}) =
      ButtonsHintClearPress;
  const factory ButtonsHintEvent.updateButtons() =
      ButtonsHintUpdateButtonsEvent;
}
