part of 'main_menu_bloc.dart';

@freezed
sealed class MainMenuEvent with _$MainMenuEvent {
  const factory MainMenuEvent.select(int index) = MainMenuSelectEvent;
  const factory MainMenuEvent.execute([MenuCommand? command]) = MainMenuExecuteEvent;
}
