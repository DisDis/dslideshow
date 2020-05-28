import 'package:dslideshow_flutter/src/data_model/global_state.dart';
import 'package:redux/redux.dart';

/// Reducer
final appReducer = combineReducers<GlobalState>([
  TypedReducer<GlobalState, ChangeStorageStatusAction>(_onStorageStatusChange),
//  TypedReducer<GlobalState, SearchErrorAction>(_onError),
//  TypedReducer<GlobalState, SearchResultAction>(_onResult),
]);

GlobalState _onStorageStatusChange(GlobalState state, ChangeStorageStatusAction action) {
  return state.rebuild((b) => b.storageStatus = action.newStatus);
}

class ChangeStorageStatusAction {
  final StorageStatusEnum newStatus;

  ChangeStorageStatusAction(this.newStatus);
}
