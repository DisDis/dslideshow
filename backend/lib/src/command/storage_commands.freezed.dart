// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StorageStatusCommand {
  int get id;
  @JsonKey(unknownEnumValue: StorageStatusEnum.off)
  StorageStatusEnum get status;
  String get type;

  /// Create a copy of StorageStatusCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StorageStatusCommandCopyWith<StorageStatusCommand> get copyWith =>
      _$StorageStatusCommandCopyWithImpl<StorageStatusCommand>(
        this as StorageStatusCommand,
        _$identity,
      );

  /// Serializes this StorageStatusCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as StorageStatusCommand;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StorageStatusCommand &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.status, _this.status) ||
                other.status == _this.status) &&
            (identical(other.type, _this.type) || other.type == _this.type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as StorageStatusCommand;
    return Object.hash(runtimeType, _this.id, _this.status, _this.type);
  }

  @override
  String toString() {
    final _this = this as StorageStatusCommand;
    return 'StorageStatusCommand(id: ${_this.id}, status: ${_this.status}, type: ${_this.type})';
  }
}

/// @nodoc
abstract mixin class $StorageStatusCommandCopyWith<$Res> {
  factory $StorageStatusCommandCopyWith(
    StorageStatusCommand value,
    $Res Function(StorageStatusCommand) _then,
  ) = _$StorageStatusCommandCopyWithImpl;
  @useResult
  $Res call({
    int id,
    @JsonKey(unknownEnumValue: StorageStatusEnum.off) StorageStatusEnum status,
    String type,
  });
}

/// @nodoc
class _$StorageStatusCommandCopyWithImpl<$Res>
    implements $StorageStatusCommandCopyWith<$Res> {
  _$StorageStatusCommandCopyWithImpl(this._self, this._then);

  final StorageStatusCommand _self;
  final $Res Function(StorageStatusCommand) _then;

  /// Create a copy of StorageStatusCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? status = null, Object? type = null}) {
    return _then(
      StorageStatusCommand(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as StorageStatusEnum,
        type: null == type
            ? _self.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [StorageStatusCommand].
extension StorageStatusCommandPatterns on StorageStatusCommand {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_StorageStatusCommand value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StorageStatusCommand() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_StorageStatusCommand value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StorageStatusCommand():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_StorageStatusCommand value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StorageStatusCommand() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      int id,
      @JsonKey(unknownEnumValue: StorageStatusEnum.off)
      StorageStatusEnum status,
      String type,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StorageStatusCommand() when $default != null:
        return $default(_that.id, _that.status, _that.type);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      int id,
      @JsonKey(unknownEnumValue: StorageStatusEnum.off)
      StorageStatusEnum status,
      String type,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StorageStatusCommand():
        return $default(_that.id, _that.status, _that.type);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      int id,
      @JsonKey(unknownEnumValue: StorageStatusEnum.off)
      StorageStatusEnum status,
      String type,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StorageStatusCommand() when $default != null:
        return $default(_that.id, _that.status, _that.type);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StorageStatusCommand implements StorageStatusCommand {
  const _StorageStatusCommand({
    required this.id,
    @JsonKey(unknownEnumValue: StorageStatusEnum.off) required this.status,
    this.type = StorageStatusCommand.TYPE,
  });
  factory _StorageStatusCommand.fromJson(Map<String, dynamic> json) =>
      _$StorageStatusCommandFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(unknownEnumValue: StorageStatusEnum.off)
  final StorageStatusEnum status;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of StorageStatusCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StorageStatusCommandCopyWith<_StorageStatusCommand> get copyWith =>
      __$StorageStatusCommandCopyWithImpl<_StorageStatusCommand>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$StorageStatusCommandToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StorageStatusCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, status, type);
  }

  @override
  String toString() {
    return 'StorageStatusCommand(id: $id, status: $status, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$StorageStatusCommandCopyWith<$Res>
    implements $StorageStatusCommandCopyWith<$Res> {
  factory _$StorageStatusCommandCopyWith(
    _StorageStatusCommand value,
    $Res Function(_StorageStatusCommand) _then,
  ) = __$StorageStatusCommandCopyWithImpl;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(unknownEnumValue: StorageStatusEnum.off) StorageStatusEnum status,
    String type,
  });
}

/// @nodoc
class __$StorageStatusCommandCopyWithImpl<$Res>
    implements _$StorageStatusCommandCopyWith<$Res> {
  __$StorageStatusCommandCopyWithImpl(this._self, this._then);

  final _StorageStatusCommand _self;
  final $Res Function(_StorageStatusCommand) _then;

  /// Create a copy of StorageStatusCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? id = null, Object? status = null, Object? type = null}) {
    return _then(
      _StorageStatusCommand(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as StorageStatusEnum,
        type: null == type
            ? _self.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

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
        this as GetMediaItemCommand,
        _$identity,
      );

  /// Serializes this GetMediaItemCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GetMediaItemCommand;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetMediaItemCommand &&
            (identical(other.isCurrent, _this.isCurrent) ||
                other.isCurrent == _this.isCurrent) &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.type, _this.type) || other.type == _this.type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GetMediaItemCommand;
    return Object.hash(runtimeType, _this.isCurrent, _this.id, _this.type);
  }

  @override
  String toString() {
    final _this = this as GetMediaItemCommand;
    return 'GetMediaItemCommand(isCurrent: ${_this.isCurrent}, id: ${_this.id}, type: ${_this.type})';
  }
}

/// @nodoc
abstract mixin class $GetMediaItemCommandCopyWith<$Res> {
  factory $GetMediaItemCommandCopyWith(
    GetMediaItemCommand value,
    $Res Function(GetMediaItemCommand) _then,
  ) = _$GetMediaItemCommandCopyWithImpl;
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
    return _then(
      GetMediaItemCommand(
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
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GetMediaItemCommand].
extension GetMediaItemCommandPatterns on GetMediaItemCommand {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GetMediaItemCommand value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommand() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GetMediaItemCommand value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommand():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GetMediaItemCommand value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommand() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(bool isCurrent, int id, String type)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommand() when $default != null:
        return $default(_that.isCurrent, _that.id, _that.type);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(bool isCurrent, int id, String type) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommand():
        return $default(_that.isCurrent, _that.id, _that.type);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(bool isCurrent, int id, String type)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommand() when $default != null:
        return $default(_that.isCurrent, _that.id, _that.type);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GetMediaItemCommand implements GetMediaItemCommand {
  const _GetMediaItemCommand({
    required this.isCurrent,
    required this.id,
    this.type = GetMediaItemCommand.TYPE,
  });
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
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GetMediaItemCommandToJson(this);
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
  int get hashCode {
    return Object.hash(runtimeType, isCurrent, id, type);
  }

  @override
  String toString() {
    return 'GetMediaItemCommand(isCurrent: $isCurrent, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$GetMediaItemCommandCopyWith<$Res>
    implements $GetMediaItemCommandCopyWith<$Res> {
  factory _$GetMediaItemCommandCopyWith(
    _GetMediaItemCommand value,
    $Res Function(_GetMediaItemCommand) _then,
  ) = __$GetMediaItemCommandCopyWithImpl;
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
    return _then(
      _GetMediaItemCommand(
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
      ),
    );
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
        this as GetMediaItemCommandResult,
        _$identity,
      );

  /// Serializes this GetMediaItemCommandResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GetMediaItemCommandResult;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetMediaItemCommandResult &&
            (identical(other.mediaId, _this.mediaId) ||
                other.mediaId == _this.mediaId) &&
            (identical(other.mediaUri, _this.mediaUri) ||
                other.mediaUri == _this.mediaUri) &&
            (identical(other.id, _this.id) || other.id == _this.id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GetMediaItemCommandResult;
    return Object.hash(runtimeType, _this.mediaId, _this.mediaUri, _this.id);
  }

  @override
  String toString() {
    final _this = this as GetMediaItemCommandResult;
    return 'GetMediaItemCommandResult(mediaId: ${_this.mediaId}, mediaUri: ${_this.mediaUri}, id: ${_this.id})';
  }
}

/// @nodoc
abstract mixin class $GetMediaItemCommandResultCopyWith<$Res> {
  factory $GetMediaItemCommandResultCopyWith(
    GetMediaItemCommandResult value,
    $Res Function(GetMediaItemCommandResult) _then,
  ) = _$GetMediaItemCommandResultCopyWithImpl;
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
    return _then(
      GetMediaItemCommandResult(
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
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GetMediaItemCommandResult].
extension GetMediaItemCommandResultPatterns on GetMediaItemCommandResult {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GetMediaItemCommandResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommandResult() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GetMediaItemCommandResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommandResult():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GetMediaItemCommandResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommandResult() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? mediaId, Uri? mediaUri, int id)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommandResult() when $default != null:
        return $default(_that.mediaId, _that.mediaUri, _that.id);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String? mediaId, Uri? mediaUri, int id) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommandResult():
        return $default(_that.mediaId, _that.mediaUri, _that.id);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? mediaId, Uri? mediaUri, int id)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetMediaItemCommandResult() when $default != null:
        return $default(_that.mediaId, _that.mediaUri, _that.id);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GetMediaItemCommandResult implements GetMediaItemCommandResult {
  const _GetMediaItemCommandResult({
    this.mediaId,
    this.mediaUri,
    required this.id,
  });
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
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GetMediaItemCommandResultToJson(this);
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
  int get hashCode {
    return Object.hash(runtimeType, mediaId, mediaUri, id);
  }

  @override
  String toString() {
    return 'GetMediaItemCommandResult(mediaId: $mediaId, mediaUri: $mediaUri, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$GetMediaItemCommandResultCopyWith<$Res>
    implements $GetMediaItemCommandResultCopyWith<$Res> {
  factory _$GetMediaItemCommandResultCopyWith(
    _GetMediaItemCommandResult value,
    $Res Function(_GetMediaItemCommandResult) _then,
  ) = __$GetMediaItemCommandResultCopyWithImpl;
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
    return _then(
      _GetMediaItemCommandResult(
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
      ),
    );
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
        this as StorageNextCommand,
        _$identity,
      );

  /// Serializes this StorageNextCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as StorageNextCommand;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StorageNextCommand &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.type, _this.type) || other.type == _this.type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as StorageNextCommand;
    return Object.hash(runtimeType, _this.id, _this.type);
  }

  @override
  String toString() {
    final _this = this as StorageNextCommand;
    return 'StorageNextCommand(id: ${_this.id}, type: ${_this.type})';
  }
}

/// @nodoc
abstract mixin class $StorageNextCommandCopyWith<$Res> {
  factory $StorageNextCommandCopyWith(
    StorageNextCommand value,
    $Res Function(StorageNextCommand) _then,
  ) = _$StorageNextCommandCopyWithImpl;
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
  $Res call({Object? id = null, Object? type = null}) {
    return _then(
      StorageNextCommand(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _self.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [StorageNextCommand].
extension StorageNextCommandPatterns on StorageNextCommand {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_StorageNextCommand value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StorageNextCommand() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_StorageNextCommand value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StorageNextCommand():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_StorageNextCommand value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StorageNextCommand() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, String type)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StorageNextCommand() when $default != null:
        return $default(_that.id, _that.type);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, String type) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StorageNextCommand():
        return $default(_that.id, _that.type);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, String type)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StorageNextCommand() when $default != null:
        return $default(_that.id, _that.type);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StorageNextCommand implements StorageNextCommand {
  const _StorageNextCommand({
    required this.id,
    this.type = StorageNextCommand.TYPE,
  });
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
    return _$StorageNextCommandToJson(this);
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
  int get hashCode {
    return Object.hash(runtimeType, id, type);
  }

  @override
  String toString() {
    return 'StorageNextCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$StorageNextCommandCopyWith<$Res>
    implements $StorageNextCommandCopyWith<$Res> {
  factory _$StorageNextCommandCopyWith(
    _StorageNextCommand value,
    $Res Function(_StorageNextCommand) _then,
  ) = __$StorageNextCommandCopyWithImpl;
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
  $Res call({Object? id = null, Object? type = null}) {
    return _then(
      _StorageNextCommand(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _self.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}
