// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yandex_drive_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YandexSettingsState {
  YandexDriveStorageConfig get config;
  DriveState? get remote;
  DriveAuthorization? get authorization;
  bool get authorizationOpen;
  bool get busy;
  YandexPanelFailureKind? get failure;

  /// Create a copy of YandexSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YandexSettingsStateCopyWith<YandexSettingsState> get copyWith =>
      _$YandexSettingsStateCopyWithImpl<YandexSettingsState>(
        this as YandexSettingsState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as YandexSettingsState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YandexSettingsState &&
            (identical(other.config, _this.config) ||
                other.config == _this.config) &&
            (identical(other.remote, _this.remote) ||
                other.remote == _this.remote) &&
            (identical(other.authorization, _this.authorization) ||
                other.authorization == _this.authorization) &&
            (identical(other.authorizationOpen, _this.authorizationOpen) ||
                other.authorizationOpen == _this.authorizationOpen) &&
            (identical(other.busy, _this.busy) || other.busy == _this.busy) &&
            (identical(other.failure, _this.failure) ||
                other.failure == _this.failure));
  }

  @override
  int get hashCode {
    final _this = this as YandexSettingsState;
    return Object.hash(
      runtimeType,
      _this.config,
      _this.remote,
      _this.authorization,
      _this.authorizationOpen,
      _this.busy,
      _this.failure,
    );
  }

  @override
  String toString() {
    final _this = this as YandexSettingsState;
    return 'YandexSettingsState(config: ${_this.config}, remote: ${_this.remote}, authorization: ${_this.authorization}, authorizationOpen: ${_this.authorizationOpen}, busy: ${_this.busy}, failure: ${_this.failure})';
  }
}

/// @nodoc
abstract mixin class $YandexSettingsStateCopyWith<$Res> {
  factory $YandexSettingsStateCopyWith(
    YandexSettingsState value,
    $Res Function(YandexSettingsState) _then,
  ) = _$YandexSettingsStateCopyWithImpl;
  @useResult
  $Res call({
    YandexDriveStorageConfig config,
    DriveState? remote,
    DriveAuthorization? authorization,
    bool authorizationOpen,
    bool busy,
    YandexPanelFailureKind? failure,
  });

  $YandexDriveStorageConfigCopyWith<$Res> get config;
  $DriveStateCopyWith<$Res>? get remote;
  $DriveAuthorizationCopyWith<$Res>? get authorization;
}

/// @nodoc
class _$YandexSettingsStateCopyWithImpl<$Res>
    implements $YandexSettingsStateCopyWith<$Res> {
  _$YandexSettingsStateCopyWithImpl(this._self, this._then);

  final YandexSettingsState _self;
  final $Res Function(YandexSettingsState) _then;

  /// Create a copy of YandexSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
    Object? remote = freezed,
    Object? authorization = freezed,
    Object? authorizationOpen = null,
    Object? busy = null,
    Object? failure = freezed,
  }) {
    return _then(
      YandexSettingsState(
        config: null == config
            ? _self.config
            : config // ignore: cast_nullable_to_non_nullable
                  as YandexDriveStorageConfig,
        remote: freezed == remote
            ? _self.remote
            : remote // ignore: cast_nullable_to_non_nullable
                  as DriveState?,
        authorization: freezed == authorization
            ? _self.authorization
            : authorization // ignore: cast_nullable_to_non_nullable
                  as DriveAuthorization?,
        authorizationOpen: null == authorizationOpen
            ? _self.authorizationOpen
            : authorizationOpen // ignore: cast_nullable_to_non_nullable
                  as bool,
        busy: null == busy
            ? _self.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as YandexPanelFailureKind?,
      ),
    );
  }

  /// Create a copy of YandexSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YandexDriveStorageConfigCopyWith<$Res> get config {
    return $YandexDriveStorageConfigCopyWith<$Res>(_self.config, (value) {
      return _then(_self.copyWith(config: value));
    });
  }

  /// Create a copy of YandexSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriveStateCopyWith<$Res>? get remote {
    if (_self.remote == null) {
      return null;
    }

    return $DriveStateCopyWith<$Res>(_self.remote!, (value) {
      return _then(_self.copyWith(remote: value));
    });
  }

  /// Create a copy of YandexSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriveAuthorizationCopyWith<$Res>? get authorization {
    if (_self.authorization == null) {
      return null;
    }

    return $DriveAuthorizationCopyWith<$Res>(_self.authorization!, (value) {
      return _then(_self.copyWith(authorization: value));
    });
  }
}

/// Adds pattern-matching-related methods to [YandexSettingsState].
extension YandexSettingsStatePatterns on YandexSettingsState {
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
    TResult Function(_YandexSettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YandexSettingsState() when $default != null:
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
    TResult Function(_YandexSettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexSettingsState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_YandexSettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexSettingsState() when $default != null:
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
      YandexDriveStorageConfig config,
      DriveState? remote,
      DriveAuthorization? authorization,
      bool authorizationOpen,
      bool busy,
      YandexPanelFailureKind? failure,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YandexSettingsState() when $default != null:
        return $default(
          _that.config,
          _that.remote,
          _that.authorization,
          _that.authorizationOpen,
          _that.busy,
          _that.failure,
        );
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
      YandexDriveStorageConfig config,
      DriveState? remote,
      DriveAuthorization? authorization,
      bool authorizationOpen,
      bool busy,
      YandexPanelFailureKind? failure,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexSettingsState():
        return $default(
          _that.config,
          _that.remote,
          _that.authorization,
          _that.authorizationOpen,
          _that.busy,
          _that.failure,
        );
      case _:
        throw StateError('Unexpected subclass');
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
      YandexDriveStorageConfig config,
      DriveState? remote,
      DriveAuthorization? authorization,
      bool authorizationOpen,
      bool busy,
      YandexPanelFailureKind? failure,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexSettingsState() when $default != null:
        return $default(
          _that.config,
          _that.remote,
          _that.authorization,
          _that.authorizationOpen,
          _that.busy,
          _that.failure,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _YandexSettingsState implements YandexSettingsState {
  const _YandexSettingsState({
    required this.config,
    this.remote,
    this.authorization,
    this.authorizationOpen = false,
    this.busy = false,
    this.failure,
  });

  @override
  final YandexDriveStorageConfig config;
  @override
  final DriveState? remote;
  @override
  final DriveAuthorization? authorization;
  @override
  @JsonKey()
  final bool authorizationOpen;
  @override
  @JsonKey()
  final bool busy;
  @override
  final YandexPanelFailureKind? failure;

  /// Create a copy of YandexSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YandexSettingsStateCopyWith<_YandexSettingsState> get copyWith =>
      __$YandexSettingsStateCopyWithImpl<_YandexSettingsState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YandexSettingsState &&
            (identical(other.config, config) || other.config == config) &&
            (identical(other.remote, remote) || other.remote == remote) &&
            (identical(other.authorization, authorization) ||
                other.authorization == authorization) &&
            (identical(other.authorizationOpen, authorizationOpen) ||
                other.authorizationOpen == authorizationOpen) &&
            (identical(other.busy, busy) || other.busy == busy) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      config,
      remote,
      authorization,
      authorizationOpen,
      busy,
      failure,
    );
  }

  @override
  String toString() {
    return 'YandexSettingsState(config: $config, remote: $remote, authorization: $authorization, authorizationOpen: $authorizationOpen, busy: $busy, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$YandexSettingsStateCopyWith<$Res>
    implements $YandexSettingsStateCopyWith<$Res> {
  factory _$YandexSettingsStateCopyWith(
    _YandexSettingsState value,
    $Res Function(_YandexSettingsState) _then,
  ) = __$YandexSettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    YandexDriveStorageConfig config,
    DriveState? remote,
    DriveAuthorization? authorization,
    bool authorizationOpen,
    bool busy,
    YandexPanelFailureKind? failure,
  });

  @override
  $YandexDriveStorageConfigCopyWith<$Res> get config;
  @override
  $DriveStateCopyWith<$Res>? get remote;
  @override
  $DriveAuthorizationCopyWith<$Res>? get authorization;
}

/// @nodoc
class __$YandexSettingsStateCopyWithImpl<$Res>
    implements _$YandexSettingsStateCopyWith<$Res> {
  __$YandexSettingsStateCopyWithImpl(this._self, this._then);

  final _YandexSettingsState _self;
  final $Res Function(_YandexSettingsState) _then;

  /// Create a copy of YandexSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
    Object? remote = freezed,
    Object? authorization = freezed,
    Object? authorizationOpen = null,
    Object? busy = null,
    Object? failure = freezed,
  }) {
    return _then(
      _YandexSettingsState(
        config: null == config
            ? _self.config
            : config // ignore: cast_nullable_to_non_nullable
                  as YandexDriveStorageConfig,
        remote: freezed == remote
            ? _self.remote
            : remote // ignore: cast_nullable_to_non_nullable
                  as DriveState?,
        authorization: freezed == authorization
            ? _self.authorization
            : authorization // ignore: cast_nullable_to_non_nullable
                  as DriveAuthorization?,
        authorizationOpen: null == authorizationOpen
            ? _self.authorizationOpen
            : authorizationOpen // ignore: cast_nullable_to_non_nullable
                  as bool,
        busy: null == busy
            ? _self.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as YandexPanelFailureKind?,
      ),
    );
  }

  /// Create a copy of YandexSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YandexDriveStorageConfigCopyWith<$Res> get config {
    return $YandexDriveStorageConfigCopyWith<$Res>(_self.config, (value) {
      return _then(_self.copyWith(config: value));
    });
  }

  /// Create a copy of YandexSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriveStateCopyWith<$Res>? get remote {
    if (_self.remote == null) {
      return null;
    }

    return $DriveStateCopyWith<$Res>(_self.remote!, (value) {
      return _then(_self.copyWith(remote: value));
    });
  }

  /// Create a copy of YandexSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriveAuthorizationCopyWith<$Res>? get authorization {
    if (_self.authorization == null) {
      return null;
    }

    return $DriveAuthorizationCopyWith<$Res>(_self.authorization!, (value) {
      return _then(_self.copyWith(authorization: value));
    });
  }
}

/// @nodoc
mixin _$YandexFolderState {
  String get path;
  DriveFolderPage? get page;
  int get offset;
  Set<String> get selected;
  List<int> get previousOffsets;
  bool get busy;
  YandexPanelFailureKind? get failure;

  /// Create a copy of YandexFolderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YandexFolderStateCopyWith<YandexFolderState> get copyWith =>
      _$YandexFolderStateCopyWithImpl<YandexFolderState>(
        this as YandexFolderState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as YandexFolderState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YandexFolderState &&
            (identical(other.path, _this.path) || other.path == _this.path) &&
            (identical(other.page, _this.page) || other.page == _this.page) &&
            (identical(other.offset, _this.offset) ||
                other.offset == _this.offset) &&
            const DeepCollectionEquality().equals(
              other.selected,
              _this.selected,
            ) &&
            const DeepCollectionEquality().equals(
              other.previousOffsets,
              _this.previousOffsets,
            ) &&
            (identical(other.busy, _this.busy) || other.busy == _this.busy) &&
            (identical(other.failure, _this.failure) ||
                other.failure == _this.failure));
  }

  @override
  int get hashCode {
    final _this = this as YandexFolderState;
    return Object.hash(
      runtimeType,
      _this.path,
      _this.page,
      _this.offset,
      const DeepCollectionEquality().hash(_this.selected),
      const DeepCollectionEquality().hash(_this.previousOffsets),
      _this.busy,
      _this.failure,
    );
  }

  @override
  String toString() {
    final _this = this as YandexFolderState;
    return 'YandexFolderState(path: ${_this.path}, page: ${_this.page}, offset: ${_this.offset}, selected: ${_this.selected}, previousOffsets: ${_this.previousOffsets}, busy: ${_this.busy}, failure: ${_this.failure})';
  }
}

/// @nodoc
abstract mixin class $YandexFolderStateCopyWith<$Res> {
  factory $YandexFolderStateCopyWith(
    YandexFolderState value,
    $Res Function(YandexFolderState) _then,
  ) = _$YandexFolderStateCopyWithImpl;
  @useResult
  $Res call({
    String path,
    DriveFolderPage? page,
    int offset,
    Set<String> selected,
    List<int> previousOffsets,
    bool busy,
    YandexPanelFailureKind? failure,
  });

  $DriveFolderPageCopyWith<$Res>? get page;
}

/// @nodoc
class _$YandexFolderStateCopyWithImpl<$Res>
    implements $YandexFolderStateCopyWith<$Res> {
  _$YandexFolderStateCopyWithImpl(this._self, this._then);

  final YandexFolderState _self;
  final $Res Function(YandexFolderState) _then;

  /// Create a copy of YandexFolderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? page = freezed,
    Object? offset = null,
    Object? selected = null,
    Object? previousOffsets = null,
    Object? busy = null,
    Object? failure = freezed,
  }) {
    return _then(
      YandexFolderState(
        path: null == path
            ? _self.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        page: freezed == page
            ? _self.page
            : page // ignore: cast_nullable_to_non_nullable
                  as DriveFolderPage?,
        offset: null == offset
            ? _self.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
        selected: null == selected
            ? _self.selected
            : selected // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        previousOffsets: null == previousOffsets
            ? _self.previousOffsets
            : previousOffsets // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        busy: null == busy
            ? _self.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as YandexPanelFailureKind?,
      ),
    );
  }

  /// Create a copy of YandexFolderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriveFolderPageCopyWith<$Res>? get page {
    if (_self.page == null) {
      return null;
    }

    return $DriveFolderPageCopyWith<$Res>(_self.page!, (value) {
      return _then(_self.copyWith(page: value));
    });
  }
}

/// Adds pattern-matching-related methods to [YandexFolderState].
extension YandexFolderStatePatterns on YandexFolderState {
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
    TResult Function(_YandexFolderState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YandexFolderState() when $default != null:
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
    TResult Function(_YandexFolderState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexFolderState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_YandexFolderState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexFolderState() when $default != null:
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
      String path,
      DriveFolderPage? page,
      int offset,
      Set<String> selected,
      List<int> previousOffsets,
      bool busy,
      YandexPanelFailureKind? failure,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YandexFolderState() when $default != null:
        return $default(
          _that.path,
          _that.page,
          _that.offset,
          _that.selected,
          _that.previousOffsets,
          _that.busy,
          _that.failure,
        );
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
      String path,
      DriveFolderPage? page,
      int offset,
      Set<String> selected,
      List<int> previousOffsets,
      bool busy,
      YandexPanelFailureKind? failure,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexFolderState():
        return $default(
          _that.path,
          _that.page,
          _that.offset,
          _that.selected,
          _that.previousOffsets,
          _that.busy,
          _that.failure,
        );
      case _:
        throw StateError('Unexpected subclass');
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
      String path,
      DriveFolderPage? page,
      int offset,
      Set<String> selected,
      List<int> previousOffsets,
      bool busy,
      YandexPanelFailureKind? failure,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexFolderState() when $default != null:
        return $default(
          _that.path,
          _that.page,
          _that.offset,
          _that.selected,
          _that.previousOffsets,
          _that.busy,
          _that.failure,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _YandexFolderState implements YandexFolderState {
  const _YandexFolderState({
    this.path = 'disk:/',
    this.page,
    this.offset = 0,
    Set<String> selected = const <String>{},
    List<int> previousOffsets = const <int>[],
    this.busy = false,
    this.failure,
  }) : _selected = selected,
       _previousOffsets = previousOffsets;

  @override
  @JsonKey()
  final String path;
  @override
  final DriveFolderPage? page;
  @override
  @JsonKey()
  final int offset;
  final Set<String> _selected;
  @override
  @JsonKey()
  Set<String> get selected {
    if (_selected is EqualUnmodifiableSetView) return _selected;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selected);
  }

  final List<int> _previousOffsets;
  @override
  @JsonKey()
  List<int> get previousOffsets {
    if (_previousOffsets is EqualUnmodifiableListView) return _previousOffsets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousOffsets);
  }

  @override
  @JsonKey()
  final bool busy;
  @override
  final YandexPanelFailureKind? failure;

  /// Create a copy of YandexFolderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YandexFolderStateCopyWith<_YandexFolderState> get copyWith =>
      __$YandexFolderStateCopyWithImpl<_YandexFolderState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YandexFolderState &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            const DeepCollectionEquality().equals(other.selected, _selected) &&
            const DeepCollectionEquality().equals(
              other.previousOffsets,
              _previousOffsets,
            ) &&
            (identical(other.busy, busy) || other.busy == busy) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      path,
      page,
      offset,
      const DeepCollectionEquality().hash(_selected),
      const DeepCollectionEquality().hash(_previousOffsets),
      busy,
      failure,
    );
  }

  @override
  String toString() {
    return 'YandexFolderState(path: $path, page: $page, offset: $offset, selected: $selected, previousOffsets: $previousOffsets, busy: $busy, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$YandexFolderStateCopyWith<$Res>
    implements $YandexFolderStateCopyWith<$Res> {
  factory _$YandexFolderStateCopyWith(
    _YandexFolderState value,
    $Res Function(_YandexFolderState) _then,
  ) = __$YandexFolderStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    String path,
    DriveFolderPage? page,
    int offset,
    Set<String> selected,
    List<int> previousOffsets,
    bool busy,
    YandexPanelFailureKind? failure,
  });

  @override
  $DriveFolderPageCopyWith<$Res>? get page;
}

/// @nodoc
class __$YandexFolderStateCopyWithImpl<$Res>
    implements _$YandexFolderStateCopyWith<$Res> {
  __$YandexFolderStateCopyWithImpl(this._self, this._then);

  final _YandexFolderState _self;
  final $Res Function(_YandexFolderState) _then;

  /// Create a copy of YandexFolderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? path = null,
    Object? page = freezed,
    Object? offset = null,
    Object? selected = null,
    Object? previousOffsets = null,
    Object? busy = null,
    Object? failure = freezed,
  }) {
    return _then(
      _YandexFolderState(
        path: null == path
            ? _self.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        page: freezed == page
            ? _self.page
            : page // ignore: cast_nullable_to_non_nullable
                  as DriveFolderPage?,
        offset: null == offset
            ? _self.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
        selected: null == selected
            ? _self._selected
            : selected // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        previousOffsets: null == previousOffsets
            ? _self._previousOffsets
            : previousOffsets // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        busy: null == busy
            ? _self.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as YandexPanelFailureKind?,
      ),
    );
  }

  /// Create a copy of YandexFolderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriveFolderPageCopyWith<$Res>? get page {
    if (_self.page == null) {
      return null;
    }

    return $DriveFolderPageCopyWith<$Res>(_self.page!, (value) {
      return _then(_self.copyWith(page: value));
    });
  }
}

/// @nodoc
mixin _$YandexApplicationState {
  String get clientId;
  bool get busy;
  YandexPanelFailureKind? get failure;

  /// Create a copy of YandexApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YandexApplicationStateCopyWith<YandexApplicationState> get copyWith =>
      _$YandexApplicationStateCopyWithImpl<YandexApplicationState>(
        this as YandexApplicationState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as YandexApplicationState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YandexApplicationState &&
            (identical(other.clientId, _this.clientId) ||
                other.clientId == _this.clientId) &&
            (identical(other.busy, _this.busy) || other.busy == _this.busy) &&
            (identical(other.failure, _this.failure) ||
                other.failure == _this.failure));
  }

  @override
  int get hashCode {
    final _this = this as YandexApplicationState;
    return Object.hash(runtimeType, _this.clientId, _this.busy, _this.failure);
  }

  @override
  String toString() {
    final _this = this as YandexApplicationState;
    return 'YandexApplicationState(clientId: ${_this.clientId}, busy: ${_this.busy}, failure: ${_this.failure})';
  }
}

/// @nodoc
abstract mixin class $YandexApplicationStateCopyWith<$Res> {
  factory $YandexApplicationStateCopyWith(
    YandexApplicationState value,
    $Res Function(YandexApplicationState) _then,
  ) = _$YandexApplicationStateCopyWithImpl;
  @useResult
  $Res call({String clientId, bool busy, YandexPanelFailureKind? failure});
}

/// @nodoc
class _$YandexApplicationStateCopyWithImpl<$Res>
    implements $YandexApplicationStateCopyWith<$Res> {
  _$YandexApplicationStateCopyWithImpl(this._self, this._then);

  final YandexApplicationState _self;
  final $Res Function(YandexApplicationState) _then;

  /// Create a copy of YandexApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? busy = null,
    Object? failure = freezed,
  }) {
    return _then(
      YandexApplicationState(
        clientId: null == clientId
            ? _self.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        busy: null == busy
            ? _self.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as YandexPanelFailureKind?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [YandexApplicationState].
extension YandexApplicationStatePatterns on YandexApplicationState {
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
    TResult Function(_YandexApplicationState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YandexApplicationState() when $default != null:
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
    TResult Function(_YandexApplicationState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexApplicationState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_YandexApplicationState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexApplicationState() when $default != null:
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
      String clientId,
      bool busy,
      YandexPanelFailureKind? failure,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YandexApplicationState() when $default != null:
        return $default(_that.clientId, _that.busy, _that.failure);
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
      String clientId,
      bool busy,
      YandexPanelFailureKind? failure,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexApplicationState():
        return $default(_that.clientId, _that.busy, _that.failure);
      case _:
        throw StateError('Unexpected subclass');
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
      String clientId,
      bool busy,
      YandexPanelFailureKind? failure,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YandexApplicationState() when $default != null:
        return $default(_that.clientId, _that.busy, _that.failure);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _YandexApplicationState implements YandexApplicationState {
  const _YandexApplicationState({
    required this.clientId,
    this.busy = false,
    this.failure,
  });

  @override
  final String clientId;
  @override
  @JsonKey()
  final bool busy;
  @override
  final YandexPanelFailureKind? failure;

  /// Create a copy of YandexApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YandexApplicationStateCopyWith<_YandexApplicationState> get copyWith =>
      __$YandexApplicationStateCopyWithImpl<_YandexApplicationState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YandexApplicationState &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.busy, busy) || other.busy == busy) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, clientId, busy, failure);
  }

  @override
  String toString() {
    return 'YandexApplicationState(clientId: $clientId, busy: $busy, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$YandexApplicationStateCopyWith<$Res>
    implements $YandexApplicationStateCopyWith<$Res> {
  factory _$YandexApplicationStateCopyWith(
    _YandexApplicationState value,
    $Res Function(_YandexApplicationState) _then,
  ) = __$YandexApplicationStateCopyWithImpl;
  @override
  @useResult
  $Res call({String clientId, bool busy, YandexPanelFailureKind? failure});
}

/// @nodoc
class __$YandexApplicationStateCopyWithImpl<$Res>
    implements _$YandexApplicationStateCopyWith<$Res> {
  __$YandexApplicationStateCopyWithImpl(this._self, this._then);

  final _YandexApplicationState _self;
  final $Res Function(_YandexApplicationState) _then;

  /// Create a copy of YandexApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? clientId = null,
    Object? busy = null,
    Object? failure = freezed,
  }) {
    return _then(
      _YandexApplicationState(
        clientId: null == clientId
            ? _self.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        busy: null == busy
            ? _self.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as YandexPanelFailureKind?,
      ),
    );
  }
}
