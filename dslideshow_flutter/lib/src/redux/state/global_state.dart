library dslideshow.global.state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'global_state.g.dart';

abstract class GlobalState implements Built<GlobalState, GlobalStateBuilder> {
  static final Duration defaultDelayBetweenItems = new Duration(seconds: 15);

  static Serializer<GlobalState> get serializer => _$globalStateSerializer;

  factory GlobalState([void updates(GlobalStateBuilder b)]) = _$GlobalState;
  factory GlobalState.initial() {
    return (GlobalStateBuilder()
          ..isPaused = false
          ..storageStatus = StorageStatusEnum.done
          ..delayBetweenItems = defaultDelayBetweenItems
          ..beginTimePowerButtonPress = DateTime.now()
          ..isScreenLock = false
          ..isDebug = false
          ..isMenu = false
          ..hasInternet = true)
        .build();
  }

  GlobalState._();

  DateTime? get beginTimePowerButtonPress;

  String? get currentMediaFile;

  Duration? get delayBetweenItems;

  bool get hasInternet;

  bool get isScreenLock;

  bool get isDebug;

  bool get isMenu;

  bool get isPaused;

  String? get nextMediaFile;

  StorageStatusEnum? get storageStatus;
}

class StorageStatusEnum extends EnumClass {
  static const StorageStatusEnum download = _$download;

  static const StorageStatusEnum off = _$off;
  static const StorageStatusEnum done = _$done;

  /// Example of how to make an [EnumClass] serializable.
  ///
  /// Declare a static final [Serializers] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<StorageStatusEnum> get serializer =>
      _$storageStatusEnumSerializer;

  static BuiltSet<StorageStatusEnum> get values => _$values;

  const StorageStatusEnum._(String name) : super(name);
  static StorageStatusEnum valueOf(String name) => _$valueOf(name);
}
