// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_info_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetSystemInfoCommand _$GetSystemInfoCommandFromJson(Map<String, dynamic> json) {
  return _GetSystemInfoCommand.fromJson(json);
}

/// @nodoc
mixin _$GetSystemInfoCommand {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetSystemInfoCommandCopyWith<GetSystemInfoCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetSystemInfoCommandCopyWith<$Res> {
  factory $GetSystemInfoCommandCopyWith(GetSystemInfoCommand value,
          $Res Function(GetSystemInfoCommand) then) =
      _$GetSystemInfoCommandCopyWithImpl<$Res, GetSystemInfoCommand>;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$GetSystemInfoCommandCopyWithImpl<$Res,
        $Val extends GetSystemInfoCommand>
    implements $GetSystemInfoCommandCopyWith<$Res> {
  _$GetSystemInfoCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$GetSystemInfoCommandImplCopyWith<$Res>
    implements $GetSystemInfoCommandCopyWith<$Res> {
  factory _$$GetSystemInfoCommandImplCopyWith(_$GetSystemInfoCommandImpl value,
          $Res Function(_$GetSystemInfoCommandImpl) then) =
      __$$GetSystemInfoCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$$GetSystemInfoCommandImplCopyWithImpl<$Res>
    extends _$GetSystemInfoCommandCopyWithImpl<$Res, _$GetSystemInfoCommandImpl>
    implements _$$GetSystemInfoCommandImplCopyWith<$Res> {
  __$$GetSystemInfoCommandImplCopyWithImpl(_$GetSystemInfoCommandImpl _value,
      $Res Function(_$GetSystemInfoCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$GetSystemInfoCommandImpl(
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
class _$GetSystemInfoCommandImpl implements _GetSystemInfoCommand {
  const _$GetSystemInfoCommandImpl(
      {required this.id, this.type = GetSystemInfoCommand.TYPE});

  factory _$GetSystemInfoCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetSystemInfoCommandImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'GetSystemInfoCommand(id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSystemInfoCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetSystemInfoCommandImplCopyWith<_$GetSystemInfoCommandImpl>
      get copyWith =>
          __$$GetSystemInfoCommandImplCopyWithImpl<_$GetSystemInfoCommandImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetSystemInfoCommandImplToJson(
      this,
    );
  }
}

abstract class _GetSystemInfoCommand implements GetSystemInfoCommand {
  const factory _GetSystemInfoCommand(
      {required final int id, final String type}) = _$GetSystemInfoCommandImpl;

  factory _GetSystemInfoCommand.fromJson(Map<String, dynamic> json) =
      _$GetSystemInfoCommandImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$GetSystemInfoCommandImplCopyWith<_$GetSystemInfoCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetSystemInfoCommandResult _$GetSystemInfoCommandResultFromJson(
    Map<String, dynamic> json) {
  return _GetSystemInfoCommandResult.fromJson(json);
}

/// @nodoc
mixin _$GetSystemInfoCommandResult {
  SystemInfo get systemInfo => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetSystemInfoCommandResultCopyWith<GetSystemInfoCommandResult>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetSystemInfoCommandResultCopyWith<$Res> {
  factory $GetSystemInfoCommandResultCopyWith(GetSystemInfoCommandResult value,
          $Res Function(GetSystemInfoCommandResult) then) =
      _$GetSystemInfoCommandResultCopyWithImpl<$Res,
          GetSystemInfoCommandResult>;
  @useResult
  $Res call({SystemInfo systemInfo, int id});

  $SystemInfoCopyWith<$Res> get systemInfo;
}

/// @nodoc
class _$GetSystemInfoCommandResultCopyWithImpl<$Res,
        $Val extends GetSystemInfoCommandResult>
    implements $GetSystemInfoCommandResultCopyWith<$Res> {
  _$GetSystemInfoCommandResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemInfo = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      systemInfo: null == systemInfo
          ? _value.systemInfo
          : systemInfo // ignore: cast_nullable_to_non_nullable
              as SystemInfo,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SystemInfoCopyWith<$Res> get systemInfo {
    return $SystemInfoCopyWith<$Res>(_value.systemInfo, (value) {
      return _then(_value.copyWith(systemInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetSystemInfoCommandResultImplCopyWith<$Res>
    implements $GetSystemInfoCommandResultCopyWith<$Res> {
  factory _$$GetSystemInfoCommandResultImplCopyWith(
          _$GetSystemInfoCommandResultImpl value,
          $Res Function(_$GetSystemInfoCommandResultImpl) then) =
      __$$GetSystemInfoCommandResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SystemInfo systemInfo, int id});

  @override
  $SystemInfoCopyWith<$Res> get systemInfo;
}

/// @nodoc
class __$$GetSystemInfoCommandResultImplCopyWithImpl<$Res>
    extends _$GetSystemInfoCommandResultCopyWithImpl<$Res,
        _$GetSystemInfoCommandResultImpl>
    implements _$$GetSystemInfoCommandResultImplCopyWith<$Res> {
  __$$GetSystemInfoCommandResultImplCopyWithImpl(
      _$GetSystemInfoCommandResultImpl _value,
      $Res Function(_$GetSystemInfoCommandResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemInfo = null,
    Object? id = null,
  }) {
    return _then(_$GetSystemInfoCommandResultImpl(
      systemInfo: null == systemInfo
          ? _value.systemInfo
          : systemInfo // ignore: cast_nullable_to_non_nullable
              as SystemInfo,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetSystemInfoCommandResultImpl implements _GetSystemInfoCommandResult {
  const _$GetSystemInfoCommandResultImpl(
      {required this.systemInfo, required this.id});

  factory _$GetSystemInfoCommandResultImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetSystemInfoCommandResultImplFromJson(json);

  @override
  final SystemInfo systemInfo;
  @override
  final int id;

  @override
  String toString() {
    return 'GetSystemInfoCommandResult(systemInfo: $systemInfo, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSystemInfoCommandResultImpl &&
            (identical(other.systemInfo, systemInfo) ||
                other.systemInfo == systemInfo) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, systemInfo, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetSystemInfoCommandResultImplCopyWith<_$GetSystemInfoCommandResultImpl>
      get copyWith => __$$GetSystemInfoCommandResultImplCopyWithImpl<
          _$GetSystemInfoCommandResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetSystemInfoCommandResultImplToJson(
      this,
    );
  }
}

abstract class _GetSystemInfoCommandResult
    implements GetSystemInfoCommandResult {
  const factory _GetSystemInfoCommandResult(
      {required final SystemInfo systemInfo,
      required final int id}) = _$GetSystemInfoCommandResultImpl;

  factory _GetSystemInfoCommandResult.fromJson(Map<String, dynamic> json) =
      _$GetSystemInfoCommandResultImpl.fromJson;

  @override
  SystemInfo get systemInfo;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$GetSystemInfoCommandResultImplCopyWith<_$GetSystemInfoCommandResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}
