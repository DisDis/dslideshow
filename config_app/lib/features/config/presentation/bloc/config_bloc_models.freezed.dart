// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_bloc_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConfigEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConfigEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfigEvent()';
  }
}

/// @nodoc
class $ConfigEventCopyWith<$Res> {
  $ConfigEventCopyWith(ConfigEvent _, $Res Function(ConfigEvent) __);
}

/// Adds pattern-matching-related methods to [ConfigEvent].
extension ConfigEventPatterns on ConfigEvent {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfigLoadEvent value)? load,
    TResult Function(ConfigSaveEvent value)? save,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ConfigLoadEvent() when load != null:
        return load(_that);
      case ConfigSaveEvent() when save != null:
        return save(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(ConfigLoadEvent value) load,
    required TResult Function(ConfigSaveEvent value) save,
  }) {
    final _that = this;
    switch (_that) {
      case ConfigLoadEvent():
        return load(_that);
      case ConfigSaveEvent():
        return save(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfigLoadEvent value)? load,
    TResult? Function(ConfigSaveEvent value)? save,
  }) {
    final _that = this;
    switch (_that) {
      case ConfigLoadEvent() when load != null:
        return load(_that);
      case ConfigSaveEvent() when save != null:
        return save(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(AppConfig config)? save,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ConfigLoadEvent() when load != null:
        return load();
      case ConfigSaveEvent() when save != null:
        return save(_that.config);
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
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(AppConfig config) save,
  }) {
    final _that = this;
    switch (_that) {
      case ConfigLoadEvent():
        return load();
      case ConfigSaveEvent():
        return save(_that.config);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(AppConfig config)? save,
  }) {
    final _that = this;
    switch (_that) {
      case ConfigLoadEvent() when load != null:
        return load();
      case ConfigSaveEvent() when save != null:
        return save(_that.config);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ConfigLoadEvent implements ConfigEvent {
  const ConfigLoadEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConfigLoadEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfigEvent.load()';
  }
}

/// @nodoc

class ConfigSaveEvent implements ConfigEvent {
  const ConfigSaveEvent(this.config);

  final AppConfig config;

  /// Create a copy of ConfigEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfigSaveEventCopyWith<ConfigSaveEvent> get copyWith =>
      _$ConfigSaveEventCopyWithImpl<ConfigSaveEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfigSaveEvent &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @override
  String toString() {
    return 'ConfigEvent.save(config: $config)';
  }
}

/// @nodoc
abstract mixin class $ConfigSaveEventCopyWith<$Res>
    implements $ConfigEventCopyWith<$Res> {
  factory $ConfigSaveEventCopyWith(
          ConfigSaveEvent value, $Res Function(ConfigSaveEvent) _then) =
      _$ConfigSaveEventCopyWithImpl;
  @useResult
  $Res call({AppConfig config});
}

/// @nodoc
class _$ConfigSaveEventCopyWithImpl<$Res>
    implements $ConfigSaveEventCopyWith<$Res> {
  _$ConfigSaveEventCopyWithImpl(this._self, this._then);

  final ConfigSaveEvent _self;
  final $Res Function(ConfigSaveEvent) _then;

  /// Create a copy of ConfigEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
  }) {
    return _then(ConfigSaveEvent(
      null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as AppConfig,
    ));
  }
}

/// @nodoc
mixin _$ConfigState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConfigState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfigState()';
  }
}

/// @nodoc
class $ConfigStateCopyWith<$Res> {
  $ConfigStateCopyWith(ConfigState _, $Res Function(ConfigState) __);
}

/// Adds pattern-matching-related methods to [ConfigState].
extension ConfigStatePatterns on ConfigState {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfigInitialState value)? initial,
    TResult Function(ConfigLoadingState value)? loading,
    TResult Function(ConfigLoadedState value)? loaded,
    TResult Function(ConfigErrorState value)? error,
    TResult Function(ConfigSavingState value)? saving,
    TResult Function(ConfigSavedState value)? saved,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ConfigInitialState() when initial != null:
        return initial(_that);
      case ConfigLoadingState() when loading != null:
        return loading(_that);
      case ConfigLoadedState() when loaded != null:
        return loaded(_that);
      case ConfigErrorState() when error != null:
        return error(_that);
      case ConfigSavingState() when saving != null:
        return saving(_that);
      case ConfigSavedState() when saved != null:
        return saved(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(ConfigInitialState value) initial,
    required TResult Function(ConfigLoadingState value) loading,
    required TResult Function(ConfigLoadedState value) loaded,
    required TResult Function(ConfigErrorState value) error,
    required TResult Function(ConfigSavingState value) saving,
    required TResult Function(ConfigSavedState value) saved,
  }) {
    final _that = this;
    switch (_that) {
      case ConfigInitialState():
        return initial(_that);
      case ConfigLoadingState():
        return loading(_that);
      case ConfigLoadedState():
        return loaded(_that);
      case ConfigErrorState():
        return error(_that);
      case ConfigSavingState():
        return saving(_that);
      case ConfigSavedState():
        return saved(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfigInitialState value)? initial,
    TResult? Function(ConfigLoadingState value)? loading,
    TResult? Function(ConfigLoadedState value)? loaded,
    TResult? Function(ConfigErrorState value)? error,
    TResult? Function(ConfigSavingState value)? saving,
    TResult? Function(ConfigSavedState value)? saved,
  }) {
    final _that = this;
    switch (_that) {
      case ConfigInitialState() when initial != null:
        return initial(_that);
      case ConfigLoadingState() when loading != null:
        return loading(_that);
      case ConfigLoadedState() when loaded != null:
        return loaded(_that);
      case ConfigErrorState() when error != null:
        return error(_that);
      case ConfigSavingState() when saving != null:
        return saving(_that);
      case ConfigSavedState() when saved != null:
        return saved(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppConfig config)? loaded,
    TResult Function(String message)? error,
    TResult Function()? saving,
    TResult Function()? saved,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ConfigInitialState() when initial != null:
        return initial();
      case ConfigLoadingState() when loading != null:
        return loading();
      case ConfigLoadedState() when loaded != null:
        return loaded(_that.config);
      case ConfigErrorState() when error != null:
        return error(_that.message);
      case ConfigSavingState() when saving != null:
        return saving();
      case ConfigSavedState() when saved != null:
        return saved();
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
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppConfig config) loaded,
    required TResult Function(String message) error,
    required TResult Function() saving,
    required TResult Function() saved,
  }) {
    final _that = this;
    switch (_that) {
      case ConfigInitialState():
        return initial();
      case ConfigLoadingState():
        return loading();
      case ConfigLoadedState():
        return loaded(_that.config);
      case ConfigErrorState():
        return error(_that.message);
      case ConfigSavingState():
        return saving();
      case ConfigSavedState():
        return saved();
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppConfig config)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? saving,
    TResult? Function()? saved,
  }) {
    final _that = this;
    switch (_that) {
      case ConfigInitialState() when initial != null:
        return initial();
      case ConfigLoadingState() when loading != null:
        return loading();
      case ConfigLoadedState() when loaded != null:
        return loaded(_that.config);
      case ConfigErrorState() when error != null:
        return error(_that.message);
      case ConfigSavingState() when saving != null:
        return saving();
      case ConfigSavedState() when saved != null:
        return saved();
      case _:
        return null;
    }
  }
}

/// @nodoc

class ConfigInitialState implements ConfigState {
  const ConfigInitialState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConfigInitialState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfigState.initial()';
  }
}

/// @nodoc

class ConfigLoadingState implements ConfigState {
  const ConfigLoadingState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConfigLoadingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfigState.loading()';
  }
}

/// @nodoc

class ConfigLoadedState implements ConfigState {
  const ConfigLoadedState(this.config);

  final AppConfig config;

  /// Create a copy of ConfigState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfigLoadedStateCopyWith<ConfigLoadedState> get copyWith =>
      _$ConfigLoadedStateCopyWithImpl<ConfigLoadedState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfigLoadedState &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @override
  String toString() {
    return 'ConfigState.loaded(config: $config)';
  }
}

/// @nodoc
abstract mixin class $ConfigLoadedStateCopyWith<$Res>
    implements $ConfigStateCopyWith<$Res> {
  factory $ConfigLoadedStateCopyWith(
          ConfigLoadedState value, $Res Function(ConfigLoadedState) _then) =
      _$ConfigLoadedStateCopyWithImpl;
  @useResult
  $Res call({AppConfig config});
}

/// @nodoc
class _$ConfigLoadedStateCopyWithImpl<$Res>
    implements $ConfigLoadedStateCopyWith<$Res> {
  _$ConfigLoadedStateCopyWithImpl(this._self, this._then);

  final ConfigLoadedState _self;
  final $Res Function(ConfigLoadedState) _then;

  /// Create a copy of ConfigState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
  }) {
    return _then(ConfigLoadedState(
      null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as AppConfig,
    ));
  }
}

/// @nodoc

class ConfigErrorState implements ConfigState {
  const ConfigErrorState(this.message);

  final String message;

  /// Create a copy of ConfigState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfigErrorStateCopyWith<ConfigErrorState> get copyWith =>
      _$ConfigErrorStateCopyWithImpl<ConfigErrorState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfigErrorState &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'ConfigState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $ConfigErrorStateCopyWith<$Res>
    implements $ConfigStateCopyWith<$Res> {
  factory $ConfigErrorStateCopyWith(
          ConfigErrorState value, $Res Function(ConfigErrorState) _then) =
      _$ConfigErrorStateCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ConfigErrorStateCopyWithImpl<$Res>
    implements $ConfigErrorStateCopyWith<$Res> {
  _$ConfigErrorStateCopyWithImpl(this._self, this._then);

  final ConfigErrorState _self;
  final $Res Function(ConfigErrorState) _then;

  /// Create a copy of ConfigState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(ConfigErrorState(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ConfigSavingState implements ConfigState {
  const ConfigSavingState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConfigSavingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfigState.saving()';
  }
}

/// @nodoc

class ConfigSavedState implements ConfigState {
  const ConfigSavedState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConfigSavedState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfigState.saved()';
  }
}

// dart format on
