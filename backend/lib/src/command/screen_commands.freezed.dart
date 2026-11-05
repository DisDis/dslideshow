// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScreenTurnCommand {
  bool get enabled;
  int get id;
  String get type;

  /// Create a copy of ScreenTurnCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScreenTurnCommandCopyWith<ScreenTurnCommand> get copyWith =>
      _$ScreenTurnCommandCopyWithImpl<ScreenTurnCommand>(
        this as ScreenTurnCommand,
        _$identity,
      );

  /// Serializes this ScreenTurnCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as ScreenTurnCommand;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScreenTurnCommand &&
            (identical(other.enabled, _this.enabled) ||
                other.enabled == _this.enabled) &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.type, _this.type) || other.type == _this.type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as ScreenTurnCommand;
    return Object.hash(runtimeType, _this.enabled, _this.id, _this.type);
  }

  @override
  String toString() {
    final _this = this as ScreenTurnCommand;
    return 'ScreenTurnCommand(enabled: ${_this.enabled}, id: ${_this.id}, type: ${_this.type})';
  }
}

/// @nodoc
abstract mixin class $ScreenTurnCommandCopyWith<$Res> {
  factory $ScreenTurnCommandCopyWith(
    ScreenTurnCommand value,
    $Res Function(ScreenTurnCommand) _then,
  ) = _$ScreenTurnCommandCopyWithImpl;
  @useResult
  $Res call({bool enabled, int id, String type});
}

/// @nodoc
class _$ScreenTurnCommandCopyWithImpl<$Res>
    implements $ScreenTurnCommandCopyWith<$Res> {
  _$ScreenTurnCommandCopyWithImpl(this._self, this._then);

  final ScreenTurnCommand _self;
  final $Res Function(ScreenTurnCommand) _then;

  /// Create a copy of ScreenTurnCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? enabled = null, Object? id = null, Object? type = null}) {
    return _then(
      ScreenTurnCommand(
        enabled: null == enabled
            ? _self.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
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

/// Adds pattern-matching-related methods to [ScreenTurnCommand].
extension ScreenTurnCommandPatterns on ScreenTurnCommand {
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
    TResult Function(_ScreenTurnCommand value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScreenTurnCommand() when $default != null:
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
    TResult Function(_ScreenTurnCommand value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenTurnCommand():
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
    TResult? Function(_ScreenTurnCommand value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenTurnCommand() when $default != null:
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
    TResult Function(bool enabled, int id, String type)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScreenTurnCommand() when $default != null:
        return $default(_that.enabled, _that.id, _that.type);
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
    TResult Function(bool enabled, int id, String type) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenTurnCommand():
        return $default(_that.enabled, _that.id, _that.type);
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
    TResult? Function(bool enabled, int id, String type)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenTurnCommand() when $default != null:
        return $default(_that.enabled, _that.id, _that.type);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ScreenTurnCommand implements ScreenTurnCommand {
  const _ScreenTurnCommand({
    required this.enabled,
    required this.id,
    this.type = ScreenTurnCommand.TYPE,
  });
  factory _ScreenTurnCommand.fromJson(Map<String, dynamic> json) =>
      _$ScreenTurnCommandFromJson(json);

  @override
  final bool enabled;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of ScreenTurnCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScreenTurnCommandCopyWith<_ScreenTurnCommand> get copyWith =>
      __$ScreenTurnCommandCopyWithImpl<_ScreenTurnCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ScreenTurnCommandToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScreenTurnCommand &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, enabled, id, type);
  }

  @override
  String toString() {
    return 'ScreenTurnCommand(enabled: $enabled, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$ScreenTurnCommandCopyWith<$Res>
    implements $ScreenTurnCommandCopyWith<$Res> {
  factory _$ScreenTurnCommandCopyWith(
    _ScreenTurnCommand value,
    $Res Function(_ScreenTurnCommand) _then,
  ) = __$ScreenTurnCommandCopyWithImpl;
  @override
  @useResult
  $Res call({bool enabled, int id, String type});
}

/// @nodoc
class __$ScreenTurnCommandCopyWithImpl<$Res>
    implements _$ScreenTurnCommandCopyWith<$Res> {
  __$ScreenTurnCommandCopyWithImpl(this._self, this._then);

  final _ScreenTurnCommand _self;
  final $Res Function(_ScreenTurnCommand) _then;

  /// Create a copy of ScreenTurnCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? enabled = null, Object? id = null, Object? type = null}) {
    return _then(
      _ScreenTurnCommand(
        enabled: null == enabled
            ? _self.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
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
mixin _$ScreenToggleCommand {
  int get id;
  String get type;

  /// Create a copy of ScreenToggleCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScreenToggleCommandCopyWith<ScreenToggleCommand> get copyWith =>
      _$ScreenToggleCommandCopyWithImpl<ScreenToggleCommand>(
        this as ScreenToggleCommand,
        _$identity,
      );

  /// Serializes this ScreenToggleCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as ScreenToggleCommand;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScreenToggleCommand &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.type, _this.type) || other.type == _this.type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as ScreenToggleCommand;
    return Object.hash(runtimeType, _this.id, _this.type);
  }

  @override
  String toString() {
    final _this = this as ScreenToggleCommand;
    return 'ScreenToggleCommand(id: ${_this.id}, type: ${_this.type})';
  }
}

/// @nodoc
abstract mixin class $ScreenToggleCommandCopyWith<$Res> {
  factory $ScreenToggleCommandCopyWith(
    ScreenToggleCommand value,
    $Res Function(ScreenToggleCommand) _then,
  ) = _$ScreenToggleCommandCopyWithImpl;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$ScreenToggleCommandCopyWithImpl<$Res>
    implements $ScreenToggleCommandCopyWith<$Res> {
  _$ScreenToggleCommandCopyWithImpl(this._self, this._then);

  final ScreenToggleCommand _self;
  final $Res Function(ScreenToggleCommand) _then;

  /// Create a copy of ScreenToggleCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? type = null}) {
    return _then(
      ScreenToggleCommand(
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

/// Adds pattern-matching-related methods to [ScreenToggleCommand].
extension ScreenToggleCommandPatterns on ScreenToggleCommand {
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
    TResult Function(_ScreenToggleCommand value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScreenToggleCommand() when $default != null:
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
    TResult Function(_ScreenToggleCommand value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenToggleCommand():
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
    TResult? Function(_ScreenToggleCommand value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenToggleCommand() when $default != null:
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
      case _ScreenToggleCommand() when $default != null:
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
      case _ScreenToggleCommand():
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
      case _ScreenToggleCommand() when $default != null:
        return $default(_that.id, _that.type);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ScreenToggleCommand implements ScreenToggleCommand {
  const _ScreenToggleCommand({
    required this.id,
    this.type = ScreenToggleCommand.TYPE,
  });
  factory _ScreenToggleCommand.fromJson(Map<String, dynamic> json) =>
      _$ScreenToggleCommandFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of ScreenToggleCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScreenToggleCommandCopyWith<_ScreenToggleCommand> get copyWith =>
      __$ScreenToggleCommandCopyWithImpl<_ScreenToggleCommand>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$ScreenToggleCommandToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScreenToggleCommand &&
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
    return 'ScreenToggleCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$ScreenToggleCommandCopyWith<$Res>
    implements $ScreenToggleCommandCopyWith<$Res> {
  factory _$ScreenToggleCommandCopyWith(
    _ScreenToggleCommand value,
    $Res Function(_ScreenToggleCommand) _then,
  ) = __$ScreenToggleCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$ScreenToggleCommandCopyWithImpl<$Res>
    implements _$ScreenToggleCommandCopyWith<$Res> {
  __$ScreenToggleCommandCopyWithImpl(this._self, this._then);

  final _ScreenToggleCommand _self;
  final $Res Function(_ScreenToggleCommand) _then;

  /// Create a copy of ScreenToggleCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? id = null, Object? type = null}) {
    return _then(
      _ScreenToggleCommand(
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
