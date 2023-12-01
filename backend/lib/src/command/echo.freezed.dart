// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'echo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EchoCommand _$EchoCommandFromJson(Map<String, dynamic> json) {
  return _EchoCommand.fromJson(json);
}

/// @nodoc
mixin _$EchoCommand {
  int get id => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EchoCommandCopyWith<EchoCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EchoCommandCopyWith<$Res> {
  factory $EchoCommandCopyWith(
          EchoCommand value, $Res Function(EchoCommand) then) =
      _$EchoCommandCopyWithImpl<$Res, EchoCommand>;
  @useResult
  $Res call({int id, String? text, String type});
}

/// @nodoc
class _$EchoCommandCopyWithImpl<$Res, $Val extends EchoCommand>
    implements $EchoCommandCopyWith<$Res> {
  _$EchoCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EchoCommandImplCopyWith<$Res>
    implements $EchoCommandCopyWith<$Res> {
  factory _$$EchoCommandImplCopyWith(
          _$EchoCommandImpl value, $Res Function(_$EchoCommandImpl) then) =
      __$$EchoCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? text, String type});
}

/// @nodoc
class __$$EchoCommandImplCopyWithImpl<$Res>
    extends _$EchoCommandCopyWithImpl<$Res, _$EchoCommandImpl>
    implements _$$EchoCommandImplCopyWith<$Res> {
  __$$EchoCommandImplCopyWithImpl(
      _$EchoCommandImpl _value, $Res Function(_$EchoCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = freezed,
    Object? type = null,
  }) {
    return _then(_$EchoCommandImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EchoCommandImpl implements _EchoCommand {
  const _$EchoCommandImpl(
      {required this.id, this.text, this.type = EchoCommand.TYPE});

  factory _$EchoCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$EchoCommandImplFromJson(json);

  @override
  final int id;
  @override
  final String? text;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'EchoCommand(id: $id, text: $text, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EchoCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EchoCommandImplCopyWith<_$EchoCommandImpl> get copyWith =>
      __$$EchoCommandImplCopyWithImpl<_$EchoCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EchoCommandImplToJson(
      this,
    );
  }
}

abstract class _EchoCommand implements EchoCommand {
  const factory _EchoCommand(
      {required final int id,
      final String? text,
      final String type}) = _$EchoCommandImpl;

  factory _EchoCommand.fromJson(Map<String, dynamic> json) =
      _$EchoCommandImpl.fromJson;

  @override
  int get id;
  @override
  String? get text;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$EchoCommandImplCopyWith<_$EchoCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EchoCommandResult _$EchoCommandResultFromJson(Map<String, dynamic> json) {
  return _EchoCommandResult.fromJson(json);
}

/// @nodoc
mixin _$EchoCommandResult {
  int get id => throw _privateConstructorUsedError;
  String? get resultText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EchoCommandResultCopyWith<EchoCommandResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EchoCommandResultCopyWith<$Res> {
  factory $EchoCommandResultCopyWith(
          EchoCommandResult value, $Res Function(EchoCommandResult) then) =
      _$EchoCommandResultCopyWithImpl<$Res, EchoCommandResult>;
  @useResult
  $Res call({int id, String? resultText});
}

/// @nodoc
class _$EchoCommandResultCopyWithImpl<$Res, $Val extends EchoCommandResult>
    implements $EchoCommandResultCopyWith<$Res> {
  _$EchoCommandResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? resultText = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      resultText: freezed == resultText
          ? _value.resultText
          : resultText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EchoCommandResultImplCopyWith<$Res>
    implements $EchoCommandResultCopyWith<$Res> {
  factory _$$EchoCommandResultImplCopyWith(_$EchoCommandResultImpl value,
          $Res Function(_$EchoCommandResultImpl) then) =
      __$$EchoCommandResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? resultText});
}

/// @nodoc
class __$$EchoCommandResultImplCopyWithImpl<$Res>
    extends _$EchoCommandResultCopyWithImpl<$Res, _$EchoCommandResultImpl>
    implements _$$EchoCommandResultImplCopyWith<$Res> {
  __$$EchoCommandResultImplCopyWithImpl(_$EchoCommandResultImpl _value,
      $Res Function(_$EchoCommandResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? resultText = freezed,
  }) {
    return _then(_$EchoCommandResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      resultText: freezed == resultText
          ? _value.resultText
          : resultText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EchoCommandResultImpl implements _EchoCommandResult {
  const _$EchoCommandResultImpl({required this.id, this.resultText});

  factory _$EchoCommandResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$EchoCommandResultImplFromJson(json);

  @override
  final int id;
  @override
  final String? resultText;

  @override
  String toString() {
    return 'EchoCommandResult(id: $id, resultText: $resultText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EchoCommandResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.resultText, resultText) ||
                other.resultText == resultText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, resultText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EchoCommandResultImplCopyWith<_$EchoCommandResultImpl> get copyWith =>
      __$$EchoCommandResultImplCopyWithImpl<_$EchoCommandResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EchoCommandResultImplToJson(
      this,
    );
  }
}

abstract class _EchoCommandResult implements EchoCommandResult {
  const factory _EchoCommandResult(
      {required final int id,
      final String? resultText}) = _$EchoCommandResultImpl;

  factory _EchoCommandResult.fromJson(Map<String, dynamic> json) =
      _$EchoCommandResultImpl.fromJson;

  @override
  int get id;
  @override
  String? get resultText;
  @override
  @JsonKey(ignore: true)
  _$$EchoCommandResultImplCopyWith<_$EchoCommandResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
