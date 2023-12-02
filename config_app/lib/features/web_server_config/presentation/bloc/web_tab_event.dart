import 'package:meta/meta.dart';

@immutable
abstract class WebTabEvent {}

class ReloadAppWebTabEvent extends WebTabEvent {}

class LoadWebTabEvent extends WebTabEvent {}
