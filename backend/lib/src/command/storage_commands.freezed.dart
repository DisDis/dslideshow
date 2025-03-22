// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetMediaItemCommand {
  bool get isCurrent;
  int get id;
  String get type;

  /// Create a copy of GetMediaItemCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GetMediaItemCommandCopyWith<GetMediaItemCommand> get copyWith =>
      _$GetMediaItemCommandCopyWithImpl<GetMediaItemCommand>(
          this as GetMediaItemCommand, _$identity);

  /// Serializes this GetMediaItemCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetMediaItemCommand &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isCurrent, id, type);

  @override
  String toString() {
    return 'GetMediaItemCommand(isCurrent: $isCurrent, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $GetMediaItemCommandCopyWith<$Res> {
  factory $GetMediaItemCommandCopyWith(
          GetMediaItemCommand value, $Res Function(GetMediaItemCommand) _then) =
      _$GetMediaItemCommandCopyWithImpl;
  @useResult
  $Res call({bool isCurrent, int id, String type});
}

/// @nodoc
class _$GetMediaItemCommandCopyWithImpl<$Res>
    implements $GetMediaItemCommandCopyWith<$Res> {
  _$GetMediaItemCommandCopyWithImpl(this._self, this._then);

  final GetMediaItemCommand _self;
  final $Res Function(GetMediaItemCommand) _then;

  /// Create a copy of GetMediaItemCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCurrent = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      isCurrent: null == isCurrent
          ? _self.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
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
class _GetMediaItemCommand implements GetMediaItemCommand {
  const _GetMediaItemCommand(
      {required this.isCurrent,
      required this.id,
      this.type = GetMediaItemCommand.TYPE});
  factory _GetMediaItemCommand.fromJson(Map<String, dynamic> json) =>
      _$GetMediaItemCommandFromJson(json);

  @override
  final bool isCurrent;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of GetMediaItemCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetMediaItemCommandCopyWith<_GetMediaItemCommand> get copyWith =>
      __$GetMediaItemCommandCopyWithImpl<_GetMediaItemCommand>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GetMediaItemCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetMediaItemCommand &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isCurrent, id, type);

  @override
  String toString() {
    return 'GetMediaItemCommand(isCurrent: $isCurrent, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$GetMediaItemCommandCopyWith<$Res>
    implements $GetMediaItemCommandCopyWith<$Res> {
  factory _$GetMediaItemCommandCopyWith(_GetMediaItemCommand value,
          $Res Function(_GetMediaItemCommand) _then) =
      __$GetMediaItemCommandCopyWithImpl;
  @override
  @useResult
  $Res call({bool isCurrent, int id, String type});
}

/// @nodoc
class __$GetMediaItemCommandCopyWithImpl<$Res>
    implements _$GetMediaItemCommandCopyWith<$Res> {
  __$GetMediaItemCommandCopyWithImpl(this._self, this._then);

  final _GetMediaItemCommand _self;
  final $Res Function(_GetMediaItemCommand) _then;

  /// Create a copy of GetMediaItemCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCurrent = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_GetMediaItemCommand(
      isCurrent: null == isCurrent
          ? _self.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
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
mixin _$GetMediaItemCommandResult {
  String? get mediaId;
  Uri? get mediaUri;
  int get id;

  /// Create a copy of GetMediaItemCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GetMediaItemCommandResultCopyWith<GetMediaItemCommandResult> get copyWith =>
      _$GetMediaItemCommandResultCopyWithImpl<GetMediaItemCommandResult>(
          this as GetMediaItemCommandResult, _$identity);

  /// Serializes this GetMediaItemCommandResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetMediaItemCommandResult &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.mediaUri, mediaUri) ||
                other.mediaUri == mediaUri) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mediaId, mediaUri, id);

  @override
  String toString() {
    return 'GetMediaItemCommandResult(mediaId: $mediaId, mediaUri: $mediaUri, id: $id)';
  }
}

/// @nodoc
abstract mixin class $GetMediaItemCommandResultCopyWith<$Res> {
  factory $GetMediaItemCommandResultCopyWith(GetMediaItemCommandResult value,
          $Res Function(GetMediaItemCommandResult) _then) =
      _$GetMediaItemCommandResultCopyWithImpl;
  @useResult
  $Res call({String? mediaId, Uri? mediaUri, int id});
}

/// @nodoc
class _$GetMediaItemCommandResultCopyWithImpl<$Res>
    implements $GetMediaItemCommandResultCopyWith<$Res> {
  _$GetMediaItemCommandResultCopyWithImpl(this._self, this._then);

  final GetMediaItemCommandResult _self;
  final $Res Function(GetMediaItemCommandResult) _then;

  /// Create a copy of GetMediaItemCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = freezed,
    Object? mediaUri = freezed,
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      mediaId: freezed == mediaId
          ? _self.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaUri: freezed == mediaUri
          ? _self.mediaUri
          : mediaUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GetMediaItemCommandResult implements GetMediaItemCommandResult {
  const _GetMediaItemCommandResult(
      {this.mediaId, this.mediaUri, required this.id});
  factory _GetMediaItemCommandResult.fromJson(Map<String, dynamic> json) =>
      _$GetMediaItemCommandResultFromJson(json);

  @override
  final String? mediaId;
  @override
  final Uri? mediaUri;
  @override
  final int id;

  /// Create a copy of GetMediaItemCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetMediaItemCommandResultCopyWith<_GetMediaItemCommandResult>
      get copyWith =>
          __$GetMediaItemCommandResultCopyWithImpl<_GetMediaItemCommandResult>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GetMediaItemCommandResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetMediaItemCommandResult &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.mediaUri, mediaUri) ||
                other.mediaUri == mediaUri) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mediaId, mediaUri, id);

  @override
  String toString() {
    return 'GetMediaItemCommandResult(mediaId: $mediaId, mediaUri: $mediaUri, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$GetMediaItemCommandResultCopyWith<$Res>
    implements $GetMediaItemCommandResultCopyWith<$Res> {
  factory _$GetMediaItemCommandResultCopyWith(_GetMediaItemCommandResult value,
          $Res Function(_GetMediaItemCommandResult) _then) =
      __$GetMediaItemCommandResultCopyWithImpl;
  @override
  @useResult
  $Res call({String? mediaId, Uri? mediaUri, int id});
}

/// @nodoc
class __$GetMediaItemCommandResultCopyWithImpl<$Res>
    implements _$GetMediaItemCommandResultCopyWith<$Res> {
  __$GetMediaItemCommandResultCopyWithImpl(this._self, this._then);

  final _GetMediaItemCommandResult _self;
  final $Res Function(_GetMediaItemCommandResult) _then;

  /// Create a copy of GetMediaItemCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mediaId = freezed,
    Object? mediaUri = freezed,
    Object? id = null,
  }) {
    return _then(_GetMediaItemCommandResult(
      mediaId: freezed == mediaId
          ? _self.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaUri: freezed == mediaUri
          ? _self.mediaUri
          : mediaUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$StorageNextCommand {
  int get id;
  String get type;

  /// Create a copy of StorageNextCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StorageNextCommandCopyWith<StorageNextCommand> get copyWith =>
      _$StorageNextCommandCopyWithImpl<StorageNextCommand>(
          this as StorageNextCommand, _$identity);

  /// Serializes this StorageNextCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StorageNextCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'StorageNextCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $StorageNextCommandCopyWith<$Res> {
  factory $StorageNextCommandCopyWith(
          StorageNextCommand value, $Res Function(StorageNextCommand) _then) =
      _$StorageNextCommandCopyWithImpl;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$StorageNextCommandCopyWithImpl<$Res>
    implements $StorageNextCommandCopyWith<$Res> {
  _$StorageNextCommandCopyWithImpl(this._self, this._then);

  final StorageNextCommand _self;
  final $Res Function(StorageNextCommand) _then;

  /// Create a copy of StorageNextCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
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
class _StorageNextCommand implements StorageNextCommand {
  const _StorageNextCommand(
      {required this.id, this.type = StorageNextCommand.TYPE});
  factory _StorageNextCommand.fromJson(Map<String, dynamic> json) =>
      _$StorageNextCommandFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of StorageNextCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StorageNextCommandCopyWith<_StorageNextCommand> get copyWith =>
      __$StorageNextCommandCopyWithImpl<_StorageNextCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StorageNextCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StorageNextCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'StorageNextCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$StorageNextCommandCopyWith<$Res>
    implements $StorageNextCommandCopyWith<$Res> {
  factory _$StorageNextCommandCopyWith(
          _StorageNextCommand value, $Res Function(_StorageNextCommand) _then) =
      __$StorageNextCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$StorageNextCommandCopyWithImpl<$Res>
    implements _$StorageNextCommandCopyWith<$Res> {
  __$StorageNextCommandCopyWithImpl(this._self, this._then);

  final _StorageNextCommand _self;
  final $Res Function(_StorageNextCommand) _then;

  /// Create a copy of StorageNextCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_StorageNextCommand(
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

// dart format on
