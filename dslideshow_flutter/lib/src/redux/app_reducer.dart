import 'package:dslideshow_flutter/src/redux/actions/change_debug_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_pause_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_storage_status_action.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:redux/redux.dart';

/// Reducer
final appReducer = combineReducers<GlobalState>([
  TypedReducer<GlobalState, ChangeStorageStatusAction>(_onStorageStatusChange),
  TypedReducer<GlobalState, ChangeDebugAction>(_onDebugChange),
  TypedReducer<GlobalState, ChangePauseAction>(_onPauseChange),
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
