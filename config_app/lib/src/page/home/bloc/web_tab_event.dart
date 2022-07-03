import 'dart:async';
import 'dart:developer' as developer;

import 'package:meta/meta.dart';

@immutable
abstract class WebTabEvent {}

class ReloadAppWebTabEvent extends WebTabEvent {}

class LoadWebTabEvent extends WebTabEvent {}
