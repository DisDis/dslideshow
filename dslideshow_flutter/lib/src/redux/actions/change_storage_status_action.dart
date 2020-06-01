import 'package:dslideshow_flutter/src/redux/data_model/global_state.dart';

class ChangeStorageStatusAction {
  final StorageStatusEnum newStatus;

  ChangeStorageStatusAction(this.newStatus);
}
