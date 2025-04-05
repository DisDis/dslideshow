part of 'buttons_hint_bloc.dart';

@freezed
sealed class ButtonsHintState with _$ButtonsHintState {
  const factory ButtonsHintState.display({
    required bool isShow,
    required Color normalColor,
    required Color pushColor,
    required IconData button0Icon,
    required bool button0isPush,
    required IconData button1Icon,
    required bool button1isPush,
    required IconData button2Icon,
    required bool button2isPush,
    required IconData button3Icon,
    required bool button3isPush,
  }) = ButtonsHintDisplayState;
}
