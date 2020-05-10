library dslideshow.global.state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';

part 'global_state.g.dart';

abstract class GlobalState implements Built<GlobalState, GlobalStateBuilder> {
  static final Duration defaultDelayBetweenItems = new Duration(seconds: 15);
  static Serializer<GlobalState> get serializer => _$globalStateSerializer;
    @nullable
    String get currentMediaFile;
    @nullable
    String get nextMediaFile;
    Duration get delayBetweenItems;
    bool get isPaused;
    bool get hasInternet;
    bool get isDebug;
    StorageStatusEnum get storageStatus;
    @nullable
    DateTime get beginTimePowerButtonPress;
    GlobalState._();
    factory GlobalState.initial(){
      return (GlobalStateBuilder()
        ..isPaused = false
        ..storageStatus = StorageStatusEnum.off
        ..delayBetweenItems = defaultDelayBetweenItems
        ..beginTimePowerButtonPress = null
        ..isDebug = false
        ..hasInternet = true).build();
    }
    factory GlobalState([void updates(GlobalStateBuilder b)]) = _$GlobalState;
}


class StorageStatusEnum extends EnumClass {
  /// Example of how to make an [EnumClass] serializable.
  ///
  /// Declare a static final [Serializers] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<StorageStatusEnum> get serializer => _$storageStatusEnumSerializer;

  static const StorageStatusEnum download = _$download;
  static const StorageStatusEnum off = _$off;
  static const StorageStatusEnum done = _$done;

  const StorageStatusEnum._(String name) : super(name);

  static BuiltSet<StorageStatusEnum> get values => _$values;
  static StorageStatusEnum valueOf(String name) => _$valueOf(name);
}