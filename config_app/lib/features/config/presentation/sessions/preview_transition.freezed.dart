// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preview_transition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PreviewTransition {
  MediaSliderItemEffect get effect;
  EffectSlideInput get outgoing;
  EffectSlideInput get incoming;
  Duration get duration;

  /// Create a copy of PreviewTransition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PreviewTransitionCopyWith<PreviewTransition> get copyWith =>
      _$PreviewTransitionCopyWithImpl<PreviewTransition>(
        this as PreviewTransition,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as PreviewTransition;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PreviewTransition &&
            (identical(other.effect, _this.effect) ||
                other.effect == _this.effect) &&
            (identical(other.outgoing, _this.outgoing) ||
                other.outgoing == _this.outgoing) &&
            (identical(other.incoming, _this.incoming) ||
                other.incoming == _this.incoming) &&
            (identical(other.duration, _this.duration) ||
                other.duration == _this.duration));
  }

  @override
  int get hashCode {
    final _this = this as PreviewTransition;
    return Object.hash(
      runtimeType,
      _this.effect,
      _this.outgoing,
      _this.incoming,
      _this.duration,
    );
  }

  @override
  String toString() {
    final _this = this as PreviewTransition;
    return 'PreviewTransition(effect: ${_this.effect}, outgoing: ${_this.outgoing}, incoming: ${_this.incoming}, duration: ${_this.duration})';
  }
}

/// @nodoc
abstract mixin class $PreviewTransitionCopyWith<$Res> {
  factory $PreviewTransitionCopyWith(
    PreviewTransition value,
    $Res Function(PreviewTransition) _then,
  ) = _$PreviewTransitionCopyWithImpl;
  @useResult
  $Res call({
    MediaSliderItemEffect effect,
    EffectSlideInput outgoing,
    EffectSlideInput incoming,
    Duration duration,
  });

  $EffectSlideInputCopyWith<$Res> get outgoing;
  $EffectSlideInputCopyWith<$Res> get incoming;
}

/// @nodoc
class _$PreviewTransitionCopyWithImpl<$Res>
    implements $PreviewTransitionCopyWith<$Res> {
  _$PreviewTransitionCopyWithImpl(this._self, this._then);

  final PreviewTransition _self;
  final $Res Function(PreviewTransition) _then;

  /// Create a copy of PreviewTransition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? effect = null,
    Object? outgoing = null,
    Object? incoming = null,
    Object? duration = null,
  }) {
    return _then(
      PreviewTransition(
        effect: null == effect
            ? _self.effect
            : effect // ignore: cast_nullable_to_non_nullable
                  as MediaSliderItemEffect,
        outgoing: null == outgoing
            ? _self.outgoing
            : outgoing // ignore: cast_nullable_to_non_nullable
                  as EffectSlideInput,
        incoming: null == incoming
            ? _self.incoming
            : incoming // ignore: cast_nullable_to_non_nullable
                  as EffectSlideInput,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration,
      ),
    );
  }

  /// Create a copy of PreviewTransition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EffectSlideInputCopyWith<$Res> get outgoing {
    return $EffectSlideInputCopyWith<$Res>(_self.outgoing, (value) {
      return _then(_self.copyWith(outgoing: value));
    });
  }

  /// Create a copy of PreviewTransition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EffectSlideInputCopyWith<$Res> get incoming {
    return $EffectSlideInputCopyWith<$Res>(_self.incoming, (value) {
      return _then(_self.copyWith(incoming: value));
    });
  }
}

/// Adds pattern-matching-related methods to [PreviewTransition].
extension PreviewTransitionPatterns on PreviewTransition {
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
    TResult Function(_PreviewTransition value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PreviewTransition() when $default != null:
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
    TResult Function(_PreviewTransition value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PreviewTransition():
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
    TResult? Function(_PreviewTransition value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PreviewTransition() when $default != null:
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
      MediaSliderItemEffect effect,
      EffectSlideInput outgoing,
      EffectSlideInput incoming,
      Duration duration,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PreviewTransition() when $default != null:
        return $default(
          _that.effect,
          _that.outgoing,
          _that.incoming,
          _that.duration,
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
      MediaSliderItemEffect effect,
      EffectSlideInput outgoing,
      EffectSlideInput incoming,
      Duration duration,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PreviewTransition():
        return $default(
          _that.effect,
          _that.outgoing,
          _that.incoming,
          _that.duration,
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
      MediaSliderItemEffect effect,
      EffectSlideInput outgoing,
      EffectSlideInput incoming,
      Duration duration,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PreviewTransition() when $default != null:
        return $default(
          _that.effect,
          _that.outgoing,
          _that.incoming,
          _that.duration,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PreviewTransition implements PreviewTransition {
  const _PreviewTransition({
    required this.effect,
    required this.outgoing,
    required this.incoming,
    required this.duration,
  });

  @override
  final MediaSliderItemEffect effect;
  @override
  final EffectSlideInput outgoing;
  @override
  final EffectSlideInput incoming;
  @override
  final Duration duration;

  /// Create a copy of PreviewTransition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PreviewTransitionCopyWith<_PreviewTransition> get copyWith =>
      __$PreviewTransitionCopyWithImpl<_PreviewTransition>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PreviewTransition &&
            (identical(other.effect, effect) || other.effect == effect) &&
            (identical(other.outgoing, outgoing) ||
                other.outgoing == outgoing) &&
            (identical(other.incoming, incoming) ||
                other.incoming == incoming) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, effect, outgoing, incoming, duration);
  }

  @override
  String toString() {
    return 'PreviewTransition(effect: $effect, outgoing: $outgoing, incoming: $incoming, duration: $duration)';
  }
}

/// @nodoc
abstract mixin class _$PreviewTransitionCopyWith<$Res>
    implements $PreviewTransitionCopyWith<$Res> {
  factory _$PreviewTransitionCopyWith(
    _PreviewTransition value,
    $Res Function(_PreviewTransition) _then,
  ) = __$PreviewTransitionCopyWithImpl;
  @override
  @useResult
  $Res call({
    MediaSliderItemEffect effect,
    EffectSlideInput outgoing,
    EffectSlideInput incoming,
    Duration duration,
  });

  @override
  $EffectSlideInputCopyWith<$Res> get outgoing;
  @override
  $EffectSlideInputCopyWith<$Res> get incoming;
}

/// @nodoc
class __$PreviewTransitionCopyWithImpl<$Res>
    implements _$PreviewTransitionCopyWith<$Res> {
  __$PreviewTransitionCopyWithImpl(this._self, this._then);

  final _PreviewTransition _self;
  final $Res Function(_PreviewTransition) _then;

  /// Create a copy of PreviewTransition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? effect = null,
    Object? outgoing = null,
    Object? incoming = null,
    Object? duration = null,
  }) {
    return _then(
      _PreviewTransition(
        effect: null == effect
            ? _self.effect
            : effect // ignore: cast_nullable_to_non_nullable
                  as MediaSliderItemEffect,
        outgoing: null == outgoing
            ? _self.outgoing
            : outgoing // ignore: cast_nullable_to_non_nullable
                  as EffectSlideInput,
        incoming: null == incoming
            ? _self.incoming
            : incoming // ignore: cast_nullable_to_non_nullable
                  as EffectSlideInput,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration,
      ),
    );
  }

  /// Create a copy of PreviewTransition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EffectSlideInputCopyWith<$Res> get outgoing {
    return $EffectSlideInputCopyWith<$Res>(_self.outgoing, (value) {
      return _then(_self.copyWith(outgoing: value));
    });
  }

  /// Create a copy of PreviewTransition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EffectSlideInputCopyWith<$Res> get incoming {
    return $EffectSlideInputCopyWith<$Res>(_self.incoming, (value) {
      return _then(_self.copyWith(incoming: value));
    });
  }
}

/// @nodoc
mixin _$PreviewPhotoPair {
  PreviewPhoto get from;
  int get fromIndex;
  PreviewPhoto get to;
  int get toIndex;

  /// Create a copy of PreviewPhotoPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PreviewPhotoPairCopyWith<PreviewPhotoPair> get copyWith =>
      _$PreviewPhotoPairCopyWithImpl<PreviewPhotoPair>(
        this as PreviewPhotoPair,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as PreviewPhotoPair;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PreviewPhotoPair &&
            (identical(other.from, _this.from) || other.from == _this.from) &&
            (identical(other.fromIndex, _this.fromIndex) ||
                other.fromIndex == _this.fromIndex) &&
            (identical(other.to, _this.to) || other.to == _this.to) &&
            (identical(other.toIndex, _this.toIndex) ||
                other.toIndex == _this.toIndex));
  }

  @override
  int get hashCode {
    final _this = this as PreviewPhotoPair;
    return Object.hash(
      runtimeType,
      _this.from,
      _this.fromIndex,
      _this.to,
      _this.toIndex,
    );
  }

  @override
  String toString() {
    final _this = this as PreviewPhotoPair;
    return 'PreviewPhotoPair(from: ${_this.from}, fromIndex: ${_this.fromIndex}, to: ${_this.to}, toIndex: ${_this.toIndex})';
  }
}

/// @nodoc
abstract mixin class $PreviewPhotoPairCopyWith<$Res> {
  factory $PreviewPhotoPairCopyWith(
    PreviewPhotoPair value,
    $Res Function(PreviewPhotoPair) _then,
  ) = _$PreviewPhotoPairCopyWithImpl;
  @useResult
  $Res call({PreviewPhoto from, int fromIndex, PreviewPhoto to, int toIndex});
}

/// @nodoc
class _$PreviewPhotoPairCopyWithImpl<$Res>
    implements $PreviewPhotoPairCopyWith<$Res> {
  _$PreviewPhotoPairCopyWithImpl(this._self, this._then);

  final PreviewPhotoPair _self;
  final $Res Function(PreviewPhotoPair) _then;

  /// Create a copy of PreviewPhotoPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? fromIndex = null,
    Object? to = null,
    Object? toIndex = null,
  }) {
    return _then(
      PreviewPhotoPair(
        from: null == from
            ? _self.from
            : from // ignore: cast_nullable_to_non_nullable
                  as PreviewPhoto,
        fromIndex: null == fromIndex
            ? _self.fromIndex
            : fromIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        to: null == to
            ? _self.to
            : to // ignore: cast_nullable_to_non_nullable
                  as PreviewPhoto,
        toIndex: null == toIndex
            ? _self.toIndex
            : toIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [PreviewPhotoPair].
extension PreviewPhotoPairPatterns on PreviewPhotoPair {
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
    TResult Function(_PreviewPhotoPair value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PreviewPhotoPair() when $default != null:
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
    TResult Function(_PreviewPhotoPair value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PreviewPhotoPair():
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
    TResult? Function(_PreviewPhotoPair value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PreviewPhotoPair() when $default != null:
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
      PreviewPhoto from,
      int fromIndex,
      PreviewPhoto to,
      int toIndex,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PreviewPhotoPair() when $default != null:
        return $default(_that.from, _that.fromIndex, _that.to, _that.toIndex);
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
      PreviewPhoto from,
      int fromIndex,
      PreviewPhoto to,
      int toIndex,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PreviewPhotoPair():
        return $default(_that.from, _that.fromIndex, _that.to, _that.toIndex);
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
      PreviewPhoto from,
      int fromIndex,
      PreviewPhoto to,
      int toIndex,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PreviewPhotoPair() when $default != null:
        return $default(_that.from, _that.fromIndex, _that.to, _that.toIndex);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PreviewPhotoPair implements PreviewPhotoPair {
  const _PreviewPhotoPair({
    required this.from,
    required this.fromIndex,
    required this.to,
    required this.toIndex,
  });

  @override
  final PreviewPhoto from;
  @override
  final int fromIndex;
  @override
  final PreviewPhoto to;
  @override
  final int toIndex;

  /// Create a copy of PreviewPhotoPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PreviewPhotoPairCopyWith<_PreviewPhotoPair> get copyWith =>
      __$PreviewPhotoPairCopyWithImpl<_PreviewPhotoPair>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PreviewPhotoPair &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.fromIndex, fromIndex) ||
                other.fromIndex == fromIndex) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.toIndex, toIndex) || other.toIndex == toIndex));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, from, fromIndex, to, toIndex);
  }

  @override
  String toString() {
    return 'PreviewPhotoPair(from: $from, fromIndex: $fromIndex, to: $to, toIndex: $toIndex)';
  }
}

/// @nodoc
abstract mixin class _$PreviewPhotoPairCopyWith<$Res>
    implements $PreviewPhotoPairCopyWith<$Res> {
  factory _$PreviewPhotoPairCopyWith(
    _PreviewPhotoPair value,
    $Res Function(_PreviewPhotoPair) _then,
  ) = __$PreviewPhotoPairCopyWithImpl;
  @override
  @useResult
  $Res call({PreviewPhoto from, int fromIndex, PreviewPhoto to, int toIndex});
}

/// @nodoc
class __$PreviewPhotoPairCopyWithImpl<$Res>
    implements _$PreviewPhotoPairCopyWith<$Res> {
  __$PreviewPhotoPairCopyWithImpl(this._self, this._then);

  final _PreviewPhotoPair _self;
  final $Res Function(_PreviewPhotoPair) _then;

  /// Create a copy of PreviewPhotoPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? from = null,
    Object? fromIndex = null,
    Object? to = null,
    Object? toIndex = null,
  }) {
    return _then(
      _PreviewPhotoPair(
        from: null == from
            ? _self.from
            : from // ignore: cast_nullable_to_non_nullable
                  as PreviewPhoto,
        fromIndex: null == fromIndex
            ? _self.fromIndex
            : fromIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        to: null == to
            ? _self.to
            : to // ignore: cast_nullable_to_non_nullable
                  as PreviewPhoto,
        toIndex: null == toIndex
            ? _self.toIndex
            : toIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
