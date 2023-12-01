// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetMediaItemCommand _$GetMediaItemCommandFromJson(Map<String, dynamic> json) {
  return _GetMediaItemCommand.fromJson(json);
}

/// @nodoc
mixin _$GetMediaItemCommand {
  bool get isCurrent => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetMediaItemCommandCopyWith<GetMediaItemCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetMediaItemCommandCopyWith<$Res> {
  factory $GetMediaItemCommandCopyWith(
          GetMediaItemCommand value, $Res Function(GetMediaItemCommand) then) =
      _$GetMediaItemCommandCopyWithImpl<$Res, GetMediaItemCommand>;
  @useResult
  $Res call({bool isCurrent, int id, String type});
}

/// @nodoc
class _$GetMediaItemCommandCopyWithImpl<$Res, $Val extends GetMediaItemCommand>
    implements $GetMediaItemCommandCopyWith<$Res> {
  _$GetMediaItemCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCurrent = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
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
abstract class _$$GetMediaItemCommandImplCopyWith<$Res>
    implements $GetMediaItemCommandCopyWith<$Res> {
  factory _$$GetMediaItemCommandImplCopyWith(_$GetMediaItemCommandImpl value,
          $Res Function(_$GetMediaItemCommandImpl) then) =
      __$$GetMediaItemCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isCurrent, int id, String type});
}

/// @nodoc
class __$$GetMediaItemCommandImplCopyWithImpl<$Res>
    extends _$GetMediaItemCommandCopyWithImpl<$Res, _$GetMediaItemCommandImpl>
    implements _$$GetMediaItemCommandImplCopyWith<$Res> {
  __$$GetMediaItemCommandImplCopyWithImpl(_$GetMediaItemCommandImpl _value,
      $Res Function(_$GetMediaItemCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCurrent = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$GetMediaItemCommandImpl(
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
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
class _$GetMediaItemCommandImpl implements _GetMediaItemCommand {
  const _$GetMediaItemCommandImpl(
      {required this.isCurrent,
      required this.id,
      this.type = GetMediaItemCommand.TYPE});

  factory _$GetMediaItemCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetMediaItemCommandImplFromJson(json);

  @override
  final bool isCurrent;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'GetMediaItemCommand(isCurrent: $isCurrent, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetMediaItemCommandImpl &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isCurrent, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetMediaItemCommandImplCopyWith<_$GetMediaItemCommandImpl> get copyWith =>
      __$$GetMediaItemCommandImplCopyWithImpl<_$GetMediaItemCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetMediaItemCommandImplToJson(
      this,
    );
  }
}

abstract class _GetMediaItemCommand implements GetMediaItemCommand {
  const factory _GetMediaItemCommand(
      {required final bool isCurrent,
      required final int id,
      final String type}) = _$GetMediaItemCommandImpl;

  factory _GetMediaItemCommand.fromJson(Map<String, dynamic> json) =
      _$GetMediaItemCommandImpl.fromJson;

  @override
  bool get isCurrent;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$GetMediaItemCommandImplCopyWith<_$GetMediaItemCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GetMediaItemCommandResult _$GetMediaItemCommandResultFromJson(
    Map<String, dynamic> json) {
  return _GetMediaItemCommandResult.fromJson(json);
}

/// @nodoc
mixin _$GetMediaItemCommandResult {
  String? get mediaId => throw _privateConstructorUsedError;
  Uri? get mediaUri => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetMediaItemCommandResultCopyWith<GetMediaItemCommandResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetMediaItemCommandResultCopyWith<$Res> {
  factory $GetMediaItemCommandResultCopyWith(GetMediaItemCommandResult value,
          $Res Function(GetMediaItemCommandResult) then) =
      _$GetMediaItemCommandResultCopyWithImpl<$Res, GetMediaItemCommandResult>;
  @useResult
  $Res call({String? mediaId, Uri? mediaUri, int id});
}

/// @nodoc
class _$GetMediaItemCommandResultCopyWithImpl<$Res,
        $Val extends GetMediaItemCommandResult>
    implements $GetMediaItemCommandResultCopyWith<$Res> {
  _$GetMediaItemCommandResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = freezed,
    Object? mediaUri = freezed,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      mediaId: freezed == mediaId
          ? _value.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaUri: freezed == mediaUri
          ? _value.mediaUri
          : mediaUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetMediaItemCommandResultImplCopyWith<$Res>
    implements $GetMediaItemCommandResultCopyWith<$Res> {
  factory _$$GetMediaItemCommandResultImplCopyWith(
          _$GetMediaItemCommandResultImpl value,
          $Res Function(_$GetMediaItemCommandResultImpl) then) =
      __$$GetMediaItemCommandResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? mediaId, Uri? mediaUri, int id});
}

/// @nodoc
class __$$GetMediaItemCommandResultImplCopyWithImpl<$Res>
    extends _$GetMediaItemCommandResultCopyWithImpl<$Res,
        _$GetMediaItemCommandResultImpl>
    implements _$$GetMediaItemCommandResultImplCopyWith<$Res> {
  __$$GetMediaItemCommandResultImplCopyWithImpl(
      _$GetMediaItemCommandResultImpl _value,
      $Res Function(_$GetMediaItemCommandResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = freezed,
    Object? mediaUri = freezed,
    Object? id = null,
  }) {
    return _then(_$GetMediaItemCommandResultImpl(
      mediaId: freezed == mediaId
          ? _value.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaUri: freezed == mediaUri
          ? _value.mediaUri
          : mediaUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetMediaItemCommandResultImpl implements _GetMediaItemCommandResult {
  const _$GetMediaItemCommandResultImpl(
      {this.mediaId, this.mediaUri, required this.id});

  factory _$GetMediaItemCommandResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetMediaItemCommandResultImplFromJson(json);

  @override
  final String? mediaId;
  @override
  final Uri? mediaUri;
  @override
  final int id;

  @override
  String toString() {
    return 'GetMediaItemCommandResult(mediaId: $mediaId, mediaUri: $mediaUri, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetMediaItemCommandResultImpl &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.mediaUri, mediaUri) ||
                other.mediaUri == mediaUri) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, mediaId, mediaUri, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetMediaItemCommandResultImplCopyWith<_$GetMediaItemCommandResultImpl>
      get copyWith => __$$GetMediaItemCommandResultImplCopyWithImpl<
          _$GetMediaItemCommandResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetMediaItemCommandResultImplToJson(
      this,
    );
  }
}

abstract class _GetMediaItemCommandResult implements GetMediaItemCommandResult {
  const factory _GetMediaItemCommandResult(
      {final String? mediaId,
      final Uri? mediaUri,
      required final int id}) = _$GetMediaItemCommandResultImpl;

  factory _GetMediaItemCommandResult.fromJson(Map<String, dynamic> json) =
      _$GetMediaItemCommandResultImpl.fromJson;

  @override
  String? get mediaId;
  @override
  Uri? get mediaUri;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$GetMediaItemCommandResultImplCopyWith<_$GetMediaItemCommandResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StorageNextCommand _$StorageNextCommandFromJson(Map<String, dynamic> json) {
  return _StorageNextCommand.fromJson(json);
}

/// @nodoc
mixin _$StorageNextCommand {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StorageNextCommandCopyWith<StorageNextCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageNextCommandCopyWith<$Res> {
  factory $StorageNextCommandCopyWith(
          StorageNextCommand value, $Res Function(StorageNextCommand) then) =
      _$StorageNextCommandCopyWithImpl<$Res, StorageNextCommand>;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$StorageNextCommandCopyWithImpl<$Res, $Val extends StorageNextCommand>
    implements $StorageNextCommandCopyWith<$Res> {
  _$StorageNextCommandCopyWithImpl(this._value, this._then);

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
abstract class _$$StorageNextCommandImplCopyWith<$Res>
    implements $StorageNextCommandCopyWith<$Res> {
  factory _$$StorageNextCommandImplCopyWith(_$StorageNextCommandImpl value,
          $Res Function(_$StorageNextCommandImpl) then) =
      __$$StorageNextCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$$StorageNextCommandImplCopyWithImpl<$Res>
    extends _$StorageNextCommandCopyWithImpl<$Res, _$StorageNextCommandImpl>
    implements _$$StorageNextCommandImplCopyWith<$Res> {
  __$$StorageNextCommandImplCopyWithImpl(_$StorageNextCommandImpl _value,
      $Res Function(_$StorageNextCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$StorageNextCommandImpl(
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
class _$StorageNextCommandImpl implements _StorageNextCommand {
  const _$StorageNextCommandImpl(
      {required this.id, this.type = StorageNextCommand.TYPE});

  factory _$StorageNextCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorageNextCommandImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'StorageNextCommand(id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageNextCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageNextCommandImplCopyWith<_$StorageNextCommandImpl> get copyWith =>
      __$$StorageNextCommandImplCopyWithImpl<_$StorageNextCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StorageNextCommandImplToJson(
      this,
    );
  }
}

abstract class _StorageNextCommand implements StorageNextCommand {
  const factory _StorageNextCommand(
      {required final int id, final String type}) = _$StorageNextCommandImpl;

  factory _StorageNextCommand.fromJson(Map<String, dynamic> json) =
      _$StorageNextCommandImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$StorageNextCommandImplCopyWith<_$StorageNextCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
