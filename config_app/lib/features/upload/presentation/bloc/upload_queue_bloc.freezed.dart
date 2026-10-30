// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_queue_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadQueueState {
  List<UploadTask> get tasks;
  Map<String, double> get activeProgress;
  int get taskRevision;
  bool get isScanningFolder;
  bool get isSelecting;
  UploadSelectionIssue? get selectionIssue;
  int get selectionRevision;

  /// Create a copy of UploadQueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UploadQueueStateCopyWith<UploadQueueState> get copyWith =>
      _$UploadQueueStateCopyWithImpl<UploadQueueState>(this as UploadQueueState, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as UploadQueueState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UploadQueueState &&
            const DeepCollectionEquality().equals(other.tasks, _this.tasks) &&
            const DeepCollectionEquality().equals(other.activeProgress, _this.activeProgress) &&
            (identical(other.taskRevision, _this.taskRevision) || other.taskRevision == _this.taskRevision) &&
            (identical(other.isScanningFolder, _this.isScanningFolder) ||
                other.isScanningFolder == _this.isScanningFolder) &&
            (identical(other.isSelecting, _this.isSelecting) || other.isSelecting == _this.isSelecting) &&
            (identical(other.selectionIssue, _this.selectionIssue) || other.selectionIssue == _this.selectionIssue) &&
            (identical(other.selectionRevision, _this.selectionRevision) ||
                other.selectionRevision == _this.selectionRevision));
  }

  @override
  int get hashCode {
    final _this = this as UploadQueueState;
    return Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_this.tasks),
      const DeepCollectionEquality().hash(_this.activeProgress),
      _this.taskRevision,
      _this.isScanningFolder,
      _this.isSelecting,
      _this.selectionIssue,
      _this.selectionRevision,
    );
  }

  @override
  String toString() {
    final _this = this as UploadQueueState;
    return 'UploadQueueState(tasks: ${_this.tasks}, activeProgress: ${_this.activeProgress}, taskRevision: ${_this.taskRevision}, isScanningFolder: ${_this.isScanningFolder}, isSelecting: ${_this.isSelecting}, selectionIssue: ${_this.selectionIssue}, selectionRevision: ${_this.selectionRevision})';
  }
}

/// @nodoc
abstract mixin class $UploadQueueStateCopyWith<$Res> {
  factory $UploadQueueStateCopyWith(UploadQueueState value, $Res Function(UploadQueueState) _then) =
      _$UploadQueueStateCopyWithImpl;
  @useResult
  $Res call({
    List<UploadTask> tasks,
    Map<String, double> activeProgress,
    int taskRevision,
    bool isScanningFolder,
    bool isSelecting,
    UploadSelectionIssue? selectionIssue,
    int selectionRevision,
  });
}

/// @nodoc
class _$UploadQueueStateCopyWithImpl<$Res> implements $UploadQueueStateCopyWith<$Res> {
  _$UploadQueueStateCopyWithImpl(this._self, this._then);

  final UploadQueueState _self;
  final $Res Function(UploadQueueState) _then;

  /// Create a copy of UploadQueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? activeProgress = null,
    Object? taskRevision = null,
    Object? isScanningFolder = null,
    Object? isSelecting = null,
    Object? selectionIssue = freezed,
    Object? selectionRevision = null,
  }) {
    return _then(
      UploadQueueState(
        tasks: null == tasks
            ? _self.tasks
            : tasks // ignore: cast_nullable_to_non_nullable
                  as List<UploadTask>,
        activeProgress: null == activeProgress
            ? _self.activeProgress
            : activeProgress // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        taskRevision: null == taskRevision
            ? _self.taskRevision
            : taskRevision // ignore: cast_nullable_to_non_nullable
                  as int,
        isScanningFolder: null == isScanningFolder
            ? _self.isScanningFolder
            : isScanningFolder // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSelecting: null == isSelecting
            ? _self.isSelecting
            : isSelecting // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectionIssue: freezed == selectionIssue
            ? _self.selectionIssue
            : selectionIssue // ignore: cast_nullable_to_non_nullable
                  as UploadSelectionIssue?,
        selectionRevision: null == selectionRevision
            ? _self.selectionRevision
            : selectionRevision // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [UploadQueueState].
extension UploadQueueStatePatterns on UploadQueueState {
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
    TResult Function(_UploadQueueState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UploadQueueState() when $default != null:
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
  TResult map<TResult extends Object?>(TResult Function(_UploadQueueState value) $default) {
    final _that = this;
    switch (_that) {
      case _UploadQueueState():
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
  TResult? mapOrNull<TResult extends Object?>(TResult? Function(_UploadQueueState value)? $default) {
    final _that = this;
    switch (_that) {
      case _UploadQueueState() when $default != null:
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
      List<UploadTask> tasks,
      Map<String, double> activeProgress,
      int taskRevision,
      bool isScanningFolder,
      bool isSelecting,
      UploadSelectionIssue? selectionIssue,
      int selectionRevision,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UploadQueueState() when $default != null:
        return $default(
          _that.tasks,
          _that.activeProgress,
          _that.taskRevision,
          _that.isScanningFolder,
          _that.isSelecting,
          _that.selectionIssue,
          _that.selectionRevision,
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
      List<UploadTask> tasks,
      Map<String, double> activeProgress,
      int taskRevision,
      bool isScanningFolder,
      bool isSelecting,
      UploadSelectionIssue? selectionIssue,
      int selectionRevision,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadQueueState():
        return $default(
          _that.tasks,
          _that.activeProgress,
          _that.taskRevision,
          _that.isScanningFolder,
          _that.isSelecting,
          _that.selectionIssue,
          _that.selectionRevision,
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
      List<UploadTask> tasks,
      Map<String, double> activeProgress,
      int taskRevision,
      bool isScanningFolder,
      bool isSelecting,
      UploadSelectionIssue? selectionIssue,
      int selectionRevision,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadQueueState() when $default != null:
        return $default(
          _that.tasks,
          _that.activeProgress,
          _that.taskRevision,
          _that.isScanningFolder,
          _that.isSelecting,
          _that.selectionIssue,
          _that.selectionRevision,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UploadQueueState implements UploadQueueState {
  const _UploadQueueState({
    List<UploadTask> tasks = const [],
    Map<String, double> activeProgress = const {},
    this.taskRevision = 0,
    this.isScanningFolder = false,
    this.isSelecting = false,
    this.selectionIssue,
    this.selectionRevision = 0,
  }) : _tasks = tasks,
       _activeProgress = activeProgress;

  final List<UploadTask> _tasks;
  @override
  @JsonKey()
  List<UploadTask> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final Map<String, double> _activeProgress;
  @override
  @JsonKey()
  Map<String, double> get activeProgress {
    if (_activeProgress is EqualUnmodifiableMapView) return _activeProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_activeProgress);
  }

  @override
  @JsonKey()
  final int taskRevision;
  @override
  @JsonKey()
  final bool isScanningFolder;
  @override
  @JsonKey()
  final bool isSelecting;
  @override
  final UploadSelectionIssue? selectionIssue;
  @override
  @JsonKey()
  final int selectionRevision;

  /// Create a copy of UploadQueueState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UploadQueueStateCopyWith<_UploadQueueState> get copyWith =>
      __$UploadQueueStateCopyWithImpl<_UploadQueueState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UploadQueueState &&
            const DeepCollectionEquality().equals(other.tasks, _tasks) &&
            const DeepCollectionEquality().equals(other.activeProgress, _activeProgress) &&
            (identical(other.taskRevision, taskRevision) || other.taskRevision == taskRevision) &&
            (identical(other.isScanningFolder, isScanningFolder) || other.isScanningFolder == isScanningFolder) &&
            (identical(other.isSelecting, isSelecting) || other.isSelecting == isSelecting) &&
            (identical(other.selectionIssue, selectionIssue) || other.selectionIssue == selectionIssue) &&
            (identical(other.selectionRevision, selectionRevision) || other.selectionRevision == selectionRevision));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_activeProgress),
      taskRevision,
      isScanningFolder,
      isSelecting,
      selectionIssue,
      selectionRevision,
    );
  }

  @override
  String toString() {
    return 'UploadQueueState(tasks: $tasks, activeProgress: $activeProgress, taskRevision: $taskRevision, isScanningFolder: $isScanningFolder, isSelecting: $isSelecting, selectionIssue: $selectionIssue, selectionRevision: $selectionRevision)';
  }
}

/// @nodoc
abstract mixin class _$UploadQueueStateCopyWith<$Res> implements $UploadQueueStateCopyWith<$Res> {
  factory _$UploadQueueStateCopyWith(_UploadQueueState value, $Res Function(_UploadQueueState) _then) =
      __$UploadQueueStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    List<UploadTask> tasks,
    Map<String, double> activeProgress,
    int taskRevision,
    bool isScanningFolder,
    bool isSelecting,
    UploadSelectionIssue? selectionIssue,
    int selectionRevision,
  });
}

/// @nodoc
class __$UploadQueueStateCopyWithImpl<$Res> implements _$UploadQueueStateCopyWith<$Res> {
  __$UploadQueueStateCopyWithImpl(this._self, this._then);

  final _UploadQueueState _self;
  final $Res Function(_UploadQueueState) _then;

  /// Create a copy of UploadQueueState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tasks = null,
    Object? activeProgress = null,
    Object? taskRevision = null,
    Object? isScanningFolder = null,
    Object? isSelecting = null,
    Object? selectionIssue = freezed,
    Object? selectionRevision = null,
  }) {
    return _then(
      _UploadQueueState(
        tasks: null == tasks
            ? _self._tasks
            : tasks // ignore: cast_nullable_to_non_nullable
                  as List<UploadTask>,
        activeProgress: null == activeProgress
            ? _self._activeProgress
            : activeProgress // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        taskRevision: null == taskRevision
            ? _self.taskRevision
            : taskRevision // ignore: cast_nullable_to_non_nullable
                  as int,
        isScanningFolder: null == isScanningFolder
            ? _self.isScanningFolder
            : isScanningFolder // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSelecting: null == isSelecting
            ? _self.isSelecting
            : isSelecting // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectionIssue: freezed == selectionIssue
            ? _self.selectionIssue
            : selectionIssue // ignore: cast_nullable_to_non_nullable
                  as UploadSelectionIssue?,
        selectionRevision: null == selectionRevision
            ? _self.selectionRevision
            : selectionRevision // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
mixin _$UploadQueueEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is UploadQueueEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UploadQueueEvent()';
  }
}

/// @nodoc
class $UploadQueueEventCopyWith<$Res> {
  $UploadQueueEventCopyWith(UploadQueueEvent _, $Res Function(UploadQueueEvent) __);
}

/// Adds pattern-matching-related methods to [UploadQueueEvent].
extension UploadQueueEventPatterns on UploadQueueEvent {
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
    TResult Function(_Select value)? select,
    TResult Function(_AddFiles value)? addFiles,
    TResult Function(_AddPlatformFiles value)? addPlatformFiles,
    TResult Function(_AddFolder value)? addFolder,
    TResult Function(_RemoveTask value)? removeTask,
    TResult Function(_RetryTask value)? retryTask,
    TResult Function(_UpdateProgress value)? updateProgress,
    TResult Function(_TaskFinished value)? taskFinished,
    TResult Function(_FolderChunk value)? folderChunk,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Select() when select != null:
        return select(_that);
      case _AddFiles() when addFiles != null:
        return addFiles(_that);
      case _AddPlatformFiles() when addPlatformFiles != null:
        return addPlatformFiles(_that);
      case _AddFolder() when addFolder != null:
        return addFolder(_that);
      case _RemoveTask() when removeTask != null:
        return removeTask(_that);
      case _RetryTask() when retryTask != null:
        return retryTask(_that);
      case _UpdateProgress() when updateProgress != null:
        return updateProgress(_that);
      case _TaskFinished() when taskFinished != null:
        return taskFinished(_that);
      case _FolderChunk() when folderChunk != null:
        return folderChunk(_that);
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
    required TResult Function(_Select value) select,
    required TResult Function(_AddFiles value) addFiles,
    required TResult Function(_AddPlatformFiles value) addPlatformFiles,
    required TResult Function(_AddFolder value) addFolder,
    required TResult Function(_RemoveTask value) removeTask,
    required TResult Function(_RetryTask value) retryTask,
    required TResult Function(_UpdateProgress value) updateProgress,
    required TResult Function(_TaskFinished value) taskFinished,
    required TResult Function(_FolderChunk value) folderChunk,
  }) {
    final _that = this;
    switch (_that) {
      case _Select():
        return select(_that);
      case _AddFiles():
        return addFiles(_that);
      case _AddPlatformFiles():
        return addPlatformFiles(_that);
      case _AddFolder():
        return addFolder(_that);
      case _RemoveTask():
        return removeTask(_that);
      case _RetryTask():
        return retryTask(_that);
      case _UpdateProgress():
        return updateProgress(_that);
      case _TaskFinished():
        return taskFinished(_that);
      case _FolderChunk():
        return folderChunk(_that);
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
    TResult? Function(_Select value)? select,
    TResult? Function(_AddFiles value)? addFiles,
    TResult? Function(_AddPlatformFiles value)? addPlatformFiles,
    TResult? Function(_AddFolder value)? addFolder,
    TResult? Function(_RemoveTask value)? removeTask,
    TResult? Function(_RetryTask value)? retryTask,
    TResult? Function(_UpdateProgress value)? updateProgress,
    TResult? Function(_TaskFinished value)? taskFinished,
    TResult? Function(_FolderChunk value)? folderChunk,
  }) {
    final _that = this;
    switch (_that) {
      case _Select() when select != null:
        return select(_that);
      case _AddFiles() when addFiles != null:
        return addFiles(_that);
      case _AddPlatformFiles() when addPlatformFiles != null:
        return addPlatformFiles(_that);
      case _AddFolder() when addFolder != null:
        return addFolder(_that);
      case _RemoveTask() when removeTask != null:
        return removeTask(_that);
      case _RetryTask() when retryTask != null:
        return retryTask(_that);
      case _UpdateProgress() when updateProgress != null:
        return updateProgress(_that);
      case _TaskFinished() when taskFinished != null:
        return taskFinished(_that);
      case _FolderChunk() when folderChunk != null:
        return folderChunk(_that);
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
    TResult Function(UploadSelectionKind kind)? select,
    TResult Function(List<File> files, String rootPath)? addFiles,
    TResult Function(List<PlatformFile> files, String rootPath)? addPlatformFiles,
    TResult Function(String path)? addFolder,
    TResult Function(String taskId)? removeTask,
    TResult Function(String taskId)? retryTask,
    TResult Function(String taskId, int attemptId, int sent, int total)? updateProgress,
    TResult Function(String taskId, int attemptId, UploadFailure? failure, bool cancelled)? taskFinished,
    TResult Function(int scanId, List<UploadFolderFile> files, bool finished, UploadSelectionIssue? issue)? folderChunk,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Select() when select != null:
        return select(_that.kind);
      case _AddFiles() when addFiles != null:
        return addFiles(_that.files, _that.rootPath);
      case _AddPlatformFiles() when addPlatformFiles != null:
        return addPlatformFiles(_that.files, _that.rootPath);
      case _AddFolder() when addFolder != null:
        return addFolder(_that.path);
      case _RemoveTask() when removeTask != null:
        return removeTask(_that.taskId);
      case _RetryTask() when retryTask != null:
        return retryTask(_that.taskId);
      case _UpdateProgress() when updateProgress != null:
        return updateProgress(_that.taskId, _that.attemptId, _that.sent, _that.total);
      case _TaskFinished() when taskFinished != null:
        return taskFinished(_that.taskId, _that.attemptId, _that.failure, _that.cancelled);
      case _FolderChunk() when folderChunk != null:
        return folderChunk(_that.scanId, _that.files, _that.finished, _that.issue);
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
    required TResult Function(UploadSelectionKind kind) select,
    required TResult Function(List<File> files, String rootPath) addFiles,
    required TResult Function(List<PlatformFile> files, String rootPath) addPlatformFiles,
    required TResult Function(String path) addFolder,
    required TResult Function(String taskId) removeTask,
    required TResult Function(String taskId) retryTask,
    required TResult Function(String taskId, int attemptId, int sent, int total) updateProgress,
    required TResult Function(String taskId, int attemptId, UploadFailure? failure, bool cancelled) taskFinished,
    required TResult Function(int scanId, List<UploadFolderFile> files, bool finished, UploadSelectionIssue? issue)
    folderChunk,
  }) {
    final _that = this;
    switch (_that) {
      case _Select():
        return select(_that.kind);
      case _AddFiles():
        return addFiles(_that.files, _that.rootPath);
      case _AddPlatformFiles():
        return addPlatformFiles(_that.files, _that.rootPath);
      case _AddFolder():
        return addFolder(_that.path);
      case _RemoveTask():
        return removeTask(_that.taskId);
      case _RetryTask():
        return retryTask(_that.taskId);
      case _UpdateProgress():
        return updateProgress(_that.taskId, _that.attemptId, _that.sent, _that.total);
      case _TaskFinished():
        return taskFinished(_that.taskId, _that.attemptId, _that.failure, _that.cancelled);
      case _FolderChunk():
        return folderChunk(_that.scanId, _that.files, _that.finished, _that.issue);
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
    TResult? Function(UploadSelectionKind kind)? select,
    TResult? Function(List<File> files, String rootPath)? addFiles,
    TResult? Function(List<PlatformFile> files, String rootPath)? addPlatformFiles,
    TResult? Function(String path)? addFolder,
    TResult? Function(String taskId)? removeTask,
    TResult? Function(String taskId)? retryTask,
    TResult? Function(String taskId, int attemptId, int sent, int total)? updateProgress,
    TResult? Function(String taskId, int attemptId, UploadFailure? failure, bool cancelled)? taskFinished,
    TResult? Function(int scanId, List<UploadFolderFile> files, bool finished, UploadSelectionIssue? issue)?
    folderChunk,
  }) {
    final _that = this;
    switch (_that) {
      case _Select() when select != null:
        return select(_that.kind);
      case _AddFiles() when addFiles != null:
        return addFiles(_that.files, _that.rootPath);
      case _AddPlatformFiles() when addPlatformFiles != null:
        return addPlatformFiles(_that.files, _that.rootPath);
      case _AddFolder() when addFolder != null:
        return addFolder(_that.path);
      case _RemoveTask() when removeTask != null:
        return removeTask(_that.taskId);
      case _RetryTask() when retryTask != null:
        return retryTask(_that.taskId);
      case _UpdateProgress() when updateProgress != null:
        return updateProgress(_that.taskId, _that.attemptId, _that.sent, _that.total);
      case _TaskFinished() when taskFinished != null:
        return taskFinished(_that.taskId, _that.attemptId, _that.failure, _that.cancelled);
      case _FolderChunk() when folderChunk != null:
        return folderChunk(_that.scanId, _that.files, _that.finished, _that.issue);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Select implements UploadQueueEvent {
  const _Select(this.kind);

  final UploadSelectionKind kind;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SelectCopyWith<_Select> get copyWith => __$SelectCopyWithImpl<_Select>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Select && (identical(other.kind, kind) || other.kind == kind));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, kind);
  }

  @override
  String toString() {
    return 'UploadQueueEvent.select(kind: $kind)';
  }
}

/// @nodoc
abstract mixin class _$SelectCopyWith<$Res> implements $UploadQueueEventCopyWith<$Res> {
  factory _$SelectCopyWith(_Select value, $Res Function(_Select) _then) = __$SelectCopyWithImpl;
  @useResult
  $Res call({UploadSelectionKind kind});
}

/// @nodoc
class __$SelectCopyWithImpl<$Res> implements _$SelectCopyWith<$Res> {
  __$SelectCopyWithImpl(this._self, this._then);

  final _Select _self;
  final $Res Function(_Select) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? kind = null}) {
    return _then(
      _Select(
        null == kind
            ? _self.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as UploadSelectionKind,
      ),
    );
  }
}

/// @nodoc

class _AddFiles implements UploadQueueEvent {
  const _AddFiles({required List<File> files, required this.rootPath}) : _files = files;

  final List<File> _files;
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  final String rootPath;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddFilesCopyWith<_AddFiles> get copyWith => __$AddFilesCopyWithImpl<_AddFiles>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddFiles &&
            const DeepCollectionEquality().equals(other.files, _files) &&
            (identical(other.rootPath, rootPath) || other.rootPath == rootPath));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, const DeepCollectionEquality().hash(_files), rootPath);
  }

  @override
  String toString() {
    return 'UploadQueueEvent.addFiles(files: $files, rootPath: $rootPath)';
  }
}

/// @nodoc
abstract mixin class _$AddFilesCopyWith<$Res> implements $UploadQueueEventCopyWith<$Res> {
  factory _$AddFilesCopyWith(_AddFiles value, $Res Function(_AddFiles) _then) = __$AddFilesCopyWithImpl;
  @useResult
  $Res call({List<File> files, String rootPath});
}

/// @nodoc
class __$AddFilesCopyWithImpl<$Res> implements _$AddFilesCopyWith<$Res> {
  __$AddFilesCopyWithImpl(this._self, this._then);

  final _AddFiles _self;
  final $Res Function(_AddFiles) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? files = null, Object? rootPath = null}) {
    return _then(
      _AddFiles(
        files: null == files
            ? _self._files
            : files // ignore: cast_nullable_to_non_nullable
                  as List<File>,
        rootPath: null == rootPath
            ? _self.rootPath
            : rootPath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _AddPlatformFiles implements UploadQueueEvent {
  const _AddPlatformFiles({required List<PlatformFile> files, required this.rootPath}) : _files = files;

  final List<PlatformFile> _files;
  List<PlatformFile> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  final String rootPath;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddPlatformFilesCopyWith<_AddPlatformFiles> get copyWith =>
      __$AddPlatformFilesCopyWithImpl<_AddPlatformFiles>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddPlatformFiles &&
            const DeepCollectionEquality().equals(other.files, _files) &&
            (identical(other.rootPath, rootPath) || other.rootPath == rootPath));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, const DeepCollectionEquality().hash(_files), rootPath);
  }

  @override
  String toString() {
    return 'UploadQueueEvent.addPlatformFiles(files: $files, rootPath: $rootPath)';
  }
}

/// @nodoc
abstract mixin class _$AddPlatformFilesCopyWith<$Res> implements $UploadQueueEventCopyWith<$Res> {
  factory _$AddPlatformFilesCopyWith(_AddPlatformFiles value, $Res Function(_AddPlatformFiles) _then) =
      __$AddPlatformFilesCopyWithImpl;
  @useResult
  $Res call({List<PlatformFile> files, String rootPath});
}

/// @nodoc
class __$AddPlatformFilesCopyWithImpl<$Res> implements _$AddPlatformFilesCopyWith<$Res> {
  __$AddPlatformFilesCopyWithImpl(this._self, this._then);

  final _AddPlatformFiles _self;
  final $Res Function(_AddPlatformFiles) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? files = null, Object? rootPath = null}) {
    return _then(
      _AddPlatformFiles(
        files: null == files
            ? _self._files
            : files // ignore: cast_nullable_to_non_nullable
                  as List<PlatformFile>,
        rootPath: null == rootPath
            ? _self.rootPath
            : rootPath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _AddFolder implements UploadQueueEvent {
  const _AddFolder(this.path);

  final String path;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddFolderCopyWith<_AddFolder> get copyWith => __$AddFolderCopyWithImpl<_AddFolder>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddFolder &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, path);
  }

  @override
  String toString() {
    return 'UploadQueueEvent.addFolder(path: $path)';
  }
}

/// @nodoc
abstract mixin class _$AddFolderCopyWith<$Res> implements $UploadQueueEventCopyWith<$Res> {
  factory _$AddFolderCopyWith(_AddFolder value, $Res Function(_AddFolder) _then) = __$AddFolderCopyWithImpl;
  @useResult
  $Res call({String path});
}

/// @nodoc
class __$AddFolderCopyWithImpl<$Res> implements _$AddFolderCopyWith<$Res> {
  __$AddFolderCopyWithImpl(this._self, this._then);

  final _AddFolder _self;
  final $Res Function(_AddFolder) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? path = null}) {
    return _then(
      _AddFolder(
        null == path
            ? _self.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _RemoveTask implements UploadQueueEvent {
  const _RemoveTask(this.taskId);

  final String taskId;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RemoveTaskCopyWith<_RemoveTask> get copyWith => __$RemoveTaskCopyWithImpl<_RemoveTask>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RemoveTask &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, taskId);
  }

  @override
  String toString() {
    return 'UploadQueueEvent.removeTask(taskId: $taskId)';
  }
}

/// @nodoc
abstract mixin class _$RemoveTaskCopyWith<$Res> implements $UploadQueueEventCopyWith<$Res> {
  factory _$RemoveTaskCopyWith(_RemoveTask value, $Res Function(_RemoveTask) _then) = __$RemoveTaskCopyWithImpl;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$RemoveTaskCopyWithImpl<$Res> implements _$RemoveTaskCopyWith<$Res> {
  __$RemoveTaskCopyWithImpl(this._self, this._then);

  final _RemoveTask _self;
  final $Res Function(_RemoveTask) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? taskId = null}) {
    return _then(
      _RemoveTask(
        null == taskId
            ? _self.taskId
            : taskId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _RetryTask implements UploadQueueEvent {
  const _RetryTask(this.taskId);

  final String taskId;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RetryTaskCopyWith<_RetryTask> get copyWith => __$RetryTaskCopyWithImpl<_RetryTask>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RetryTask &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, taskId);
  }

  @override
  String toString() {
    return 'UploadQueueEvent.retryTask(taskId: $taskId)';
  }
}

/// @nodoc
abstract mixin class _$RetryTaskCopyWith<$Res> implements $UploadQueueEventCopyWith<$Res> {
  factory _$RetryTaskCopyWith(_RetryTask value, $Res Function(_RetryTask) _then) = __$RetryTaskCopyWithImpl;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$RetryTaskCopyWithImpl<$Res> implements _$RetryTaskCopyWith<$Res> {
  __$RetryTaskCopyWithImpl(this._self, this._then);

  final _RetryTask _self;
  final $Res Function(_RetryTask) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? taskId = null}) {
    return _then(
      _RetryTask(
        null == taskId
            ? _self.taskId
            : taskId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _UpdateProgress implements UploadQueueEvent {
  const _UpdateProgress(this.taskId, this.attemptId, this.sent, this.total);

  final String taskId;
  final int attemptId;
  final int sent;
  final int total;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateProgressCopyWith<_UpdateProgress> get copyWith =>
      __$UpdateProgressCopyWithImpl<_UpdateProgress>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateProgress &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.attemptId, attemptId) || other.attemptId == attemptId) &&
            (identical(other.sent, sent) || other.sent == sent) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, taskId, attemptId, sent, total);
  }

  @override
  String toString() {
    return 'UploadQueueEvent.updateProgress(taskId: $taskId, attemptId: $attemptId, sent: $sent, total: $total)';
  }
}

/// @nodoc
abstract mixin class _$UpdateProgressCopyWith<$Res> implements $UploadQueueEventCopyWith<$Res> {
  factory _$UpdateProgressCopyWith(_UpdateProgress value, $Res Function(_UpdateProgress) _then) =
      __$UpdateProgressCopyWithImpl;
  @useResult
  $Res call({String taskId, int attemptId, int sent, int total});
}

/// @nodoc
class __$UpdateProgressCopyWithImpl<$Res> implements _$UpdateProgressCopyWith<$Res> {
  __$UpdateProgressCopyWithImpl(this._self, this._then);

  final _UpdateProgress _self;
  final $Res Function(_UpdateProgress) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? taskId = null, Object? attemptId = null, Object? sent = null, Object? total = null}) {
    return _then(
      _UpdateProgress(
        null == taskId
            ? _self.taskId
            : taskId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == attemptId
            ? _self.attemptId
            : attemptId // ignore: cast_nullable_to_non_nullable
                  as int,
        null == sent
            ? _self.sent
            : sent // ignore: cast_nullable_to_non_nullable
                  as int,
        null == total
            ? _self.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _TaskFinished implements UploadQueueEvent {
  const _TaskFinished(this.taskId, this.attemptId, this.failure, this.cancelled);

  final String taskId;
  final int attemptId;
  final UploadFailure? failure;
  final bool cancelled;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TaskFinishedCopyWith<_TaskFinished> get copyWith => __$TaskFinishedCopyWithImpl<_TaskFinished>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TaskFinished &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.attemptId, attemptId) || other.attemptId == attemptId) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.cancelled, cancelled) || other.cancelled == cancelled));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, taskId, attemptId, failure, cancelled);
  }

  @override
  String toString() {
    return 'UploadQueueEvent.taskFinished(taskId: $taskId, attemptId: $attemptId, failure: $failure, cancelled: $cancelled)';
  }
}

/// @nodoc
abstract mixin class _$TaskFinishedCopyWith<$Res> implements $UploadQueueEventCopyWith<$Res> {
  factory _$TaskFinishedCopyWith(_TaskFinished value, $Res Function(_TaskFinished) _then) = __$TaskFinishedCopyWithImpl;
  @useResult
  $Res call({String taskId, int attemptId, UploadFailure? failure, bool cancelled});
}

/// @nodoc
class __$TaskFinishedCopyWithImpl<$Res> implements _$TaskFinishedCopyWith<$Res> {
  __$TaskFinishedCopyWithImpl(this._self, this._then);

  final _TaskFinished _self;
  final $Res Function(_TaskFinished) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? taskId = null, Object? attemptId = null, Object? failure = freezed, Object? cancelled = null}) {
    return _then(
      _TaskFinished(
        null == taskId
            ? _self.taskId
            : taskId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == attemptId
            ? _self.attemptId
            : attemptId // ignore: cast_nullable_to_non_nullable
                  as int,
        freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as UploadFailure?,
        null == cancelled
            ? _self.cancelled
            : cancelled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _FolderChunk implements UploadQueueEvent {
  const _FolderChunk({required this.scanId, required List<UploadFolderFile> files, this.finished = false, this.issue})
    : _files = files;

  final int scanId;
  final List<UploadFolderFile> _files;
  List<UploadFolderFile> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey()
  final bool finished;
  final UploadSelectionIssue? issue;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FolderChunkCopyWith<_FolderChunk> get copyWith => __$FolderChunkCopyWithImpl<_FolderChunk>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FolderChunk &&
            (identical(other.scanId, scanId) || other.scanId == scanId) &&
            const DeepCollectionEquality().equals(other.files, _files) &&
            (identical(other.finished, finished) || other.finished == finished) &&
            (identical(other.issue, issue) || other.issue == issue));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, scanId, const DeepCollectionEquality().hash(_files), finished, issue);
  }

  @override
  String toString() {
    return 'UploadQueueEvent.folderChunk(scanId: $scanId, files: $files, finished: $finished, issue: $issue)';
  }
}

/// @nodoc
abstract mixin class _$FolderChunkCopyWith<$Res> implements $UploadQueueEventCopyWith<$Res> {
  factory _$FolderChunkCopyWith(_FolderChunk value, $Res Function(_FolderChunk) _then) = __$FolderChunkCopyWithImpl;
  @useResult
  $Res call({int scanId, List<UploadFolderFile> files, bool finished, UploadSelectionIssue? issue});
}

/// @nodoc
class __$FolderChunkCopyWithImpl<$Res> implements _$FolderChunkCopyWith<$Res> {
  __$FolderChunkCopyWithImpl(this._self, this._then);

  final _FolderChunk _self;
  final $Res Function(_FolderChunk) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? scanId = null, Object? files = null, Object? finished = null, Object? issue = freezed}) {
    return _then(
      _FolderChunk(
        scanId: null == scanId
            ? _self.scanId
            : scanId // ignore: cast_nullable_to_non_nullable
                  as int,
        files: null == files
            ? _self._files
            : files // ignore: cast_nullable_to_non_nullable
                  as List<UploadFolderFile>,
        finished: null == finished
            ? _self.finished
            : finished // ignore: cast_nullable_to_non_nullable
                  as bool,
        issue: freezed == issue
            ? _self.issue
            : issue // ignore: cast_nullable_to_non_nullable
                  as UploadSelectionIssue?,
      ),
    );
  }
}
