import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen_state.freezed.dart';

enum ScreenPhase { on, waitingOff, fadingOut, poweringOff, off, wakingUp, fadingIn, failed, disposed }

@freezed
sealed class ScreenState with _$ScreenState {
  const factory ScreenState({required bool? isScreenOn, required bool autoWakeEnabled, required ScreenPhase phase}) =
      _ScreenState;
}
