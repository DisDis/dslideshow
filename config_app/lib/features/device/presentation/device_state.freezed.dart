// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceState {
  FrameState? get frame;
  SystemInfo? get metrics;
  RpcTelemetrySnapshot? get rpc;
  DateTime? get metricsSampledAt;
  int? get webSocketTimeouts;
  DeviceFailure? get failure;
  DeviceFailure? get metricsFailure;
  FrameControl? get pendingControl;
  bool get started;
  bool get active;
  bool get connected;
  bool get commandInFlight;
  bool get loading;
  bool get stale;
  bool get metricsStale;
  bool get rpcStale;
  bool get detailsExpanded;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeviceStateCopyWith<DeviceState> get copyWith =>
      _$DeviceStateCopyWithImpl<DeviceState>(this as DeviceState, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as DeviceState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeviceState &&
            (identical(other.frame, _this.frame) ||
                other.frame == _this.frame) &&
            (identical(other.metrics, _this.metrics) ||
                other.metrics == _this.metrics) &&
            (identical(other.rpc, _this.rpc) || other.rpc == _this.rpc) &&
            (identical(other.metricsSampledAt, _this.metricsSampledAt) ||
                other.metricsSampledAt == _this.metricsSampledAt) &&
            (identical(other.webSocketTimeouts, _this.webSocketTimeouts) ||
                other.webSocketTimeouts == _this.webSocketTimeouts) &&
            (identical(other.failure, _this.failure) ||
                other.failure == _this.failure) &&
            (identical(other.metricsFailure, _this.metricsFailure) ||
                other.metricsFailure == _this.metricsFailure) &&
            (identical(other.pendingControl, _this.pendingControl) ||
                other.pendingControl == _this.pendingControl) &&
            (identical(other.started, _this.started) ||
                other.started == _this.started) &&
            (identical(other.active, _this.active) ||
                other.active == _this.active) &&
            (identical(other.connected, _this.connected) ||
                other.connected == _this.connected) &&
            (identical(other.commandInFlight, _this.commandInFlight) ||
                other.commandInFlight == _this.commandInFlight) &&
            (identical(other.loading, _this.loading) ||
                other.loading == _this.loading) &&
            (identical(other.stale, _this.stale) ||
                other.stale == _this.stale) &&
            (identical(other.metricsStale, _this.metricsStale) ||
                other.metricsStale == _this.metricsStale) &&
            (identical(other.rpcStale, _this.rpcStale) ||
                other.rpcStale == _this.rpcStale) &&
            (identical(other.detailsExpanded, _this.detailsExpanded) ||
                other.detailsExpanded == _this.detailsExpanded));
  }

  @override
  int get hashCode {
    final _this = this as DeviceState;
    return Object.hash(
      runtimeType,
      _this.frame,
      _this.metrics,
      _this.rpc,
      _this.metricsSampledAt,
      _this.webSocketTimeouts,
      _this.failure,
      _this.metricsFailure,
      _this.pendingControl,
      _this.started,
      _this.active,
      _this.connected,
      _this.commandInFlight,
      _this.loading,
      _this.stale,
      _this.metricsStale,
      _this.rpcStale,
      _this.detailsExpanded,
    );
  }

  @override
  String toString() {
    final _this = this as DeviceState;
    return 'DeviceState(frame: ${_this.frame}, metrics: ${_this.metrics}, rpc: ${_this.rpc}, metricsSampledAt: ${_this.metricsSampledAt}, webSocketTimeouts: ${_this.webSocketTimeouts}, failure: ${_this.failure}, metricsFailure: ${_this.metricsFailure}, pendingControl: ${_this.pendingControl}, started: ${_this.started}, active: ${_this.active}, connected: ${_this.connected}, commandInFlight: ${_this.commandInFlight}, loading: ${_this.loading}, stale: ${_this.stale}, metricsStale: ${_this.metricsStale}, rpcStale: ${_this.rpcStale}, detailsExpanded: ${_this.detailsExpanded})';
  }
}

/// @nodoc
abstract mixin class $DeviceStateCopyWith<$Res> {
  factory $DeviceStateCopyWith(
    DeviceState value,
    $Res Function(DeviceState) _then,
  ) = _$DeviceStateCopyWithImpl;
  @useResult
  $Res call({
    FrameState? frame,
    SystemInfo? metrics,
    RpcTelemetrySnapshot? rpc,
    DateTime? metricsSampledAt,
    int? webSocketTimeouts,
    DeviceFailure? failure,
    DeviceFailure? metricsFailure,
    FrameControl? pendingControl,
    bool started,
    bool active,
    bool connected,
    bool commandInFlight,
    bool loading,
    bool stale,
    bool metricsStale,
    bool rpcStale,
    bool detailsExpanded,
  });

  $FrameStateCopyWith<$Res>? get frame;
  $SystemInfoCopyWith<$Res>? get metrics;
}

/// @nodoc
class _$DeviceStateCopyWithImpl<$Res> implements $DeviceStateCopyWith<$Res> {
  _$DeviceStateCopyWithImpl(this._self, this._then);

  final DeviceState _self;
  final $Res Function(DeviceState) _then;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frame = freezed,
    Object? metrics = freezed,
    Object? rpc = freezed,
    Object? metricsSampledAt = freezed,
    Object? webSocketTimeouts = freezed,
    Object? failure = freezed,
    Object? metricsFailure = freezed,
    Object? pendingControl = freezed,
    Object? started = null,
    Object? active = null,
    Object? connected = null,
    Object? commandInFlight = null,
    Object? loading = null,
    Object? stale = null,
    Object? metricsStale = null,
    Object? rpcStale = null,
    Object? detailsExpanded = null,
  }) {
    return _then(
      DeviceState(
        frame: freezed == frame
            ? _self.frame
            : frame // ignore: cast_nullable_to_non_nullable
                  as FrameState?,
        metrics: freezed == metrics
            ? _self.metrics
            : metrics // ignore: cast_nullable_to_non_nullable
                  as SystemInfo?,
        rpc: freezed == rpc
            ? _self.rpc
            : rpc // ignore: cast_nullable_to_non_nullable
                  as RpcTelemetrySnapshot?,
        metricsSampledAt: freezed == metricsSampledAt
            ? _self.metricsSampledAt
            : metricsSampledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        webSocketTimeouts: freezed == webSocketTimeouts
            ? _self.webSocketTimeouts
            : webSocketTimeouts // ignore: cast_nullable_to_non_nullable
                  as int?,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as DeviceFailure?,
        metricsFailure: freezed == metricsFailure
            ? _self.metricsFailure
            : metricsFailure // ignore: cast_nullable_to_non_nullable
                  as DeviceFailure?,
        pendingControl: freezed == pendingControl
            ? _self.pendingControl
            : pendingControl // ignore: cast_nullable_to_non_nullable
                  as FrameControl?,
        started: null == started
            ? _self.started
            : started // ignore: cast_nullable_to_non_nullable
                  as bool,
        active: null == active
            ? _self.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        connected: null == connected
            ? _self.connected
            : connected // ignore: cast_nullable_to_non_nullable
                  as bool,
        commandInFlight: null == commandInFlight
            ? _self.commandInFlight
            : commandInFlight // ignore: cast_nullable_to_non_nullable
                  as bool,
        loading: null == loading
            ? _self.loading
            : loading // ignore: cast_nullable_to_non_nullable
                  as bool,
        stale: null == stale
            ? _self.stale
            : stale // ignore: cast_nullable_to_non_nullable
                  as bool,
        metricsStale: null == metricsStale
            ? _self.metricsStale
            : metricsStale // ignore: cast_nullable_to_non_nullable
                  as bool,
        rpcStale: null == rpcStale
            ? _self.rpcStale
            : rpcStale // ignore: cast_nullable_to_non_nullable
                  as bool,
        detailsExpanded: null == detailsExpanded
            ? _self.detailsExpanded
            : detailsExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FrameStateCopyWith<$Res>? get frame {
    if (_self.frame == null) {
      return null;
    }

    return $FrameStateCopyWith<$Res>(_self.frame!, (value) {
      return _then(_self.copyWith(frame: value));
    });
  }

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SystemInfoCopyWith<$Res>? get metrics {
    if (_self.metrics == null) {
      return null;
    }

    return $SystemInfoCopyWith<$Res>(_self.metrics!, (value) {
      return _then(_self.copyWith(metrics: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DeviceState].
extension DeviceStatePatterns on DeviceState {
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
    TResult Function(_DeviceState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeviceState() when $default != null:
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
    TResult Function(_DeviceState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeviceState():
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
    TResult? Function(_DeviceState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeviceState() when $default != null:
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
      FrameState? frame,
      SystemInfo? metrics,
      RpcTelemetrySnapshot? rpc,
      DateTime? metricsSampledAt,
      int? webSocketTimeouts,
      DeviceFailure? failure,
      DeviceFailure? metricsFailure,
      FrameControl? pendingControl,
      bool started,
      bool active,
      bool connected,
      bool commandInFlight,
      bool loading,
      bool stale,
      bool metricsStale,
      bool rpcStale,
      bool detailsExpanded,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeviceState() when $default != null:
        return $default(
          _that.frame,
          _that.metrics,
          _that.rpc,
          _that.metricsSampledAt,
          _that.webSocketTimeouts,
          _that.failure,
          _that.metricsFailure,
          _that.pendingControl,
          _that.started,
          _that.active,
          _that.connected,
          _that.commandInFlight,
          _that.loading,
          _that.stale,
          _that.metricsStale,
          _that.rpcStale,
          _that.detailsExpanded,
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
      FrameState? frame,
      SystemInfo? metrics,
      RpcTelemetrySnapshot? rpc,
      DateTime? metricsSampledAt,
      int? webSocketTimeouts,
      DeviceFailure? failure,
      DeviceFailure? metricsFailure,
      FrameControl? pendingControl,
      bool started,
      bool active,
      bool connected,
      bool commandInFlight,
      bool loading,
      bool stale,
      bool metricsStale,
      bool rpcStale,
      bool detailsExpanded,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeviceState():
        return $default(
          _that.frame,
          _that.metrics,
          _that.rpc,
          _that.metricsSampledAt,
          _that.webSocketTimeouts,
          _that.failure,
          _that.metricsFailure,
          _that.pendingControl,
          _that.started,
          _that.active,
          _that.connected,
          _that.commandInFlight,
          _that.loading,
          _that.stale,
          _that.metricsStale,
          _that.rpcStale,
          _that.detailsExpanded,
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
      FrameState? frame,
      SystemInfo? metrics,
      RpcTelemetrySnapshot? rpc,
      DateTime? metricsSampledAt,
      int? webSocketTimeouts,
      DeviceFailure? failure,
      DeviceFailure? metricsFailure,
      FrameControl? pendingControl,
      bool started,
      bool active,
      bool connected,
      bool commandInFlight,
      bool loading,
      bool stale,
      bool metricsStale,
      bool rpcStale,
      bool detailsExpanded,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeviceState() when $default != null:
        return $default(
          _that.frame,
          _that.metrics,
          _that.rpc,
          _that.metricsSampledAt,
          _that.webSocketTimeouts,
          _that.failure,
          _that.metricsFailure,
          _that.pendingControl,
          _that.started,
          _that.active,
          _that.connected,
          _that.commandInFlight,
          _that.loading,
          _that.stale,
          _that.metricsStale,
          _that.rpcStale,
          _that.detailsExpanded,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DeviceState extends DeviceState {
  const _DeviceState({
    this.frame,
    this.metrics,
    this.rpc,
    this.metricsSampledAt,
    this.webSocketTimeouts,
    this.failure,
    this.metricsFailure,
    this.pendingControl,
    this.started = false,
    this.active = true,
    this.connected = true,
    this.commandInFlight = false,
    this.loading = false,
    this.stale = true,
    this.metricsStale = true,
    this.rpcStale = true,
    this.detailsExpanded = false,
  }) : super._();

  @override
  final FrameState? frame;
  @override
  final SystemInfo? metrics;
  @override
  final RpcTelemetrySnapshot? rpc;
  @override
  final DateTime? metricsSampledAt;
  @override
  final int? webSocketTimeouts;
  @override
  final DeviceFailure? failure;
  @override
  final DeviceFailure? metricsFailure;
  @override
  final FrameControl? pendingControl;
  @override
  @JsonKey()
  final bool started;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final bool connected;
  @override
  @JsonKey()
  final bool commandInFlight;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool stale;
  @override
  @JsonKey()
  final bool metricsStale;
  @override
  @JsonKey()
  final bool rpcStale;
  @override
  @JsonKey()
  final bool detailsExpanded;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeviceStateCopyWith<_DeviceState> get copyWith =>
      __$DeviceStateCopyWithImpl<_DeviceState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceState &&
            (identical(other.frame, frame) || other.frame == frame) &&
            (identical(other.metrics, metrics) || other.metrics == metrics) &&
            (identical(other.rpc, rpc) || other.rpc == rpc) &&
            (identical(other.metricsSampledAt, metricsSampledAt) ||
                other.metricsSampledAt == metricsSampledAt) &&
            (identical(other.webSocketTimeouts, webSocketTimeouts) ||
                other.webSocketTimeouts == webSocketTimeouts) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.metricsFailure, metricsFailure) ||
                other.metricsFailure == metricsFailure) &&
            (identical(other.pendingControl, pendingControl) ||
                other.pendingControl == pendingControl) &&
            (identical(other.started, started) || other.started == started) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.connected, connected) ||
                other.connected == connected) &&
            (identical(other.commandInFlight, commandInFlight) ||
                other.commandInFlight == commandInFlight) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.stale, stale) || other.stale == stale) &&
            (identical(other.metricsStale, metricsStale) ||
                other.metricsStale == metricsStale) &&
            (identical(other.rpcStale, rpcStale) ||
                other.rpcStale == rpcStale) &&
            (identical(other.detailsExpanded, detailsExpanded) ||
                other.detailsExpanded == detailsExpanded));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      frame,
      metrics,
      rpc,
      metricsSampledAt,
      webSocketTimeouts,
      failure,
      metricsFailure,
      pendingControl,
      started,
      active,
      connected,
      commandInFlight,
      loading,
      stale,
      metricsStale,
      rpcStale,
      detailsExpanded,
    );
  }

  @override
  String toString() {
    return 'DeviceState(frame: $frame, metrics: $metrics, rpc: $rpc, metricsSampledAt: $metricsSampledAt, webSocketTimeouts: $webSocketTimeouts, failure: $failure, metricsFailure: $metricsFailure, pendingControl: $pendingControl, started: $started, active: $active, connected: $connected, commandInFlight: $commandInFlight, loading: $loading, stale: $stale, metricsStale: $metricsStale, rpcStale: $rpcStale, detailsExpanded: $detailsExpanded)';
  }
}

/// @nodoc
abstract mixin class _$DeviceStateCopyWith<$Res>
    implements $DeviceStateCopyWith<$Res> {
  factory _$DeviceStateCopyWith(
    _DeviceState value,
    $Res Function(_DeviceState) _then,
  ) = __$DeviceStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    FrameState? frame,
    SystemInfo? metrics,
    RpcTelemetrySnapshot? rpc,
    DateTime? metricsSampledAt,
    int? webSocketTimeouts,
    DeviceFailure? failure,
    DeviceFailure? metricsFailure,
    FrameControl? pendingControl,
    bool started,
    bool active,
    bool connected,
    bool commandInFlight,
    bool loading,
    bool stale,
    bool metricsStale,
    bool rpcStale,
    bool detailsExpanded,
  });

  @override
  $FrameStateCopyWith<$Res>? get frame;
  @override
  $SystemInfoCopyWith<$Res>? get metrics;
}

/// @nodoc
class __$DeviceStateCopyWithImpl<$Res> implements _$DeviceStateCopyWith<$Res> {
  __$DeviceStateCopyWithImpl(this._self, this._then);

  final _DeviceState _self;
  final $Res Function(_DeviceState) _then;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? frame = freezed,
    Object? metrics = freezed,
    Object? rpc = freezed,
    Object? metricsSampledAt = freezed,
    Object? webSocketTimeouts = freezed,
    Object? failure = freezed,
    Object? metricsFailure = freezed,
    Object? pendingControl = freezed,
    Object? started = null,
    Object? active = null,
    Object? connected = null,
    Object? commandInFlight = null,
    Object? loading = null,
    Object? stale = null,
    Object? metricsStale = null,
    Object? rpcStale = null,
    Object? detailsExpanded = null,
  }) {
    return _then(
      _DeviceState(
        frame: freezed == frame
            ? _self.frame
            : frame // ignore: cast_nullable_to_non_nullable
                  as FrameState?,
        metrics: freezed == metrics
            ? _self.metrics
            : metrics // ignore: cast_nullable_to_non_nullable
                  as SystemInfo?,
        rpc: freezed == rpc
            ? _self.rpc
            : rpc // ignore: cast_nullable_to_non_nullable
                  as RpcTelemetrySnapshot?,
        metricsSampledAt: freezed == metricsSampledAt
            ? _self.metricsSampledAt
            : metricsSampledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        webSocketTimeouts: freezed == webSocketTimeouts
            ? _self.webSocketTimeouts
            : webSocketTimeouts // ignore: cast_nullable_to_non_nullable
                  as int?,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as DeviceFailure?,
        metricsFailure: freezed == metricsFailure
            ? _self.metricsFailure
            : metricsFailure // ignore: cast_nullable_to_non_nullable
                  as DeviceFailure?,
        pendingControl: freezed == pendingControl
            ? _self.pendingControl
            : pendingControl // ignore: cast_nullable_to_non_nullable
                  as FrameControl?,
        started: null == started
            ? _self.started
            : started // ignore: cast_nullable_to_non_nullable
                  as bool,
        active: null == active
            ? _self.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        connected: null == connected
            ? _self.connected
            : connected // ignore: cast_nullable_to_non_nullable
                  as bool,
        commandInFlight: null == commandInFlight
            ? _self.commandInFlight
            : commandInFlight // ignore: cast_nullable_to_non_nullable
                  as bool,
        loading: null == loading
            ? _self.loading
            : loading // ignore: cast_nullable_to_non_nullable
                  as bool,
        stale: null == stale
            ? _self.stale
            : stale // ignore: cast_nullable_to_non_nullable
                  as bool,
        metricsStale: null == metricsStale
            ? _self.metricsStale
            : metricsStale // ignore: cast_nullable_to_non_nullable
                  as bool,
        rpcStale: null == rpcStale
            ? _self.rpcStale
            : rpcStale // ignore: cast_nullable_to_non_nullable
                  as bool,
        detailsExpanded: null == detailsExpanded
            ? _self.detailsExpanded
            : detailsExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FrameStateCopyWith<$Res>? get frame {
    if (_self.frame == null) {
      return null;
    }

    return $FrameStateCopyWith<$Res>(_self.frame!, (value) {
      return _then(_self.copyWith(frame: value));
    });
  }

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SystemInfoCopyWith<$Res>? get metrics {
    if (_self.metrics == null) {
      return null;
    }

    return $SystemInfoCopyWith<$Res>(_self.metrics!, (value) {
      return _then(_self.copyWith(metrics: value));
    });
  }
}
