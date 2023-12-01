// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OTAReadyCommand _$OTAReadyCommandFromJson(Map<String, dynamic> json) {
  return _OTAReadyCommand.fromJson(json);
}

/// @nodoc
mixin _$OTAReadyCommand {
  bool get ready => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OTAReadyCommandCopyWith<OTAReadyCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OTAReadyCommandCopyWith<$Res> {
  factory $OTAReadyCommandCopyWith(
          OTAReadyCommand value, $Res Function(OTAReadyCommand) then) =
      _$OTAReadyCommandCopyWithImpl<$Res, OTAReadyCommand>;
  @useResult
  $Res call({bool ready, int id, String type});
}

/// @nodoc
class _$OTAReadyCommandCopyWithImpl<$Res, $Val extends OTAReadyCommand>
    implements $OTAReadyCommandCopyWith<$Res> {
  _$OTAReadyCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ready = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      ready: null == ready
          ? _value.ready
          : ready // ignore: cast_nullable_to_non_nullable
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
abstract class _$$OTAReadyCommandImplCopyWith<$Res>
    implements $OTAReadyCommandCopyWith<$Res> {
  factory _$$OTAReadyCommandImplCopyWith(_$OTAReadyCommandImpl value,
          $Res Function(_$OTAReadyCommandImpl) then) =
      __$$OTAReadyCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool ready, int id, String type});
}

/// @nodoc
class __$$OTAReadyCommandImplCopyWithImpl<$Res>
    extends _$OTAReadyCommandCopyWithImpl<$Res, _$OTAReadyCommandImpl>
    implements _$$OTAReadyCommandImplCopyWith<$Res> {
  __$$OTAReadyCommandImplCopyWithImpl(
      _$OTAReadyCommandImpl _value, $Res Function(_$OTAReadyCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ready = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$OTAReadyCommandImpl(
      ready: null == ready
          ? _value.ready
          : ready // ignore: cast_nullable_to_non_nullable
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
class _$OTAReadyCommandImpl implements _OTAReadyCommand {
  const _$OTAReadyCommandImpl(
      {required this.ready,
      required this.id,
      this.type = OTAReadyCommand.TYPE});

  factory _$OTAReadyCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$OTAReadyCommandImplFromJson(json);

  @override
  final bool ready;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'OTAReadyCommand(ready: $ready, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OTAReadyCommandImpl &&
            (identical(other.ready, ready) || other.ready == ready) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ready, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OTAReadyCommandImplCopyWith<_$OTAReadyCommandImpl> get copyWith =>
      __$$OTAReadyCommandImplCopyWithImpl<_$OTAReadyCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OTAReadyCommandImplToJson(
      this,
    );
  }
}

abstract class _OTAReadyCommand implements OTAReadyCommand {
  const factory _OTAReadyCommand(
      {required final bool ready,
      required final int id,
      final String type}) = _$OTAReadyCommandImpl;

  factory _OTAReadyCommand.fromJson(Map<String, dynamic> json) =
      _$OTAReadyCommandImpl.fromJson;

  @override
  bool get ready;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$OTAReadyCommandImplCopyWith<_$OTAReadyCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OTAGetInfoCommand _$OTAGetInfoCommandFromJson(Map<String, dynamic> json) {
  return _OTAGetInfoCommand.fromJson(json);
}

/// @nodoc
mixin _$OTAGetInfoCommand {
  OTAInfo? get info => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OTAGetInfoCommandCopyWith<OTAGetInfoCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OTAGetInfoCommandCopyWith<$Res> {
  factory $OTAGetInfoCommandCopyWith(
          OTAGetInfoCommand value, $Res Function(OTAGetInfoCommand) then) =
      _$OTAGetInfoCommandCopyWithImpl<$Res, OTAGetInfoCommand>;
  @useResult
  $Res call({OTAInfo? info, int id, String type});

  $OTAInfoCopyWith<$Res>? get info;
}

/// @nodoc
class _$OTAGetInfoCommandCopyWithImpl<$Res, $Val extends OTAGetInfoCommand>
    implements $OTAGetInfoCommandCopyWith<$Res> {
  _$OTAGetInfoCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = freezed,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo?,
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

  @override
  @pragma('vm:prefer-inline')
  $OTAInfoCopyWith<$Res>? get info {
    if (_value.info == null) {
      return null;
    }

    return $OTAInfoCopyWith<$Res>(_value.info!, (value) {
      return _then(_value.copyWith(info: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OTAGetInfoCommandImplCopyWith<$Res>
    implements $OTAGetInfoCommandCopyWith<$Res> {
  factory _$$OTAGetInfoCommandImplCopyWith(_$OTAGetInfoCommandImpl value,
          $Res Function(_$OTAGetInfoCommandImpl) then) =
      __$$OTAGetInfoCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OTAInfo? info, int id, String type});

  @override
  $OTAInfoCopyWith<$Res>? get info;
}

/// @nodoc
class __$$OTAGetInfoCommandImplCopyWithImpl<$Res>
    extends _$OTAGetInfoCommandCopyWithImpl<$Res, _$OTAGetInfoCommandImpl>
    implements _$$OTAGetInfoCommandImplCopyWith<$Res> {
  __$$OTAGetInfoCommandImplCopyWithImpl(_$OTAGetInfoCommandImpl _value,
      $Res Function(_$OTAGetInfoCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = freezed,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$OTAGetInfoCommandImpl(
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo?,
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
class _$OTAGetInfoCommandImpl implements _OTAGetInfoCommand {
  const _$OTAGetInfoCommandImpl(
      {this.info, required this.id, this.type = OTAGetInfoCommand.TYPE});

  factory _$OTAGetInfoCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$OTAGetInfoCommandImplFromJson(json);

  @override
  final OTAInfo? info;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'OTAGetInfoCommand(info: $info, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OTAGetInfoCommandImpl &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, info, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OTAGetInfoCommandImplCopyWith<_$OTAGetInfoCommandImpl> get copyWith =>
      __$$OTAGetInfoCommandImplCopyWithImpl<_$OTAGetInfoCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OTAGetInfoCommandImplToJson(
      this,
    );
  }
}

abstract class _OTAGetInfoCommand implements OTAGetInfoCommand {
  const factory _OTAGetInfoCommand(
      {final OTAInfo? info,
      required final int id,
      final String type}) = _$OTAGetInfoCommandImpl;

  factory _OTAGetInfoCommand.fromJson(Map<String, dynamic> json) =
      _$OTAGetInfoCommandImpl.fromJson;

  @override
  OTAInfo? get info;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$OTAGetInfoCommandImplCopyWith<_$OTAGetInfoCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OTAGetInfoCommandResult _$OTAGetInfoCommandResultFromJson(
    Map<String, dynamic> json) {
  return _OTAGetInfoCommandResult.fromJson(json);
}

/// @nodoc
mixin _$OTAGetInfoCommandResult {
  OTAInfo get info => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OTAGetInfoCommandResultCopyWith<OTAGetInfoCommandResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OTAGetInfoCommandResultCopyWith<$Res> {
  factory $OTAGetInfoCommandResultCopyWith(OTAGetInfoCommandResult value,
          $Res Function(OTAGetInfoCommandResult) then) =
      _$OTAGetInfoCommandResultCopyWithImpl<$Res, OTAGetInfoCommandResult>;
  @useResult
  $Res call({OTAInfo info, int id});

  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$OTAGetInfoCommandResultCopyWithImpl<$Res,
        $Val extends OTAGetInfoCommandResult>
    implements $OTAGetInfoCommandResultCopyWith<$Res> {
  _$OTAGetInfoCommandResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OTAInfoCopyWith<$Res> get info {
    return $OTAInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OTAGetInfoCommandResultImplCopyWith<$Res>
    implements $OTAGetInfoCommandResultCopyWith<$Res> {
  factory _$$OTAGetInfoCommandResultImplCopyWith(
          _$OTAGetInfoCommandResultImpl value,
          $Res Function(_$OTAGetInfoCommandResultImpl) then) =
      __$$OTAGetInfoCommandResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OTAInfo info, int id});

  @override
  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$OTAGetInfoCommandResultImplCopyWithImpl<$Res>
    extends _$OTAGetInfoCommandResultCopyWithImpl<$Res,
        _$OTAGetInfoCommandResultImpl>
    implements _$$OTAGetInfoCommandResultImplCopyWith<$Res> {
  __$$OTAGetInfoCommandResultImplCopyWithImpl(
      _$OTAGetInfoCommandResultImpl _value,
      $Res Function(_$OTAGetInfoCommandResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? id = null,
  }) {
    return _then(_$OTAGetInfoCommandResultImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OTAGetInfoCommandResultImpl implements _OTAGetInfoCommandResult {
  const _$OTAGetInfoCommandResultImpl({required this.info, required this.id});

  factory _$OTAGetInfoCommandResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$OTAGetInfoCommandResultImplFromJson(json);

  @override
  final OTAInfo info;
  @override
  final int id;

  @override
  String toString() {
    return 'OTAGetInfoCommandResult(info: $info, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OTAGetInfoCommandResultImpl &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, info, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OTAGetInfoCommandResultImplCopyWith<_$OTAGetInfoCommandResultImpl>
      get copyWith => __$$OTAGetInfoCommandResultImplCopyWithImpl<
          _$OTAGetInfoCommandResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OTAGetInfoCommandResultImplToJson(
      this,
    );
  }
}

abstract class _OTAGetInfoCommandResult implements OTAGetInfoCommandResult {
  const factory _OTAGetInfoCommandResult(
      {required final OTAInfo info,
      required final int id}) = _$OTAGetInfoCommandResultImpl;

  factory _OTAGetInfoCommandResult.fromJson(Map<String, dynamic> json) =
      _$OTAGetInfoCommandResultImpl.fromJson;

  @override
  OTAInfo get info;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$OTAGetInfoCommandResultImplCopyWith<_$OTAGetInfoCommandResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OTAOutputCommand _$OTAOutputCommandFromJson(Map<String, dynamic> json) {
  return _OTAOutputCommand.fromJson(json);
}

/// @nodoc
mixin _$OTAOutputCommand {
  int get id => throw _privateConstructorUsedError;
  String get output => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OTAOutputCommandCopyWith<OTAOutputCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OTAOutputCommandCopyWith<$Res> {
  factory $OTAOutputCommandCopyWith(
          OTAOutputCommand value, $Res Function(OTAOutputCommand) then) =
      _$OTAOutputCommandCopyWithImpl<$Res, OTAOutputCommand>;
  @useResult
  $Res call({int id, String output, String type});
}

/// @nodoc
class _$OTAOutputCommandCopyWithImpl<$Res, $Val extends OTAOutputCommand>
    implements $OTAOutputCommandCopyWith<$Res> {
  _$OTAOutputCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? output = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OTAOutputCommandImplCopyWith<$Res>
    implements $OTAOutputCommandCopyWith<$Res> {
  factory _$$OTAOutputCommandImplCopyWith(_$OTAOutputCommandImpl value,
          $Res Function(_$OTAOutputCommandImpl) then) =
      __$$OTAOutputCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String output, String type});
}

/// @nodoc
class __$$OTAOutputCommandImplCopyWithImpl<$Res>
    extends _$OTAOutputCommandCopyWithImpl<$Res, _$OTAOutputCommandImpl>
    implements _$$OTAOutputCommandImplCopyWith<$Res> {
  __$$OTAOutputCommandImplCopyWithImpl(_$OTAOutputCommandImpl _value,
      $Res Function(_$OTAOutputCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? output = null,
    Object? type = null,
  }) {
    return _then(_$OTAOutputCommandImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OTAOutputCommandImpl implements _OTAOutputCommand {
  const _$OTAOutputCommandImpl(
      {required this.id,
      required this.output,
      this.type = OTAOutputCommand.TYPE});

  factory _$OTAOutputCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$OTAOutputCommandImplFromJson(json);

  @override
  final int id;
  @override
  final String output;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'OTAOutputCommand(id: $id, output: $output, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OTAOutputCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.output, output) || other.output == output) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, output, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OTAOutputCommandImplCopyWith<_$OTAOutputCommandImpl> get copyWith =>
      __$$OTAOutputCommandImplCopyWithImpl<_$OTAOutputCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OTAOutputCommandImplToJson(
      this,
    );
  }
}

abstract class _OTAOutputCommand implements OTAOutputCommand {
  const factory _OTAOutputCommand(
      {required final int id,
      required final String output,
      final String type}) = _$OTAOutputCommandImpl;

  factory _OTAOutputCommand.fromJson(Map<String, dynamic> json) =
      _$OTAOutputCommandImpl.fromJson;

  @override
  int get id;
  @override
  String get output;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$OTAOutputCommandImplCopyWith<_$OTAOutputCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OTAInfo _$OTAInfoFromJson(Map<String, dynamic> json) {
  return _OTAInfo.fromJson(json);
}

/// @nodoc
mixin _$OTAInfo {
  OTAStatus get status => throw _privateConstructorUsedError;
  double get uploadingPercent => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  int? get exitCode => throw _privateConstructorUsedError;
  String? get errorText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OTAInfoCopyWith<OTAInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OTAInfoCopyWith<$Res> {
  factory $OTAInfoCopyWith(OTAInfo value, $Res Function(OTAInfo) then) =
      _$OTAInfoCopyWithImpl<$Res, OTAInfo>;
  @useResult
  $Res call(
      {OTAStatus status,
      double uploadingPercent,
      String code,
      int? exitCode,
      String? errorText});
}

/// @nodoc
class _$OTAInfoCopyWithImpl<$Res, $Val extends OTAInfo>
    implements $OTAInfoCopyWith<$Res> {
  _$OTAInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? uploadingPercent = null,
    Object? code = null,
    Object? exitCode = freezed,
    Object? errorText = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OTAStatus,
      uploadingPercent: null == uploadingPercent
          ? _value.uploadingPercent
          : uploadingPercent // ignore: cast_nullable_to_non_nullable
              as double,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      exitCode: freezed == exitCode
          ? _value.exitCode
          : exitCode // ignore: cast_nullable_to_non_nullable
              as int?,
      errorText: freezed == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OTAInfoImplCopyWith<$Res> implements $OTAInfoCopyWith<$Res> {
  factory _$$OTAInfoImplCopyWith(
          _$OTAInfoImpl value, $Res Function(_$OTAInfoImpl) then) =
      __$$OTAInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OTAStatus status,
      double uploadingPercent,
      String code,
      int? exitCode,
      String? errorText});
}

/// @nodoc
class __$$OTAInfoImplCopyWithImpl<$Res>
    extends _$OTAInfoCopyWithImpl<$Res, _$OTAInfoImpl>
    implements _$$OTAInfoImplCopyWith<$Res> {
  __$$OTAInfoImplCopyWithImpl(
      _$OTAInfoImpl _value, $Res Function(_$OTAInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? uploadingPercent = null,
    Object? code = null,
    Object? exitCode = freezed,
    Object? errorText = freezed,
  }) {
    return _then(_$OTAInfoImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OTAStatus,
      uploadingPercent: null == uploadingPercent
          ? _value.uploadingPercent
          : uploadingPercent // ignore: cast_nullable_to_non_nullable
              as double,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      exitCode: freezed == exitCode
          ? _value.exitCode
          : exitCode // ignore: cast_nullable_to_non_nullable
              as int?,
      errorText: freezed == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OTAInfoImpl implements _OTAInfo {
  const _$OTAInfoImpl(
      {required this.status,
      required this.uploadingPercent,
      required this.code,
      this.exitCode,
      this.errorText});

  factory _$OTAInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OTAInfoImplFromJson(json);

  @override
  final OTAStatus status;
  @override
  final double uploadingPercent;
  @override
  final String code;
  @override
  final int? exitCode;
  @override
  final String? errorText;

  @override
  String toString() {
    return 'OTAInfo(status: $status, uploadingPercent: $uploadingPercent, code: $code, exitCode: $exitCode, errorText: $errorText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OTAInfoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.uploadingPercent, uploadingPercent) ||
                other.uploadingPercent == uploadingPercent) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.exitCode, exitCode) ||
                other.exitCode == exitCode) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, uploadingPercent, code, exitCode, errorText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OTAInfoImplCopyWith<_$OTAInfoImpl> get copyWith =>
      __$$OTAInfoImplCopyWithImpl<_$OTAInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OTAInfoImplToJson(
      this,
    );
  }
}

abstract class _OTAInfo implements OTAInfo {
  const factory _OTAInfo(
      {required final OTAStatus status,
      required final double uploadingPercent,
      required final String code,
      final int? exitCode,
      final String? errorText}) = _$OTAInfoImpl;

  factory _OTAInfo.fromJson(Map<String, dynamic> json) = _$OTAInfoImpl.fromJson;

  @override
  OTAStatus get status;
  @override
  double get uploadingPercent;
  @override
  String get code;
  @override
  int? get exitCode;
  @override
  String? get errorText;
  @override
  @JsonKey(ignore: true)
  _$$OTAInfoImplCopyWith<_$OTAInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
