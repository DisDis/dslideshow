part of 'buttons_hint_bloc.dart';

@freezed
class ButtonsHintEvent with _$ButtonsHintEvent {
  const factory ButtonsHintEvent() = _ButtonsHintEvent;
  const factory ButtonsHintEvent.show({
    required bool isShow,
  }) = ButtonsHintShowEvent;
  const factory ButtonsHintEvent.pushButton({
    required ButtonType button,
  }) = ButtonsHintPushButtonEvent;
}
