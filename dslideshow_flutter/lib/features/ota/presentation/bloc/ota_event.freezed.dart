// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtaEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent()';
  }
}

/// @nodoc
class $OtaEventCopyWith<$Res> {
  $OtaEventCopyWith(OtaEvent _, $Res Function(OtaEvent) __);
}

/// @nodoc

class OtaInitializationEvent implements OtaEvent {
  const OtaInitializationEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaInitializationEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent.initialization()';
  }
}

/// @nodoc

class OtaUpdateInfoEvent implements OtaEvent {
  const OtaUpdateInfoEvent(this.info);

  final OTAInfo info;

  /// Create a copy of OtaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OtaUpdateInfoEventCopyWith<OtaUpdateInfoEvent> get copyWith =>
      _$OtaUpdateInfoEventCopyWithImpl<OtaUpdateInfoEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OtaUpdateInfoEvent &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'OtaEvent.updateInfo(info: $info)';
  }
}

/// @nodoc
abstract mixin class $OtaUpdateInfoEventCopyWith<$Res>
    implements $OtaEventCopyWith<$Res> {
  factory $OtaUpdateInfoEventCopyWith(
          OtaUpdateInfoEvent value, $Res Function(OtaUpdateInfoEvent) _then) =
      _$OtaUpdateInfoEventCopyWithImpl;
  @useResult
  $Res call({OTAInfo info});

  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$OtaUpdateInfoEventCopyWithImpl<$Res>
    implements $OtaUpdateInfoEventCopyWith<$Res> {
  _$OtaUpdateInfoEventCopyWithImpl(this._self, this._then);

  final OtaUpdateInfoEvent _self;
  final $Res Function(OtaUpdateInfoEvent) _then;

  /// Create a copy of OtaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(OtaUpdateInfoEvent(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }

  /// Create a copy of OtaEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OTAInfoCopyWith<$Res> get info {
    return $OTAInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc

class OtaReadyEvent implements OtaEvent {
  const OtaReadyEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaReadyEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent.ready()';
  }
}

/// @nodoc

class OtaExitEvent implements OtaEvent {
  const OtaExitEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaExitEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent.exit()';
  }
}

/// @nodoc

class OtaTerminalUpdateEvent implements OtaEvent {
  const OtaTerminalUpdateEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaTerminalUpdateEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent.terminalUpdate()';
  }
}

// dart format on
