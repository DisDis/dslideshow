// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_management_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryManagementEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryManagementEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryManagementEvent()';
  }
}

/// @nodoc
class $GalleryManagementEventCopyWith<$Res> {
  $GalleryManagementEventCopyWith(
    GalleryManagementEvent _,
    $Res Function(GalleryManagementEvent) __,
  );
}

/// Adds pattern-matching-related methods to [GalleryManagementEvent].
extension GalleryManagementEventPatterns on GalleryManagementEvent {
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
    TResult Function(GalleryManagementCatalogChanged value)? catalogChanged,
    TResult Function(GalleryManagementSectionChanged value)? sectionChanged,
    TResult Function(GalleryManagementSelectionToggled value)? selectionToggled,
    TResult Function(GalleryManagementSelectionCleared value)? selectionCleared,
    TResult Function(GalleryManagementTrashSelectionAllRequested value)?
    trashSelectionAllRequested,
    TResult Function(GalleryManagementClearTrashRequested value)?
    clearTrashRequested,
    TResult Function(GalleryManagementTrashRequested value)? trashRequested,
    TResult Function(GalleryManagementMutationRequested value)?
    mutationRequested,
    TResult Function(GalleryManagementMutationDecision value)? mutationDecision,
    TResult Function(GalleryManagementRefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GalleryManagementCatalogChanged() when catalogChanged != null:
        return catalogChanged(_that);
      case GalleryManagementSectionChanged() when sectionChanged != null:
        return sectionChanged(_that);
      case GalleryManagementSelectionToggled() when selectionToggled != null:
        return selectionToggled(_that);
      case GalleryManagementSelectionCleared() when selectionCleared != null:
        return selectionCleared(_that);
      case GalleryManagementTrashSelectionAllRequested()
          when trashSelectionAllRequested != null:
        return trashSelectionAllRequested(_that);
      case GalleryManagementClearTrashRequested()
          when clearTrashRequested != null:
        return clearTrashRequested(_that);
      case GalleryManagementTrashRequested() when trashRequested != null:
        return trashRequested(_that);
      case GalleryManagementMutationRequested() when mutationRequested != null:
        return mutationRequested(_that);
      case GalleryManagementMutationDecision() when mutationDecision != null:
        return mutationDecision(_that);
      case GalleryManagementRefreshRequested() when refreshRequested != null:
        return refreshRequested(_that);
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
    required TResult Function(GalleryManagementCatalogChanged value)
    catalogChanged,
    required TResult Function(GalleryManagementSectionChanged value)
    sectionChanged,
    required TResult Function(GalleryManagementSelectionToggled value)
    selectionToggled,
    required TResult Function(GalleryManagementSelectionCleared value)
    selectionCleared,
    required TResult Function(GalleryManagementTrashSelectionAllRequested value)
    trashSelectionAllRequested,
    required TResult Function(GalleryManagementClearTrashRequested value)
    clearTrashRequested,
    required TResult Function(GalleryManagementTrashRequested value)
    trashRequested,
    required TResult Function(GalleryManagementMutationRequested value)
    mutationRequested,
    required TResult Function(GalleryManagementMutationDecision value)
    mutationDecision,
    required TResult Function(GalleryManagementRefreshRequested value)
    refreshRequested,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryManagementCatalogChanged():
        return catalogChanged(_that);
      case GalleryManagementSectionChanged():
        return sectionChanged(_that);
      case GalleryManagementSelectionToggled():
        return selectionToggled(_that);
      case GalleryManagementSelectionCleared():
        return selectionCleared(_that);
      case GalleryManagementTrashSelectionAllRequested():
        return trashSelectionAllRequested(_that);
      case GalleryManagementClearTrashRequested():
        return clearTrashRequested(_that);
      case GalleryManagementTrashRequested():
        return trashRequested(_that);
      case GalleryManagementMutationRequested():
        return mutationRequested(_that);
      case GalleryManagementMutationDecision():
        return mutationDecision(_that);
      case GalleryManagementRefreshRequested():
        return refreshRequested(_that);
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
    TResult? Function(GalleryManagementCatalogChanged value)? catalogChanged,
    TResult? Function(GalleryManagementSectionChanged value)? sectionChanged,
    TResult? Function(GalleryManagementSelectionToggled value)?
    selectionToggled,
    TResult? Function(GalleryManagementSelectionCleared value)?
    selectionCleared,
    TResult? Function(GalleryManagementTrashSelectionAllRequested value)?
    trashSelectionAllRequested,
    TResult? Function(GalleryManagementClearTrashRequested value)?
    clearTrashRequested,
    TResult? Function(GalleryManagementTrashRequested value)? trashRequested,
    TResult? Function(GalleryManagementMutationRequested value)?
    mutationRequested,
    TResult? Function(GalleryManagementMutationDecision value)?
    mutationDecision,
    TResult? Function(GalleryManagementRefreshRequested value)?
    refreshRequested,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryManagementCatalogChanged() when catalogChanged != null:
        return catalogChanged(_that);
      case GalleryManagementSectionChanged() when sectionChanged != null:
        return sectionChanged(_that);
      case GalleryManagementSelectionToggled() when selectionToggled != null:
        return selectionToggled(_that);
      case GalleryManagementSelectionCleared() when selectionCleared != null:
        return selectionCleared(_that);
      case GalleryManagementTrashSelectionAllRequested()
          when trashSelectionAllRequested != null:
        return trashSelectionAllRequested(_that);
      case GalleryManagementClearTrashRequested()
          when clearTrashRequested != null:
        return clearTrashRequested(_that);
      case GalleryManagementTrashRequested() when trashRequested != null:
        return trashRequested(_that);
      case GalleryManagementMutationRequested() when mutationRequested != null:
        return mutationRequested(_that);
      case GalleryManagementMutationDecision() when mutationDecision != null:
        return mutationDecision(_that);
      case GalleryManagementRefreshRequested() when refreshRequested != null:
        return refreshRequested(_that);
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
    TResult Function(GalleryState catalog)? catalogChanged,
    TResult Function(GallerySection section)? sectionChanged,
    TResult Function(String selectionIdentity)? selectionToggled,
    TResult Function()? selectionCleared,
    TResult Function()? trashSelectionAllRequested,
    TResult Function()? clearTrashRequested,
    TResult Function()? trashRequested,
    TResult Function(GalleryMutation action)? mutationRequested,
    TResult Function(int confirmationId, bool confirmed)? mutationDecision,
    TResult Function(Completer<void> completion)? refreshRequested,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GalleryManagementCatalogChanged() when catalogChanged != null:
        return catalogChanged(_that.catalog);
      case GalleryManagementSectionChanged() when sectionChanged != null:
        return sectionChanged(_that.section);
      case GalleryManagementSelectionToggled() when selectionToggled != null:
        return selectionToggled(_that.selectionIdentity);
      case GalleryManagementSelectionCleared() when selectionCleared != null:
        return selectionCleared();
      case GalleryManagementTrashSelectionAllRequested()
          when trashSelectionAllRequested != null:
        return trashSelectionAllRequested();
      case GalleryManagementClearTrashRequested()
          when clearTrashRequested != null:
        return clearTrashRequested();
      case GalleryManagementTrashRequested() when trashRequested != null:
        return trashRequested();
      case GalleryManagementMutationRequested() when mutationRequested != null:
        return mutationRequested(_that.action);
      case GalleryManagementMutationDecision() when mutationDecision != null:
        return mutationDecision(_that.confirmationId, _that.confirmed);
      case GalleryManagementRefreshRequested() when refreshRequested != null:
        return refreshRequested(_that.completion);
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
    required TResult Function(GalleryState catalog) catalogChanged,
    required TResult Function(GallerySection section) sectionChanged,
    required TResult Function(String selectionIdentity) selectionToggled,
    required TResult Function() selectionCleared,
    required TResult Function() trashSelectionAllRequested,
    required TResult Function() clearTrashRequested,
    required TResult Function() trashRequested,
    required TResult Function(GalleryMutation action) mutationRequested,
    required TResult Function(int confirmationId, bool confirmed)
    mutationDecision,
    required TResult Function(Completer<void> completion) refreshRequested,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryManagementCatalogChanged():
        return catalogChanged(_that.catalog);
      case GalleryManagementSectionChanged():
        return sectionChanged(_that.section);
      case GalleryManagementSelectionToggled():
        return selectionToggled(_that.selectionIdentity);
      case GalleryManagementSelectionCleared():
        return selectionCleared();
      case GalleryManagementTrashSelectionAllRequested():
        return trashSelectionAllRequested();
      case GalleryManagementClearTrashRequested():
        return clearTrashRequested();
      case GalleryManagementTrashRequested():
        return trashRequested();
      case GalleryManagementMutationRequested():
        return mutationRequested(_that.action);
      case GalleryManagementMutationDecision():
        return mutationDecision(_that.confirmationId, _that.confirmed);
      case GalleryManagementRefreshRequested():
        return refreshRequested(_that.completion);
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
    TResult? Function(GalleryState catalog)? catalogChanged,
    TResult? Function(GallerySection section)? sectionChanged,
    TResult? Function(String selectionIdentity)? selectionToggled,
    TResult? Function()? selectionCleared,
    TResult? Function()? trashSelectionAllRequested,
    TResult? Function()? clearTrashRequested,
    TResult? Function()? trashRequested,
    TResult? Function(GalleryMutation action)? mutationRequested,
    TResult? Function(int confirmationId, bool confirmed)? mutationDecision,
    TResult? Function(Completer<void> completion)? refreshRequested,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryManagementCatalogChanged() when catalogChanged != null:
        return catalogChanged(_that.catalog);
      case GalleryManagementSectionChanged() when sectionChanged != null:
        return sectionChanged(_that.section);
      case GalleryManagementSelectionToggled() when selectionToggled != null:
        return selectionToggled(_that.selectionIdentity);
      case GalleryManagementSelectionCleared() when selectionCleared != null:
        return selectionCleared();
      case GalleryManagementTrashSelectionAllRequested()
          when trashSelectionAllRequested != null:
        return trashSelectionAllRequested();
      case GalleryManagementClearTrashRequested()
          when clearTrashRequested != null:
        return clearTrashRequested();
      case GalleryManagementTrashRequested() when trashRequested != null:
        return trashRequested();
      case GalleryManagementMutationRequested() when mutationRequested != null:
        return mutationRequested(_that.action);
      case GalleryManagementMutationDecision() when mutationDecision != null:
        return mutationDecision(_that.confirmationId, _that.confirmed);
      case GalleryManagementRefreshRequested() when refreshRequested != null:
        return refreshRequested(_that.completion);
      case _:
        return null;
    }
  }
}

/// @nodoc

class GalleryManagementCatalogChanged implements GalleryManagementEvent {
  const GalleryManagementCatalogChanged(this.catalog);

  final GalleryState catalog;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryManagementCatalogChangedCopyWith<GalleryManagementCatalogChanged>
  get copyWith =>
      _$GalleryManagementCatalogChangedCopyWithImpl<
        GalleryManagementCatalogChanged
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementCatalogChanged &&
            (identical(other.catalog, catalog) || other.catalog == catalog));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, catalog);
  }

  @override
  String toString() {
    return 'GalleryManagementEvent.catalogChanged(catalog: $catalog)';
  }
}

/// @nodoc
abstract mixin class $GalleryManagementCatalogChangedCopyWith<$Res>
    implements $GalleryManagementEventCopyWith<$Res> {
  factory $GalleryManagementCatalogChangedCopyWith(
    GalleryManagementCatalogChanged value,
    $Res Function(GalleryManagementCatalogChanged) _then,
  ) = _$GalleryManagementCatalogChangedCopyWithImpl;
  @useResult
  $Res call({GalleryState catalog});

  $GalleryStateCopyWith<$Res> get catalog;
}

/// @nodoc
class _$GalleryManagementCatalogChangedCopyWithImpl<$Res>
    implements $GalleryManagementCatalogChangedCopyWith<$Res> {
  _$GalleryManagementCatalogChangedCopyWithImpl(this._self, this._then);

  final GalleryManagementCatalogChanged _self;
  final $Res Function(GalleryManagementCatalogChanged) _then;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? catalog = null}) {
    return _then(
      GalleryManagementCatalogChanged(
        null == catalog
            ? _self.catalog
            : catalog // ignore: cast_nullable_to_non_nullable
                  as GalleryState,
      ),
    );
  }

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryStateCopyWith<$Res> get catalog {
    return $GalleryStateCopyWith<$Res>(_self.catalog, (value) {
      return _then(_self.copyWith(catalog: value));
    });
  }
}

/// @nodoc

class GalleryManagementSectionChanged implements GalleryManagementEvent {
  const GalleryManagementSectionChanged(this.section);

  final GallerySection section;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryManagementSectionChangedCopyWith<GalleryManagementSectionChanged>
  get copyWith =>
      _$GalleryManagementSectionChangedCopyWithImpl<
        GalleryManagementSectionChanged
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementSectionChanged &&
            (identical(other.section, section) || other.section == section));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, section);
  }

  @override
  String toString() {
    return 'GalleryManagementEvent.sectionChanged(section: $section)';
  }
}

/// @nodoc
abstract mixin class $GalleryManagementSectionChangedCopyWith<$Res>
    implements $GalleryManagementEventCopyWith<$Res> {
  factory $GalleryManagementSectionChangedCopyWith(
    GalleryManagementSectionChanged value,
    $Res Function(GalleryManagementSectionChanged) _then,
  ) = _$GalleryManagementSectionChangedCopyWithImpl;
  @useResult
  $Res call({GallerySection section});
}

/// @nodoc
class _$GalleryManagementSectionChangedCopyWithImpl<$Res>
    implements $GalleryManagementSectionChangedCopyWith<$Res> {
  _$GalleryManagementSectionChangedCopyWithImpl(this._self, this._then);

  final GalleryManagementSectionChanged _self;
  final $Res Function(GalleryManagementSectionChanged) _then;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? section = null}) {
    return _then(
      GalleryManagementSectionChanged(
        null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GallerySection,
      ),
    );
  }
}

/// @nodoc

class GalleryManagementSelectionToggled implements GalleryManagementEvent {
  const GalleryManagementSelectionToggled(this.selectionIdentity);

  final String selectionIdentity;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryManagementSelectionToggledCopyWith<GalleryManagementSelectionToggled>
  get copyWith =>
      _$GalleryManagementSelectionToggledCopyWithImpl<
        GalleryManagementSelectionToggled
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementSelectionToggled &&
            (identical(other.selectionIdentity, selectionIdentity) ||
                other.selectionIdentity == selectionIdentity));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, selectionIdentity);
  }

  @override
  String toString() {
    return 'GalleryManagementEvent.selectionToggled(selectionIdentity: $selectionIdentity)';
  }
}

/// @nodoc
abstract mixin class $GalleryManagementSelectionToggledCopyWith<$Res>
    implements $GalleryManagementEventCopyWith<$Res> {
  factory $GalleryManagementSelectionToggledCopyWith(
    GalleryManagementSelectionToggled value,
    $Res Function(GalleryManagementSelectionToggled) _then,
  ) = _$GalleryManagementSelectionToggledCopyWithImpl;
  @useResult
  $Res call({String selectionIdentity});
}

/// @nodoc
class _$GalleryManagementSelectionToggledCopyWithImpl<$Res>
    implements $GalleryManagementSelectionToggledCopyWith<$Res> {
  _$GalleryManagementSelectionToggledCopyWithImpl(this._self, this._then);

  final GalleryManagementSelectionToggled _self;
  final $Res Function(GalleryManagementSelectionToggled) _then;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? selectionIdentity = null}) {
    return _then(
      GalleryManagementSelectionToggled(
        null == selectionIdentity
            ? _self.selectionIdentity
            : selectionIdentity // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class GalleryManagementSelectionCleared implements GalleryManagementEvent {
  const GalleryManagementSelectionCleared();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementSelectionCleared);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryManagementEvent.selectionCleared()';
  }
}

/// @nodoc

class GalleryManagementTrashSelectionAllRequested
    implements GalleryManagementEvent {
  const GalleryManagementTrashSelectionAllRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementTrashSelectionAllRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryManagementEvent.trashSelectionAllRequested()';
  }
}

/// @nodoc

class GalleryManagementClearTrashRequested implements GalleryManagementEvent {
  const GalleryManagementClearTrashRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementClearTrashRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryManagementEvent.clearTrashRequested()';
  }
}

/// @nodoc

class GalleryManagementTrashRequested implements GalleryManagementEvent {
  const GalleryManagementTrashRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementTrashRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryManagementEvent.trashRequested()';
  }
}

/// @nodoc

class GalleryManagementMutationRequested implements GalleryManagementEvent {
  const GalleryManagementMutationRequested(this.action);

  final GalleryMutation action;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryManagementMutationRequestedCopyWith<
    GalleryManagementMutationRequested
  >
  get copyWith =>
      _$GalleryManagementMutationRequestedCopyWithImpl<
        GalleryManagementMutationRequested
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementMutationRequested &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, action);
  }

  @override
  String toString() {
    return 'GalleryManagementEvent.mutationRequested(action: $action)';
  }
}

/// @nodoc
abstract mixin class $GalleryManagementMutationRequestedCopyWith<$Res>
    implements $GalleryManagementEventCopyWith<$Res> {
  factory $GalleryManagementMutationRequestedCopyWith(
    GalleryManagementMutationRequested value,
    $Res Function(GalleryManagementMutationRequested) _then,
  ) = _$GalleryManagementMutationRequestedCopyWithImpl;
  @useResult
  $Res call({GalleryMutation action});
}

/// @nodoc
class _$GalleryManagementMutationRequestedCopyWithImpl<$Res>
    implements $GalleryManagementMutationRequestedCopyWith<$Res> {
  _$GalleryManagementMutationRequestedCopyWithImpl(this._self, this._then);

  final GalleryManagementMutationRequested _self;
  final $Res Function(GalleryManagementMutationRequested) _then;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? action = null}) {
    return _then(
      GalleryManagementMutationRequested(
        null == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as GalleryMutation,
      ),
    );
  }
}

/// @nodoc

class GalleryManagementMutationDecision implements GalleryManagementEvent {
  const GalleryManagementMutationDecision({
    required this.confirmationId,
    required this.confirmed,
  });

  final int confirmationId;
  final bool confirmed;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryManagementMutationDecisionCopyWith<GalleryManagementMutationDecision>
  get copyWith =>
      _$GalleryManagementMutationDecisionCopyWithImpl<
        GalleryManagementMutationDecision
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementMutationDecision &&
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
    return 'GalleryManagementEvent.mutationDecision(confirmationId: $confirmationId, confirmed: $confirmed)';
  }
}

/// @nodoc
abstract mixin class $GalleryManagementMutationDecisionCopyWith<$Res>
    implements $GalleryManagementEventCopyWith<$Res> {
  factory $GalleryManagementMutationDecisionCopyWith(
    GalleryManagementMutationDecision value,
    $Res Function(GalleryManagementMutationDecision) _then,
  ) = _$GalleryManagementMutationDecisionCopyWithImpl;
  @useResult
  $Res call({int confirmationId, bool confirmed});
}

/// @nodoc
class _$GalleryManagementMutationDecisionCopyWithImpl<$Res>
    implements $GalleryManagementMutationDecisionCopyWith<$Res> {
  _$GalleryManagementMutationDecisionCopyWithImpl(this._self, this._then);

  final GalleryManagementMutationDecision _self;
  final $Res Function(GalleryManagementMutationDecision) _then;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? confirmationId = null, Object? confirmed = null}) {
    return _then(
      GalleryManagementMutationDecision(
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

class GalleryManagementRefreshRequested implements GalleryManagementEvent {
  const GalleryManagementRefreshRequested(this.completion);

  final Completer<void> completion;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryManagementRefreshRequestedCopyWith<GalleryManagementRefreshRequested>
  get copyWith =>
      _$GalleryManagementRefreshRequestedCopyWithImpl<
        GalleryManagementRefreshRequested
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementRefreshRequested &&
            (identical(other.completion, completion) ||
                other.completion == completion));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, completion);
  }

  @override
  String toString() {
    return 'GalleryManagementEvent.refreshRequested(completion: $completion)';
  }
}

/// @nodoc
abstract mixin class $GalleryManagementRefreshRequestedCopyWith<$Res>
    implements $GalleryManagementEventCopyWith<$Res> {
  factory $GalleryManagementRefreshRequestedCopyWith(
    GalleryManagementRefreshRequested value,
    $Res Function(GalleryManagementRefreshRequested) _then,
  ) = _$GalleryManagementRefreshRequestedCopyWithImpl;
  @useResult
  $Res call({Completer<void> completion});
}

/// @nodoc
class _$GalleryManagementRefreshRequestedCopyWithImpl<$Res>
    implements $GalleryManagementRefreshRequestedCopyWith<$Res> {
  _$GalleryManagementRefreshRequestedCopyWithImpl(this._self, this._then);

  final GalleryManagementRefreshRequested _self;
  final $Res Function(GalleryManagementRefreshRequested) _then;

  /// Create a copy of GalleryManagementEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? completion = null}) {
    return _then(
      GalleryManagementRefreshRequested(
        null == completion
            ? _self.completion
            : completion // ignore: cast_nullable_to_non_nullable
                  as Completer<void>,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryManagementSnapshot {
  List<GalleryItem> get items;
  Map<String, GalleryItem> get bySelectionIdentity;
  Map<String, GalleryItem> get byMediaId;
  Map<String, GalleryTrashEntry> get trashById;

  /// Create a copy of GalleryManagementSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryManagementSnapshotCopyWith<GalleryManagementSnapshot> get copyWith =>
      _$GalleryManagementSnapshotCopyWithImpl<GalleryManagementSnapshot>(
        this as GalleryManagementSnapshot,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryManagementSnapshot;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementSnapshot &&
            const DeepCollectionEquality().equals(other.items, _this.items) &&
            const DeepCollectionEquality().equals(
              other.bySelectionIdentity,
              _this.bySelectionIdentity,
            ) &&
            const DeepCollectionEquality().equals(
              other.byMediaId,
              _this.byMediaId,
            ) &&
            const DeepCollectionEquality().equals(
              other.trashById,
              _this.trashById,
            ));
  }

  @override
  int get hashCode {
    final _this = this as GalleryManagementSnapshot;
    return Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_this.items),
      const DeepCollectionEquality().hash(_this.bySelectionIdentity),
      const DeepCollectionEquality().hash(_this.byMediaId),
      const DeepCollectionEquality().hash(_this.trashById),
    );
  }

  @override
  String toString() {
    final _this = this as GalleryManagementSnapshot;
    return 'GalleryManagementSnapshot(items: ${_this.items}, bySelectionIdentity: ${_this.bySelectionIdentity}, byMediaId: ${_this.byMediaId}, trashById: ${_this.trashById})';
  }
}

/// @nodoc
abstract mixin class $GalleryManagementSnapshotCopyWith<$Res> {
  factory $GalleryManagementSnapshotCopyWith(
    GalleryManagementSnapshot value,
    $Res Function(GalleryManagementSnapshot) _then,
  ) = _$GalleryManagementSnapshotCopyWithImpl;
  @useResult
  $Res call({
    List<GalleryItem> items,
    Map<String, GalleryItem> bySelectionIdentity,
    Map<String, GalleryItem> byMediaId,
    Map<String, GalleryTrashEntry> trashById,
  });
}

/// @nodoc
class _$GalleryManagementSnapshotCopyWithImpl<$Res>
    implements $GalleryManagementSnapshotCopyWith<$Res> {
  _$GalleryManagementSnapshotCopyWithImpl(this._self, this._then);

  final GalleryManagementSnapshot _self;
  final $Res Function(GalleryManagementSnapshot) _then;

  /// Create a copy of GalleryManagementSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? bySelectionIdentity = null,
    Object? byMediaId = null,
    Object? trashById = null,
  }) {
    return _then(
      GalleryManagementSnapshot(
        items: null == items
            ? _self.items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryItem>,
        bySelectionIdentity: null == bySelectionIdentity
            ? _self.bySelectionIdentity
            : bySelectionIdentity // ignore: cast_nullable_to_non_nullable
                  as Map<String, GalleryItem>,
        byMediaId: null == byMediaId
            ? _self.byMediaId
            : byMediaId // ignore: cast_nullable_to_non_nullable
                  as Map<String, GalleryItem>,
        trashById: null == trashById
            ? _self.trashById
            : trashById // ignore: cast_nullable_to_non_nullable
                  as Map<String, GalleryTrashEntry>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryManagementSnapshot].
extension GalleryManagementSnapshotPatterns on GalleryManagementSnapshot {
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
    TResult Function(_GalleryManagementSnapshot value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementSnapshot() when $default != null:
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
    TResult Function(_GalleryManagementSnapshot value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementSnapshot():
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
    TResult? Function(_GalleryManagementSnapshot value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementSnapshot() when $default != null:
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
      List<GalleryItem> items,
      Map<String, GalleryItem> bySelectionIdentity,
      Map<String, GalleryItem> byMediaId,
      Map<String, GalleryTrashEntry> trashById,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementSnapshot() when $default != null:
        return $default(
          _that.items,
          _that.bySelectionIdentity,
          _that.byMediaId,
          _that.trashById,
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
      List<GalleryItem> items,
      Map<String, GalleryItem> bySelectionIdentity,
      Map<String, GalleryItem> byMediaId,
      Map<String, GalleryTrashEntry> trashById,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementSnapshot():
        return $default(
          _that.items,
          _that.bySelectionIdentity,
          _that.byMediaId,
          _that.trashById,
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
      List<GalleryItem> items,
      Map<String, GalleryItem> bySelectionIdentity,
      Map<String, GalleryItem> byMediaId,
      Map<String, GalleryTrashEntry> trashById,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementSnapshot() when $default != null:
        return $default(
          _that.items,
          _that.bySelectionIdentity,
          _that.byMediaId,
          _that.trashById,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryManagementSnapshot implements GalleryManagementSnapshot {
  const _GalleryManagementSnapshot({
    List<GalleryItem> items = const [],
    Map<String, GalleryItem> bySelectionIdentity = const {},
    Map<String, GalleryItem> byMediaId = const {},
    Map<String, GalleryTrashEntry> trashById = const {},
  }) : _items = items,
       _bySelectionIdentity = bySelectionIdentity,
       _byMediaId = byMediaId,
       _trashById = trashById;

  final List<GalleryItem> _items;
  @override
  @JsonKey()
  List<GalleryItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final Map<String, GalleryItem> _bySelectionIdentity;
  @override
  @JsonKey()
  Map<String, GalleryItem> get bySelectionIdentity {
    if (_bySelectionIdentity is EqualUnmodifiableMapView)
      return _bySelectionIdentity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_bySelectionIdentity);
  }

  final Map<String, GalleryItem> _byMediaId;
  @override
  @JsonKey()
  Map<String, GalleryItem> get byMediaId {
    if (_byMediaId is EqualUnmodifiableMapView) return _byMediaId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byMediaId);
  }

  final Map<String, GalleryTrashEntry> _trashById;
  @override
  @JsonKey()
  Map<String, GalleryTrashEntry> get trashById {
    if (_trashById is EqualUnmodifiableMapView) return _trashById;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_trashById);
  }

  /// Create a copy of GalleryManagementSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryManagementSnapshotCopyWith<_GalleryManagementSnapshot>
  get copyWith =>
      __$GalleryManagementSnapshotCopyWithImpl<_GalleryManagementSnapshot>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryManagementSnapshot &&
            const DeepCollectionEquality().equals(other.items, _items) &&
            const DeepCollectionEquality().equals(
              other.bySelectionIdentity,
              _bySelectionIdentity,
            ) &&
            const DeepCollectionEquality().equals(
              other.byMediaId,
              _byMediaId,
            ) &&
            const DeepCollectionEquality().equals(other.trashById, _trashById));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_bySelectionIdentity),
      const DeepCollectionEquality().hash(_byMediaId),
      const DeepCollectionEquality().hash(_trashById),
    );
  }

  @override
  String toString() {
    return 'GalleryManagementSnapshot(items: $items, bySelectionIdentity: $bySelectionIdentity, byMediaId: $byMediaId, trashById: $trashById)';
  }
}

/// @nodoc
abstract mixin class _$GalleryManagementSnapshotCopyWith<$Res>
    implements $GalleryManagementSnapshotCopyWith<$Res> {
  factory _$GalleryManagementSnapshotCopyWith(
    _GalleryManagementSnapshot value,
    $Res Function(_GalleryManagementSnapshot) _then,
  ) = __$GalleryManagementSnapshotCopyWithImpl;
  @override
  @useResult
  $Res call({
    List<GalleryItem> items,
    Map<String, GalleryItem> bySelectionIdentity,
    Map<String, GalleryItem> byMediaId,
    Map<String, GalleryTrashEntry> trashById,
  });
}

/// @nodoc
class __$GalleryManagementSnapshotCopyWithImpl<$Res>
    implements _$GalleryManagementSnapshotCopyWith<$Res> {
  __$GalleryManagementSnapshotCopyWithImpl(this._self, this._then);

  final _GalleryManagementSnapshot _self;
  final $Res Function(_GalleryManagementSnapshot) _then;

  /// Create a copy of GalleryManagementSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? bySelectionIdentity = null,
    Object? byMediaId = null,
    Object? trashById = null,
  }) {
    return _then(
      _GalleryManagementSnapshot(
        items: null == items
            ? _self._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryItem>,
        bySelectionIdentity: null == bySelectionIdentity
            ? _self._bySelectionIdentity
            : bySelectionIdentity // ignore: cast_nullable_to_non_nullable
                  as Map<String, GalleryItem>,
        byMediaId: null == byMediaId
            ? _self._byMediaId
            : byMediaId // ignore: cast_nullable_to_non_nullable
                  as Map<String, GalleryItem>,
        trashById: null == trashById
            ? _self._trashById
            : trashById // ignore: cast_nullable_to_non_nullable
                  as Map<String, GalleryTrashEntry>,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryManagementOperationPlan {
  GalleryMutation get action;
  GalleryManagementSnapshot get snapshot;
  List<GalleryMediaRef> get items;
  List<GalleryOperationRequest> get requests;

  /// Create a copy of GalleryManagementOperationPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryManagementOperationPlanCopyWith<GalleryManagementOperationPlan>
  get copyWith =>
      _$GalleryManagementOperationPlanCopyWithImpl<
        GalleryManagementOperationPlan
      >(this as GalleryManagementOperationPlan, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryManagementOperationPlan;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementOperationPlan &&
            (identical(other.action, _this.action) ||
                other.action == _this.action) &&
            (identical(other.snapshot, _this.snapshot) ||
                other.snapshot == _this.snapshot) &&
            const DeepCollectionEquality().equals(other.items, _this.items) &&
            const DeepCollectionEquality().equals(
              other.requests,
              _this.requests,
            ));
  }

  @override
  int get hashCode {
    final _this = this as GalleryManagementOperationPlan;
    return Object.hash(
      runtimeType,
      _this.action,
      _this.snapshot,
      const DeepCollectionEquality().hash(_this.items),
      const DeepCollectionEquality().hash(_this.requests),
    );
  }

  @override
  String toString() {
    final _this = this as GalleryManagementOperationPlan;
    return 'GalleryManagementOperationPlan(action: ${_this.action}, snapshot: ${_this.snapshot}, items: ${_this.items}, requests: ${_this.requests})';
  }
}

/// @nodoc
abstract mixin class $GalleryManagementOperationPlanCopyWith<$Res> {
  factory $GalleryManagementOperationPlanCopyWith(
    GalleryManagementOperationPlan value,
    $Res Function(GalleryManagementOperationPlan) _then,
  ) = _$GalleryManagementOperationPlanCopyWithImpl;
  @useResult
  $Res call({
    GalleryMutation action,
    GalleryManagementSnapshot snapshot,
    List<GalleryMediaRef> items,
    List<GalleryOperationRequest> requests,
  });

  $GalleryManagementSnapshotCopyWith<$Res> get snapshot;
}

/// @nodoc
class _$GalleryManagementOperationPlanCopyWithImpl<$Res>
    implements $GalleryManagementOperationPlanCopyWith<$Res> {
  _$GalleryManagementOperationPlanCopyWithImpl(this._self, this._then);

  final GalleryManagementOperationPlan _self;
  final $Res Function(GalleryManagementOperationPlan) _then;

  /// Create a copy of GalleryManagementOperationPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? snapshot = null,
    Object? items = null,
    Object? requests = null,
  }) {
    return _then(
      GalleryManagementOperationPlan(
        action: null == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as GalleryMutation,
        snapshot: null == snapshot
            ? _self.snapshot
            : snapshot // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementSnapshot,
        items: null == items
            ? _self.items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryMediaRef>,
        requests: null == requests
            ? _self.requests
            : requests // ignore: cast_nullable_to_non_nullable
                  as List<GalleryOperationRequest>,
      ),
    );
  }

  /// Create a copy of GalleryManagementOperationPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryManagementSnapshotCopyWith<$Res> get snapshot {
    return $GalleryManagementSnapshotCopyWith<$Res>(_self.snapshot, (value) {
      return _then(_self.copyWith(snapshot: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryManagementOperationPlan].
extension GalleryManagementOperationPlanPatterns
    on GalleryManagementOperationPlan {
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
    TResult Function(_GalleryManagementOperationPlan value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementOperationPlan() when $default != null:
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
    TResult Function(_GalleryManagementOperationPlan value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementOperationPlan():
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
    TResult? Function(_GalleryManagementOperationPlan value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementOperationPlan() when $default != null:
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
      GalleryMutation action,
      GalleryManagementSnapshot snapshot,
      List<GalleryMediaRef> items,
      List<GalleryOperationRequest> requests,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementOperationPlan() when $default != null:
        return $default(
          _that.action,
          _that.snapshot,
          _that.items,
          _that.requests,
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
      GalleryMutation action,
      GalleryManagementSnapshot snapshot,
      List<GalleryMediaRef> items,
      List<GalleryOperationRequest> requests,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementOperationPlan():
        return $default(
          _that.action,
          _that.snapshot,
          _that.items,
          _that.requests,
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
      GalleryMutation action,
      GalleryManagementSnapshot snapshot,
      List<GalleryMediaRef> items,
      List<GalleryOperationRequest> requests,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementOperationPlan() when $default != null:
        return $default(
          _that.action,
          _that.snapshot,
          _that.items,
          _that.requests,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryManagementOperationPlan
    implements GalleryManagementOperationPlan {
  const _GalleryManagementOperationPlan({
    required this.action,
    required this.snapshot,
    required List<GalleryMediaRef> items,
    required List<GalleryOperationRequest> requests,
  }) : _items = items,
       _requests = requests;

  @override
  final GalleryMutation action;
  @override
  final GalleryManagementSnapshot snapshot;
  final List<GalleryMediaRef> _items;
  @override
  List<GalleryMediaRef> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<GalleryOperationRequest> _requests;
  @override
  List<GalleryOperationRequest> get requests {
    if (_requests is EqualUnmodifiableListView) return _requests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requests);
  }

  /// Create a copy of GalleryManagementOperationPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryManagementOperationPlanCopyWith<_GalleryManagementOperationPlan>
  get copyWith =>
      __$GalleryManagementOperationPlanCopyWithImpl<
        _GalleryManagementOperationPlan
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryManagementOperationPlan &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.snapshot, snapshot) ||
                other.snapshot == snapshot) &&
            const DeepCollectionEquality().equals(other.items, _items) &&
            const DeepCollectionEquality().equals(other.requests, _requests));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      action,
      snapshot,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_requests),
    );
  }

  @override
  String toString() {
    return 'GalleryManagementOperationPlan(action: $action, snapshot: $snapshot, items: $items, requests: $requests)';
  }
}

/// @nodoc
abstract mixin class _$GalleryManagementOperationPlanCopyWith<$Res>
    implements $GalleryManagementOperationPlanCopyWith<$Res> {
  factory _$GalleryManagementOperationPlanCopyWith(
    _GalleryManagementOperationPlan value,
    $Res Function(_GalleryManagementOperationPlan) _then,
  ) = __$GalleryManagementOperationPlanCopyWithImpl;
  @override
  @useResult
  $Res call({
    GalleryMutation action,
    GalleryManagementSnapshot snapshot,
    List<GalleryMediaRef> items,
    List<GalleryOperationRequest> requests,
  });

  @override
  $GalleryManagementSnapshotCopyWith<$Res> get snapshot;
}

/// @nodoc
class __$GalleryManagementOperationPlanCopyWithImpl<$Res>
    implements _$GalleryManagementOperationPlanCopyWith<$Res> {
  __$GalleryManagementOperationPlanCopyWithImpl(this._self, this._then);

  final _GalleryManagementOperationPlan _self;
  final $Res Function(_GalleryManagementOperationPlan) _then;

  /// Create a copy of GalleryManagementOperationPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? action = null,
    Object? snapshot = null,
    Object? items = null,
    Object? requests = null,
  }) {
    return _then(
      _GalleryManagementOperationPlan(
        action: null == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as GalleryMutation,
        snapshot: null == snapshot
            ? _self.snapshot
            : snapshot // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementSnapshot,
        items: null == items
            ? _self._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryMediaRef>,
        requests: null == requests
            ? _self._requests
            : requests // ignore: cast_nullable_to_non_nullable
                  as List<GalleryOperationRequest>,
      ),
    );
  }

  /// Create a copy of GalleryManagementOperationPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryManagementSnapshotCopyWith<$Res> get snapshot {
    return $GalleryManagementSnapshotCopyWith<$Res>(_self.snapshot, (value) {
      return _then(_self.copyWith(snapshot: value));
    });
  }
}

/// @nodoc
mixin _$GalleryManagementState {
  GallerySection get section;
  GalleryManagementSnapshot get snapshot;
  Set<String> get selectedIds;
  Set<GalleryCapability> get capabilities;
  GalleryManagementLoadStatus get catalogStatus;
  bool get catalogRefreshing;
  bool get catalogRefreshFailed;
  GalleryTrashCatalog? get trash;
  bool get trashLoading;
  bool get trashFailed;
  bool get busy;
  GalleryMutationConfirmation? get confirmation;
  GalleryOperationRequest? get pendingOperation;
  GalleryManagementOperationPlan? get operationPlan;
  int get completedBatches;
  int get processedItems;
  int get succeededItems;
  GalleryOperationResult? get lastResult;
  List<GalleryOperationItemResult> get failures;
  GalleryManagementSnapshot? get failureSnapshot;
  GalleryManagementNotice get notice;
  int get noticeSerial;
  GalleryErrorCode? get error;

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryManagementStateCopyWith<GalleryManagementState> get copyWith =>
      _$GalleryManagementStateCopyWithImpl<GalleryManagementState>(
        this as GalleryManagementState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryManagementState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryManagementState &&
            (identical(other.section, _this.section) ||
                other.section == _this.section) &&
            (identical(other.snapshot, _this.snapshot) ||
                other.snapshot == _this.snapshot) &&
            const DeepCollectionEquality().equals(
              other.selectedIds,
              _this.selectedIds,
            ) &&
            const DeepCollectionEquality().equals(
              other.capabilities,
              _this.capabilities,
            ) &&
            (identical(other.catalogStatus, _this.catalogStatus) ||
                other.catalogStatus == _this.catalogStatus) &&
            (identical(other.catalogRefreshing, _this.catalogRefreshing) ||
                other.catalogRefreshing == _this.catalogRefreshing) &&
            (identical(
                  other.catalogRefreshFailed,
                  _this.catalogRefreshFailed,
                ) ||
                other.catalogRefreshFailed == _this.catalogRefreshFailed) &&
            (identical(other.trash, _this.trash) ||
                other.trash == _this.trash) &&
            (identical(other.trashLoading, _this.trashLoading) ||
                other.trashLoading == _this.trashLoading) &&
            (identical(other.trashFailed, _this.trashFailed) ||
                other.trashFailed == _this.trashFailed) &&
            (identical(other.busy, _this.busy) || other.busy == _this.busy) &&
            (identical(other.confirmation, _this.confirmation) ||
                other.confirmation == _this.confirmation) &&
            (identical(other.pendingOperation, _this.pendingOperation) ||
                other.pendingOperation == _this.pendingOperation) &&
            (identical(other.operationPlan, _this.operationPlan) ||
                other.operationPlan == _this.operationPlan) &&
            (identical(other.completedBatches, _this.completedBatches) ||
                other.completedBatches == _this.completedBatches) &&
            (identical(other.processedItems, _this.processedItems) ||
                other.processedItems == _this.processedItems) &&
            (identical(other.succeededItems, _this.succeededItems) ||
                other.succeededItems == _this.succeededItems) &&
            (identical(other.lastResult, _this.lastResult) ||
                other.lastResult == _this.lastResult) &&
            const DeepCollectionEquality().equals(
              other.failures,
              _this.failures,
            ) &&
            (identical(other.failureSnapshot, _this.failureSnapshot) ||
                other.failureSnapshot == _this.failureSnapshot) &&
            (identical(other.notice, _this.notice) ||
                other.notice == _this.notice) &&
            (identical(other.noticeSerial, _this.noticeSerial) ||
                other.noticeSerial == _this.noticeSerial) &&
            (identical(other.error, _this.error) ||
                other.error == _this.error));
  }

  @override
  int get hashCode {
    final _this = this as GalleryManagementState;
    return Object.hashAll([
      runtimeType,
      _this.section,
      _this.snapshot,
      const DeepCollectionEquality().hash(_this.selectedIds),
      const DeepCollectionEquality().hash(_this.capabilities),
      _this.catalogStatus,
      _this.catalogRefreshing,
      _this.catalogRefreshFailed,
      _this.trash,
      _this.trashLoading,
      _this.trashFailed,
      _this.busy,
      _this.confirmation,
      _this.pendingOperation,
      _this.operationPlan,
      _this.completedBatches,
      _this.processedItems,
      _this.succeededItems,
      _this.lastResult,
      const DeepCollectionEquality().hash(_this.failures),
      _this.failureSnapshot,
      _this.notice,
      _this.noticeSerial,
      _this.error,
    ]);
  }

  @override
  String toString() {
    final _this = this as GalleryManagementState;
    return 'GalleryManagementState(section: ${_this.section}, snapshot: ${_this.snapshot}, selectedIds: ${_this.selectedIds}, capabilities: ${_this.capabilities}, catalogStatus: ${_this.catalogStatus}, catalogRefreshing: ${_this.catalogRefreshing}, catalogRefreshFailed: ${_this.catalogRefreshFailed}, trash: ${_this.trash}, trashLoading: ${_this.trashLoading}, trashFailed: ${_this.trashFailed}, busy: ${_this.busy}, confirmation: ${_this.confirmation}, pendingOperation: ${_this.pendingOperation}, operationPlan: ${_this.operationPlan}, completedBatches: ${_this.completedBatches}, processedItems: ${_this.processedItems}, succeededItems: ${_this.succeededItems}, lastResult: ${_this.lastResult}, failures: ${_this.failures}, failureSnapshot: ${_this.failureSnapshot}, notice: ${_this.notice}, noticeSerial: ${_this.noticeSerial}, error: ${_this.error})';
  }
}

/// @nodoc
abstract mixin class $GalleryManagementStateCopyWith<$Res> {
  factory $GalleryManagementStateCopyWith(
    GalleryManagementState value,
    $Res Function(GalleryManagementState) _then,
  ) = _$GalleryManagementStateCopyWithImpl;
  @useResult
  $Res call({
    GallerySection section,
    GalleryManagementSnapshot snapshot,
    Set<String> selectedIds,
    Set<GalleryCapability> capabilities,
    GalleryManagementLoadStatus catalogStatus,
    bool catalogRefreshing,
    bool catalogRefreshFailed,
    GalleryTrashCatalog? trash,
    bool trashLoading,
    bool trashFailed,
    bool busy,
    GalleryMutationConfirmation? confirmation,
    GalleryOperationRequest? pendingOperation,
    GalleryManagementOperationPlan? operationPlan,
    int completedBatches,
    int processedItems,
    int succeededItems,
    GalleryOperationResult? lastResult,
    List<GalleryOperationItemResult> failures,
    GalleryManagementSnapshot? failureSnapshot,
    GalleryManagementNotice notice,
    int noticeSerial,
    GalleryErrorCode? error,
  });

  $GalleryManagementSnapshotCopyWith<$Res> get snapshot;
  $GalleryTrashCatalogCopyWith<$Res>? get trash;
  $GalleryMutationConfirmationCopyWith<$Res>? get confirmation;
  $GalleryOperationRequestCopyWith<$Res>? get pendingOperation;
  $GalleryManagementOperationPlanCopyWith<$Res>? get operationPlan;
  $GalleryOperationResultCopyWith<$Res>? get lastResult;
  $GalleryManagementSnapshotCopyWith<$Res>? get failureSnapshot;
}

/// @nodoc
class _$GalleryManagementStateCopyWithImpl<$Res>
    implements $GalleryManagementStateCopyWith<$Res> {
  _$GalleryManagementStateCopyWithImpl(this._self, this._then);

  final GalleryManagementState _self;
  final $Res Function(GalleryManagementState) _then;

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? section = null,
    Object? snapshot = null,
    Object? selectedIds = null,
    Object? capabilities = null,
    Object? catalogStatus = null,
    Object? catalogRefreshing = null,
    Object? catalogRefreshFailed = null,
    Object? trash = freezed,
    Object? trashLoading = null,
    Object? trashFailed = null,
    Object? busy = null,
    Object? confirmation = freezed,
    Object? pendingOperation = freezed,
    Object? operationPlan = freezed,
    Object? completedBatches = null,
    Object? processedItems = null,
    Object? succeededItems = null,
    Object? lastResult = freezed,
    Object? failures = null,
    Object? failureSnapshot = freezed,
    Object? notice = null,
    Object? noticeSerial = null,
    Object? error = freezed,
  }) {
    return _then(
      GalleryManagementState(
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GallerySection,
        snapshot: null == snapshot
            ? _self.snapshot
            : snapshot // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementSnapshot,
        selectedIds: null == selectedIds
            ? _self.selectedIds
            : selectedIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        capabilities: null == capabilities
            ? _self.capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as Set<GalleryCapability>,
        catalogStatus: null == catalogStatus
            ? _self.catalogStatus
            : catalogStatus // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementLoadStatus,
        catalogRefreshing: null == catalogRefreshing
            ? _self.catalogRefreshing
            : catalogRefreshing // ignore: cast_nullable_to_non_nullable
                  as bool,
        catalogRefreshFailed: null == catalogRefreshFailed
            ? _self.catalogRefreshFailed
            : catalogRefreshFailed // ignore: cast_nullable_to_non_nullable
                  as bool,
        trash: freezed == trash
            ? _self.trash
            : trash // ignore: cast_nullable_to_non_nullable
                  as GalleryTrashCatalog?,
        trashLoading: null == trashLoading
            ? _self.trashLoading
            : trashLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        trashFailed: null == trashFailed
            ? _self.trashFailed
            : trashFailed // ignore: cast_nullable_to_non_nullable
                  as bool,
        busy: null == busy
            ? _self.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        confirmation: freezed == confirmation
            ? _self.confirmation
            : confirmation // ignore: cast_nullable_to_non_nullable
                  as GalleryMutationConfirmation?,
        pendingOperation: freezed == pendingOperation
            ? _self.pendingOperation
            : pendingOperation // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationRequest?,
        operationPlan: freezed == operationPlan
            ? _self.operationPlan
            : operationPlan // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementOperationPlan?,
        completedBatches: null == completedBatches
            ? _self.completedBatches
            : completedBatches // ignore: cast_nullable_to_non_nullable
                  as int,
        processedItems: null == processedItems
            ? _self.processedItems
            : processedItems // ignore: cast_nullable_to_non_nullable
                  as int,
        succeededItems: null == succeededItems
            ? _self.succeededItems
            : succeededItems // ignore: cast_nullable_to_non_nullable
                  as int,
        lastResult: freezed == lastResult
            ? _self.lastResult
            : lastResult // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationResult?,
        failures: null == failures
            ? _self.failures
            : failures // ignore: cast_nullable_to_non_nullable
                  as List<GalleryOperationItemResult>,
        failureSnapshot: freezed == failureSnapshot
            ? _self.failureSnapshot
            : failureSnapshot // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementSnapshot?,
        notice: null == notice
            ? _self.notice
            : notice // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementNotice,
        noticeSerial: null == noticeSerial
            ? _self.noticeSerial
            : noticeSerial // ignore: cast_nullable_to_non_nullable
                  as int,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
      ),
    );
  }

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryManagementSnapshotCopyWith<$Res> get snapshot {
    return $GalleryManagementSnapshotCopyWith<$Res>(_self.snapshot, (value) {
      return _then(_self.copyWith(snapshot: value));
    });
  }

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryTrashCatalogCopyWith<$Res>? get trash {
    if (_self.trash == null) {
      return null;
    }

    return $GalleryTrashCatalogCopyWith<$Res>(_self.trash!, (value) {
      return _then(_self.copyWith(trash: value));
    });
  }

  /// Create a copy of GalleryManagementState
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

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationRequestCopyWith<$Res>? get pendingOperation {
    if (_self.pendingOperation == null) {
      return null;
    }

    return $GalleryOperationRequestCopyWith<$Res>(_self.pendingOperation!, (
      value,
    ) {
      return _then(_self.copyWith(pendingOperation: value));
    });
  }

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryManagementOperationPlanCopyWith<$Res>? get operationPlan {
    if (_self.operationPlan == null) {
      return null;
    }

    return $GalleryManagementOperationPlanCopyWith<$Res>(_self.operationPlan!, (
      value,
    ) {
      return _then(_self.copyWith(operationPlan: value));
    });
  }

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationResultCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
      return null;
    }

    return $GalleryOperationResultCopyWith<$Res>(_self.lastResult!, (value) {
      return _then(_self.copyWith(lastResult: value));
    });
  }

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryManagementSnapshotCopyWith<$Res>? get failureSnapshot {
    if (_self.failureSnapshot == null) {
      return null;
    }

    return $GalleryManagementSnapshotCopyWith<$Res>(_self.failureSnapshot!, (
      value,
    ) {
      return _then(_self.copyWith(failureSnapshot: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryManagementState].
extension GalleryManagementStatePatterns on GalleryManagementState {
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
    TResult Function(_GalleryManagementState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementState() when $default != null:
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
    TResult Function(_GalleryManagementState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementState():
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
    TResult? Function(_GalleryManagementState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementState() when $default != null:
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
      GallerySection section,
      GalleryManagementSnapshot snapshot,
      Set<String> selectedIds,
      Set<GalleryCapability> capabilities,
      GalleryManagementLoadStatus catalogStatus,
      bool catalogRefreshing,
      bool catalogRefreshFailed,
      GalleryTrashCatalog? trash,
      bool trashLoading,
      bool trashFailed,
      bool busy,
      GalleryMutationConfirmation? confirmation,
      GalleryOperationRequest? pendingOperation,
      GalleryManagementOperationPlan? operationPlan,
      int completedBatches,
      int processedItems,
      int succeededItems,
      GalleryOperationResult? lastResult,
      List<GalleryOperationItemResult> failures,
      GalleryManagementSnapshot? failureSnapshot,
      GalleryManagementNotice notice,
      int noticeSerial,
      GalleryErrorCode? error,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementState() when $default != null:
        return $default(
          _that.section,
          _that.snapshot,
          _that.selectedIds,
          _that.capabilities,
          _that.catalogStatus,
          _that.catalogRefreshing,
          _that.catalogRefreshFailed,
          _that.trash,
          _that.trashLoading,
          _that.trashFailed,
          _that.busy,
          _that.confirmation,
          _that.pendingOperation,
          _that.operationPlan,
          _that.completedBatches,
          _that.processedItems,
          _that.succeededItems,
          _that.lastResult,
          _that.failures,
          _that.failureSnapshot,
          _that.notice,
          _that.noticeSerial,
          _that.error,
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
      GallerySection section,
      GalleryManagementSnapshot snapshot,
      Set<String> selectedIds,
      Set<GalleryCapability> capabilities,
      GalleryManagementLoadStatus catalogStatus,
      bool catalogRefreshing,
      bool catalogRefreshFailed,
      GalleryTrashCatalog? trash,
      bool trashLoading,
      bool trashFailed,
      bool busy,
      GalleryMutationConfirmation? confirmation,
      GalleryOperationRequest? pendingOperation,
      GalleryManagementOperationPlan? operationPlan,
      int completedBatches,
      int processedItems,
      int succeededItems,
      GalleryOperationResult? lastResult,
      List<GalleryOperationItemResult> failures,
      GalleryManagementSnapshot? failureSnapshot,
      GalleryManagementNotice notice,
      int noticeSerial,
      GalleryErrorCode? error,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementState():
        return $default(
          _that.section,
          _that.snapshot,
          _that.selectedIds,
          _that.capabilities,
          _that.catalogStatus,
          _that.catalogRefreshing,
          _that.catalogRefreshFailed,
          _that.trash,
          _that.trashLoading,
          _that.trashFailed,
          _that.busy,
          _that.confirmation,
          _that.pendingOperation,
          _that.operationPlan,
          _that.completedBatches,
          _that.processedItems,
          _that.succeededItems,
          _that.lastResult,
          _that.failures,
          _that.failureSnapshot,
          _that.notice,
          _that.noticeSerial,
          _that.error,
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
      GallerySection section,
      GalleryManagementSnapshot snapshot,
      Set<String> selectedIds,
      Set<GalleryCapability> capabilities,
      GalleryManagementLoadStatus catalogStatus,
      bool catalogRefreshing,
      bool catalogRefreshFailed,
      GalleryTrashCatalog? trash,
      bool trashLoading,
      bool trashFailed,
      bool busy,
      GalleryMutationConfirmation? confirmation,
      GalleryOperationRequest? pendingOperation,
      GalleryManagementOperationPlan? operationPlan,
      int completedBatches,
      int processedItems,
      int succeededItems,
      GalleryOperationResult? lastResult,
      List<GalleryOperationItemResult> failures,
      GalleryManagementSnapshot? failureSnapshot,
      GalleryManagementNotice notice,
      int noticeSerial,
      GalleryErrorCode? error,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryManagementState() when $default != null:
        return $default(
          _that.section,
          _that.snapshot,
          _that.selectedIds,
          _that.capabilities,
          _that.catalogStatus,
          _that.catalogRefreshing,
          _that.catalogRefreshFailed,
          _that.trash,
          _that.trashLoading,
          _that.trashFailed,
          _that.busy,
          _that.confirmation,
          _that.pendingOperation,
          _that.operationPlan,
          _that.completedBatches,
          _that.processedItems,
          _that.succeededItems,
          _that.lastResult,
          _that.failures,
          _that.failureSnapshot,
          _that.notice,
          _that.noticeSerial,
          _that.error,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryManagementState extends GalleryManagementState {
  const _GalleryManagementState({
    this.section = GallerySection.library,
    this.snapshot = const GalleryManagementSnapshot(),
    Set<String> selectedIds = const {},
    Set<GalleryCapability> capabilities = const {},
    this.catalogStatus = GalleryManagementLoadStatus.loading,
    this.catalogRefreshing = false,
    this.catalogRefreshFailed = false,
    this.trash,
    this.trashLoading = false,
    this.trashFailed = false,
    this.busy = false,
    this.confirmation,
    this.pendingOperation,
    this.operationPlan,
    this.completedBatches = 0,
    this.processedItems = 0,
    this.succeededItems = 0,
    this.lastResult,
    List<GalleryOperationItemResult> failures = const [],
    this.failureSnapshot,
    this.notice = GalleryManagementNotice.none,
    this.noticeSerial = 0,
    this.error,
  }) : _selectedIds = selectedIds,
       _capabilities = capabilities,
       _failures = failures,
       super._();

  @override
  @JsonKey()
  final GallerySection section;
  @override
  @JsonKey()
  final GalleryManagementSnapshot snapshot;
  final Set<String> _selectedIds;
  @override
  @JsonKey()
  Set<String> get selectedIds {
    if (_selectedIds is EqualUnmodifiableSetView) return _selectedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedIds);
  }

  final Set<GalleryCapability> _capabilities;
  @override
  @JsonKey()
  Set<GalleryCapability> get capabilities {
    if (_capabilities is EqualUnmodifiableSetView) return _capabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_capabilities);
  }

  @override
  @JsonKey()
  final GalleryManagementLoadStatus catalogStatus;
  @override
  @JsonKey()
  final bool catalogRefreshing;
  @override
  @JsonKey()
  final bool catalogRefreshFailed;
  @override
  final GalleryTrashCatalog? trash;
  @override
  @JsonKey()
  final bool trashLoading;
  @override
  @JsonKey()
  final bool trashFailed;
  @override
  @JsonKey()
  final bool busy;
  @override
  final GalleryMutationConfirmation? confirmation;
  @override
  final GalleryOperationRequest? pendingOperation;
  @override
  final GalleryManagementOperationPlan? operationPlan;
  @override
  @JsonKey()
  final int completedBatches;
  @override
  @JsonKey()
  final int processedItems;
  @override
  @JsonKey()
  final int succeededItems;
  @override
  final GalleryOperationResult? lastResult;
  final List<GalleryOperationItemResult> _failures;
  @override
  @JsonKey()
  List<GalleryOperationItemResult> get failures {
    if (_failures is EqualUnmodifiableListView) return _failures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_failures);
  }

  @override
  final GalleryManagementSnapshot? failureSnapshot;
  @override
  @JsonKey()
  final GalleryManagementNotice notice;
  @override
  @JsonKey()
  final int noticeSerial;
  @override
  final GalleryErrorCode? error;

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryManagementStateCopyWith<_GalleryManagementState> get copyWith =>
      __$GalleryManagementStateCopyWithImpl<_GalleryManagementState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryManagementState &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.snapshot, snapshot) ||
                other.snapshot == snapshot) &&
            const DeepCollectionEquality().equals(
              other.selectedIds,
              _selectedIds,
            ) &&
            const DeepCollectionEquality().equals(
              other.capabilities,
              _capabilities,
            ) &&
            (identical(other.catalogStatus, catalogStatus) ||
                other.catalogStatus == catalogStatus) &&
            (identical(other.catalogRefreshing, catalogRefreshing) ||
                other.catalogRefreshing == catalogRefreshing) &&
            (identical(other.catalogRefreshFailed, catalogRefreshFailed) ||
                other.catalogRefreshFailed == catalogRefreshFailed) &&
            (identical(other.trash, trash) || other.trash == trash) &&
            (identical(other.trashLoading, trashLoading) ||
                other.trashLoading == trashLoading) &&
            (identical(other.trashFailed, trashFailed) ||
                other.trashFailed == trashFailed) &&
            (identical(other.busy, busy) || other.busy == busy) &&
            (identical(other.confirmation, confirmation) ||
                other.confirmation == confirmation) &&
            (identical(other.pendingOperation, pendingOperation) ||
                other.pendingOperation == pendingOperation) &&
            (identical(other.operationPlan, operationPlan) ||
                other.operationPlan == operationPlan) &&
            (identical(other.completedBatches, completedBatches) ||
                other.completedBatches == completedBatches) &&
            (identical(other.processedItems, processedItems) ||
                other.processedItems == processedItems) &&
            (identical(other.succeededItems, succeededItems) ||
                other.succeededItems == succeededItems) &&
            (identical(other.lastResult, lastResult) ||
                other.lastResult == lastResult) &&
            const DeepCollectionEquality().equals(other.failures, _failures) &&
            (identical(other.failureSnapshot, failureSnapshot) ||
                other.failureSnapshot == failureSnapshot) &&
            (identical(other.notice, notice) || other.notice == notice) &&
            (identical(other.noticeSerial, noticeSerial) ||
                other.noticeSerial == noticeSerial) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      section,
      snapshot,
      const DeepCollectionEquality().hash(_selectedIds),
      const DeepCollectionEquality().hash(_capabilities),
      catalogStatus,
      catalogRefreshing,
      catalogRefreshFailed,
      trash,
      trashLoading,
      trashFailed,
      busy,
      confirmation,
      pendingOperation,
      operationPlan,
      completedBatches,
      processedItems,
      succeededItems,
      lastResult,
      const DeepCollectionEquality().hash(_failures),
      failureSnapshot,
      notice,
      noticeSerial,
      error,
    ]);
  }

  @override
  String toString() {
    return 'GalleryManagementState(section: $section, snapshot: $snapshot, selectedIds: $selectedIds, capabilities: $capabilities, catalogStatus: $catalogStatus, catalogRefreshing: $catalogRefreshing, catalogRefreshFailed: $catalogRefreshFailed, trash: $trash, trashLoading: $trashLoading, trashFailed: $trashFailed, busy: $busy, confirmation: $confirmation, pendingOperation: $pendingOperation, operationPlan: $operationPlan, completedBatches: $completedBatches, processedItems: $processedItems, succeededItems: $succeededItems, lastResult: $lastResult, failures: $failures, failureSnapshot: $failureSnapshot, notice: $notice, noticeSerial: $noticeSerial, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$GalleryManagementStateCopyWith<$Res>
    implements $GalleryManagementStateCopyWith<$Res> {
  factory _$GalleryManagementStateCopyWith(
    _GalleryManagementState value,
    $Res Function(_GalleryManagementState) _then,
  ) = __$GalleryManagementStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    GallerySection section,
    GalleryManagementSnapshot snapshot,
    Set<String> selectedIds,
    Set<GalleryCapability> capabilities,
    GalleryManagementLoadStatus catalogStatus,
    bool catalogRefreshing,
    bool catalogRefreshFailed,
    GalleryTrashCatalog? trash,
    bool trashLoading,
    bool trashFailed,
    bool busy,
    GalleryMutationConfirmation? confirmation,
    GalleryOperationRequest? pendingOperation,
    GalleryManagementOperationPlan? operationPlan,
    int completedBatches,
    int processedItems,
    int succeededItems,
    GalleryOperationResult? lastResult,
    List<GalleryOperationItemResult> failures,
    GalleryManagementSnapshot? failureSnapshot,
    GalleryManagementNotice notice,
    int noticeSerial,
    GalleryErrorCode? error,
  });

  @override
  $GalleryManagementSnapshotCopyWith<$Res> get snapshot;
  @override
  $GalleryTrashCatalogCopyWith<$Res>? get trash;
  @override
  $GalleryMutationConfirmationCopyWith<$Res>? get confirmation;
  @override
  $GalleryOperationRequestCopyWith<$Res>? get pendingOperation;
  @override
  $GalleryManagementOperationPlanCopyWith<$Res>? get operationPlan;
  @override
  $GalleryOperationResultCopyWith<$Res>? get lastResult;
  @override
  $GalleryManagementSnapshotCopyWith<$Res>? get failureSnapshot;
}

/// @nodoc
class __$GalleryManagementStateCopyWithImpl<$Res>
    implements _$GalleryManagementStateCopyWith<$Res> {
  __$GalleryManagementStateCopyWithImpl(this._self, this._then);

  final _GalleryManagementState _self;
  final $Res Function(_GalleryManagementState) _then;

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? section = null,
    Object? snapshot = null,
    Object? selectedIds = null,
    Object? capabilities = null,
    Object? catalogStatus = null,
    Object? catalogRefreshing = null,
    Object? catalogRefreshFailed = null,
    Object? trash = freezed,
    Object? trashLoading = null,
    Object? trashFailed = null,
    Object? busy = null,
    Object? confirmation = freezed,
    Object? pendingOperation = freezed,
    Object? operationPlan = freezed,
    Object? completedBatches = null,
    Object? processedItems = null,
    Object? succeededItems = null,
    Object? lastResult = freezed,
    Object? failures = null,
    Object? failureSnapshot = freezed,
    Object? notice = null,
    Object? noticeSerial = null,
    Object? error = freezed,
  }) {
    return _then(
      _GalleryManagementState(
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GallerySection,
        snapshot: null == snapshot
            ? _self.snapshot
            : snapshot // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementSnapshot,
        selectedIds: null == selectedIds
            ? _self._selectedIds
            : selectedIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        capabilities: null == capabilities
            ? _self._capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as Set<GalleryCapability>,
        catalogStatus: null == catalogStatus
            ? _self.catalogStatus
            : catalogStatus // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementLoadStatus,
        catalogRefreshing: null == catalogRefreshing
            ? _self.catalogRefreshing
            : catalogRefreshing // ignore: cast_nullable_to_non_nullable
                  as bool,
        catalogRefreshFailed: null == catalogRefreshFailed
            ? _self.catalogRefreshFailed
            : catalogRefreshFailed // ignore: cast_nullable_to_non_nullable
                  as bool,
        trash: freezed == trash
            ? _self.trash
            : trash // ignore: cast_nullable_to_non_nullable
                  as GalleryTrashCatalog?,
        trashLoading: null == trashLoading
            ? _self.trashLoading
            : trashLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        trashFailed: null == trashFailed
            ? _self.trashFailed
            : trashFailed // ignore: cast_nullable_to_non_nullable
                  as bool,
        busy: null == busy
            ? _self.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        confirmation: freezed == confirmation
            ? _self.confirmation
            : confirmation // ignore: cast_nullable_to_non_nullable
                  as GalleryMutationConfirmation?,
        pendingOperation: freezed == pendingOperation
            ? _self.pendingOperation
            : pendingOperation // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationRequest?,
        operationPlan: freezed == operationPlan
            ? _self.operationPlan
            : operationPlan // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementOperationPlan?,
        completedBatches: null == completedBatches
            ? _self.completedBatches
            : completedBatches // ignore: cast_nullable_to_non_nullable
                  as int,
        processedItems: null == processedItems
            ? _self.processedItems
            : processedItems // ignore: cast_nullable_to_non_nullable
                  as int,
        succeededItems: null == succeededItems
            ? _self.succeededItems
            : succeededItems // ignore: cast_nullable_to_non_nullable
                  as int,
        lastResult: freezed == lastResult
            ? _self.lastResult
            : lastResult // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationResult?,
        failures: null == failures
            ? _self._failures
            : failures // ignore: cast_nullable_to_non_nullable
                  as List<GalleryOperationItemResult>,
        failureSnapshot: freezed == failureSnapshot
            ? _self.failureSnapshot
            : failureSnapshot // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementSnapshot?,
        notice: null == notice
            ? _self.notice
            : notice // ignore: cast_nullable_to_non_nullable
                  as GalleryManagementNotice,
        noticeSerial: null == noticeSerial
            ? _self.noticeSerial
            : noticeSerial // ignore: cast_nullable_to_non_nullable
                  as int,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
      ),
    );
  }

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryManagementSnapshotCopyWith<$Res> get snapshot {
    return $GalleryManagementSnapshotCopyWith<$Res>(_self.snapshot, (value) {
      return _then(_self.copyWith(snapshot: value));
    });
  }

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryTrashCatalogCopyWith<$Res>? get trash {
    if (_self.trash == null) {
      return null;
    }

    return $GalleryTrashCatalogCopyWith<$Res>(_self.trash!, (value) {
      return _then(_self.copyWith(trash: value));
    });
  }

  /// Create a copy of GalleryManagementState
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

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationRequestCopyWith<$Res>? get pendingOperation {
    if (_self.pendingOperation == null) {
      return null;
    }

    return $GalleryOperationRequestCopyWith<$Res>(_self.pendingOperation!, (
      value,
    ) {
      return _then(_self.copyWith(pendingOperation: value));
    });
  }

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryManagementOperationPlanCopyWith<$Res>? get operationPlan {
    if (_self.operationPlan == null) {
      return null;
    }

    return $GalleryManagementOperationPlanCopyWith<$Res>(_self.operationPlan!, (
      value,
    ) {
      return _then(_self.copyWith(operationPlan: value));
    });
  }

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationResultCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
      return null;
    }

    return $GalleryOperationResultCopyWith<$Res>(_self.lastResult!, (value) {
      return _then(_self.copyWith(lastResult: value));
    });
  }

  /// Create a copy of GalleryManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryManagementSnapshotCopyWith<$Res>? get failureSnapshot {
    if (_self.failureSnapshot == null) {
      return null;
    }

    return $GalleryManagementSnapshotCopyWith<$Res>(_self.failureSnapshot!, (
      value,
    ) {
      return _then(_self.copyWith(failureSnapshot: value));
    });
  }
}
