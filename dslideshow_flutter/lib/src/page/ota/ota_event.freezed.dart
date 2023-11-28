// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
    TResult? Function()? initialization,
    TResult? Function(OTAInfo info)? updateInfo,
    TResult? Function()? ready,
    TResult? Function()? exit,
    TResult? Function()? terminalUpdate,
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
    TResult? Function(OtaInitializationEvent value)? initialization,
    TResult? Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult? Function(OtaReadyEvent value)? ready,
    TResult? Function(OtaExitEvent value)? exit,
    TResult? Function(OtaTerminalUpdateEvent value)? terminalUpdate,
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
      _$OtaEventCopyWithImpl<$Res, OtaEvent>;
}

/// @nodoc
class _$OtaEventCopyWithImpl<$Res, $Val extends OtaEvent>
    implements $OtaEventCopyWith<$Res> {
  _$OtaEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OtaInitializationEventImplCopyWith<$Res> {
  factory _$$OtaInitializationEventImplCopyWith(
          _$OtaInitializationEventImpl value,
          $Res Function(_$OtaInitializationEventImpl) then) =
      __$$OtaInitializationEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtaInitializationEventImplCopyWithImpl<$Res>
    extends _$OtaEventCopyWithImpl<$Res, _$OtaInitializationEventImpl>
    implements _$$OtaInitializationEventImplCopyWith<$Res> {
  __$$OtaInitializationEventImplCopyWithImpl(
      _$OtaInitializationEventImpl _value,
      $Res Function(_$OtaInitializationEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OtaInitializationEventImpl implements OtaInitializationEvent {
  const _$OtaInitializationEventImpl();

  @override
  String toString() {
    return 'OtaEvent.initialization()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtaInitializationEventImpl);
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
    TResult? Function()? initialization,
    TResult? Function(OTAInfo info)? updateInfo,
    TResult? Function()? ready,
    TResult? Function()? exit,
    TResult? Function()? terminalUpdate,
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
    TResult? Function(OtaInitializationEvent value)? initialization,
    TResult? Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult? Function(OtaReadyEvent value)? ready,
    TResult? Function(OtaExitEvent value)? exit,
    TResult? Function(OtaTerminalUpdateEvent value)? terminalUpdate,
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
  const factory OtaInitializationEvent() = _$OtaInitializationEventImpl;
}

/// @nodoc
abstract class _$$OtaUpdateInfoEventImplCopyWith<$Res> {
  factory _$$OtaUpdateInfoEventImplCopyWith(_$OtaUpdateInfoEventImpl value,
          $Res Function(_$OtaUpdateInfoEventImpl) then) =
      __$$OtaUpdateInfoEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OTAInfo info});
}

/// @nodoc
class __$$OtaUpdateInfoEventImplCopyWithImpl<$Res>
    extends _$OtaEventCopyWithImpl<$Res, _$OtaUpdateInfoEventImpl>
    implements _$$OtaUpdateInfoEventImplCopyWith<$Res> {
  __$$OtaUpdateInfoEventImplCopyWithImpl(_$OtaUpdateInfoEventImpl _value,
      $Res Function(_$OtaUpdateInfoEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$OtaUpdateInfoEventImpl(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$OtaUpdateInfoEventImpl implements OtaUpdateInfoEvent {
  const _$OtaUpdateInfoEventImpl(this.info);

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
            other is _$OtaUpdateInfoEventImpl &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtaUpdateInfoEventImplCopyWith<_$OtaUpdateInfoEventImpl> get copyWith =>
      __$$OtaUpdateInfoEventImplCopyWithImpl<_$OtaUpdateInfoEventImpl>(
          this, _$identity);

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
    TResult? Function()? initialization,
    TResult? Function(OTAInfo info)? updateInfo,
    TResult? Function()? ready,
    TResult? Function()? exit,
    TResult? Function()? terminalUpdate,
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
    TResult? Function(OtaInitializationEvent value)? initialization,
    TResult? Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult? Function(OtaReadyEvent value)? ready,
    TResult? Function(OtaExitEvent value)? exit,
    TResult? Function(OtaTerminalUpdateEvent value)? terminalUpdate,
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
  const factory OtaUpdateInfoEvent(final OTAInfo info) =
      _$OtaUpdateInfoEventImpl;

  OTAInfo get info;
  @JsonKey(ignore: true)
  _$$OtaUpdateInfoEventImplCopyWith<_$OtaUpdateInfoEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtaReadyEventImplCopyWith<$Res> {
  factory _$$OtaReadyEventImplCopyWith(
          _$OtaReadyEventImpl value, $Res Function(_$OtaReadyEventImpl) then) =
      __$$OtaReadyEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtaReadyEventImplCopyWithImpl<$Res>
    extends _$OtaEventCopyWithImpl<$Res, _$OtaReadyEventImpl>
    implements _$$OtaReadyEventImplCopyWith<$Res> {
  __$$OtaReadyEventImplCopyWithImpl(
      _$OtaReadyEventImpl _value, $Res Function(_$OtaReadyEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OtaReadyEventImpl implements OtaReadyEvent {
  const _$OtaReadyEventImpl();

  @override
  String toString() {
    return 'OtaEvent.ready()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtaReadyEventImpl);
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
    TResult? Function()? initialization,
    TResult? Function(OTAInfo info)? updateInfo,
    TResult? Function()? ready,
    TResult? Function()? exit,
    TResult? Function()? terminalUpdate,
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
    TResult? Function(OtaInitializationEvent value)? initialization,
    TResult? Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult? Function(OtaReadyEvent value)? ready,
    TResult? Function(OtaExitEvent value)? exit,
    TResult? Function(OtaTerminalUpdateEvent value)? terminalUpdate,
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
  const factory OtaReadyEvent() = _$OtaReadyEventImpl;
}

/// @nodoc
abstract class _$$OtaExitEventImplCopyWith<$Res> {
  factory _$$OtaExitEventImplCopyWith(
          _$OtaExitEventImpl value, $Res Function(_$OtaExitEventImpl) then) =
      __$$OtaExitEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtaExitEventImplCopyWithImpl<$Res>
    extends _$OtaEventCopyWithImpl<$Res, _$OtaExitEventImpl>
    implements _$$OtaExitEventImplCopyWith<$Res> {
  __$$OtaExitEventImplCopyWithImpl(
      _$OtaExitEventImpl _value, $Res Function(_$OtaExitEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OtaExitEventImpl implements OtaExitEvent {
  const _$OtaExitEventImpl();

  @override
  String toString() {
    return 'OtaEvent.exit()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtaExitEventImpl);
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
    TResult? Function()? initialization,
    TResult? Function(OTAInfo info)? updateInfo,
    TResult? Function()? ready,
    TResult? Function()? exit,
    TResult? Function()? terminalUpdate,
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
    TResult? Function(OtaInitializationEvent value)? initialization,
    TResult? Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult? Function(OtaReadyEvent value)? ready,
    TResult? Function(OtaExitEvent value)? exit,
    TResult? Function(OtaTerminalUpdateEvent value)? terminalUpdate,
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
  const factory OtaExitEvent() = _$OtaExitEventImpl;
}

/// @nodoc
abstract class _$$OtaTerminalUpdateEventImplCopyWith<$Res> {
  factory _$$OtaTerminalUpdateEventImplCopyWith(
          _$OtaTerminalUpdateEventImpl value,
          $Res Function(_$OtaTerminalUpdateEventImpl) then) =
      __$$OtaTerminalUpdateEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtaTerminalUpdateEventImplCopyWithImpl<$Res>
    extends _$OtaEventCopyWithImpl<$Res, _$OtaTerminalUpdateEventImpl>
    implements _$$OtaTerminalUpdateEventImplCopyWith<$Res> {
  __$$OtaTerminalUpdateEventImplCopyWithImpl(
      _$OtaTerminalUpdateEventImpl _value,
      $Res Function(_$OtaTerminalUpdateEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OtaTerminalUpdateEventImpl implements OtaTerminalUpdateEvent {
  const _$OtaTerminalUpdateEventImpl();

  @override
  String toString() {
    return 'OtaEvent.terminalUpdate()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtaTerminalUpdateEventImpl);
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
    TResult? Function()? initialization,
    TResult? Function(OTAInfo info)? updateInfo,
    TResult? Function()? ready,
    TResult? Function()? exit,
    TResult? Function()? terminalUpdate,
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
    TResult? Function(OtaInitializationEvent value)? initialization,
    TResult? Function(OtaUpdateInfoEvent value)? updateInfo,
    TResult? Function(OtaReadyEvent value)? ready,
    TResult? Function(OtaExitEvent value)? exit,
    TResult? Function(OtaTerminalUpdateEvent value)? terminalUpdate,
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
  const factory OtaTerminalUpdateEvent() = _$OtaTerminalUpdateEventImpl;
}
