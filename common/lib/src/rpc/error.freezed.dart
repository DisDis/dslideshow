// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ErrorResult _$ErrorResultFromJson(Map<String, dynamic> json) {
  return _ErrorResult.fromJson(json);
}

/// @nodoc
mixin _$ErrorResult {
  String get error => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorResultCopyWith<ErrorResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorResultCopyWith<$Res> {
  factory $ErrorResultCopyWith(
          ErrorResult value, $Res Function(ErrorResult) then) =
      _$ErrorResultCopyWithImpl<$Res, ErrorResult>;
  @useResult
  $Res call({String error, int id});
}

/// @nodoc
class _$ErrorResultCopyWithImpl<$Res, $Val extends ErrorResult>
    implements $ErrorResultCopyWith<$Res> {
  _$ErrorResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorResultImplCopyWith<$Res>
    implements $ErrorResultCopyWith<$Res> {
  factory _$$ErrorResultImplCopyWith(
          _$ErrorResultImpl value, $Res Function(_$ErrorResultImpl) then) =
      __$$ErrorResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String error, int id});
}

/// @nodoc
class __$$ErrorResultImplCopyWithImpl<$Res>
    extends _$ErrorResultCopyWithImpl<$Res, _$ErrorResultImpl>
    implements _$$ErrorResultImplCopyWith<$Res> {
  __$$ErrorResultImplCopyWithImpl(
      _$ErrorResultImpl _value, $Res Function(_$ErrorResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? id = null,
  }) {
    return _then(_$ErrorResultImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorResultImpl implements _ErrorResult {
  const _$ErrorResultImpl({required this.error, required this.id});

  factory _$ErrorResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorResultImplFromJson(json);

  @override
  final String error;
  @override
  final int id;

  @override
  String toString() {
    return 'ErrorResult(error: $error, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorResultImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorResultImplCopyWith<_$ErrorResultImpl> get copyWith =>
      __$$ErrorResultImplCopyWithImpl<_$ErrorResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorResultImplToJson(
      this,
    );
  }
}

abstract class _ErrorResult implements ErrorResult {
  const factory _ErrorResult(
      {required final String error, required final int id}) = _$ErrorResultImpl;

  factory _ErrorResult.fromJson(Map<String, dynamic> json) =
      _$ErrorResultImpl.fromJson;

  @override
  String get error;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$ErrorResultImplCopyWith<_$ErrorResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
