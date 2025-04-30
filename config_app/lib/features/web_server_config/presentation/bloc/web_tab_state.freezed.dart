// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebTabState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WebTabState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WebTabState()';
  }
}

/// @nodoc
class $WebTabStateCopyWith<$Res> {
  $WebTabStateCopyWith(WebTabState _, $Res Function(WebTabState) __);
}

/// @nodoc

class UnWebTabState implements WebTabState {
  const UnWebTabState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UnWebTabState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WebTabState.uninitialized()';
  }
}

/// @nodoc

class ErrorWebTabState implements WebTabState {
  const ErrorWebTabState(this.errorMessage);

  final String errorMessage;

  /// Create a copy of WebTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorWebTabStateCopyWith<ErrorWebTabState> get copyWith =>
      _$ErrorWebTabStateCopyWithImpl<ErrorWebTabState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorWebTabState &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'WebTabState.error(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ErrorWebTabStateCopyWith<$Res>
    implements $WebTabStateCopyWith<$Res> {
  factory $ErrorWebTabStateCopyWith(
          ErrorWebTabState value, $Res Function(ErrorWebTabState) _then) =
      _$ErrorWebTabStateCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$ErrorWebTabStateCopyWithImpl<$Res>
    implements $ErrorWebTabStateCopyWith<$Res> {
  _$ErrorWebTabStateCopyWithImpl(this._self, this._then);

  final ErrorWebTabState _self;
  final $Res Function(ErrorWebTabState) _then;

  /// Create a copy of WebTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(ErrorWebTabState(
      null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class InWebTabState implements WebTabState {
  const InWebTabState(this.config);

  final AppConfig config;

  /// Create a copy of WebTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InWebTabStateCopyWith<InWebTabState> get copyWith =>
      _$InWebTabStateCopyWithImpl<InWebTabState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InWebTabState &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @override
  String toString() {
    return 'WebTabState.initialized(config: $config)';
  }
}

/// @nodoc
abstract mixin class $InWebTabStateCopyWith<$Res>
    implements $WebTabStateCopyWith<$Res> {
  factory $InWebTabStateCopyWith(
          InWebTabState value, $Res Function(InWebTabState) _then) =
      _$InWebTabStateCopyWithImpl;
  @useResult
  $Res call({AppConfig config});
}

/// @nodoc
class _$InWebTabStateCopyWithImpl<$Res>
    implements $InWebTabStateCopyWith<$Res> {
  _$InWebTabStateCopyWithImpl(this._self, this._then);

  final InWebTabState _self;
  final $Res Function(InWebTabState) _then;

  /// Create a copy of WebTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
  }) {
    return _then(InWebTabState(
      null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as AppConfig,
    ));
  }
}

// dart format on
