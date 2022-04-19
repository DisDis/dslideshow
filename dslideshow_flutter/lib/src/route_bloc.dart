import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

enum RoutePage { welcome, slideshow, config, ota }

@immutable
abstract class NavigateEvent {}

class ChangePageEvent extends NavigateEvent {
  final RoutePage page;

  ChangePageEvent(this.page);
}

@immutable
class RouteState {
  final RoutePage current;

  const RouteState(this.current);
}

class RouteBloc extends Bloc<ChangePageEvent, RouteState> {
  RouteBloc() : super(const RouteState(RoutePage.welcome)) {
    on<ChangePageEvent>((event, emit) => emit(RouteState(event.page)));
  }
}
