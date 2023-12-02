import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SlideshowEvent {
  // Stream<SlideshowState> applyAsync({SlideshowState currentState, SlideshowBloc bloc});
}

// class SlideshowInitialEvent extends SlideshowEvent {}

class SlideshowScreenLockEvent extends SlideshowEvent {
  final bool value;

  SlideshowScreenLockEvent(this.value);
}

class SlideshowPauseEvent extends SlideshowEvent {
  final bool value;

  SlideshowPauseEvent(this.value);
}

class SlideshowMenuEvent extends SlideshowEvent {
  final bool value;

  SlideshowMenuEvent(this.value);
}

class SlideshowInternetEvent extends SlideshowEvent {
  final bool value;

  SlideshowInternetEvent(this.value);
}

class SlideshowDebugEvent extends SlideshowEvent {
  final bool value;

  SlideshowDebugEvent(this.value);
}

class SlideshowChangeStorageStatusEvent extends SlideshowEvent {
  final StorageStatusEnum value;

  SlideshowChangeStorageStatusEvent(this.value);
}

class SlideshowChageItemEvent extends SlideshowEvent {
  SlideshowChageItemEvent();
}
