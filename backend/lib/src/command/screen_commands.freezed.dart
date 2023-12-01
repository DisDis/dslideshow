// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScreenTurnCommand _$ScreenTurnCommandFromJson(Map<String, dynamic> json) {
  return _ScreenTurnCommand.fromJson(json);
}

/// @nodoc
mixin _$ScreenTurnCommand {
  bool get enabled => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScreenTurnCommandCopyWith<ScreenTurnCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenTurnCommandCopyWith<$Res> {
  factory $ScreenTurnCommandCopyWith(
          ScreenTurnCommand value, $Res Function(ScreenTurnCommand) then) =
      _$ScreenTurnCommandCopyWithImpl<$Res, ScreenTurnCommand>;
  @useResult
  $Res call({bool enabled, int id, String type});
}

/// @nodoc
class _$ScreenTurnCommandCopyWithImpl<$Res, $Val extends ScreenTurnCommand>
    implements $ScreenTurnCommandCopyWith<$Res> {
  _$ScreenTurnCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScreenTurnCommandImplCopyWith<$Res>
    implements $ScreenTurnCommandCopyWith<$Res> {
  factory _$$ScreenTurnCommandImplCopyWith(_$ScreenTurnCommandImpl value,
          $Res Function(_$ScreenTurnCommandImpl) then) =
      __$$ScreenTurnCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enabled, int id, String type});
}

/// @nodoc
class __$$ScreenTurnCommandImplCopyWithImpl<$Res>
    extends _$ScreenTurnCommandCopyWithImpl<$Res, _$ScreenTurnCommandImpl>
    implements _$$ScreenTurnCommandImplCopyWith<$Res> {
  __$$ScreenTurnCommandImplCopyWithImpl(_$ScreenTurnCommandImpl _value,
      $Res Function(_$ScreenTurnCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$ScreenTurnCommandImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScreenTurnCommandImpl implements _ScreenTurnCommand {
  const _$ScreenTurnCommandImpl(
      {required this.enabled,
      required this.id,
      this.type = ScreenTurnCommand.TYPE});

  factory _$ScreenTurnCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScreenTurnCommandImplFromJson(json);

  @override
  final bool enabled;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'ScreenTurnCommand(enabled: $enabled, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScreenTurnCommandImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScreenTurnCommandImplCopyWith<_$ScreenTurnCommandImpl> get copyWith =>
      __$$ScreenTurnCommandImplCopyWithImpl<_$ScreenTurnCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScreenTurnCommandImplToJson(
      this,
    );
  }
}

abstract class _ScreenTurnCommand implements ScreenTurnCommand {
  const factory _ScreenTurnCommand(
      {required final bool enabled,
      required final int id,
      final String type}) = _$ScreenTurnCommandImpl;

  factory _ScreenTurnCommand.fromJson(Map<String, dynamic> json) =
      _$ScreenTurnCommandImpl.fromJson;

  @override
  bool get enabled;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ScreenTurnCommandImplCopyWith<_$ScreenTurnCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScreenLockCommand _$ScreenLockCommandFromJson(Map<String, dynamic> json) {
  return _ScreenLockCommand.fromJson(json);
}

/// @nodoc
mixin _$ScreenLockCommand {
  bool get isLock => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScreenLockCommandCopyWith<ScreenLockCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenLockCommandCopyWith<$Res> {
  factory $ScreenLockCommandCopyWith(
          ScreenLockCommand value, $Res Function(ScreenLockCommand) then) =
      _$ScreenLockCommandCopyWithImpl<$Res, ScreenLockCommand>;
  @useResult
  $Res call({bool isLock, int id, String type});
}

/// @nodoc
class _$ScreenLockCommandCopyWithImpl<$Res, $Val extends ScreenLockCommand>
    implements $ScreenLockCommandCopyWith<$Res> {
  _$ScreenLockCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLock = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      isLock: null == isLock
          ? _value.isLock
          : isLock // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScreenLockCommandImplCopyWith<$Res>
    implements $ScreenLockCommandCopyWith<$Res> {
  factory _$$ScreenLockCommandImplCopyWith(_$ScreenLockCommandImpl value,
          $Res Function(_$ScreenLockCommandImpl) then) =
      __$$ScreenLockCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLock, int id, String type});
}

/// @nodoc
class __$$ScreenLockCommandImplCopyWithImpl<$Res>
    extends _$ScreenLockCommandCopyWithImpl<$Res, _$ScreenLockCommandImpl>
    implements _$$ScreenLockCommandImplCopyWith<$Res> {
  __$$ScreenLockCommandImplCopyWithImpl(_$ScreenLockCommandImpl _value,
      $Res Function(_$ScreenLockCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLock = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$ScreenLockCommandImpl(
      isLock: null == isLock
          ? _value.isLock
          : isLock // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScreenLockCommandImpl implements _ScreenLockCommand {
  const _$ScreenLockCommandImpl(
      {required this.isLock,
      required this.id,
      this.type = ScreenLockCommand.TYPE});

  factory _$ScreenLockCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScreenLockCommandImplFromJson(json);

  @override
  final bool isLock;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'ScreenLockCommand(isLock: $isLock, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScreenLockCommandImpl &&
            (identical(other.isLock, isLock) || other.isLock == isLock) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isLock, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScreenLockCommandImplCopyWith<_$ScreenLockCommandImpl> get copyWith =>
      __$$ScreenLockCommandImplCopyWithImpl<_$ScreenLockCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScreenLockCommandImplToJson(
      this,
    );
  }
}

abstract class _ScreenLockCommand implements ScreenLockCommand {
  const factory _ScreenLockCommand(
      {required final bool isLock,
      required final int id,
      final String type}) = _$ScreenLockCommandImpl;

  factory _ScreenLockCommand.fromJson(Map<String, dynamic> json) =
      _$ScreenLockCommandImpl.fromJson;

  @override
  bool get isLock;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ScreenLockCommandImplCopyWith<_$ScreenLockCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
