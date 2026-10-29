// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_viewer_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryViewerEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryViewerEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryViewerEvent()';
  }
}

/// @nodoc
class $GalleryViewerEventCopyWith<$Res> {
  $GalleryViewerEventCopyWith(
    GalleryViewerEvent _,
    $Res Function(GalleryViewerEvent) __,
  );
}

/// Adds pattern-matching-related methods to [GalleryViewerEvent].
extension GalleryViewerEventPatterns on GalleryViewerEvent {
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
    TResult Function(ViewerConfigured value)? configured,
    TResult Function(ViewerItemChanged value)? itemChanged,
    TResult Function(ViewerInfoToggled value)? infoToggled,
    TResult Function(ViewerMetadataRequested value)? metadataRequested,
    TResult Function(ViewerMetadataCompleted value)? metadataCompleted,
    TResult Function(ViewerRotationRequested value)? rotationRequested,
    TResult Function(ViewerRotationCompleted value)? rotationCompleted,
    TResult Function(ViewerMutationRequested value)? mutationRequested,
    TResult Function(ViewerMutationDecision value)? mutationDecision,
    TResult Function(ViewerMutationCompleted value)? mutationCompleted,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfigured() when configured != null:
        return configured(_that);
      case ViewerItemChanged() when itemChanged != null:
        return itemChanged(_that);
      case ViewerInfoToggled() when infoToggled != null:
        return infoToggled(_that);
      case ViewerMetadataRequested() when metadataRequested != null:
        return metadataRequested(_that);
      case ViewerMetadataCompleted() when metadataCompleted != null:
        return metadataCompleted(_that);
      case ViewerRotationRequested() when rotationRequested != null:
        return rotationRequested(_that);
      case ViewerRotationCompleted() when rotationCompleted != null:
        return rotationCompleted(_that);
      case ViewerMutationRequested() when mutationRequested != null:
        return mutationRequested(_that);
      case ViewerMutationDecision() when mutationDecision != null:
        return mutationDecision(_that);
      case ViewerMutationCompleted() when mutationCompleted != null:
        return mutationCompleted(_that);
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
    required TResult Function(ViewerConfigured value) configured,
    required TResult Function(ViewerItemChanged value) itemChanged,
    required TResult Function(ViewerInfoToggled value) infoToggled,
    required TResult Function(ViewerMetadataRequested value) metadataRequested,
    required TResult Function(ViewerMetadataCompleted value) metadataCompleted,
    required TResult Function(ViewerRotationRequested value) rotationRequested,
    required TResult Function(ViewerRotationCompleted value) rotationCompleted,
    required TResult Function(ViewerMutationRequested value) mutationRequested,
    required TResult Function(ViewerMutationDecision value) mutationDecision,
    required TResult Function(ViewerMutationCompleted value) mutationCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfigured():
        return configured(_that);
      case ViewerItemChanged():
        return itemChanged(_that);
      case ViewerInfoToggled():
        return infoToggled(_that);
      case ViewerMetadataRequested():
        return metadataRequested(_that);
      case ViewerMetadataCompleted():
        return metadataCompleted(_that);
      case ViewerRotationRequested():
        return rotationRequested(_that);
      case ViewerRotationCompleted():
        return rotationCompleted(_that);
      case ViewerMutationRequested():
        return mutationRequested(_that);
      case ViewerMutationDecision():
        return mutationDecision(_that);
      case ViewerMutationCompleted():
        return mutationCompleted(_that);
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
    TResult? Function(ViewerConfigured value)? configured,
    TResult? Function(ViewerItemChanged value)? itemChanged,
    TResult? Function(ViewerInfoToggled value)? infoToggled,
    TResult? Function(ViewerMetadataRequested value)? metadataRequested,
    TResult? Function(ViewerMetadataCompleted value)? metadataCompleted,
    TResult? Function(ViewerRotationRequested value)? rotationRequested,
    TResult? Function(ViewerRotationCompleted value)? rotationCompleted,
    TResult? Function(ViewerMutationRequested value)? mutationRequested,
    TResult? Function(ViewerMutationDecision value)? mutationDecision,
    TResult? Function(ViewerMutationCompleted value)? mutationCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfigured() when configured != null:
        return configured(_that);
      case ViewerItemChanged() when itemChanged != null:
        return itemChanged(_that);
      case ViewerInfoToggled() when infoToggled != null:
        return infoToggled(_that);
      case ViewerMetadataRequested() when metadataRequested != null:
        return metadataRequested(_that);
      case ViewerMetadataCompleted() when metadataCompleted != null:
        return metadataCompleted(_that);
      case ViewerRotationRequested() when rotationRequested != null:
        return rotationRequested(_that);
      case ViewerRotationCompleted() when rotationCompleted != null:
        return rotationCompleted(_that);
      case ViewerMutationRequested() when mutationRequested != null:
        return mutationRequested(_that);
      case ViewerMutationDecision() when mutationDecision != null:
        return mutationDecision(_that);
      case ViewerMutationCompleted() when mutationCompleted != null:
        return mutationCompleted(_that);
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
    TResult Function(GalleryViewerConfiguration configuration)? configured,
    TResult Function(GalleryItem? item, int subscriptionGeneration)?
    itemChanged,
    TResult Function()? infoToggled,
    TResult Function()? metadataRequested,
    TResult Function(
      int generation,
      GalleryMetadata? data,
      GalleryErrorCode? error,
    )?
    metadataCompleted,
    TResult Function(GalleryRotation rotation)? rotationRequested,
    TResult Function(
      int generation,
      GalleryMetadata? data,
      GalleryErrorCode? error,
    )?
    rotationCompleted,
    TResult Function(GalleryMutation action)? mutationRequested,
    TResult Function(int confirmationId, bool confirmed)? mutationDecision,
    TResult Function(
      int generation,
      GalleryOperationResult? result,
      GalleryErrorCode? error,
    )?
    mutationCompleted,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfigured() when configured != null:
        return configured(_that.configuration);
      case ViewerItemChanged() when itemChanged != null:
        return itemChanged(_that.item, _that.subscriptionGeneration);
      case ViewerInfoToggled() when infoToggled != null:
        return infoToggled();
      case ViewerMetadataRequested() when metadataRequested != null:
        return metadataRequested();
      case ViewerMetadataCompleted() when metadataCompleted != null:
        return metadataCompleted(_that.generation, _that.data, _that.error);
      case ViewerRotationRequested() when rotationRequested != null:
        return rotationRequested(_that.rotation);
      case ViewerRotationCompleted() when rotationCompleted != null:
        return rotationCompleted(_that.generation, _that.data, _that.error);
      case ViewerMutationRequested() when mutationRequested != null:
        return mutationRequested(_that.action);
      case ViewerMutationDecision() when mutationDecision != null:
        return mutationDecision(_that.confirmationId, _that.confirmed);
      case ViewerMutationCompleted() when mutationCompleted != null:
        return mutationCompleted(_that.generation, _that.result, _that.error);
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
    required TResult Function(GalleryViewerConfiguration configuration)
    configured,
    required TResult Function(GalleryItem? item, int subscriptionGeneration)
    itemChanged,
    required TResult Function() infoToggled,
    required TResult Function() metadataRequested,
    required TResult Function(
      int generation,
      GalleryMetadata? data,
      GalleryErrorCode? error,
    )
    metadataCompleted,
    required TResult Function(GalleryRotation rotation) rotationRequested,
    required TResult Function(
      int generation,
      GalleryMetadata? data,
      GalleryErrorCode? error,
    )
    rotationCompleted,
    required TResult Function(GalleryMutation action) mutationRequested,
    required TResult Function(int confirmationId, bool confirmed)
    mutationDecision,
    required TResult Function(
      int generation,
      GalleryOperationResult? result,
      GalleryErrorCode? error,
    )
    mutationCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfigured():
        return configured(_that.configuration);
      case ViewerItemChanged():
        return itemChanged(_that.item, _that.subscriptionGeneration);
      case ViewerInfoToggled():
        return infoToggled();
      case ViewerMetadataRequested():
        return metadataRequested();
      case ViewerMetadataCompleted():
        return metadataCompleted(_that.generation, _that.data, _that.error);
      case ViewerRotationRequested():
        return rotationRequested(_that.rotation);
      case ViewerRotationCompleted():
        return rotationCompleted(_that.generation, _that.data, _that.error);
      case ViewerMutationRequested():
        return mutationRequested(_that.action);
      case ViewerMutationDecision():
        return mutationDecision(_that.confirmationId, _that.confirmed);
      case ViewerMutationCompleted():
        return mutationCompleted(_that.generation, _that.result, _that.error);
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
    TResult? Function(GalleryViewerConfiguration configuration)? configured,
    TResult? Function(GalleryItem? item, int subscriptionGeneration)?
    itemChanged,
    TResult? Function()? infoToggled,
    TResult? Function()? metadataRequested,
    TResult? Function(
      int generation,
      GalleryMetadata? data,
      GalleryErrorCode? error,
    )?
    metadataCompleted,
    TResult? Function(GalleryRotation rotation)? rotationRequested,
    TResult? Function(
      int generation,
      GalleryMetadata? data,
      GalleryErrorCode? error,
    )?
    rotationCompleted,
    TResult? Function(GalleryMutation action)? mutationRequested,
    TResult? Function(int confirmationId, bool confirmed)? mutationDecision,
    TResult? Function(
      int generation,
      GalleryOperationResult? result,
      GalleryErrorCode? error,
    )?
    mutationCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfigured() when configured != null:
        return configured(_that.configuration);
      case ViewerItemChanged() when itemChanged != null:
        return itemChanged(_that.item, _that.subscriptionGeneration);
      case ViewerInfoToggled() when infoToggled != null:
        return infoToggled();
      case ViewerMetadataRequested() when metadataRequested != null:
        return metadataRequested();
      case ViewerMetadataCompleted() when metadataCompleted != null:
        return metadataCompleted(_that.generation, _that.data, _that.error);
      case ViewerRotationRequested() when rotationRequested != null:
        return rotationRequested(_that.rotation);
      case ViewerRotationCompleted() when rotationCompleted != null:
        return rotationCompleted(_that.generation, _that.data, _that.error);
      case ViewerMutationRequested() when mutationRequested != null:
        return mutationRequested(_that.action);
      case ViewerMutationDecision() when mutationDecision != null:
        return mutationDecision(_that.confirmationId, _that.confirmed);
      case ViewerMutationCompleted() when mutationCompleted != null:
        return mutationCompleted(_that.generation, _that.result, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ViewerConfigured implements GalleryViewerEvent {
  const ViewerConfigured(this.configuration);

  final GalleryViewerConfiguration configuration;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerConfiguredCopyWith<ViewerConfigured> get copyWith =>
      _$ViewerConfiguredCopyWithImpl<ViewerConfigured>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerConfigured &&
            (identical(other.configuration, configuration) ||
                other.configuration == configuration));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, configuration);
  }

  @override
  String toString() {
    return 'GalleryViewerEvent.configured(configuration: $configuration)';
  }
}

/// @nodoc
abstract mixin class $ViewerConfiguredCopyWith<$Res>
    implements $GalleryViewerEventCopyWith<$Res> {
  factory $ViewerConfiguredCopyWith(
    ViewerConfigured value,
    $Res Function(ViewerConfigured) _then,
  ) = _$ViewerConfiguredCopyWithImpl;
  @useResult
  $Res call({GalleryViewerConfiguration configuration});

  $GalleryViewerConfigurationCopyWith<$Res> get configuration;
}

/// @nodoc
class _$ViewerConfiguredCopyWithImpl<$Res>
    implements $ViewerConfiguredCopyWith<$Res> {
  _$ViewerConfiguredCopyWithImpl(this._self, this._then);

  final ViewerConfigured _self;
  final $Res Function(ViewerConfigured) _then;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? configuration = null}) {
    return _then(
      ViewerConfigured(
        null == configuration
            ? _self.configuration
            : configuration // ignore: cast_nullable_to_non_nullable
                  as GalleryViewerConfiguration,
      ),
    );
  }

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryViewerConfigurationCopyWith<$Res> get configuration {
    return $GalleryViewerConfigurationCopyWith<$Res>(_self.configuration, (
      value,
    ) {
      return _then(_self.copyWith(configuration: value));
    });
  }
}

/// @nodoc

class ViewerItemChanged implements GalleryViewerEvent {
  const ViewerItemChanged(this.item, this.subscriptionGeneration);

  final GalleryItem? item;
  final int subscriptionGeneration;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerItemChangedCopyWith<ViewerItemChanged> get copyWith =>
      _$ViewerItemChangedCopyWithImpl<ViewerItemChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerItemChanged &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.subscriptionGeneration, subscriptionGeneration) ||
                other.subscriptionGeneration == subscriptionGeneration));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, item, subscriptionGeneration);
  }

  @override
  String toString() {
    return 'GalleryViewerEvent.itemChanged(item: $item, subscriptionGeneration: $subscriptionGeneration)';
  }
}

/// @nodoc
abstract mixin class $ViewerItemChangedCopyWith<$Res>
    implements $GalleryViewerEventCopyWith<$Res> {
  factory $ViewerItemChangedCopyWith(
    ViewerItemChanged value,
    $Res Function(ViewerItemChanged) _then,
  ) = _$ViewerItemChangedCopyWithImpl;
  @useResult
  $Res call({GalleryItem? item, int subscriptionGeneration});
}

/// @nodoc
class _$ViewerItemChangedCopyWithImpl<$Res>
    implements $ViewerItemChangedCopyWith<$Res> {
  _$ViewerItemChangedCopyWithImpl(this._self, this._then);

  final ViewerItemChanged _self;
  final $Res Function(ViewerItemChanged) _then;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? item = freezed, Object? subscriptionGeneration = null}) {
    return _then(
      ViewerItemChanged(
        freezed == item
            ? _self.item
            : item // ignore: cast_nullable_to_non_nullable
                  as GalleryItem?,
        null == subscriptionGeneration
            ? _self.subscriptionGeneration
            : subscriptionGeneration // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class ViewerInfoToggled implements GalleryViewerEvent {
  const ViewerInfoToggled();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ViewerInfoToggled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryViewerEvent.infoToggled()';
  }
}

/// @nodoc

class ViewerMetadataRequested implements GalleryViewerEvent {
  const ViewerMetadataRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ViewerMetadataRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryViewerEvent.metadataRequested()';
  }
}

/// @nodoc

class ViewerMetadataCompleted implements GalleryViewerEvent {
  const ViewerMetadataCompleted({
    required this.generation,
    this.data,
    this.error,
  });

  final int generation;
  final GalleryMetadata? data;
  final GalleryErrorCode? error;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerMetadataCompletedCopyWith<ViewerMetadataCompleted> get copyWith =>
      _$ViewerMetadataCompletedCopyWithImpl<ViewerMetadataCompleted>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerMetadataCompleted &&
            (identical(other.generation, generation) ||
                other.generation == generation) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, generation, data, error);
  }

  @override
  String toString() {
    return 'GalleryViewerEvent.metadataCompleted(generation: $generation, data: $data, error: $error)';
  }
}

/// @nodoc
abstract mixin class $ViewerMetadataCompletedCopyWith<$Res>
    implements $GalleryViewerEventCopyWith<$Res> {
  factory $ViewerMetadataCompletedCopyWith(
    ViewerMetadataCompleted value,
    $Res Function(ViewerMetadataCompleted) _then,
  ) = _$ViewerMetadataCompletedCopyWithImpl;
  @useResult
  $Res call({int generation, GalleryMetadata? data, GalleryErrorCode? error});

  $GalleryMetadataCopyWith<$Res>? get data;
}

/// @nodoc
class _$ViewerMetadataCompletedCopyWithImpl<$Res>
    implements $ViewerMetadataCompletedCopyWith<$Res> {
  _$ViewerMetadataCompletedCopyWithImpl(this._self, this._then);

  final ViewerMetadataCompleted _self;
  final $Res Function(ViewerMetadataCompleted) _then;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? generation = null,
    Object? data = freezed,
    Object? error = freezed,
  }) {
    return _then(
      ViewerMetadataCompleted(
        generation: null == generation
            ? _self.generation
            : generation // ignore: cast_nullable_to_non_nullable
                  as int,
        data: freezed == data
            ? _self.data
            : data // ignore: cast_nullable_to_non_nullable
                  as GalleryMetadata?,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
      ),
    );
  }

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetadataCopyWith<$Res>? get data {
    if (_self.data == null) {
      return null;
    }

    return $GalleryMetadataCopyWith<$Res>(_self.data!, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc

class ViewerRotationRequested implements GalleryViewerEvent {
  const ViewerRotationRequested(this.rotation);

  final GalleryRotation rotation;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerRotationRequestedCopyWith<ViewerRotationRequested> get copyWith =>
      _$ViewerRotationRequestedCopyWithImpl<ViewerRotationRequested>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerRotationRequested &&
            (identical(other.rotation, rotation) ||
                other.rotation == rotation));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, rotation);
  }

  @override
  String toString() {
    return 'GalleryViewerEvent.rotationRequested(rotation: $rotation)';
  }
}

/// @nodoc
abstract mixin class $ViewerRotationRequestedCopyWith<$Res>
    implements $GalleryViewerEventCopyWith<$Res> {
  factory $ViewerRotationRequestedCopyWith(
    ViewerRotationRequested value,
    $Res Function(ViewerRotationRequested) _then,
  ) = _$ViewerRotationRequestedCopyWithImpl;
  @useResult
  $Res call({GalleryRotation rotation});
}

/// @nodoc
class _$ViewerRotationRequestedCopyWithImpl<$Res>
    implements $ViewerRotationRequestedCopyWith<$Res> {
  _$ViewerRotationRequestedCopyWithImpl(this._self, this._then);

  final ViewerRotationRequested _self;
  final $Res Function(ViewerRotationRequested) _then;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? rotation = null}) {
    return _then(
      ViewerRotationRequested(
        null == rotation
            ? _self.rotation
            : rotation // ignore: cast_nullable_to_non_nullable
                  as GalleryRotation,
      ),
    );
  }
}

/// @nodoc

class ViewerRotationCompleted implements GalleryViewerEvent {
  const ViewerRotationCompleted({
    required this.generation,
    this.data,
    this.error,
  });

  final int generation;
  final GalleryMetadata? data;
  final GalleryErrorCode? error;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerRotationCompletedCopyWith<ViewerRotationCompleted> get copyWith =>
      _$ViewerRotationCompletedCopyWithImpl<ViewerRotationCompleted>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerRotationCompleted &&
            (identical(other.generation, generation) ||
                other.generation == generation) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, generation, data, error);
  }

  @override
  String toString() {
    return 'GalleryViewerEvent.rotationCompleted(generation: $generation, data: $data, error: $error)';
  }
}

/// @nodoc
abstract mixin class $ViewerRotationCompletedCopyWith<$Res>
    implements $GalleryViewerEventCopyWith<$Res> {
  factory $ViewerRotationCompletedCopyWith(
    ViewerRotationCompleted value,
    $Res Function(ViewerRotationCompleted) _then,
  ) = _$ViewerRotationCompletedCopyWithImpl;
  @useResult
  $Res call({int generation, GalleryMetadata? data, GalleryErrorCode? error});

  $GalleryMetadataCopyWith<$Res>? get data;
}

/// @nodoc
class _$ViewerRotationCompletedCopyWithImpl<$Res>
    implements $ViewerRotationCompletedCopyWith<$Res> {
  _$ViewerRotationCompletedCopyWithImpl(this._self, this._then);

  final ViewerRotationCompleted _self;
  final $Res Function(ViewerRotationCompleted) _then;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? generation = null,
    Object? data = freezed,
    Object? error = freezed,
  }) {
    return _then(
      ViewerRotationCompleted(
        generation: null == generation
            ? _self.generation
            : generation // ignore: cast_nullable_to_non_nullable
                  as int,
        data: freezed == data
            ? _self.data
            : data // ignore: cast_nullable_to_non_nullable
                  as GalleryMetadata?,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
      ),
    );
  }

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetadataCopyWith<$Res>? get data {
    if (_self.data == null) {
      return null;
    }

    return $GalleryMetadataCopyWith<$Res>(_self.data!, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc

class ViewerMutationRequested implements GalleryViewerEvent {
  const ViewerMutationRequested(this.action);

  final GalleryMutation action;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerMutationRequestedCopyWith<ViewerMutationRequested> get copyWith =>
      _$ViewerMutationRequestedCopyWithImpl<ViewerMutationRequested>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerMutationRequested &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, action);
  }

  @override
  String toString() {
    return 'GalleryViewerEvent.mutationRequested(action: $action)';
  }
}

/// @nodoc
abstract mixin class $ViewerMutationRequestedCopyWith<$Res>
    implements $GalleryViewerEventCopyWith<$Res> {
  factory $ViewerMutationRequestedCopyWith(
    ViewerMutationRequested value,
    $Res Function(ViewerMutationRequested) _then,
  ) = _$ViewerMutationRequestedCopyWithImpl;
  @useResult
  $Res call({GalleryMutation action});
}

/// @nodoc
class _$ViewerMutationRequestedCopyWithImpl<$Res>
    implements $ViewerMutationRequestedCopyWith<$Res> {
  _$ViewerMutationRequestedCopyWithImpl(this._self, this._then);

  final ViewerMutationRequested _self;
  final $Res Function(ViewerMutationRequested) _then;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? action = null}) {
    return _then(
      ViewerMutationRequested(
        null == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as GalleryMutation,
      ),
    );
  }
}

/// @nodoc

class ViewerMutationDecision implements GalleryViewerEvent {
  const ViewerMutationDecision({
    required this.confirmationId,
    required this.confirmed,
  });

  final int confirmationId;
  final bool confirmed;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerMutationDecisionCopyWith<ViewerMutationDecision> get copyWith =>
      _$ViewerMutationDecisionCopyWithImpl<ViewerMutationDecision>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerMutationDecision &&
            (identical(other.confirmationId, confirmationId) ||
                other.confirmationId == confirmationId) &&
            (identical(other.confirmed, confirmed) ||
                other.confirmed == confirmed));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, confirmationId, confirmed);
  }

  @override
  String toString() {
    return 'GalleryViewerEvent.mutationDecision(confirmationId: $confirmationId, confirmed: $confirmed)';
  }
}

/// @nodoc
abstract mixin class $ViewerMutationDecisionCopyWith<$Res>
    implements $GalleryViewerEventCopyWith<$Res> {
  factory $ViewerMutationDecisionCopyWith(
    ViewerMutationDecision value,
    $Res Function(ViewerMutationDecision) _then,
  ) = _$ViewerMutationDecisionCopyWithImpl;
  @useResult
  $Res call({int confirmationId, bool confirmed});
}

/// @nodoc
class _$ViewerMutationDecisionCopyWithImpl<$Res>
    implements $ViewerMutationDecisionCopyWith<$Res> {
  _$ViewerMutationDecisionCopyWithImpl(this._self, this._then);

  final ViewerMutationDecision _self;
  final $Res Function(ViewerMutationDecision) _then;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? confirmationId = null, Object? confirmed = null}) {
    return _then(
      ViewerMutationDecision(
        confirmationId: null == confirmationId
            ? _self.confirmationId
            : confirmationId // ignore: cast_nullable_to_non_nullable
                  as int,
        confirmed: null == confirmed
            ? _self.confirmed
            : confirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class ViewerMutationCompleted implements GalleryViewerEvent {
  const ViewerMutationCompleted({
    required this.generation,
    this.result,
    this.error,
  });

  final int generation;
  final GalleryOperationResult? result;
  final GalleryErrorCode? error;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerMutationCompletedCopyWith<ViewerMutationCompleted> get copyWith =>
      _$ViewerMutationCompletedCopyWithImpl<ViewerMutationCompleted>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerMutationCompleted &&
            (identical(other.generation, generation) ||
                other.generation == generation) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, generation, result, error);
  }

  @override
  String toString() {
    return 'GalleryViewerEvent.mutationCompleted(generation: $generation, result: $result, error: $error)';
  }
}

/// @nodoc
abstract mixin class $ViewerMutationCompletedCopyWith<$Res>
    implements $GalleryViewerEventCopyWith<$Res> {
  factory $ViewerMutationCompletedCopyWith(
    ViewerMutationCompleted value,
    $Res Function(ViewerMutationCompleted) _then,
  ) = _$ViewerMutationCompletedCopyWithImpl;
  @useResult
  $Res call({
    int generation,
    GalleryOperationResult? result,
    GalleryErrorCode? error,
  });

  $GalleryOperationResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$ViewerMutationCompletedCopyWithImpl<$Res>
    implements $ViewerMutationCompletedCopyWith<$Res> {
  _$ViewerMutationCompletedCopyWithImpl(this._self, this._then);

  final ViewerMutationCompleted _self;
  final $Res Function(ViewerMutationCompleted) _then;

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? generation = null,
    Object? result = freezed,
    Object? error = freezed,
  }) {
    return _then(
      ViewerMutationCompleted(
        generation: null == generation
            ? _self.generation
            : generation // ignore: cast_nullable_to_non_nullable
                  as int,
        result: freezed == result
            ? _self.result
            : result // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationResult?,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
      ),
    );
  }

  /// Create a copy of GalleryViewerEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationResultCopyWith<$Res>? get result {
    if (_self.result == null) {
      return null;
    }

    return $GalleryOperationResultCopyWith<$Res>(_self.result!, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

/// @nodoc
mixin _$GalleryViewerConfiguration {
  GalleryItem get item;
  GalleryManagementRepository? get management;
  Set<GalleryCapability> get capabilities;
  GalleryTrashEntry? get trashEntry;
  Stream<GalleryItem?>? get itemUpdates;
  GalleryItem? Function()? get currentItem;

  /// Create a copy of GalleryViewerConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryViewerConfigurationCopyWith<GalleryViewerConfiguration>
  get copyWith =>
      _$GalleryViewerConfigurationCopyWithImpl<GalleryViewerConfiguration>(
        this as GalleryViewerConfiguration,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryViewerConfiguration;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryViewerConfiguration &&
            (identical(other.item, _this.item) || other.item == _this.item) &&
            (identical(other.management, _this.management) ||
                other.management == _this.management) &&
            const DeepCollectionEquality().equals(
              other.capabilities,
              _this.capabilities,
            ) &&
            (identical(other.trashEntry, _this.trashEntry) ||
                other.trashEntry == _this.trashEntry) &&
            (identical(other.itemUpdates, _this.itemUpdates) ||
                other.itemUpdates == _this.itemUpdates) &&
            (identical(other.currentItem, _this.currentItem) ||
                other.currentItem == _this.currentItem));
  }

  @override
  int get hashCode {
    final _this = this as GalleryViewerConfiguration;
    return Object.hash(
      runtimeType,
      _this.item,
      _this.management,
      const DeepCollectionEquality().hash(_this.capabilities),
      _this.trashEntry,
      _this.itemUpdates,
      _this.currentItem,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryViewerConfiguration;
    return 'GalleryViewerConfiguration(item: ${_this.item}, management: ${_this.management}, capabilities: ${_this.capabilities}, trashEntry: ${_this.trashEntry}, itemUpdates: ${_this.itemUpdates}, currentItem: ${_this.currentItem})';
  }
}

/// @nodoc
abstract mixin class $GalleryViewerConfigurationCopyWith<$Res> {
  factory $GalleryViewerConfigurationCopyWith(
    GalleryViewerConfiguration value,
    $Res Function(GalleryViewerConfiguration) _then,
  ) = _$GalleryViewerConfigurationCopyWithImpl;
  @useResult
  $Res call({
    GalleryItem item,
    GalleryManagementRepository? management,
    Set<GalleryCapability> capabilities,
    GalleryTrashEntry? trashEntry,
    Stream<GalleryItem?>? itemUpdates,
    GalleryItem? Function()? currentItem,
  });

  $GalleryTrashEntryCopyWith<$Res>? get trashEntry;
}

/// @nodoc
class _$GalleryViewerConfigurationCopyWithImpl<$Res>
    implements $GalleryViewerConfigurationCopyWith<$Res> {
  _$GalleryViewerConfigurationCopyWithImpl(this._self, this._then);

  final GalleryViewerConfiguration _self;
  final $Res Function(GalleryViewerConfiguration) _then;

  /// Create a copy of GalleryViewerConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? management = freezed,
    Object? capabilities = null,
    Object? trashEntry = freezed,
    Object? itemUpdates = freezed,
    Object? currentItem = freezed,
  }) {
    return _then(
      GalleryViewerConfiguration(
        item: null == item
            ? _self.item
            : item // ignore: cast_nullable_to_non_nullable
                  as GalleryItem,
        management: freezed == management
            ? _self.management
            : management // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementRepository?,
        capabilities: null == capabilities
            ? _self.capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as Set<GalleryCapability>,
        trashEntry: freezed == trashEntry
            ? _self.trashEntry
            : trashEntry // ignore: cast_nullable_to_non_nullable
                  as GalleryTrashEntry?,
        itemUpdates: freezed == itemUpdates
            ? _self.itemUpdates
            : itemUpdates // ignore: cast_nullable_to_non_nullable
                  as Stream<GalleryItem?>?,
        currentItem: freezed == currentItem
            ? _self.currentItem
            : currentItem // ignore: cast_nullable_to_non_nullable
                  as GalleryItem? Function()?,
      ),
    );
  }

  /// Create a copy of GalleryViewerConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryTrashEntryCopyWith<$Res>? get trashEntry {
    if (_self.trashEntry == null) {
      return null;
    }

    return $GalleryTrashEntryCopyWith<$Res>(_self.trashEntry!, (value) {
      return _then(_self.copyWith(trashEntry: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryViewerConfiguration].
extension GalleryViewerConfigurationPatterns on GalleryViewerConfiguration {
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
    TResult Function(_GalleryViewerConfiguration value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerConfiguration() when $default != null:
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
    TResult Function(_GalleryViewerConfiguration value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerConfiguration():
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
    TResult? Function(_GalleryViewerConfiguration value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerConfiguration() when $default != null:
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
      GalleryItem item,
      GalleryManagementRepository? management,
      Set<GalleryCapability> capabilities,
      GalleryTrashEntry? trashEntry,
      Stream<GalleryItem?>? itemUpdates,
      GalleryItem? Function()? currentItem,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerConfiguration() when $default != null:
        return $default(
          _that.item,
          _that.management,
          _that.capabilities,
          _that.trashEntry,
          _that.itemUpdates,
          _that.currentItem,
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
      GalleryItem item,
      GalleryManagementRepository? management,
      Set<GalleryCapability> capabilities,
      GalleryTrashEntry? trashEntry,
      Stream<GalleryItem?>? itemUpdates,
      GalleryItem? Function()? currentItem,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerConfiguration():
        return $default(
          _that.item,
          _that.management,
          _that.capabilities,
          _that.trashEntry,
          _that.itemUpdates,
          _that.currentItem,
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
      GalleryItem item,
      GalleryManagementRepository? management,
      Set<GalleryCapability> capabilities,
      GalleryTrashEntry? trashEntry,
      Stream<GalleryItem?>? itemUpdates,
      GalleryItem? Function()? currentItem,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerConfiguration() when $default != null:
        return $default(
          _that.item,
          _that.management,
          _that.capabilities,
          _that.trashEntry,
          _that.itemUpdates,
          _that.currentItem,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryViewerConfiguration implements GalleryViewerConfiguration {
  const _GalleryViewerConfiguration({
    required this.item,
    this.management,
    Set<GalleryCapability> capabilities = const {},
    this.trashEntry,
    this.itemUpdates,
    this.currentItem,
  }) : _capabilities = capabilities;

  @override
  final GalleryItem item;
  @override
  final GalleryManagementRepository? management;
  final Set<GalleryCapability> _capabilities;
  @override
  @JsonKey()
  Set<GalleryCapability> get capabilities {
    if (_capabilities is EqualUnmodifiableSetView) return _capabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_capabilities);
  }

  @override
  final GalleryTrashEntry? trashEntry;
  @override
  final Stream<GalleryItem?>? itemUpdates;
  @override
  final GalleryItem? Function()? currentItem;

  /// Create a copy of GalleryViewerConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryViewerConfigurationCopyWith<_GalleryViewerConfiguration>
  get copyWith =>
      __$GalleryViewerConfigurationCopyWithImpl<_GalleryViewerConfiguration>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryViewerConfiguration &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.management, management) ||
                other.management == management) &&
            const DeepCollectionEquality().equals(
              other.capabilities,
              _capabilities,
            ) &&
            (identical(other.trashEntry, trashEntry) ||
                other.trashEntry == trashEntry) &&
            (identical(other.itemUpdates, itemUpdates) ||
                other.itemUpdates == itemUpdates) &&
            (identical(other.currentItem, currentItem) ||
                other.currentItem == currentItem));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      item,
      management,
      const DeepCollectionEquality().hash(_capabilities),
      trashEntry,
      itemUpdates,
      currentItem,
    );
  }

  @override
  String toString() {
    return 'GalleryViewerConfiguration(item: $item, management: $management, capabilities: $capabilities, trashEntry: $trashEntry, itemUpdates: $itemUpdates, currentItem: $currentItem)';
  }
}

/// @nodoc
abstract mixin class _$GalleryViewerConfigurationCopyWith<$Res>
    implements $GalleryViewerConfigurationCopyWith<$Res> {
  factory _$GalleryViewerConfigurationCopyWith(
    _GalleryViewerConfiguration value,
    $Res Function(_GalleryViewerConfiguration) _then,
  ) = __$GalleryViewerConfigurationCopyWithImpl;
  @override
  @useResult
  $Res call({
    GalleryItem item,
    GalleryManagementRepository? management,
    Set<GalleryCapability> capabilities,
    GalleryTrashEntry? trashEntry,
    Stream<GalleryItem?>? itemUpdates,
    GalleryItem? Function()? currentItem,
  });

  @override
  $GalleryTrashEntryCopyWith<$Res>? get trashEntry;
}

/// @nodoc
class __$GalleryViewerConfigurationCopyWithImpl<$Res>
    implements _$GalleryViewerConfigurationCopyWith<$Res> {
  __$GalleryViewerConfigurationCopyWithImpl(this._self, this._then);

  final _GalleryViewerConfiguration _self;
  final $Res Function(_GalleryViewerConfiguration) _then;

  /// Create a copy of GalleryViewerConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? item = null,
    Object? management = freezed,
    Object? capabilities = null,
    Object? trashEntry = freezed,
    Object? itemUpdates = freezed,
    Object? currentItem = freezed,
  }) {
    return _then(
      _GalleryViewerConfiguration(
        item: null == item
            ? _self.item
            : item // ignore: cast_nullable_to_non_nullable
                  as GalleryItem,
        management: freezed == management
            ? _self.management
            : management // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementRepository?,
        capabilities: null == capabilities
            ? _self._capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as Set<GalleryCapability>,
        trashEntry: freezed == trashEntry
            ? _self.trashEntry
            : trashEntry // ignore: cast_nullable_to_non_nullable
                  as GalleryTrashEntry?,
        itemUpdates: freezed == itemUpdates
            ? _self.itemUpdates
            : itemUpdates // ignore: cast_nullable_to_non_nullable
                  as Stream<GalleryItem?>?,
        currentItem: freezed == currentItem
            ? _self.currentItem
            : currentItem // ignore: cast_nullable_to_non_nullable
                  as GalleryItem? Function()?,
      ),
    );
  }

  /// Create a copy of GalleryViewerConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryTrashEntryCopyWith<$Res>? get trashEntry {
    if (_self.trashEntry == null) {
      return null;
    }

    return $GalleryTrashEntryCopyWith<$Res>(_self.trashEntry!, (value) {
      return _then(_self.copyWith(trashEntry: value));
    });
  }
}

/// @nodoc
mixin _$GalleryViewerEffect {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryViewerEffect);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryViewerEffect()';
  }
}

/// @nodoc
class $GalleryViewerEffectCopyWith<$Res> {
  $GalleryViewerEffectCopyWith(
    GalleryViewerEffect _,
    $Res Function(GalleryViewerEffect) __,
  );
}

/// Adds pattern-matching-related methods to [GalleryViewerEffect].
extension GalleryViewerEffectPatterns on GalleryViewerEffect {
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
    TResult Function(ViewerConfirmMutation value)? mutationConfirmation,
    TResult Function(ViewerConfirmationChanged value)? confirmationChanged,
    TResult Function(ViewerOperationFailed value)? operationFailed,
    TResult Function(ViewerRotationApplied value)? rotationApplied,
    TResult Function(ViewerMutationApplied value)? mutationApplied,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfirmMutation() when mutationConfirmation != null:
        return mutationConfirmation(_that);
      case ViewerConfirmationChanged() when confirmationChanged != null:
        return confirmationChanged(_that);
      case ViewerOperationFailed() when operationFailed != null:
        return operationFailed(_that);
      case ViewerRotationApplied() when rotationApplied != null:
        return rotationApplied(_that);
      case ViewerMutationApplied() when mutationApplied != null:
        return mutationApplied(_that);
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
    required TResult Function(ViewerConfirmMutation value) mutationConfirmation,
    required TResult Function(ViewerConfirmationChanged value)
    confirmationChanged,
    required TResult Function(ViewerOperationFailed value) operationFailed,
    required TResult Function(ViewerRotationApplied value) rotationApplied,
    required TResult Function(ViewerMutationApplied value) mutationApplied,
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfirmMutation():
        return mutationConfirmation(_that);
      case ViewerConfirmationChanged():
        return confirmationChanged(_that);
      case ViewerOperationFailed():
        return operationFailed(_that);
      case ViewerRotationApplied():
        return rotationApplied(_that);
      case ViewerMutationApplied():
        return mutationApplied(_that);
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
    TResult? Function(ViewerConfirmMutation value)? mutationConfirmation,
    TResult? Function(ViewerConfirmationChanged value)? confirmationChanged,
    TResult? Function(ViewerOperationFailed value)? operationFailed,
    TResult? Function(ViewerRotationApplied value)? rotationApplied,
    TResult? Function(ViewerMutationApplied value)? mutationApplied,
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfirmMutation() when mutationConfirmation != null:
        return mutationConfirmation(_that);
      case ViewerConfirmationChanged() when confirmationChanged != null:
        return confirmationChanged(_that);
      case ViewerOperationFailed() when operationFailed != null:
        return operationFailed(_that);
      case ViewerRotationApplied() when rotationApplied != null:
        return rotationApplied(_that);
      case ViewerMutationApplied() when mutationApplied != null:
        return mutationApplied(_that);
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
    TResult Function(GalleryMutationConfirmation confirmation)?
    mutationConfirmation,
    TResult Function()? confirmationChanged,
    TResult Function(GalleryErrorCode code, bool refreshCatalog)?
    operationFailed,
    TResult Function()? rotationApplied,
    TResult Function(GalleryMutation action, List<String> trashIds)?
    mutationApplied,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfirmMutation() when mutationConfirmation != null:
        return mutationConfirmation(_that.confirmation);
      case ViewerConfirmationChanged() when confirmationChanged != null:
        return confirmationChanged();
      case ViewerOperationFailed() when operationFailed != null:
        return operationFailed(_that.code, _that.refreshCatalog);
      case ViewerRotationApplied() when rotationApplied != null:
        return rotationApplied();
      case ViewerMutationApplied() when mutationApplied != null:
        return mutationApplied(_that.action, _that.trashIds);
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
    required TResult Function(GalleryMutationConfirmation confirmation)
    mutationConfirmation,
    required TResult Function() confirmationChanged,
    required TResult Function(GalleryErrorCode code, bool refreshCatalog)
    operationFailed,
    required TResult Function() rotationApplied,
    required TResult Function(GalleryMutation action, List<String> trashIds)
    mutationApplied,
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfirmMutation():
        return mutationConfirmation(_that.confirmation);
      case ViewerConfirmationChanged():
        return confirmationChanged();
      case ViewerOperationFailed():
        return operationFailed(_that.code, _that.refreshCatalog);
      case ViewerRotationApplied():
        return rotationApplied();
      case ViewerMutationApplied():
        return mutationApplied(_that.action, _that.trashIds);
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
    TResult? Function(GalleryMutationConfirmation confirmation)?
    mutationConfirmation,
    TResult? Function()? confirmationChanged,
    TResult? Function(GalleryErrorCode code, bool refreshCatalog)?
    operationFailed,
    TResult? Function()? rotationApplied,
    TResult? Function(GalleryMutation action, List<String> trashIds)?
    mutationApplied,
  }) {
    final _that = this;
    switch (_that) {
      case ViewerConfirmMutation() when mutationConfirmation != null:
        return mutationConfirmation(_that.confirmation);
      case ViewerConfirmationChanged() when confirmationChanged != null:
        return confirmationChanged();
      case ViewerOperationFailed() when operationFailed != null:
        return operationFailed(_that.code, _that.refreshCatalog);
      case ViewerRotationApplied() when rotationApplied != null:
        return rotationApplied();
      case ViewerMutationApplied() when mutationApplied != null:
        return mutationApplied(_that.action, _that.trashIds);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ViewerConfirmMutation implements GalleryViewerEffect {
  const ViewerConfirmMutation(this.confirmation);

  final GalleryMutationConfirmation confirmation;

  /// Create a copy of GalleryViewerEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerConfirmMutationCopyWith<ViewerConfirmMutation> get copyWith =>
      _$ViewerConfirmMutationCopyWithImpl<ViewerConfirmMutation>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerConfirmMutation &&
            (identical(other.confirmation, confirmation) ||
                other.confirmation == confirmation));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, confirmation);
  }

  @override
  String toString() {
    return 'GalleryViewerEffect.mutationConfirmation(confirmation: $confirmation)';
  }
}

/// @nodoc
abstract mixin class $ViewerConfirmMutationCopyWith<$Res>
    implements $GalleryViewerEffectCopyWith<$Res> {
  factory $ViewerConfirmMutationCopyWith(
    ViewerConfirmMutation value,
    $Res Function(ViewerConfirmMutation) _then,
  ) = _$ViewerConfirmMutationCopyWithImpl;
  @useResult
  $Res call({GalleryMutationConfirmation confirmation});

  $GalleryMutationConfirmationCopyWith<$Res> get confirmation;
}

/// @nodoc
class _$ViewerConfirmMutationCopyWithImpl<$Res>
    implements $ViewerConfirmMutationCopyWith<$Res> {
  _$ViewerConfirmMutationCopyWithImpl(this._self, this._then);

  final ViewerConfirmMutation _self;
  final $Res Function(ViewerConfirmMutation) _then;

  /// Create a copy of GalleryViewerEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? confirmation = null}) {
    return _then(
      ViewerConfirmMutation(
        null == confirmation
            ? _self.confirmation
            : confirmation // ignore: cast_nullable_to_non_nullable
                  as GalleryMutationConfirmation,
      ),
    );
  }

  /// Create a copy of GalleryViewerEffect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMutationConfirmationCopyWith<$Res> get confirmation {
    return $GalleryMutationConfirmationCopyWith<$Res>(_self.confirmation, (
      value,
    ) {
      return _then(_self.copyWith(confirmation: value));
    });
  }
}

/// @nodoc

class ViewerConfirmationChanged implements GalleryViewerEffect {
  const ViewerConfirmationChanged();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerConfirmationChanged);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryViewerEffect.confirmationChanged()';
  }
}

/// @nodoc

class ViewerOperationFailed implements GalleryViewerEffect {
  const ViewerOperationFailed(this.code, {this.refreshCatalog = false});

  final GalleryErrorCode code;
  @JsonKey()
  final bool refreshCatalog;

  /// Create a copy of GalleryViewerEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerOperationFailedCopyWith<ViewerOperationFailed> get copyWith =>
      _$ViewerOperationFailedCopyWithImpl<ViewerOperationFailed>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerOperationFailed &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.refreshCatalog, refreshCatalog) ||
                other.refreshCatalog == refreshCatalog));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, code, refreshCatalog);
  }

  @override
  String toString() {
    return 'GalleryViewerEffect.operationFailed(code: $code, refreshCatalog: $refreshCatalog)';
  }
}

/// @nodoc
abstract mixin class $ViewerOperationFailedCopyWith<$Res>
    implements $GalleryViewerEffectCopyWith<$Res> {
  factory $ViewerOperationFailedCopyWith(
    ViewerOperationFailed value,
    $Res Function(ViewerOperationFailed) _then,
  ) = _$ViewerOperationFailedCopyWithImpl;
  @useResult
  $Res call({GalleryErrorCode code, bool refreshCatalog});
}

/// @nodoc
class _$ViewerOperationFailedCopyWithImpl<$Res>
    implements $ViewerOperationFailedCopyWith<$Res> {
  _$ViewerOperationFailedCopyWithImpl(this._self, this._then);

  final ViewerOperationFailed _self;
  final $Res Function(ViewerOperationFailed) _then;

  /// Create a copy of GalleryViewerEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? code = null, Object? refreshCatalog = null}) {
    return _then(
      ViewerOperationFailed(
        null == code
            ? _self.code
            : code // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode,
        refreshCatalog: null == refreshCatalog
            ? _self.refreshCatalog
            : refreshCatalog // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class ViewerRotationApplied implements GalleryViewerEffect {
  const ViewerRotationApplied();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ViewerRotationApplied);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryViewerEffect.rotationApplied()';
  }
}

/// @nodoc

class ViewerMutationApplied implements GalleryViewerEffect {
  const ViewerMutationApplied({
    required this.action,
    List<String> trashIds = const [],
  }) : _trashIds = trashIds;

  final GalleryMutation action;
  final List<String> _trashIds;
  @JsonKey()
  List<String> get trashIds {
    if (_trashIds is EqualUnmodifiableListView) return _trashIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trashIds);
  }

  /// Create a copy of GalleryViewerEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewerMutationAppliedCopyWith<ViewerMutationApplied> get copyWith =>
      _$ViewerMutationAppliedCopyWithImpl<ViewerMutationApplied>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewerMutationApplied &&
            (identical(other.action, action) || other.action == action) &&
            const DeepCollectionEquality().equals(other.trashIds, _trashIds));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      action,
      const DeepCollectionEquality().hash(_trashIds),
    );
  }

  @override
  String toString() {
    return 'GalleryViewerEffect.mutationApplied(action: $action, trashIds: $trashIds)';
  }
}

/// @nodoc
abstract mixin class $ViewerMutationAppliedCopyWith<$Res>
    implements $GalleryViewerEffectCopyWith<$Res> {
  factory $ViewerMutationAppliedCopyWith(
    ViewerMutationApplied value,
    $Res Function(ViewerMutationApplied) _then,
  ) = _$ViewerMutationAppliedCopyWithImpl;
  @useResult
  $Res call({GalleryMutation action, List<String> trashIds});
}

/// @nodoc
class _$ViewerMutationAppliedCopyWithImpl<$Res>
    implements $ViewerMutationAppliedCopyWith<$Res> {
  _$ViewerMutationAppliedCopyWithImpl(this._self, this._then);

  final ViewerMutationApplied _self;
  final $Res Function(ViewerMutationApplied) _then;

  /// Create a copy of GalleryViewerEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? action = null, Object? trashIds = null}) {
    return _then(
      ViewerMutationApplied(
        action: null == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as GalleryMutation,
        trashIds: null == trashIds
            ? _self._trashIds
            : trashIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryViewerState {
  GalleryItem get item;
  bool get missing;
  bool get showInfo;
  bool get managementAvailable;
  Set<GalleryCapability> get capabilities;
  GalleryTrashEntry? get trashEntry;
  Set<String> get supersededRevisions;
  GalleryViewerMetadataStatus get metadataStatus;
  GalleryMetadata? get metadata;
  GalleryErrorCode? get metadataError;
  GalleryViewerOperation get operation;
  GalleryOperationRequest? get mutationRequest;
  GalleryErrorCode? get operationError;
  GalleryMutationConfirmation? get confirmation;
  int get effectId;
  GalleryViewerEffect? get effect;

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryViewerStateCopyWith<GalleryViewerState> get copyWith =>
      _$GalleryViewerStateCopyWithImpl<GalleryViewerState>(
        this as GalleryViewerState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryViewerState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryViewerState &&
            (identical(other.item, _this.item) || other.item == _this.item) &&
            (identical(other.missing, _this.missing) ||
                other.missing == _this.missing) &&
            (identical(other.showInfo, _this.showInfo) ||
                other.showInfo == _this.showInfo) &&
            (identical(other.managementAvailable, _this.managementAvailable) ||
                other.managementAvailable == _this.managementAvailable) &&
            const DeepCollectionEquality().equals(
              other.capabilities,
              _this.capabilities,
            ) &&
            (identical(other.trashEntry, _this.trashEntry) ||
                other.trashEntry == _this.trashEntry) &&
            const DeepCollectionEquality().equals(
              other.supersededRevisions,
              _this.supersededRevisions,
            ) &&
            (identical(other.metadataStatus, _this.metadataStatus) ||
                other.metadataStatus == _this.metadataStatus) &&
            (identical(other.metadata, _this.metadata) ||
                other.metadata == _this.metadata) &&
            (identical(other.metadataError, _this.metadataError) ||
                other.metadataError == _this.metadataError) &&
            (identical(other.operation, _this.operation) ||
                other.operation == _this.operation) &&
            (identical(other.mutationRequest, _this.mutationRequest) ||
                other.mutationRequest == _this.mutationRequest) &&
            (identical(other.operationError, _this.operationError) ||
                other.operationError == _this.operationError) &&
            (identical(other.confirmation, _this.confirmation) ||
                other.confirmation == _this.confirmation) &&
            (identical(other.effectId, _this.effectId) ||
                other.effectId == _this.effectId) &&
            (identical(other.effect, _this.effect) ||
                other.effect == _this.effect));
  }

  @override
  int get hashCode {
    final _this = this as GalleryViewerState;
    return Object.hash(
      runtimeType,
      _this.item,
      _this.missing,
      _this.showInfo,
      _this.managementAvailable,
      const DeepCollectionEquality().hash(_this.capabilities),
      _this.trashEntry,
      const DeepCollectionEquality().hash(_this.supersededRevisions),
      _this.metadataStatus,
      _this.metadata,
      _this.metadataError,
      _this.operation,
      _this.mutationRequest,
      _this.operationError,
      _this.confirmation,
      _this.effectId,
      _this.effect,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryViewerState;
    return 'GalleryViewerState(item: ${_this.item}, missing: ${_this.missing}, showInfo: ${_this.showInfo}, managementAvailable: ${_this.managementAvailable}, capabilities: ${_this.capabilities}, trashEntry: ${_this.trashEntry}, supersededRevisions: ${_this.supersededRevisions}, metadataStatus: ${_this.metadataStatus}, metadata: ${_this.metadata}, metadataError: ${_this.metadataError}, operation: ${_this.operation}, mutationRequest: ${_this.mutationRequest}, operationError: ${_this.operationError}, confirmation: ${_this.confirmation}, effectId: ${_this.effectId}, effect: ${_this.effect})';
  }
}

/// @nodoc
abstract mixin class $GalleryViewerStateCopyWith<$Res> {
  factory $GalleryViewerStateCopyWith(
    GalleryViewerState value,
    $Res Function(GalleryViewerState) _then,
  ) = _$GalleryViewerStateCopyWithImpl;
  @useResult
  $Res call({
    GalleryItem item,
    bool missing,
    bool showInfo,
    bool managementAvailable,
    Set<GalleryCapability> capabilities,
    GalleryTrashEntry? trashEntry,
    Set<String> supersededRevisions,
    GalleryViewerMetadataStatus metadataStatus,
    GalleryMetadata? metadata,
    GalleryErrorCode? metadataError,
    GalleryViewerOperation operation,
    GalleryOperationRequest? mutationRequest,
    GalleryErrorCode? operationError,
    GalleryMutationConfirmation? confirmation,
    int effectId,
    GalleryViewerEffect? effect,
  });

  $GalleryTrashEntryCopyWith<$Res>? get trashEntry;
  $GalleryMetadataCopyWith<$Res>? get metadata;
  $GalleryOperationRequestCopyWith<$Res>? get mutationRequest;
  $GalleryMutationConfirmationCopyWith<$Res>? get confirmation;
  $GalleryViewerEffectCopyWith<$Res>? get effect;
}

/// @nodoc
class _$GalleryViewerStateCopyWithImpl<$Res>
    implements $GalleryViewerStateCopyWith<$Res> {
  _$GalleryViewerStateCopyWithImpl(this._self, this._then);

  final GalleryViewerState _self;
  final $Res Function(GalleryViewerState) _then;

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? missing = null,
    Object? showInfo = null,
    Object? managementAvailable = null,
    Object? capabilities = null,
    Object? trashEntry = freezed,
    Object? supersededRevisions = null,
    Object? metadataStatus = null,
    Object? metadata = freezed,
    Object? metadataError = freezed,
    Object? operation = null,
    Object? mutationRequest = freezed,
    Object? operationError = freezed,
    Object? confirmation = freezed,
    Object? effectId = null,
    Object? effect = freezed,
  }) {
    return _then(
      GalleryViewerState(
        item: null == item
            ? _self.item
            : item // ignore: cast_nullable_to_non_nullable
                  as GalleryItem,
        missing: null == missing
            ? _self.missing
            : missing // ignore: cast_nullable_to_non_nullable
                  as bool,
        showInfo: null == showInfo
            ? _self.showInfo
            : showInfo // ignore: cast_nullable_to_non_nullable
                  as bool,
        managementAvailable: null == managementAvailable
            ? _self.managementAvailable
            : managementAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        capabilities: null == capabilities
            ? _self.capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as Set<GalleryCapability>,
        trashEntry: freezed == trashEntry
            ? _self.trashEntry
            : trashEntry // ignore: cast_nullable_to_non_nullable
                  as GalleryTrashEntry?,
        supersededRevisions: null == supersededRevisions
            ? _self.supersededRevisions
            : supersededRevisions // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        metadataStatus: null == metadataStatus
            ? _self.metadataStatus
            : metadataStatus // ignore: cast_nullable_to_non_nullable
                  as GalleryViewerMetadataStatus,
        metadata: freezed == metadata
            ? _self.metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as GalleryMetadata?,
        metadataError: freezed == metadataError
            ? _self.metadataError
            : metadataError // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        operation: null == operation
            ? _self.operation
            : operation // ignore: cast_nullable_to_non_nullable
                  as GalleryViewerOperation,
        mutationRequest: freezed == mutationRequest
            ? _self.mutationRequest
            : mutationRequest // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationRequest?,
        operationError: freezed == operationError
            ? _self.operationError
            : operationError // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        confirmation: freezed == confirmation
            ? _self.confirmation
            : confirmation // ignore: cast_nullable_to_non_nullable
                  as GalleryMutationConfirmation?,
        effectId: null == effectId
            ? _self.effectId
            : effectId // ignore: cast_nullable_to_non_nullable
                  as int,
        effect: freezed == effect
            ? _self.effect
            : effect // ignore: cast_nullable_to_non_nullable
                  as GalleryViewerEffect?,
      ),
    );
  }

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryTrashEntryCopyWith<$Res>? get trashEntry {
    if (_self.trashEntry == null) {
      return null;
    }

    return $GalleryTrashEntryCopyWith<$Res>(_self.trashEntry!, (value) {
      return _then(_self.copyWith(trashEntry: value));
    });
  }

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
      return null;
    }

    return $GalleryMetadataCopyWith<$Res>(_self.metadata!, (value) {
      return _then(_self.copyWith(metadata: value));
    });
  }

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationRequestCopyWith<$Res>? get mutationRequest {
    if (_self.mutationRequest == null) {
      return null;
    }

    return $GalleryOperationRequestCopyWith<$Res>(_self.mutationRequest!, (
      value,
    ) {
      return _then(_self.copyWith(mutationRequest: value));
    });
  }

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMutationConfirmationCopyWith<$Res>? get confirmation {
    if (_self.confirmation == null) {
      return null;
    }

    return $GalleryMutationConfirmationCopyWith<$Res>(_self.confirmation!, (
      value,
    ) {
      return _then(_self.copyWith(confirmation: value));
    });
  }

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryViewerEffectCopyWith<$Res>? get effect {
    if (_self.effect == null) {
      return null;
    }

    return $GalleryViewerEffectCopyWith<$Res>(_self.effect!, (value) {
      return _then(_self.copyWith(effect: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryViewerState].
extension GalleryViewerStatePatterns on GalleryViewerState {
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
    TResult Function(_GalleryViewerState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerState() when $default != null:
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
    TResult Function(_GalleryViewerState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerState():
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
    TResult? Function(_GalleryViewerState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerState() when $default != null:
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
      GalleryItem item,
      bool missing,
      bool showInfo,
      bool managementAvailable,
      Set<GalleryCapability> capabilities,
      GalleryTrashEntry? trashEntry,
      Set<String> supersededRevisions,
      GalleryViewerMetadataStatus metadataStatus,
      GalleryMetadata? metadata,
      GalleryErrorCode? metadataError,
      GalleryViewerOperation operation,
      GalleryOperationRequest? mutationRequest,
      GalleryErrorCode? operationError,
      GalleryMutationConfirmation? confirmation,
      int effectId,
      GalleryViewerEffect? effect,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerState() when $default != null:
        return $default(
          _that.item,
          _that.missing,
          _that.showInfo,
          _that.managementAvailable,
          _that.capabilities,
          _that.trashEntry,
          _that.supersededRevisions,
          _that.metadataStatus,
          _that.metadata,
          _that.metadataError,
          _that.operation,
          _that.mutationRequest,
          _that.operationError,
          _that.confirmation,
          _that.effectId,
          _that.effect,
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
      GalleryItem item,
      bool missing,
      bool showInfo,
      bool managementAvailable,
      Set<GalleryCapability> capabilities,
      GalleryTrashEntry? trashEntry,
      Set<String> supersededRevisions,
      GalleryViewerMetadataStatus metadataStatus,
      GalleryMetadata? metadata,
      GalleryErrorCode? metadataError,
      GalleryViewerOperation operation,
      GalleryOperationRequest? mutationRequest,
      GalleryErrorCode? operationError,
      GalleryMutationConfirmation? confirmation,
      int effectId,
      GalleryViewerEffect? effect,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerState():
        return $default(
          _that.item,
          _that.missing,
          _that.showInfo,
          _that.managementAvailable,
          _that.capabilities,
          _that.trashEntry,
          _that.supersededRevisions,
          _that.metadataStatus,
          _that.metadata,
          _that.metadataError,
          _that.operation,
          _that.mutationRequest,
          _that.operationError,
          _that.confirmation,
          _that.effectId,
          _that.effect,
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
      GalleryItem item,
      bool missing,
      bool showInfo,
      bool managementAvailable,
      Set<GalleryCapability> capabilities,
      GalleryTrashEntry? trashEntry,
      Set<String> supersededRevisions,
      GalleryViewerMetadataStatus metadataStatus,
      GalleryMetadata? metadata,
      GalleryErrorCode? metadataError,
      GalleryViewerOperation operation,
      GalleryOperationRequest? mutationRequest,
      GalleryErrorCode? operationError,
      GalleryMutationConfirmation? confirmation,
      int effectId,
      GalleryViewerEffect? effect,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryViewerState() when $default != null:
        return $default(
          _that.item,
          _that.missing,
          _that.showInfo,
          _that.managementAvailable,
          _that.capabilities,
          _that.trashEntry,
          _that.supersededRevisions,
          _that.metadataStatus,
          _that.metadata,
          _that.metadataError,
          _that.operation,
          _that.mutationRequest,
          _that.operationError,
          _that.confirmation,
          _that.effectId,
          _that.effect,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryViewerState extends GalleryViewerState {
  const _GalleryViewerState({
    required this.item,
    this.missing = false,
    this.showInfo = false,
    this.managementAvailable = false,
    Set<GalleryCapability> capabilities = const {},
    this.trashEntry,
    Set<String> supersededRevisions = const {},
    this.metadataStatus = GalleryViewerMetadataStatus.idle,
    this.metadata,
    this.metadataError,
    this.operation = GalleryViewerOperation.idle,
    this.mutationRequest,
    this.operationError,
    this.confirmation,
    this.effectId = 0,
    this.effect,
  }) : _capabilities = capabilities,
       _supersededRevisions = supersededRevisions,
       super._();

  @override
  final GalleryItem item;
  @override
  @JsonKey()
  final bool missing;
  @override
  @JsonKey()
  final bool showInfo;
  @override
  @JsonKey()
  final bool managementAvailable;
  final Set<GalleryCapability> _capabilities;
  @override
  @JsonKey()
  Set<GalleryCapability> get capabilities {
    if (_capabilities is EqualUnmodifiableSetView) return _capabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_capabilities);
  }

  @override
  final GalleryTrashEntry? trashEntry;
  final Set<String> _supersededRevisions;
  @override
  @JsonKey()
  Set<String> get supersededRevisions {
    if (_supersededRevisions is EqualUnmodifiableSetView)
      return _supersededRevisions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_supersededRevisions);
  }

  @override
  @JsonKey()
  final GalleryViewerMetadataStatus metadataStatus;
  @override
  final GalleryMetadata? metadata;
  @override
  final GalleryErrorCode? metadataError;
  @override
  @JsonKey()
  final GalleryViewerOperation operation;
  @override
  final GalleryOperationRequest? mutationRequest;
  @override
  final GalleryErrorCode? operationError;
  @override
  final GalleryMutationConfirmation? confirmation;
  @override
  @JsonKey()
  final int effectId;
  @override
  final GalleryViewerEffect? effect;

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryViewerStateCopyWith<_GalleryViewerState> get copyWith =>
      __$GalleryViewerStateCopyWithImpl<_GalleryViewerState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryViewerState &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.missing, missing) || other.missing == missing) &&
            (identical(other.showInfo, showInfo) ||
                other.showInfo == showInfo) &&
            (identical(other.managementAvailable, managementAvailable) ||
                other.managementAvailable == managementAvailable) &&
            const DeepCollectionEquality().equals(
              other.capabilities,
              _capabilities,
            ) &&
            (identical(other.trashEntry, trashEntry) ||
                other.trashEntry == trashEntry) &&
            const DeepCollectionEquality().equals(
              other.supersededRevisions,
              _supersededRevisions,
            ) &&
            (identical(other.metadataStatus, metadataStatus) ||
                other.metadataStatus == metadataStatus) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.metadataError, metadataError) ||
                other.metadataError == metadataError) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.mutationRequest, mutationRequest) ||
                other.mutationRequest == mutationRequest) &&
            (identical(other.operationError, operationError) ||
                other.operationError == operationError) &&
            (identical(other.confirmation, confirmation) ||
                other.confirmation == confirmation) &&
            (identical(other.effectId, effectId) ||
                other.effectId == effectId) &&
            (identical(other.effect, effect) || other.effect == effect));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      item,
      missing,
      showInfo,
      managementAvailable,
      const DeepCollectionEquality().hash(_capabilities),
      trashEntry,
      const DeepCollectionEquality().hash(_supersededRevisions),
      metadataStatus,
      metadata,
      metadataError,
      operation,
      mutationRequest,
      operationError,
      confirmation,
      effectId,
      effect,
    );
  }

  @override
  String toString() {
    return 'GalleryViewerState(item: $item, missing: $missing, showInfo: $showInfo, managementAvailable: $managementAvailable, capabilities: $capabilities, trashEntry: $trashEntry, supersededRevisions: $supersededRevisions, metadataStatus: $metadataStatus, metadata: $metadata, metadataError: $metadataError, operation: $operation, mutationRequest: $mutationRequest, operationError: $operationError, confirmation: $confirmation, effectId: $effectId, effect: $effect)';
  }
}

/// @nodoc
abstract mixin class _$GalleryViewerStateCopyWith<$Res>
    implements $GalleryViewerStateCopyWith<$Res> {
  factory _$GalleryViewerStateCopyWith(
    _GalleryViewerState value,
    $Res Function(_GalleryViewerState) _then,
  ) = __$GalleryViewerStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    GalleryItem item,
    bool missing,
    bool showInfo,
    bool managementAvailable,
    Set<GalleryCapability> capabilities,
    GalleryTrashEntry? trashEntry,
    Set<String> supersededRevisions,
    GalleryViewerMetadataStatus metadataStatus,
    GalleryMetadata? metadata,
    GalleryErrorCode? metadataError,
    GalleryViewerOperation operation,
    GalleryOperationRequest? mutationRequest,
    GalleryErrorCode? operationError,
    GalleryMutationConfirmation? confirmation,
    int effectId,
    GalleryViewerEffect? effect,
  });

  @override
  $GalleryTrashEntryCopyWith<$Res>? get trashEntry;
  @override
  $GalleryMetadataCopyWith<$Res>? get metadata;
  @override
  $GalleryOperationRequestCopyWith<$Res>? get mutationRequest;
  @override
  $GalleryMutationConfirmationCopyWith<$Res>? get confirmation;
  @override
  $GalleryViewerEffectCopyWith<$Res>? get effect;
}

/// @nodoc
class __$GalleryViewerStateCopyWithImpl<$Res>
    implements _$GalleryViewerStateCopyWith<$Res> {
  __$GalleryViewerStateCopyWithImpl(this._self, this._then);

  final _GalleryViewerState _self;
  final $Res Function(_GalleryViewerState) _then;

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? item = null,
    Object? missing = null,
    Object? showInfo = null,
    Object? managementAvailable = null,
    Object? capabilities = null,
    Object? trashEntry = freezed,
    Object? supersededRevisions = null,
    Object? metadataStatus = null,
    Object? metadata = freezed,
    Object? metadataError = freezed,
    Object? operation = null,
    Object? mutationRequest = freezed,
    Object? operationError = freezed,
    Object? confirmation = freezed,
    Object? effectId = null,
    Object? effect = freezed,
  }) {
    return _then(
      _GalleryViewerState(
        item: null == item
            ? _self.item
            : item // ignore: cast_nullable_to_non_nullable
                  as GalleryItem,
        missing: null == missing
            ? _self.missing
            : missing // ignore: cast_nullable_to_non_nullable
                  as bool,
        showInfo: null == showInfo
            ? _self.showInfo
            : showInfo // ignore: cast_nullable_to_non_nullable
                  as bool,
        managementAvailable: null == managementAvailable
            ? _self.managementAvailable
            : managementAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        capabilities: null == capabilities
            ? _self._capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as Set<GalleryCapability>,
        trashEntry: freezed == trashEntry
            ? _self.trashEntry
            : trashEntry // ignore: cast_nullable_to_non_nullable
                  as GalleryTrashEntry?,
        supersededRevisions: null == supersededRevisions
            ? _self._supersededRevisions
            : supersededRevisions // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        metadataStatus: null == metadataStatus
            ? _self.metadataStatus
            : metadataStatus // ignore: cast_nullable_to_non_nullable
                  as GalleryViewerMetadataStatus,
        metadata: freezed == metadata
            ? _self.metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as GalleryMetadata?,
        metadataError: freezed == metadataError
            ? _self.metadataError
            : metadataError // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        operation: null == operation
            ? _self.operation
            : operation // ignore: cast_nullable_to_non_nullable
                  as GalleryViewerOperation,
        mutationRequest: freezed == mutationRequest
            ? _self.mutationRequest
            : mutationRequest // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationRequest?,
        operationError: freezed == operationError
            ? _self.operationError
            : operationError // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        confirmation: freezed == confirmation
            ? _self.confirmation
            : confirmation // ignore: cast_nullable_to_non_nullable
                  as GalleryMutationConfirmation?,
        effectId: null == effectId
            ? _self.effectId
            : effectId // ignore: cast_nullable_to_non_nullable
                  as int,
        effect: freezed == effect
            ? _self.effect
            : effect // ignore: cast_nullable_to_non_nullable
                  as GalleryViewerEffect?,
      ),
    );
  }

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryTrashEntryCopyWith<$Res>? get trashEntry {
    if (_self.trashEntry == null) {
      return null;
    }

    return $GalleryTrashEntryCopyWith<$Res>(_self.trashEntry!, (value) {
      return _then(_self.copyWith(trashEntry: value));
    });
  }

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
      return null;
    }

    return $GalleryMetadataCopyWith<$Res>(_self.metadata!, (value) {
      return _then(_self.copyWith(metadata: value));
    });
  }

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationRequestCopyWith<$Res>? get mutationRequest {
    if (_self.mutationRequest == null) {
      return null;
    }

    return $GalleryOperationRequestCopyWith<$Res>(_self.mutationRequest!, (
      value,
    ) {
      return _then(_self.copyWith(mutationRequest: value));
    });
  }

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMutationConfirmationCopyWith<$Res>? get confirmation {
    if (_self.confirmation == null) {
      return null;
    }

    return $GalleryMutationConfirmationCopyWith<$Res>(_self.confirmation!, (
      value,
    ) {
      return _then(_self.copyWith(confirmation: value));
    });
  }

  /// Create a copy of GalleryViewerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryViewerEffectCopyWith<$Res>? get effect {
    if (_self.effect == null) {
      return null;
    }

    return $GalleryViewerEffectCopyWith<$Res>(_self.effect!, (value) {
      return _then(_self.copyWith(effect: value));
    });
  }
}
