// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ota_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OtaEventTearOff {
  const _$OtaEventTearOff();

  OtaInitializationEvent initialization() {
    return const OtaInitializationEvent();
  }

  OtaUpdateInfoEvent updateInfo(OTAInfo info) {
    return OtaUpdateInfoEvent(
      info,
    );
  }

  OtaReadyEvent ready() {
    return const OtaReadyEvent();
  }

  OtaExitEvent exit() {
    return const OtaExitEvent();
  }

  OtaTerminalUpdateEvent terminalUpdate() {
    return const OtaTerminalUpdateEvent();
  }
}

/// @nodoc
const $OtaEvent = _$OtaEventTearOff();

/// @nodoc
mixin _$OtaEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialization,
    required TResult Function(OTAInfo info) updateInfo,
    required TResult Function() ready,
    required TResult Function() exit,
    required TResult Function() terminalUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtaInitializationEvent value) initialization,
    required TResult Function(OtaUpdateInfoEvent value) updateInfo,
    required TResult Function(OtaReadyEvent value) ready,
    required TResult Function(OtaExitEvent value) exit,
    required TResult Function(OtaTerminalUpdateEvent value) terminalUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtaEventCopyWith<$Res> {
  factory $OtaEventCopyWith(OtaEvent value, $Res Function(OtaEvent) then) =
      _$OtaEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$OtaEventCopyWithImpl<$Res> implements $OtaEventCopyWith<$Res> {
  _$OtaEventCopyWithImpl(this._value, this._then);

  final OtaEvent _value;
  // ignore: unused_field
  final $Res Function(OtaEvent) _then;
}

/// @nodoc
abstract class $OtaInitializationEventCopyWith<$Res> {
  factory $OtaInitializationEventCopyWith(OtaInitializationEvent value,
          $Res Function(OtaInitializationEvent) then) =
      _$OtaInitializationEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$OtaInitializationEventCopyWithImpl<$Res>
    extends _$OtaEventCopyWithImpl<$Res>
    implements $OtaInitializationEventCopyWith<$Res> {
  _$OtaInitializationEventCopyWithImpl(OtaInitializationEvent _value,
      $Res Function(OtaInitializationEvent) _then)
      : super(_value, (v) => _then(v as OtaInitializationEvent));

  @override
  OtaInitializationEvent get _value => super._value as OtaInitializationEvent;
}

/// @nodoc

class _$OtaInitializationEvent implements OtaInitializationEvent {
  const _$OtaInitializationEvent();

  @override
  String toString() {
    return 'OtaEvent.initialization()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaInitializationEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialization,
    required TResult Function(OTAInfo info) updateInfo,
    required TResult Function() ready,
    required TResult Function() exit,
    required TResult Function() terminalUpdate,
  }) {
    return initialization();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
  }) {
    return initialization?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
    required TResult orElse(),
  }) {
    if (initialization != null) {
      return initialization();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtaInitializationEvent value) initialization,
    required TResult Function(OtaUpdateInfoEvent value) updateInfo,
    required TResult Function(OtaReadyEvent value) ready,
    required TResult Function(OtaExitEvent value) exit,
    required TResult Function(OtaTerminalUpdateEvent value) terminalUpdate,
  }) {
    return initialization(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
  }) {
    return initialization?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
    required TResult orElse(),
  }) {
    if (initialization != null) {
      return initialization(this);
    }
    return orElse();
  }
}

abstract class OtaInitializationEvent implements OtaEvent {
  const factory OtaInitializationEvent() = _$OtaInitializationEvent;
}

/// @nodoc
abstract class $OtaUpdateInfoEventCopyWith<$Res> {
  factory $OtaUpdateInfoEventCopyWith(
          OtaUpdateInfoEvent value, $Res Function(OtaUpdateInfoEvent) then) =
      _$OtaUpdateInfoEventCopyWithImpl<$Res>;
  $Res call({OTAInfo info});
}

/// @nodoc
class _$OtaUpdateInfoEventCopyWithImpl<$Res>
    extends _$OtaEventCopyWithImpl<$Res>
    implements $OtaUpdateInfoEventCopyWith<$Res> {
  _$OtaUpdateInfoEventCopyWithImpl(
      OtaUpdateInfoEvent _value, $Res Function(OtaUpdateInfoEvent) _then)
      : super(_value, (v) => _then(v as OtaUpdateInfoEvent));

  @override
  OtaUpdateInfoEvent get _value => super._value as OtaUpdateInfoEvent;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(OtaUpdateInfoEvent(
      info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$OtaUpdateInfoEvent implements OtaUpdateInfoEvent {
  const _$OtaUpdateInfoEvent(this.info);

  @override
  final OTAInfo info;

  @override
  String toString() {
    return 'OtaEvent.updateInfo(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OtaUpdateInfoEvent &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  $OtaUpdateInfoEventCopyWith<OtaUpdateInfoEvent> get copyWith =>
      _$OtaUpdateInfoEventCopyWithImpl<OtaUpdateInfoEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialization,
    required TResult Function(OTAInfo info) updateInfo,
    required TResult Function() ready,
    required TResult Function() exit,
    required TResult Function() terminalUpdate,
  }) {
    return updateInfo(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
  }) {
    return updateInfo?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
    required TResult orElse(),
  }) {
    if (updateInfo != null) {
      return updateInfo(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtaInitializationEvent value) initialization,
    required TResult Function(OtaUpdateInfoEvent value) updateInfo,
    required TResult Function(OtaReadyEvent value) ready,
    required TResult Function(OtaExitEvent value) exit,
    required TResult Function(OtaTerminalUpdateEvent value) terminalUpdate,
  }) {
    return updateInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
  }) {
    return updateInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
    required TResult orElse(),
  }) {
    if (updateInfo != null) {
      return updateInfo(this);
    }
    return orElse();
  }
}

abstract class OtaUpdateInfoEvent implements OtaEvent {
  const factory OtaUpdateInfoEvent(OTAInfo info) = _$OtaUpdateInfoEvent;

  OTAInfo get info;
  @JsonKey(ignore: true)
  $OtaUpdateInfoEventCopyWith<OtaUpdateInfoEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtaReadyEventCopyWith<$Res> {
  factory $OtaReadyEventCopyWith(
          OtaReadyEvent value, $Res Function(OtaReadyEvent) then) =
      _$OtaReadyEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$OtaReadyEventCopyWithImpl<$Res> extends _$OtaEventCopyWithImpl<$Res>
    implements $OtaReadyEventCopyWith<$Res> {
  _$OtaReadyEventCopyWithImpl(
      OtaReadyEvent _value, $Res Function(OtaReadyEvent) _then)
      : super(_value, (v) => _then(v as OtaReadyEvent));

  @override
  OtaReadyEvent get _value => super._value as OtaReadyEvent;
}

/// @nodoc

class _$OtaReadyEvent implements OtaReadyEvent {
  const _$OtaReadyEvent();

  @override
  String toString() {
    return 'OtaEvent.ready()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaReadyEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialization,
    required TResult Function(OTAInfo info) updateInfo,
    required TResult Function() ready,
    required TResult Function() exit,
    required TResult Function() terminalUpdate,
  }) {
    return ready();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
  }) {
    return ready?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtaInitializationEvent value) initialization,
    required TResult Function(OtaUpdateInfoEvent value) updateInfo,
    required TResult Function(OtaReadyEvent value) ready,
    required TResult Function(OtaExitEvent value) exit,
    required TResult Function(OtaTerminalUpdateEvent value) terminalUpdate,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class OtaReadyEvent implements OtaEvent {
  const factory OtaReadyEvent() = _$OtaReadyEvent;
}

/// @nodoc
abstract class $OtaExitEventCopyWith<$Res> {
  factory $OtaExitEventCopyWith(
          OtaExitEvent value, $Res Function(OtaExitEvent) then) =
      _$OtaExitEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$OtaExitEventCopyWithImpl<$Res> extends _$OtaEventCopyWithImpl<$Res>
    implements $OtaExitEventCopyWith<$Res> {
  _$OtaExitEventCopyWithImpl(
      OtaExitEvent _value, $Res Function(OtaExitEvent) _then)
      : super(_value, (v) => _then(v as OtaExitEvent));

  @override
  OtaExitEvent get _value => super._value as OtaExitEvent;
}

/// @nodoc

class _$OtaExitEvent implements OtaExitEvent {
  const _$OtaExitEvent();

  @override
  String toString() {
    return 'OtaEvent.exit()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaExitEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialization,
    required TResult Function(OTAInfo info) updateInfo,
    required TResult Function() ready,
    required TResult Function() exit,
    required TResult Function() terminalUpdate,
  }) {
    return exit();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
  }) {
    return exit?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
    required TResult orElse(),
  }) {
    if (exit != null) {
      return exit();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtaInitializationEvent value) initialization,
    required TResult Function(OtaUpdateInfoEvent value) updateInfo,
    required TResult Function(OtaReadyEvent value) ready,
    required TResult Function(OtaExitEvent value) exit,
    required TResult Function(OtaTerminalUpdateEvent value) terminalUpdate,
  }) {
    return exit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
  }) {
    return exit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
    required TResult orElse(),
  }) {
    if (exit != null) {
      return exit(this);
    }
    return orElse();
  }
}

abstract class OtaExitEvent implements OtaEvent {
  const factory OtaExitEvent() = _$OtaExitEvent;
}

/// @nodoc
abstract class $OtaTerminalUpdateEventCopyWith<$Res> {
  factory $OtaTerminalUpdateEventCopyWith(OtaTerminalUpdateEvent value,
          $Res Function(OtaTerminalUpdateEvent) then) =
      _$OtaTerminalUpdateEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$OtaTerminalUpdateEventCopyWithImpl<$Res>
    extends _$OtaEventCopyWithImpl<$Res>
    implements $OtaTerminalUpdateEventCopyWith<$Res> {
  _$OtaTerminalUpdateEventCopyWithImpl(OtaTerminalUpdateEvent _value,
      $Res Function(OtaTerminalUpdateEvent) _then)
      : super(_value, (v) => _then(v as OtaTerminalUpdateEvent));

  @override
  OtaTerminalUpdateEvent get _value => super._value as OtaTerminalUpdateEvent;
}

/// @nodoc

class _$OtaTerminalUpdateEvent implements OtaTerminalUpdateEvent {
  const _$OtaTerminalUpdateEvent();

  @override
  String toString() {
    return 'OtaEvent.terminalUpdate()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaTerminalUpdateEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialization,
    required TResult Function(OTAInfo info) updateInfo,
    required TResult Function() ready,
    required TResult Function() exit,
    required TResult Function() terminalUpdate,
  }) {
    return terminalUpdate();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
  }) {
    return terminalUpdate?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialization,
    TResult Function(OTAInfo info)? updateInfo,
    TResult Function()? ready,
    TResult Function()? exit,
    TResult Function()? terminalUpdate,
    required TResult orElse(),
  }) {
    if (terminalUpdate != null) {
      return terminalUpdate();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtaInitializationEvent value) initialization,
    required TResult Function(OtaUpdateInfoEvent value) updateInfo,
    required TResult Function(OtaReadyEvent value) ready,
    required TResult Function(OtaExitEvent value) exit,
    required TResult Function(OtaTerminalUpdateEvent value) terminalUpdate,
  }) {
    return terminalUpdate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
  }) {
    return terminalUpdate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtaInitializationEvent value)? initialization,
    TResult Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult Function(OtaReadyEvent value)? ready,
    TResult Function(OtaExitEvent value)? exit,
    TResult Function(OtaTerminalUpdateEvent value)? terminalUpdate,
    required TResult orElse(),
  }) {
    if (terminalUpdate != null) {
      return terminalUpdate(this);
    }
    return orElse();
  }
}

abstract class OtaTerminalUpdateEvent implements OtaEvent {
  const factory OtaTerminalUpdateEvent() = _$OtaTerminalUpdateEvent;
}
