// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame_discovery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiscoveredFrame {
  String get serviceKey;
  String get hostname;
  String get address;
  int get port;

  /// Create a copy of DiscoveredFrame
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiscoveredFrameCopyWith<DiscoveredFrame> get copyWith =>
      _$DiscoveredFrameCopyWithImpl<DiscoveredFrame>(this as DiscoveredFrame, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as DiscoveredFrame;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DiscoveredFrame &&
            (identical(other.serviceKey, _this.serviceKey) || other.serviceKey == _this.serviceKey) &&
            (identical(other.hostname, _this.hostname) || other.hostname == _this.hostname) &&
            (identical(other.address, _this.address) || other.address == _this.address) &&
            (identical(other.port, _this.port) || other.port == _this.port));
  }

  @override
  int get hashCode {
    final _this = this as DiscoveredFrame;
    return Object.hash(runtimeType, _this.serviceKey, _this.hostname, _this.address, _this.port);
  }

  @override
  String toString() {
    final _this = this as DiscoveredFrame;
    return 'DiscoveredFrame(serviceKey: ${_this.serviceKey}, hostname: ${_this.hostname}, address: ${_this.address}, port: ${_this.port})';
  }
}

/// @nodoc
abstract mixin class $DiscoveredFrameCopyWith<$Res> {
  factory $DiscoveredFrameCopyWith(DiscoveredFrame value, $Res Function(DiscoveredFrame) _then) =
      _$DiscoveredFrameCopyWithImpl;
  @useResult
  $Res call({String serviceKey, String hostname, String address, int port});
}

/// @nodoc
class _$DiscoveredFrameCopyWithImpl<$Res> implements $DiscoveredFrameCopyWith<$Res> {
  _$DiscoveredFrameCopyWithImpl(this._self, this._then);

  final DiscoveredFrame _self;
  final $Res Function(DiscoveredFrame) _then;

  /// Create a copy of DiscoveredFrame
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? serviceKey = null, Object? hostname = null, Object? address = null, Object? port = null}) {
    return _then(
      DiscoveredFrame(
        serviceKey: null == serviceKey
            ? _self.serviceKey
            : serviceKey // ignore: cast_nullable_to_non_nullable
                  as String,
        hostname: null == hostname
            ? _self.hostname
            : hostname // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _self.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        port: null == port
            ? _self.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [DiscoveredFrame].
extension DiscoveredFramePatterns on DiscoveredFrame {
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
    TResult Function(_DiscoveredFrame value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiscoveredFrame() when $default != null:
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
  TResult map<TResult extends Object?>(TResult Function(_DiscoveredFrame value) $default) {
    final _that = this;
    switch (_that) {
      case _DiscoveredFrame():
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
  TResult? mapOrNull<TResult extends Object?>(TResult? Function(_DiscoveredFrame value)? $default) {
    final _that = this;
    switch (_that) {
      case _DiscoveredFrame() when $default != null:
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
    TResult Function(String serviceKey, String hostname, String address, int port)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiscoveredFrame() when $default != null:
        return $default(_that.serviceKey, _that.hostname, _that.address, _that.port);
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
    TResult Function(String serviceKey, String hostname, String address, int port) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscoveredFrame():
        return $default(_that.serviceKey, _that.hostname, _that.address, _that.port);
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
    TResult? Function(String serviceKey, String hostname, String address, int port)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscoveredFrame() when $default != null:
        return $default(_that.serviceKey, _that.hostname, _that.address, _that.port);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DiscoveredFrame extends DiscoveredFrame {
  const _DiscoveredFrame({required this.serviceKey, required this.hostname, required this.address, required this.port})
    : super._();

  @override
  final String serviceKey;
  @override
  final String hostname;
  @override
  final String address;
  @override
  final int port;

  /// Create a copy of DiscoveredFrame
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DiscoveredFrameCopyWith<_DiscoveredFrame> get copyWith =>
      __$DiscoveredFrameCopyWithImpl<_DiscoveredFrame>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DiscoveredFrame &&
            (identical(other.serviceKey, serviceKey) || other.serviceKey == serviceKey) &&
            (identical(other.hostname, hostname) || other.hostname == hostname) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.port, port) || other.port == port));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, serviceKey, hostname, address, port);
  }

  @override
  String toString() {
    return 'DiscoveredFrame(serviceKey: $serviceKey, hostname: $hostname, address: $address, port: $port)';
  }
}

/// @nodoc
abstract mixin class _$DiscoveredFrameCopyWith<$Res> implements $DiscoveredFrameCopyWith<$Res> {
  factory _$DiscoveredFrameCopyWith(_DiscoveredFrame value, $Res Function(_DiscoveredFrame) _then) =
      __$DiscoveredFrameCopyWithImpl;
  @override
  @useResult
  $Res call({String serviceKey, String hostname, String address, int port});
}

/// @nodoc
class __$DiscoveredFrameCopyWithImpl<$Res> implements _$DiscoveredFrameCopyWith<$Res> {
  __$DiscoveredFrameCopyWithImpl(this._self, this._then);

  final _DiscoveredFrame _self;
  final $Res Function(_DiscoveredFrame) _then;

  /// Create a copy of DiscoveredFrame
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? serviceKey = null, Object? hostname = null, Object? address = null, Object? port = null}) {
    return _then(
      _DiscoveredFrame(
        serviceKey: null == serviceKey
            ? _self.serviceKey
            : serviceKey // ignore: cast_nullable_to_non_nullable
                  as String,
        hostname: null == hostname
            ? _self.hostname
            : hostname // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _self.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        port: null == port
            ? _self.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
mixin _$FrameDiscoveryUpdate {
  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is FrameDiscoveryUpdate);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FrameDiscoveryUpdate()';
  }
}

/// @nodoc
class $FrameDiscoveryUpdateCopyWith<$Res> {
  $FrameDiscoveryUpdateCopyWith(FrameDiscoveryUpdate _, $Res Function(FrameDiscoveryUpdate) __);
}

/// Adds pattern-matching-related methods to [FrameDiscoveryUpdate].
extension FrameDiscoveryUpdatePatterns on FrameDiscoveryUpdate {
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
    TResult Function(FrameResolved value)? resolved,
    TResult Function(FrameLost value)? lost,
    TResult Function(FrameDiscoveryLimited value)? limited,
    TResult Function(FrameResolveFailed value)? resolveFailed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FrameResolved() when resolved != null:
        return resolved(_that);
      case FrameLost() when lost != null:
        return lost(_that);
      case FrameDiscoveryLimited() when limited != null:
        return limited(_that);
      case FrameResolveFailed() when resolveFailed != null:
        return resolveFailed(_that);
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
    required TResult Function(FrameResolved value) resolved,
    required TResult Function(FrameLost value) lost,
    required TResult Function(FrameDiscoveryLimited value) limited,
    required TResult Function(FrameResolveFailed value) resolveFailed,
  }) {
    final _that = this;
    switch (_that) {
      case FrameResolved():
        return resolved(_that);
      case FrameLost():
        return lost(_that);
      case FrameDiscoveryLimited():
        return limited(_that);
      case FrameResolveFailed():
        return resolveFailed(_that);
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
    TResult? Function(FrameResolved value)? resolved,
    TResult? Function(FrameLost value)? lost,
    TResult? Function(FrameDiscoveryLimited value)? limited,
    TResult? Function(FrameResolveFailed value)? resolveFailed,
  }) {
    final _that = this;
    switch (_that) {
      case FrameResolved() when resolved != null:
        return resolved(_that);
      case FrameLost() when lost != null:
        return lost(_that);
      case FrameDiscoveryLimited() when limited != null:
        return limited(_that);
      case FrameResolveFailed() when resolveFailed != null:
        return resolveFailed(_that);
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
    TResult Function(DiscoveredFrame frame)? resolved,
    TResult Function(String serviceKey)? lost,
    TResult Function()? limited,
    TResult Function()? resolveFailed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FrameResolved() when resolved != null:
        return resolved(_that.frame);
      case FrameLost() when lost != null:
        return lost(_that.serviceKey);
      case FrameDiscoveryLimited() when limited != null:
        return limited();
      case FrameResolveFailed() when resolveFailed != null:
        return resolveFailed();
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
    required TResult Function(DiscoveredFrame frame) resolved,
    required TResult Function(String serviceKey) lost,
    required TResult Function() limited,
    required TResult Function() resolveFailed,
  }) {
    final _that = this;
    switch (_that) {
      case FrameResolved():
        return resolved(_that.frame);
      case FrameLost():
        return lost(_that.serviceKey);
      case FrameDiscoveryLimited():
        return limited();
      case FrameResolveFailed():
        return resolveFailed();
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
    TResult? Function(DiscoveredFrame frame)? resolved,
    TResult? Function(String serviceKey)? lost,
    TResult? Function()? limited,
    TResult? Function()? resolveFailed,
  }) {
    final _that = this;
    switch (_that) {
      case FrameResolved() when resolved != null:
        return resolved(_that.frame);
      case FrameLost() when lost != null:
        return lost(_that.serviceKey);
      case FrameDiscoveryLimited() when limited != null:
        return limited();
      case FrameResolveFailed() when resolveFailed != null:
        return resolveFailed();
      case _:
        return null;
    }
  }
}

/// @nodoc

class FrameResolved implements FrameDiscoveryUpdate {
  const FrameResolved(this.frame);

  final DiscoveredFrame frame;

  /// Create a copy of FrameDiscoveryUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FrameResolvedCopyWith<FrameResolved> get copyWith => _$FrameResolvedCopyWithImpl<FrameResolved>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FrameResolved &&
            (identical(other.frame, frame) || other.frame == frame));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, frame);
  }

  @override
  String toString() {
    return 'FrameDiscoveryUpdate.resolved(frame: $frame)';
  }
}

/// @nodoc
abstract mixin class $FrameResolvedCopyWith<$Res> implements $FrameDiscoveryUpdateCopyWith<$Res> {
  factory $FrameResolvedCopyWith(FrameResolved value, $Res Function(FrameResolved) _then) = _$FrameResolvedCopyWithImpl;
  @useResult
  $Res call({DiscoveredFrame frame});

  $DiscoveredFrameCopyWith<$Res> get frame;
}

/// @nodoc
class _$FrameResolvedCopyWithImpl<$Res> implements $FrameResolvedCopyWith<$Res> {
  _$FrameResolvedCopyWithImpl(this._self, this._then);

  final FrameResolved _self;
  final $Res Function(FrameResolved) _then;

  /// Create a copy of FrameDiscoveryUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? frame = null}) {
    return _then(
      FrameResolved(
        null == frame
            ? _self.frame
            : frame // ignore: cast_nullable_to_non_nullable
                  as DiscoveredFrame,
      ),
    );
  }

  /// Create a copy of FrameDiscoveryUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscoveredFrameCopyWith<$Res> get frame {
    return $DiscoveredFrameCopyWith<$Res>(_self.frame, (value) {
      return _then(_self.copyWith(frame: value));
    });
  }
}

/// @nodoc

class FrameLost implements FrameDiscoveryUpdate {
  const FrameLost(this.serviceKey);

  final String serviceKey;

  /// Create a copy of FrameDiscoveryUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FrameLostCopyWith<FrameLost> get copyWith => _$FrameLostCopyWithImpl<FrameLost>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FrameLost &&
            (identical(other.serviceKey, serviceKey) || other.serviceKey == serviceKey));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, serviceKey);
  }

  @override
  String toString() {
    return 'FrameDiscoveryUpdate.lost(serviceKey: $serviceKey)';
  }
}

/// @nodoc
abstract mixin class $FrameLostCopyWith<$Res> implements $FrameDiscoveryUpdateCopyWith<$Res> {
  factory $FrameLostCopyWith(FrameLost value, $Res Function(FrameLost) _then) = _$FrameLostCopyWithImpl;
  @useResult
  $Res call({String serviceKey});
}

/// @nodoc
class _$FrameLostCopyWithImpl<$Res> implements $FrameLostCopyWith<$Res> {
  _$FrameLostCopyWithImpl(this._self, this._then);

  final FrameLost _self;
  final $Res Function(FrameLost) _then;

  /// Create a copy of FrameDiscoveryUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? serviceKey = null}) {
    return _then(
      FrameLost(
        null == serviceKey
            ? _self.serviceKey
            : serviceKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class FrameDiscoveryLimited implements FrameDiscoveryUpdate {
  const FrameDiscoveryLimited();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is FrameDiscoveryLimited);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FrameDiscoveryUpdate.limited()';
  }
}

/// @nodoc

class FrameResolveFailed implements FrameDiscoveryUpdate {
  const FrameResolveFailed();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is FrameResolveFailed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FrameDiscoveryUpdate.resolveFailed()';
  }
}
