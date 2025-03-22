// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OTAReadyCommand {
  bool get ready;
  int get id;
  String get type;

  /// Create a copy of OTAReadyCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OTAReadyCommandCopyWith<OTAReadyCommand> get copyWith =>
      _$OTAReadyCommandCopyWithImpl<OTAReadyCommand>(
          this as OTAReadyCommand, _$identity);

  /// Serializes this OTAReadyCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OTAReadyCommand &&
            (identical(other.ready, ready) || other.ready == ready) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ready, id, type);

  @override
  String toString() {
    return 'OTAReadyCommand(ready: $ready, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $OTAReadyCommandCopyWith<$Res> {
  factory $OTAReadyCommandCopyWith(
          OTAReadyCommand value, $Res Function(OTAReadyCommand) _then) =
      _$OTAReadyCommandCopyWithImpl;
  @useResult
  $Res call({bool ready, int id, String type});
}

/// @nodoc
class _$OTAReadyCommandCopyWithImpl<$Res>
    implements $OTAReadyCommandCopyWith<$Res> {
  _$OTAReadyCommandCopyWithImpl(this._self, this._then);

  final OTAReadyCommand _self;
  final $Res Function(OTAReadyCommand) _then;

  /// Create a copy of OTAReadyCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ready = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      ready: null == ready
          ? _self.ready
          : ready // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _OTAReadyCommand implements OTAReadyCommand {
  const _OTAReadyCommand(
      {required this.ready,
      required this.id,
      this.type = OTAReadyCommand.TYPE});
  factory _OTAReadyCommand.fromJson(Map<String, dynamic> json) =>
      _$OTAReadyCommandFromJson(json);

  @override
  final bool ready;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of OTAReadyCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OTAReadyCommandCopyWith<_OTAReadyCommand> get copyWith =>
      __$OTAReadyCommandCopyWithImpl<_OTAReadyCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OTAReadyCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OTAReadyCommand &&
            (identical(other.ready, ready) || other.ready == ready) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ready, id, type);

  @override
  String toString() {
    return 'OTAReadyCommand(ready: $ready, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$OTAReadyCommandCopyWith<$Res>
    implements $OTAReadyCommandCopyWith<$Res> {
  factory _$OTAReadyCommandCopyWith(
          _OTAReadyCommand value, $Res Function(_OTAReadyCommand) _then) =
      __$OTAReadyCommandCopyWithImpl;
  @override
  @useResult
  $Res call({bool ready, int id, String type});
}

/// @nodoc
class __$OTAReadyCommandCopyWithImpl<$Res>
    implements _$OTAReadyCommandCopyWith<$Res> {
  __$OTAReadyCommandCopyWithImpl(this._self, this._then);

  final _OTAReadyCommand _self;
  final $Res Function(_OTAReadyCommand) _then;

  /// Create a copy of OTAReadyCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ready = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_OTAReadyCommand(
      ready: null == ready
          ? _self.ready
          : ready // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$OTAGetInfoCommand {
  OTAInfo? get info;
  int get id;
  String get type;

  /// Create a copy of OTAGetInfoCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OTAGetInfoCommandCopyWith<OTAGetInfoCommand> get copyWith =>
      _$OTAGetInfoCommandCopyWithImpl<OTAGetInfoCommand>(
          this as OTAGetInfoCommand, _$identity);

  /// Serializes this OTAGetInfoCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OTAGetInfoCommand &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, info, id, type);

  @override
  String toString() {
    return 'OTAGetInfoCommand(info: $info, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $OTAGetInfoCommandCopyWith<$Res> {
  factory $OTAGetInfoCommandCopyWith(
          OTAGetInfoCommand value, $Res Function(OTAGetInfoCommand) _then) =
      _$OTAGetInfoCommandCopyWithImpl;
  @useResult
  $Res call({OTAInfo? info, int id, String type});

  $OTAInfoCopyWith<$Res>? get info;
}

/// @nodoc
class _$OTAGetInfoCommandCopyWithImpl<$Res>
    implements $OTAGetInfoCommandCopyWith<$Res> {
  _$OTAGetInfoCommandCopyWithImpl(this._self, this._then);

  final OTAGetInfoCommand _self;
  final $Res Function(OTAGetInfoCommand) _then;

  /// Create a copy of OTAGetInfoCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = freezed,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      info: freezed == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of OTAGetInfoCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OTAInfoCopyWith<$Res>? get info {
    if (_self.info == null) {
      return null;
    }

    return $OTAInfoCopyWith<$Res>(_self.info!, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _OTAGetInfoCommand implements OTAGetInfoCommand {
  const _OTAGetInfoCommand(
      {this.info, required this.id, this.type = OTAGetInfoCommand.TYPE});
  factory _OTAGetInfoCommand.fromJson(Map<String, dynamic> json) =>
      _$OTAGetInfoCommandFromJson(json);

  @override
  final OTAInfo? info;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of OTAGetInfoCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OTAGetInfoCommandCopyWith<_OTAGetInfoCommand> get copyWith =>
      __$OTAGetInfoCommandCopyWithImpl<_OTAGetInfoCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OTAGetInfoCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OTAGetInfoCommand &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, info, id, type);

  @override
  String toString() {
    return 'OTAGetInfoCommand(info: $info, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$OTAGetInfoCommandCopyWith<$Res>
    implements $OTAGetInfoCommandCopyWith<$Res> {
  factory _$OTAGetInfoCommandCopyWith(
          _OTAGetInfoCommand value, $Res Function(_OTAGetInfoCommand) _then) =
      __$OTAGetInfoCommandCopyWithImpl;
  @override
  @useResult
  $Res call({OTAInfo? info, int id, String type});

  @override
  $OTAInfoCopyWith<$Res>? get info;
}

/// @nodoc
class __$OTAGetInfoCommandCopyWithImpl<$Res>
    implements _$OTAGetInfoCommandCopyWith<$Res> {
  __$OTAGetInfoCommandCopyWithImpl(this._self, this._then);

  final _OTAGetInfoCommand _self;
  final $Res Function(_OTAGetInfoCommand) _then;

  /// Create a copy of OTAGetInfoCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = freezed,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_OTAGetInfoCommand(
      info: freezed == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of OTAGetInfoCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OTAInfoCopyWith<$Res>? get info {
    if (_self.info == null) {
      return null;
    }

    return $OTAInfoCopyWith<$Res>(_self.info!, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc
mixin _$OTAGetInfoCommandResult {
  OTAInfo get info;
  int get id;

  /// Create a copy of OTAGetInfoCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OTAGetInfoCommandResultCopyWith<OTAGetInfoCommandResult> get copyWith =>
      _$OTAGetInfoCommandResultCopyWithImpl<OTAGetInfoCommandResult>(
          this as OTAGetInfoCommandResult, _$identity);

  /// Serializes this OTAGetInfoCommandResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OTAGetInfoCommandResult &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, info, id);

  @override
  String toString() {
    return 'OTAGetInfoCommandResult(info: $info, id: $id)';
  }
}

/// @nodoc
abstract mixin class $OTAGetInfoCommandResultCopyWith<$Res> {
  factory $OTAGetInfoCommandResultCopyWith(OTAGetInfoCommandResult value,
          $Res Function(OTAGetInfoCommandResult) _then) =
      _$OTAGetInfoCommandResultCopyWithImpl;
  @useResult
  $Res call({OTAInfo info, int id});

  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$OTAGetInfoCommandResultCopyWithImpl<$Res>
    implements $OTAGetInfoCommandResultCopyWith<$Res> {
  _$OTAGetInfoCommandResultCopyWithImpl(this._self, this._then);

  final OTAGetInfoCommandResult _self;
  final $Res Function(OTAGetInfoCommandResult) _then;

  /// Create a copy of OTAGetInfoCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      info: null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of OTAGetInfoCommandResult
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
@JsonSerializable()
class _OTAGetInfoCommandResult implements OTAGetInfoCommandResult {
  const _OTAGetInfoCommandResult({required this.info, required this.id});
  factory _OTAGetInfoCommandResult.fromJson(Map<String, dynamic> json) =>
      _$OTAGetInfoCommandResultFromJson(json);

  @override
  final OTAInfo info;
  @override
  final int id;

  /// Create a copy of OTAGetInfoCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OTAGetInfoCommandResultCopyWith<_OTAGetInfoCommandResult> get copyWith =>
      __$OTAGetInfoCommandResultCopyWithImpl<_OTAGetInfoCommandResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OTAGetInfoCommandResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OTAGetInfoCommandResult &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, info, id);

  @override
  String toString() {
    return 'OTAGetInfoCommandResult(info: $info, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$OTAGetInfoCommandResultCopyWith<$Res>
    implements $OTAGetInfoCommandResultCopyWith<$Res> {
  factory _$OTAGetInfoCommandResultCopyWith(_OTAGetInfoCommandResult value,
          $Res Function(_OTAGetInfoCommandResult) _then) =
      __$OTAGetInfoCommandResultCopyWithImpl;
  @override
  @useResult
  $Res call({OTAInfo info, int id});

  @override
  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$OTAGetInfoCommandResultCopyWithImpl<$Res>
    implements _$OTAGetInfoCommandResultCopyWith<$Res> {
  __$OTAGetInfoCommandResultCopyWithImpl(this._self, this._then);

  final _OTAGetInfoCommandResult _self;
  final $Res Function(_OTAGetInfoCommandResult) _then;

  /// Create a copy of OTAGetInfoCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
    Object? id = null,
  }) {
    return _then(_OTAGetInfoCommandResult(
      info: null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of OTAGetInfoCommandResult
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
mixin _$OTAOutputCommand {
  int get id;
  String get output;
  String get type;

  /// Create a copy of OTAOutputCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OTAOutputCommandCopyWith<OTAOutputCommand> get copyWith =>
      _$OTAOutputCommandCopyWithImpl<OTAOutputCommand>(
          this as OTAOutputCommand, _$identity);

  /// Serializes this OTAOutputCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OTAOutputCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.output, output) || other.output == output) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, output, type);

  @override
  String toString() {
    return 'OTAOutputCommand(id: $id, output: $output, type: $type)';
  }
}

/// @nodoc
abstract mixin class $OTAOutputCommandCopyWith<$Res> {
  factory $OTAOutputCommandCopyWith(
          OTAOutputCommand value, $Res Function(OTAOutputCommand) _then) =
      _$OTAOutputCommandCopyWithImpl;
  @useResult
  $Res call({int id, String output, String type});
}

/// @nodoc
class _$OTAOutputCommandCopyWithImpl<$Res>
    implements $OTAOutputCommandCopyWith<$Res> {
  _$OTAOutputCommandCopyWithImpl(this._self, this._then);

  final OTAOutputCommand _self;
  final $Res Function(OTAOutputCommand) _then;

  /// Create a copy of OTAOutputCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? output = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      output: null == output
          ? _self.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _OTAOutputCommand implements OTAOutputCommand {
  const _OTAOutputCommand(
      {required this.id,
      required this.output,
      this.type = OTAOutputCommand.TYPE});
  factory _OTAOutputCommand.fromJson(Map<String, dynamic> json) =>
      _$OTAOutputCommandFromJson(json);

  @override
  final int id;
  @override
  final String output;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of OTAOutputCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OTAOutputCommandCopyWith<_OTAOutputCommand> get copyWith =>
      __$OTAOutputCommandCopyWithImpl<_OTAOutputCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OTAOutputCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OTAOutputCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.output, output) || other.output == output) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, output, type);

  @override
  String toString() {
    return 'OTAOutputCommand(id: $id, output: $output, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$OTAOutputCommandCopyWith<$Res>
    implements $OTAOutputCommandCopyWith<$Res> {
  factory _$OTAOutputCommandCopyWith(
          _OTAOutputCommand value, $Res Function(_OTAOutputCommand) _then) =
      __$OTAOutputCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String output, String type});
}

/// @nodoc
class __$OTAOutputCommandCopyWithImpl<$Res>
    implements _$OTAOutputCommandCopyWith<$Res> {
  __$OTAOutputCommandCopyWithImpl(this._self, this._then);

  final _OTAOutputCommand _self;
  final $Res Function(_OTAOutputCommand) _then;

  /// Create a copy of OTAOutputCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? output = null,
    Object? type = null,
  }) {
    return _then(_OTAOutputCommand(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      output: null == output
          ? _self.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$OTAInfo {
  OTAStatus get status;
  double get uploadingPercent;
  String get code;
  int? get exitCode;
  String? get errorText;

  /// Create a copy of OTAInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OTAInfoCopyWith<OTAInfo> get copyWith =>
      _$OTAInfoCopyWithImpl<OTAInfo>(this as OTAInfo, _$identity);

  /// Serializes this OTAInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OTAInfo &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.uploadingPercent, uploadingPercent) ||
                other.uploadingPercent == uploadingPercent) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.exitCode, exitCode) ||
                other.exitCode == exitCode) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, uploadingPercent, code, exitCode, errorText);

  @override
  String toString() {
    return 'OTAInfo(status: $status, uploadingPercent: $uploadingPercent, code: $code, exitCode: $exitCode, errorText: $errorText)';
  }
}

/// @nodoc
abstract mixin class $OTAInfoCopyWith<$Res> {
  factory $OTAInfoCopyWith(OTAInfo value, $Res Function(OTAInfo) _then) =
      _$OTAInfoCopyWithImpl;
  @useResult
  $Res call(
      {OTAStatus status,
      double uploadingPercent,
      String code,
      int? exitCode,
      String? errorText});
}

/// @nodoc
class _$OTAInfoCopyWithImpl<$Res> implements $OTAInfoCopyWith<$Res> {
  _$OTAInfoCopyWithImpl(this._self, this._then);

  final OTAInfo _self;
  final $Res Function(OTAInfo) _then;

  /// Create a copy of OTAInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? uploadingPercent = null,
    Object? code = null,
    Object? exitCode = freezed,
    Object? errorText = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as OTAStatus,
      uploadingPercent: null == uploadingPercent
          ? _self.uploadingPercent
          : uploadingPercent // ignore: cast_nullable_to_non_nullable
              as double,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      exitCode: freezed == exitCode
          ? _self.exitCode
          : exitCode // ignore: cast_nullable_to_non_nullable
              as int?,
      errorText: freezed == errorText
          ? _self.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _OTAInfo implements OTAInfo {
  const _OTAInfo(
      {required this.status,
      required this.uploadingPercent,
      required this.code,
      this.exitCode,
      this.errorText});
  factory _OTAInfo.fromJson(Map<String, dynamic> json) =>
      _$OTAInfoFromJson(json);

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

  /// Create a copy of OTAInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OTAInfoCopyWith<_OTAInfo> get copyWith =>
      __$OTAInfoCopyWithImpl<_OTAInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OTAInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OTAInfo &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.uploadingPercent, uploadingPercent) ||
                other.uploadingPercent == uploadingPercent) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.exitCode, exitCode) ||
                other.exitCode == exitCode) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, uploadingPercent, code, exitCode, errorText);

  @override
  String toString() {
    return 'OTAInfo(status: $status, uploadingPercent: $uploadingPercent, code: $code, exitCode: $exitCode, errorText: $errorText)';
  }
}

/// @nodoc
abstract mixin class _$OTAInfoCopyWith<$Res> implements $OTAInfoCopyWith<$Res> {
  factory _$OTAInfoCopyWith(_OTAInfo value, $Res Function(_OTAInfo) _then) =
      __$OTAInfoCopyWithImpl;
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
class __$OTAInfoCopyWithImpl<$Res> implements _$OTAInfoCopyWith<$Res> {
  __$OTAInfoCopyWithImpl(this._self, this._then);

  final _OTAInfo _self;
  final $Res Function(_OTAInfo) _then;

  /// Create a copy of OTAInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? uploadingPercent = null,
    Object? code = null,
    Object? exitCode = freezed,
    Object? errorText = freezed,
  }) {
    return _then(_OTAInfo(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as OTAStatus,
      uploadingPercent: null == uploadingPercent
          ? _self.uploadingPercent
          : uploadingPercent // ignore: cast_nullable_to_non_nullable
              as double,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      exitCode: freezed == exitCode
          ? _self.exitCode
          : exitCode // ignore: cast_nullable_to_non_nullable
              as int?,
      errorText: freezed == errorText
          ? _self.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
