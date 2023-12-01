// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'empty_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EmptyResult _$EmptyResultFromJson(Map<String, dynamic> json) {
  return _EmptyResult.fromJson(json);
}

/// @nodoc
mixin _$EmptyResult {
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmptyResultCopyWith<EmptyResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmptyResultCopyWith<$Res> {
  factory $EmptyResultCopyWith(
          EmptyResult value, $Res Function(EmptyResult) then) =
      _$EmptyResultCopyWithImpl<$Res, EmptyResult>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$EmptyResultCopyWithImpl<$Res, $Val extends EmptyResult>
    implements $EmptyResultCopyWith<$Res> {
  _$EmptyResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmptyResultImplCopyWith<$Res>
    implements $EmptyResultCopyWith<$Res> {
  factory _$$EmptyResultImplCopyWith(
          _$EmptyResultImpl value, $Res Function(_$EmptyResultImpl) then) =
      __$$EmptyResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$EmptyResultImplCopyWithImpl<$Res>
    extends _$EmptyResultCopyWithImpl<$Res, _$EmptyResultImpl>
    implements _$$EmptyResultImplCopyWith<$Res> {
  __$$EmptyResultImplCopyWithImpl(
      _$EmptyResultImpl _value, $Res Function(_$EmptyResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$EmptyResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmptyResultImpl implements _EmptyResult {
  const _$EmptyResultImpl({required this.id});

  factory _$EmptyResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmptyResultImplFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'EmptyResult(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmptyResultImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmptyResultImplCopyWith<_$EmptyResultImpl> get copyWith =>
      __$$EmptyResultImplCopyWithImpl<_$EmptyResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmptyResultImplToJson(
      this,
    );
  }
}

abstract class _EmptyResult implements EmptyResult {
  const factory _EmptyResult({required final int id}) = _$EmptyResultImpl;

  factory _EmptyResult.fromJson(Map<String, dynamic> json) =
      _$EmptyResultImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$EmptyResultImplCopyWith<_$EmptyResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
