// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_tab_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WebTabEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() reload,
    required TResult Function() load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? reload,
    TResult? Function()? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? reload,
    TResult Function()? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ReloadAppWebTabEvent value) reload,
    required TResult Function(LoadWebTabEvent value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReloadAppWebTabEvent value)? reload,
    TResult? Function(LoadWebTabEvent value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReloadAppWebTabEvent value)? reload,
    TResult Function(LoadWebTabEvent value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebTabEventCopyWith<$Res> {
  factory $WebTabEventCopyWith(
          WebTabEvent value, $Res Function(WebTabEvent) then) =
      _$WebTabEventCopyWithImpl<$Res, WebTabEvent>;
}

/// @nodoc
class _$WebTabEventCopyWithImpl<$Res, $Val extends WebTabEvent>
    implements $WebTabEventCopyWith<$Res> {
  _$WebTabEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ReloadAppWebTabEventImplCopyWith<$Res> {
  factory _$$ReloadAppWebTabEventImplCopyWith(_$ReloadAppWebTabEventImpl value,
          $Res Function(_$ReloadAppWebTabEventImpl) then) =
      __$$ReloadAppWebTabEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReloadAppWebTabEventImplCopyWithImpl<$Res>
    extends _$WebTabEventCopyWithImpl<$Res, _$ReloadAppWebTabEventImpl>
    implements _$$ReloadAppWebTabEventImplCopyWith<$Res> {
  __$$ReloadAppWebTabEventImplCopyWithImpl(_$ReloadAppWebTabEventImpl _value,
      $Res Function(_$ReloadAppWebTabEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ReloadAppWebTabEventImpl implements ReloadAppWebTabEvent {
  const _$ReloadAppWebTabEventImpl();

  @override
  String toString() {
    return 'WebTabEvent.reload()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReloadAppWebTabEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() reload,
    required TResult Function() load,
  }) {
    return reload();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? reload,
    TResult? Function()? load,
  }) {
    return reload?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? reload,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (reload != null) {
      return reload();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ReloadAppWebTabEvent value) reload,
    required TResult Function(LoadWebTabEvent value) load,
  }) {
    return reload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReloadAppWebTabEvent value)? reload,
    TResult? Function(LoadWebTabEvent value)? load,
  }) {
    return reload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReloadAppWebTabEvent value)? reload,
    TResult Function(LoadWebTabEvent value)? load,
    required TResult orElse(),
  }) {
    if (reload != null) {
      return reload(this);
    }
    return orElse();
  }
}

abstract class ReloadAppWebTabEvent implements WebTabEvent {
  const factory ReloadAppWebTabEvent() = _$ReloadAppWebTabEventImpl;
}

/// @nodoc
abstract class _$$LoadWebTabEventImplCopyWith<$Res> {
  factory _$$LoadWebTabEventImplCopyWith(_$LoadWebTabEventImpl value,
          $Res Function(_$LoadWebTabEventImpl) then) =
      __$$LoadWebTabEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadWebTabEventImplCopyWithImpl<$Res>
    extends _$WebTabEventCopyWithImpl<$Res, _$LoadWebTabEventImpl>
    implements _$$LoadWebTabEventImplCopyWith<$Res> {
  __$$LoadWebTabEventImplCopyWithImpl(
      _$LoadWebTabEventImpl _value, $Res Function(_$LoadWebTabEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadWebTabEventImpl implements LoadWebTabEvent {
  const _$LoadWebTabEventImpl();

  @override
  String toString() {
    return 'WebTabEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadWebTabEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() reload,
    required TResult Function() load,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? reload,
    TResult? Function()? load,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? reload,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ReloadAppWebTabEvent value) reload,
    required TResult Function(LoadWebTabEvent value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReloadAppWebTabEvent value)? reload,
    TResult? Function(LoadWebTabEvent value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReloadAppWebTabEvent value)? reload,
    TResult Function(LoadWebTabEvent value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadWebTabEvent implements WebTabEvent {
  const factory LoadWebTabEvent() = _$LoadWebTabEventImpl;
}
