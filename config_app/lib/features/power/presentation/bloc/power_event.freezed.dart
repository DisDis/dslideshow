// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'power_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PowerEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PowerEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PowerEvent()';
  }
}

/// @nodoc
class $PowerEventCopyWith<$Res> {
  $PowerEventCopyWith(PowerEvent _, $Res Function(PowerEvent) __);
}

/// Adds pattern-matching-related methods to [PowerEvent].
extension PowerEventPatterns on PowerEvent {
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
    TResult Function(RestartAppPowerEvent value)? restartApp,
    TResult Function(PowerOffPowerEvent value)? powerOff,
    TResult Function(LoadPowerEvent value)? load,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case RestartAppPowerEvent() when restartApp != null:
        return restartApp(_that);
      case PowerOffPowerEvent() when powerOff != null:
        return powerOff(_that);
      case LoadPowerEvent() when load != null:
        return load(_that);
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
    required TResult Function(RestartAppPowerEvent value) restartApp,
    required TResult Function(PowerOffPowerEvent value) powerOff,
    required TResult Function(LoadPowerEvent value) load,
  }) {
    final _that = this;
    switch (_that) {
      case RestartAppPowerEvent():
        return restartApp(_that);
      case PowerOffPowerEvent():
        return powerOff(_that);
      case LoadPowerEvent():
        return load(_that);
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
    TResult? Function(RestartAppPowerEvent value)? restartApp,
    TResult? Function(PowerOffPowerEvent value)? powerOff,
    TResult? Function(LoadPowerEvent value)? load,
  }) {
    final _that = this;
    switch (_that) {
      case RestartAppPowerEvent() when restartApp != null:
        return restartApp(_that);
      case PowerOffPowerEvent() when powerOff != null:
        return powerOff(_that);
      case LoadPowerEvent() when load != null:
        return load(_that);
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
    TResult Function()? restartApp,
    TResult Function()? powerOff,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case RestartAppPowerEvent() when restartApp != null:
        return restartApp();
      case PowerOffPowerEvent() when powerOff != null:
        return powerOff();
      case LoadPowerEvent() when load != null:
        return load();
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
    required TResult Function() restartApp,
    required TResult Function() powerOff,
    required TResult Function() load,
  }) {
    final _that = this;
    switch (_that) {
      case RestartAppPowerEvent():
        return restartApp();
      case PowerOffPowerEvent():
        return powerOff();
      case LoadPowerEvent():
        return load();
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
    TResult? Function()? restartApp,
    TResult? Function()? powerOff,
    TResult? Function()? load,
  }) {
    final _that = this;
    switch (_that) {
      case RestartAppPowerEvent() when restartApp != null:
        return restartApp();
      case PowerOffPowerEvent() when powerOff != null:
        return powerOff();
      case LoadPowerEvent() when load != null:
        return load();
      case _:
        return null;
    }
  }
}

/// @nodoc

class RestartAppPowerEvent implements PowerEvent {
  const RestartAppPowerEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RestartAppPowerEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PowerEvent.restartApp()';
  }
}

/// @nodoc

class PowerOffPowerEvent implements PowerEvent {
  const PowerOffPowerEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PowerOffPowerEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PowerEvent.powerOff()';
  }
}

/// @nodoc

class LoadPowerEvent implements PowerEvent {
  const LoadPowerEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadPowerEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PowerEvent.load()';
  }
}

// dart format on
