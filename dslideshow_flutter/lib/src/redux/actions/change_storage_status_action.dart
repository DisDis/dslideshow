import 'package:dslideshow_flutter/src/redux/state/global_state.dart';

class ChangeStorageStatusAction {
  final StorageStatusEnum newStatus;

  ChangeStorageStatusAction(this.newStatus);
}
