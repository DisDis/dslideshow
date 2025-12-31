// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_tab_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebTabEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WebTabEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WebTabEvent()';
  }
}

/// @nodoc
class $WebTabEventCopyWith<$Res> {
  $WebTabEventCopyWith(WebTabEvent _, $Res Function(WebTabEvent) __);
}

/// Adds pattern-matching-related methods to [WebTabEvent].
extension WebTabEventPatterns on WebTabEvent {
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
    TResult Function(ReloadAppWebTabEvent value)? reload,
    TResult Function(LoadWebTabEvent value)? load,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ReloadAppWebTabEvent() when reload != null:
        return reload(_that);
      case LoadWebTabEvent() when load != null:
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
    required TResult Function(ReloadAppWebTabEvent value) reload,
    required TResult Function(LoadWebTabEvent value) load,
  }) {
    final _that = this;
    switch (_that) {
      case ReloadAppWebTabEvent():
        return reload(_that);
      case LoadWebTabEvent():
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
    TResult? Function(ReloadAppWebTabEvent value)? reload,
    TResult? Function(LoadWebTabEvent value)? load,
  }) {
    final _that = this;
    switch (_that) {
      case ReloadAppWebTabEvent() when reload != null:
        return reload(_that);
      case LoadWebTabEvent() when load != null:
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
    TResult Function()? reload,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ReloadAppWebTabEvent() when reload != null:
        return reload();
      case LoadWebTabEvent() when load != null:
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
    required TResult Function() reload,
    required TResult Function() load,
  }) {
    final _that = this;
    switch (_that) {
      case ReloadAppWebTabEvent():
        return reload();
      case LoadWebTabEvent():
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
    TResult? Function()? reload,
    TResult? Function()? load,
  }) {
    final _that = this;
    switch (_that) {
      case ReloadAppWebTabEvent() when reload != null:
        return reload();
      case LoadWebTabEvent() when load != null:
        return load();
      case _:
        return null;
    }
  }
}

/// @nodoc

class ReloadAppWebTabEvent implements WebTabEvent {
  const ReloadAppWebTabEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ReloadAppWebTabEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WebTabEvent.reload()';
  }
}

/// @nodoc

class LoadWebTabEvent implements WebTabEvent {
  const LoadWebTabEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadWebTabEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WebTabEvent.load()';
  }
}

// dart format on
