part of 'main_menu_bloc.dart';

@freezed
sealed class MainMenuState with _$MainMenuState {
  const factory MainMenuState({
    required int selectedIndex,
  }) = _MainMenuStateState;
}
