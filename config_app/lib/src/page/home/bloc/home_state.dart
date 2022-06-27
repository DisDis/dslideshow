import 'package:equatable/equatable.dart';

enum HomeTab { log, hardware, slideshow, welcome, web, mqtt, storage, wifi }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.slideshow,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
