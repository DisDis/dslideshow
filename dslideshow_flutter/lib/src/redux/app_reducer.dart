import 'package:dslideshow_flutter/src/redux/actions/change_debug_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_pause_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_screen_lock_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_storage_status_action.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:redux/redux.dart';

import 'actions/change_internet_action.dart';

/// Reducer
final appReducer = combineReducers<GlobalState>([
  TypedReducer<GlobalState, ChangeStorageStatusAction>(_onStorageStatusChange) as GlobalState Function(GlobalState, dynamic),
  TypedReducer<GlobalState, ChangeDebugAction>(_onDebugChange) as GlobalState Function(GlobalState, dynamic),
  TypedReducer<GlobalState, ChangePauseAction>(_onPauseChange) as GlobalState Function(GlobalState, dynamic),
  TypedReducer<GlobalState, ChangeInternetAction>(_onInternetChange) as GlobalState Function(GlobalState, dynamic),
  TypedReducer<GlobalState, ChangeScreenLockAction>(_onScreenLockChange) as GlobalState Function(GlobalState, dynamic),


]);

GlobalState _onDebugChange(GlobalState state, ChangeDebugAction action) {
  return state.rebuild((builder) => builder.isDebug = action.isDebug);
}

GlobalState _onPauseChange(GlobalState state, ChangePauseAction action) {
  return state.rebuild((builder) => builder.isPaused = action.isPaused);
}

GlobalState _onStorageStatusChange(GlobalState state, ChangeStorageStatusAction action) {
  return state.rebuild((b) => b.storageStatus = action.newStatus);
}

GlobalState _onInternetChange(GlobalState state, ChangeInternetAction action) {
  return state.rebuild((b) => b.hasInternet = action.newValue);
}

GlobalState _onScreenLockChange(GlobalState state, ChangeScreenLockAction action) {
  return state.rebuild((b) => b.isScreenLock = action.newValue);
}
