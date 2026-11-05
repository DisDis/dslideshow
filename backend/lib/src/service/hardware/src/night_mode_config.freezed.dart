// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'night_mode_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AmbientLightConfig {
  bool get enabled;
  String get topic;
  String get valueField;
  String get availabilityTopic;
  int get darkBelowLux;
  int get lightAboveLux;
  int get maxAgeSec;

  /// Create a copy of AmbientLightConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AmbientLightConfigCopyWith<AmbientLightConfig> get copyWith =>
      _$AmbientLightConfigCopyWithImpl<AmbientLightConfig>(
        this as AmbientLightConfig,
        _$identity,
      );

  /// Serializes this AmbientLightConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as AmbientLightConfig;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AmbientLightConfig &&
            (identical(other.enabled, _this.enabled) ||
                other.enabled == _this.enabled) &&
            (identical(other.topic, _this.topic) ||
                other.topic == _this.topic) &&
            (identical(other.valueField, _this.valueField) ||
                other.valueField == _this.valueField) &&
            (identical(other.availabilityTopic, _this.availabilityTopic) ||
                other.availabilityTopic == _this.availabilityTopic) &&
            (identical(other.darkBelowLux, _this.darkBelowLux) ||
                other.darkBelowLux == _this.darkBelowLux) &&
            (identical(other.lightAboveLux, _this.lightAboveLux) ||
                other.lightAboveLux == _this.lightAboveLux) &&
            (identical(other.maxAgeSec, _this.maxAgeSec) ||
                other.maxAgeSec == _this.maxAgeSec));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as AmbientLightConfig;
    return Object.hash(
      runtimeType,
      _this.enabled,
      _this.topic,
      _this.valueField,
      _this.availabilityTopic,
      _this.darkBelowLux,
      _this.lightAboveLux,
      _this.maxAgeSec,
    );
  }

  @override
  String toString() {
    final _this = this as AmbientLightConfig;
    return 'AmbientLightConfig(enabled: ${_this.enabled}, topic: ${_this.topic}, valueField: ${_this.valueField}, availabilityTopic: ${_this.availabilityTopic}, darkBelowLux: ${_this.darkBelowLux}, lightAboveLux: ${_this.lightAboveLux}, maxAgeSec: ${_this.maxAgeSec})';
  }
}

/// @nodoc
abstract mixin class $AmbientLightConfigCopyWith<$Res> {
  factory $AmbientLightConfigCopyWith(
    AmbientLightConfig value,
    $Res Function(AmbientLightConfig) _then,
  ) = _$AmbientLightConfigCopyWithImpl;
  @useResult
  $Res call({
    bool enabled,
    String topic,
    String valueField,
    String availabilityTopic,
    int darkBelowLux,
    int lightAboveLux,
    int maxAgeSec,
  });
}

/// @nodoc
class _$AmbientLightConfigCopyWithImpl<$Res>
    implements $AmbientLightConfigCopyWith<$Res> {
  _$AmbientLightConfigCopyWithImpl(this._self, this._then);

  final AmbientLightConfig _self;
  final $Res Function(AmbientLightConfig) _then;

  /// Create a copy of AmbientLightConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? topic = null,
    Object? valueField = null,
    Object? availabilityTopic = null,
    Object? darkBelowLux = null,
    Object? lightAboveLux = null,
    Object? maxAgeSec = null,
  }) {
    return _then(
      AmbientLightConfig(
        enabled: null == enabled
            ? _self.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        topic: null == topic
            ? _self.topic
            : topic // ignore: cast_nullable_to_non_nullable
                  as String,
        valueField: null == valueField
            ? _self.valueField
            : valueField // ignore: cast_nullable_to_non_nullable
                  as String,
        availabilityTopic: null == availabilityTopic
            ? _self.availabilityTopic
            : availabilityTopic // ignore: cast_nullable_to_non_nullable
                  as String,
        darkBelowLux: null == darkBelowLux
            ? _self.darkBelowLux
            : darkBelowLux // ignore: cast_nullable_to_non_nullable
                  as int,
        lightAboveLux: null == lightAboveLux
            ? _self.lightAboveLux
            : lightAboveLux // ignore: cast_nullable_to_non_nullable
                  as int,
        maxAgeSec: null == maxAgeSec
            ? _self.maxAgeSec
            : maxAgeSec // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [AmbientLightConfig].
extension AmbientLightConfigPatterns on AmbientLightConfig {
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
    TResult Function(_AmbientLightConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AmbientLightConfig() when $default != null:
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
    TResult Function(_AmbientLightConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AmbientLightConfig():
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
    TResult? Function(_AmbientLightConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AmbientLightConfig() when $default != null:
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
      bool enabled,
      String topic,
      String valueField,
      String availabilityTopic,
      int darkBelowLux,
      int lightAboveLux,
      int maxAgeSec,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AmbientLightConfig() when $default != null:
        return $default(
          _that.enabled,
          _that.topic,
          _that.valueField,
          _that.availabilityTopic,
          _that.darkBelowLux,
          _that.lightAboveLux,
          _that.maxAgeSec,
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
      bool enabled,
      String topic,
      String valueField,
      String availabilityTopic,
      int darkBelowLux,
      int lightAboveLux,
      int maxAgeSec,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AmbientLightConfig():
        return $default(
          _that.enabled,
          _that.topic,
          _that.valueField,
          _that.availabilityTopic,
          _that.darkBelowLux,
          _that.lightAboveLux,
          _that.maxAgeSec,
        );
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
      bool enabled,
      String topic,
      String valueField,
      String availabilityTopic,
      int darkBelowLux,
      int lightAboveLux,
      int maxAgeSec,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AmbientLightConfig() when $default != null:
        return $default(
          _that.enabled,
          _that.topic,
          _that.valueField,
          _that.availabilityTopic,
          _that.darkBelowLux,
          _that.lightAboveLux,
          _that.maxAgeSec,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable()
class _AmbientLightConfig implements AmbientLightConfig {
  const _AmbientLightConfig({
    this.enabled = false,
    this.topic = '',
    this.valueField = 'illuminance',
    this.availabilityTopic = '',
    this.darkBelowLux = 5,
    this.lightAboveLux = 10,
    this.maxAgeSec = 1800,
  });
  factory _AmbientLightConfig.fromJson(Map<String, dynamic> json) =>
      _$AmbientLightConfigFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final String topic;
  @override
  @JsonKey()
  final String valueField;
  @override
  @JsonKey()
  final String availabilityTopic;
  @override
  @JsonKey()
  final int darkBelowLux;
  @override
  @JsonKey()
  final int lightAboveLux;
  @override
  @JsonKey()
  final int maxAgeSec;

  /// Create a copy of AmbientLightConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AmbientLightConfigCopyWith<_AmbientLightConfig> get copyWith =>
      __$AmbientLightConfigCopyWithImpl<_AmbientLightConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AmbientLightConfigToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AmbientLightConfig &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.valueField, valueField) ||
                other.valueField == valueField) &&
            (identical(other.availabilityTopic, availabilityTopic) ||
                other.availabilityTopic == availabilityTopic) &&
            (identical(other.darkBelowLux, darkBelowLux) ||
                other.darkBelowLux == darkBelowLux) &&
            (identical(other.lightAboveLux, lightAboveLux) ||
                other.lightAboveLux == lightAboveLux) &&
            (identical(other.maxAgeSec, maxAgeSec) ||
                other.maxAgeSec == maxAgeSec));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      enabled,
      topic,
      valueField,
      availabilityTopic,
      darkBelowLux,
      lightAboveLux,
      maxAgeSec,
    );
  }

  @override
  String toString() {
    return 'AmbientLightConfig(enabled: $enabled, topic: $topic, valueField: $valueField, availabilityTopic: $availabilityTopic, darkBelowLux: $darkBelowLux, lightAboveLux: $lightAboveLux, maxAgeSec: $maxAgeSec)';
  }
}

/// @nodoc
abstract mixin class _$AmbientLightConfigCopyWith<$Res>
    implements $AmbientLightConfigCopyWith<$Res> {
  factory _$AmbientLightConfigCopyWith(
    _AmbientLightConfig value,
    $Res Function(_AmbientLightConfig) _then,
  ) = __$AmbientLightConfigCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool enabled,
    String topic,
    String valueField,
    String availabilityTopic,
    int darkBelowLux,
    int lightAboveLux,
    int maxAgeSec,
  });
}

/// @nodoc
class __$AmbientLightConfigCopyWithImpl<$Res>
    implements _$AmbientLightConfigCopyWith<$Res> {
  __$AmbientLightConfigCopyWithImpl(this._self, this._then);

  final _AmbientLightConfig _self;
  final $Res Function(_AmbientLightConfig) _then;

  /// Create a copy of AmbientLightConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enabled = null,
    Object? topic = null,
    Object? valueField = null,
    Object? availabilityTopic = null,
    Object? darkBelowLux = null,
    Object? lightAboveLux = null,
    Object? maxAgeSec = null,
  }) {
    return _then(
      _AmbientLightConfig(
        enabled: null == enabled
            ? _self.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        topic: null == topic
            ? _self.topic
            : topic // ignore: cast_nullable_to_non_nullable
                  as String,
        valueField: null == valueField
            ? _self.valueField
            : valueField // ignore: cast_nullable_to_non_nullable
                  as String,
        availabilityTopic: null == availabilityTopic
            ? _self.availabilityTopic
            : availabilityTopic // ignore: cast_nullable_to_non_nullable
                  as String,
        darkBelowLux: null == darkBelowLux
            ? _self.darkBelowLux
            : darkBelowLux // ignore: cast_nullable_to_non_nullable
                  as int,
        lightAboveLux: null == lightAboveLux
            ? _self.lightAboveLux
            : lightAboveLux // ignore: cast_nullable_to_non_nullable
                  as int,
        maxAgeSec: null == maxAgeSec
            ? _self.maxAgeSec
            : maxAgeSec // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
mixin _$NightModeConfig {
  bool get enabled;
  NightMode get mode;
  @JsonKey(
    name: 'start',
    fromJson: _startFromJson,
    toJson: NightModeConfig.formatTime,
  )
  int get startMinute;
  @JsonKey(
    name: 'end',
    fromJson: _endFromJson,
    toJson: NightModeConfig.formatTime,
  )
  int get endMinute;
  AmbientLightConfig get ambientLight;

  /// Create a copy of NightModeConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NightModeConfigCopyWith<NightModeConfig> get copyWith =>
      _$NightModeConfigCopyWithImpl<NightModeConfig>(
        this as NightModeConfig,
        _$identity,
      );

  /// Serializes this NightModeConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as NightModeConfig;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NightModeConfig &&
            (identical(other.enabled, _this.enabled) ||
                other.enabled == _this.enabled) &&
            (identical(other.mode, _this.mode) || other.mode == _this.mode) &&
            (identical(other.startMinute, _this.startMinute) ||
                other.startMinute == _this.startMinute) &&
            (identical(other.endMinute, _this.endMinute) ||
                other.endMinute == _this.endMinute) &&
            (identical(other.ambientLight, _this.ambientLight) ||
                other.ambientLight == _this.ambientLight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as NightModeConfig;
    return Object.hash(
      runtimeType,
      _this.enabled,
      _this.mode,
      _this.startMinute,
      _this.endMinute,
      _this.ambientLight,
    );
  }

  @override
  String toString() {
    final _this = this as NightModeConfig;
    return 'NightModeConfig(enabled: ${_this.enabled}, mode: ${_this.mode}, startMinute: ${_this.startMinute}, endMinute: ${_this.endMinute}, ambientLight: ${_this.ambientLight})';
  }
}

/// @nodoc
abstract mixin class $NightModeConfigCopyWith<$Res> {
  factory $NightModeConfigCopyWith(
    NightModeConfig value,
    $Res Function(NightModeConfig) _then,
  ) = _$NightModeConfigCopyWithImpl;
  @useResult
  $Res call({
    bool enabled,
    NightMode mode,
    @JsonKey(
      name: 'start',
      fromJson: _startFromJson,
      toJson: NightModeConfig.formatTime,
    )
    int startMinute,
    @JsonKey(
      name: 'end',
      fromJson: _endFromJson,
      toJson: NightModeConfig.formatTime,
    )
    int endMinute,
    AmbientLightConfig ambientLight,
  });

  $AmbientLightConfigCopyWith<$Res> get ambientLight;
}

/// @nodoc
class _$NightModeConfigCopyWithImpl<$Res>
    implements $NightModeConfigCopyWith<$Res> {
  _$NightModeConfigCopyWithImpl(this._self, this._then);

  final NightModeConfig _self;
  final $Res Function(NightModeConfig) _then;

  /// Create a copy of NightModeConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? mode = null,
    Object? startMinute = null,
    Object? endMinute = null,
    Object? ambientLight = null,
  }) {
    return _then(
      NightModeConfig(
        enabled: null == enabled
            ? _self.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        mode: null == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as NightMode,
        startMinute: null == startMinute
            ? _self.startMinute
            : startMinute // ignore: cast_nullable_to_non_nullable
                  as int,
        endMinute: null == endMinute
            ? _self.endMinute
            : endMinute // ignore: cast_nullable_to_non_nullable
                  as int,
        ambientLight: null == ambientLight
            ? _self.ambientLight
            : ambientLight // ignore: cast_nullable_to_non_nullable
                  as AmbientLightConfig,
      ),
    );
  }

  /// Create a copy of NightModeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AmbientLightConfigCopyWith<$Res> get ambientLight {
    return $AmbientLightConfigCopyWith<$Res>(_self.ambientLight, (value) {
      return _then(_self.copyWith(ambientLight: value));
    });
  }
}

/// Adds pattern-matching-related methods to [NightModeConfig].
extension NightModeConfigPatterns on NightModeConfig {
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
    TResult Function(_NightModeConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NightModeConfig() when $default != null:
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
    TResult Function(_NightModeConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NightModeConfig():
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
    TResult? Function(_NightModeConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NightModeConfig() when $default != null:
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
      bool enabled,
      NightMode mode,
      @JsonKey(
        name: 'start',
        fromJson: _startFromJson,
        toJson: NightModeConfig.formatTime,
      )
      int startMinute,
      @JsonKey(
        name: 'end',
        fromJson: _endFromJson,
        toJson: NightModeConfig.formatTime,
      )
      int endMinute,
      AmbientLightConfig ambientLight,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NightModeConfig() when $default != null:
        return $default(
          _that.enabled,
          _that.mode,
          _that.startMinute,
          _that.endMinute,
          _that.ambientLight,
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
      bool enabled,
      NightMode mode,
      @JsonKey(
        name: 'start',
        fromJson: _startFromJson,
        toJson: NightModeConfig.formatTime,
      )
      int startMinute,
      @JsonKey(
        name: 'end',
        fromJson: _endFromJson,
        toJson: NightModeConfig.formatTime,
      )
      int endMinute,
      AmbientLightConfig ambientLight,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NightModeConfig():
        return $default(
          _that.enabled,
          _that.mode,
          _that.startMinute,
          _that.endMinute,
          _that.ambientLight,
        );
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
      bool enabled,
      NightMode mode,
      @JsonKey(
        name: 'start',
        fromJson: _startFromJson,
        toJson: NightModeConfig.formatTime,
      )
      int startMinute,
      @JsonKey(
        name: 'end',
        fromJson: _endFromJson,
        toJson: NightModeConfig.formatTime,
      )
      int endMinute,
      AmbientLightConfig ambientLight,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NightModeConfig() when $default != null:
        return $default(
          _that.enabled,
          _that.mode,
          _that.startMinute,
          _that.endMinute,
          _that.ambientLight,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _NightModeConfig extends NightModeConfig {
  const _NightModeConfig({
    this.enabled = false,
    this.mode = NightMode.scheduleOnly,
    @JsonKey(
      name: 'start',
      fromJson: _startFromJson,
      toJson: NightModeConfig.formatTime,
    )
    this.startMinute = 1380,
    @JsonKey(
      name: 'end',
      fromJson: _endFromJson,
      toJson: NightModeConfig.formatTime,
    )
    this.endMinute = 480,
    this.ambientLight = const AmbientLightConfig(),
  }) : super._();
  factory _NightModeConfig.fromJson(Map<String, dynamic> json) =>
      _$NightModeConfigFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final NightMode mode;
  @override
  @JsonKey(
    name: 'start',
    fromJson: _startFromJson,
    toJson: NightModeConfig.formatTime,
  )
  final int startMinute;
  @override
  @JsonKey(
    name: 'end',
    fromJson: _endFromJson,
    toJson: NightModeConfig.formatTime,
  )
  final int endMinute;
  @override
  @JsonKey()
  final AmbientLightConfig ambientLight;

  /// Create a copy of NightModeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NightModeConfigCopyWith<_NightModeConfig> get copyWith =>
      __$NightModeConfigCopyWithImpl<_NightModeConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NightModeConfigToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NightModeConfig &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.startMinute, startMinute) ||
                other.startMinute == startMinute) &&
            (identical(other.endMinute, endMinute) ||
                other.endMinute == endMinute) &&
            (identical(other.ambientLight, ambientLight) ||
                other.ambientLight == ambientLight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      enabled,
      mode,
      startMinute,
      endMinute,
      ambientLight,
    );
  }

  @override
  String toString() {
    return 'NightModeConfig(enabled: $enabled, mode: $mode, startMinute: $startMinute, endMinute: $endMinute, ambientLight: $ambientLight)';
  }
}

/// @nodoc
abstract mixin class _$NightModeConfigCopyWith<$Res>
    implements $NightModeConfigCopyWith<$Res> {
  factory _$NightModeConfigCopyWith(
    _NightModeConfig value,
    $Res Function(_NightModeConfig) _then,
  ) = __$NightModeConfigCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool enabled,
    NightMode mode,
    @JsonKey(
      name: 'start',
      fromJson: _startFromJson,
      toJson: NightModeConfig.formatTime,
    )
    int startMinute,
    @JsonKey(
      name: 'end',
      fromJson: _endFromJson,
      toJson: NightModeConfig.formatTime,
    )
    int endMinute,
    AmbientLightConfig ambientLight,
  });

  @override
  $AmbientLightConfigCopyWith<$Res> get ambientLight;
}

/// @nodoc
class __$NightModeConfigCopyWithImpl<$Res>
    implements _$NightModeConfigCopyWith<$Res> {
  __$NightModeConfigCopyWithImpl(this._self, this._then);

  final _NightModeConfig _self;
  final $Res Function(_NightModeConfig) _then;

  /// Create a copy of NightModeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enabled = null,
    Object? mode = null,
    Object? startMinute = null,
    Object? endMinute = null,
    Object? ambientLight = null,
  }) {
    return _then(
      _NightModeConfig(
        enabled: null == enabled
            ? _self.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        mode: null == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as NightMode,
        startMinute: null == startMinute
            ? _self.startMinute
            : startMinute // ignore: cast_nullable_to_non_nullable
                  as int,
        endMinute: null == endMinute
            ? _self.endMinute
            : endMinute // ignore: cast_nullable_to_non_nullable
                  as int,
        ambientLight: null == ambientLight
            ? _self.ambientLight
            : ambientLight // ignore: cast_nullable_to_non_nullable
                  as AmbientLightConfig,
      ),
    );
  }

  /// Create a copy of NightModeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AmbientLightConfigCopyWith<$Res> get ambientLight {
    return $AmbientLightConfigCopyWith<$Res>(_self.ambientLight, (value) {
      return _then(_self.copyWith(ambientLight: value));
    });
  }
}
