// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_queue_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadQueueEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UploadQueueEvent);
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
  $UploadQueueEventCopyWith(
      UploadQueueEvent _, $Res Function(UploadQueueEvent) __);
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
    TResult Function(_AddFiles value)? addFiles,
    TResult Function(_RemoveTask value)? removeTask,
    TResult Function(_RetryTask value)? retryTask,
    TResult Function(_UpdateProgress value)? updateProgress,
    TResult Function(_TaskCompleted value)? taskCompleted,
    TResult Function(_TaskFailed value)? taskFailed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AddFiles() when addFiles != null:
        return addFiles(_that);
      case _RemoveTask() when removeTask != null:
        return removeTask(_that);
      case _RetryTask() when retryTask != null:
        return retryTask(_that);
      case _UpdateProgress() when updateProgress != null:
        return updateProgress(_that);
      case _TaskCompleted() when taskCompleted != null:
        return taskCompleted(_that);
      case _TaskFailed() when taskFailed != null:
        return taskFailed(_that);
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
    required TResult Function(_AddFiles value) addFiles,
    required TResult Function(_RemoveTask value) removeTask,
    required TResult Function(_RetryTask value) retryTask,
    required TResult Function(_UpdateProgress value) updateProgress,
    required TResult Function(_TaskCompleted value) taskCompleted,
    required TResult Function(_TaskFailed value) taskFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _AddFiles():
        return addFiles(_that);
      case _RemoveTask():
        return removeTask(_that);
      case _RetryTask():
        return retryTask(_that);
      case _UpdateProgress():
        return updateProgress(_that);
      case _TaskCompleted():
        return taskCompleted(_that);
      case _TaskFailed():
        return taskFailed(_that);
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
    TResult? Function(_AddFiles value)? addFiles,
    TResult? Function(_RemoveTask value)? removeTask,
    TResult? Function(_RetryTask value)? retryTask,
    TResult? Function(_UpdateProgress value)? updateProgress,
    TResult? Function(_TaskCompleted value)? taskCompleted,
    TResult? Function(_TaskFailed value)? taskFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _AddFiles() when addFiles != null:
        return addFiles(_that);
      case _RemoveTask() when removeTask != null:
        return removeTask(_that);
      case _RetryTask() when retryTask != null:
        return retryTask(_that);
      case _UpdateProgress() when updateProgress != null:
        return updateProgress(_that);
      case _TaskCompleted() when taskCompleted != null:
        return taskCompleted(_that);
      case _TaskFailed() when taskFailed != null:
        return taskFailed(_that);
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
    TResult Function(List<File> files, String rootPath)? addFiles,
    TResult Function(String taskId)? removeTask,
    TResult Function(String taskId)? retryTask,
    TResult Function(String taskId, int sent, int total)? updateProgress,
    TResult Function(String taskId)? taskCompleted,
    TResult Function(String taskId, String error)? taskFailed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AddFiles() when addFiles != null:
        return addFiles(_that.files, _that.rootPath);
      case _RemoveTask() when removeTask != null:
        return removeTask(_that.taskId);
      case _RetryTask() when retryTask != null:
        return retryTask(_that.taskId);
      case _UpdateProgress() when updateProgress != null:
        return updateProgress(_that.taskId, _that.sent, _that.total);
      case _TaskCompleted() when taskCompleted != null:
        return taskCompleted(_that.taskId);
      case _TaskFailed() when taskFailed != null:
        return taskFailed(_that.taskId, _that.error);
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
    required TResult Function(List<File> files, String rootPath) addFiles,
    required TResult Function(String taskId) removeTask,
    required TResult Function(String taskId) retryTask,
    required TResult Function(String taskId, int sent, int total)
        updateProgress,
    required TResult Function(String taskId) taskCompleted,
    required TResult Function(String taskId, String error) taskFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _AddFiles():
        return addFiles(_that.files, _that.rootPath);
      case _RemoveTask():
        return removeTask(_that.taskId);
      case _RetryTask():
        return retryTask(_that.taskId);
      case _UpdateProgress():
        return updateProgress(_that.taskId, _that.sent, _that.total);
      case _TaskCompleted():
        return taskCompleted(_that.taskId);
      case _TaskFailed():
        return taskFailed(_that.taskId, _that.error);
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
    TResult? Function(List<File> files, String rootPath)? addFiles,
    TResult? Function(String taskId)? removeTask,
    TResult? Function(String taskId)? retryTask,
    TResult? Function(String taskId, int sent, int total)? updateProgress,
    TResult? Function(String taskId)? taskCompleted,
    TResult? Function(String taskId, String error)? taskFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _AddFiles() when addFiles != null:
        return addFiles(_that.files, _that.rootPath);
      case _RemoveTask() when removeTask != null:
        return removeTask(_that.taskId);
      case _RetryTask() when retryTask != null:
        return retryTask(_that.taskId);
      case _UpdateProgress() when updateProgress != null:
        return updateProgress(_that.taskId, _that.sent, _that.total);
      case _TaskCompleted() when taskCompleted != null:
        return taskCompleted(_that.taskId);
      case _TaskFailed() when taskFailed != null:
        return taskFailed(_that.taskId, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AddFiles implements UploadQueueEvent {
  const _AddFiles({required final List<File> files, required this.rootPath})
      : _files = files;

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
  _$AddFilesCopyWith<_AddFiles> get copyWith =>
      __$AddFilesCopyWithImpl<_AddFiles>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddFiles &&
            const DeepCollectionEquality().equals(other._files, _files) &&
            (identical(other.rootPath, rootPath) ||
                other.rootPath == rootPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_files), rootPath);

  @override
  String toString() {
    return 'UploadQueueEvent.addFiles(files: $files, rootPath: $rootPath)';
  }
}

/// @nodoc
abstract mixin class _$AddFilesCopyWith<$Res>
    implements $UploadQueueEventCopyWith<$Res> {
  factory _$AddFilesCopyWith(_AddFiles value, $Res Function(_AddFiles) _then) =
      __$AddFilesCopyWithImpl;
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
  $Res call({
    Object? files = null,
    Object? rootPath = null,
  }) {
    return _then(_AddFiles(
      files: null == files
          ? _self._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
      rootPath: null == rootPath
          ? _self.rootPath
          : rootPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
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
  _$RemoveTaskCopyWith<_RemoveTask> get copyWith =>
      __$RemoveTaskCopyWithImpl<_RemoveTask>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RemoveTask &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  @override
  String toString() {
    return 'UploadQueueEvent.removeTask(taskId: $taskId)';
  }
}

/// @nodoc
abstract mixin class _$RemoveTaskCopyWith<$Res>
    implements $UploadQueueEventCopyWith<$Res> {
  factory _$RemoveTaskCopyWith(
          _RemoveTask value, $Res Function(_RemoveTask) _then) =
      __$RemoveTaskCopyWithImpl;
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
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_RemoveTask(
      null == taskId
          ? _self.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
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
  _$RetryTaskCopyWith<_RetryTask> get copyWith =>
      __$RetryTaskCopyWithImpl<_RetryTask>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RetryTask &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  @override
  String toString() {
    return 'UploadQueueEvent.retryTask(taskId: $taskId)';
  }
}

/// @nodoc
abstract mixin class _$RetryTaskCopyWith<$Res>
    implements $UploadQueueEventCopyWith<$Res> {
  factory _$RetryTaskCopyWith(
          _RetryTask value, $Res Function(_RetryTask) _then) =
      __$RetryTaskCopyWithImpl;
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
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_RetryTask(
      null == taskId
          ? _self.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _UpdateProgress implements UploadQueueEvent {
  const _UpdateProgress(this.taskId, this.sent, this.total);

  final String taskId;
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
            (identical(other.sent, sent) || other.sent == sent) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId, sent, total);

  @override
  String toString() {
    return 'UploadQueueEvent.updateProgress(taskId: $taskId, sent: $sent, total: $total)';
  }
}

/// @nodoc
abstract mixin class _$UpdateProgressCopyWith<$Res>
    implements $UploadQueueEventCopyWith<$Res> {
  factory _$UpdateProgressCopyWith(
          _UpdateProgress value, $Res Function(_UpdateProgress) _then) =
      __$UpdateProgressCopyWithImpl;
  @useResult
  $Res call({String taskId, int sent, int total});
}

/// @nodoc
class __$UpdateProgressCopyWithImpl<$Res>
    implements _$UpdateProgressCopyWith<$Res> {
  __$UpdateProgressCopyWithImpl(this._self, this._then);

  final _UpdateProgress _self;
  final $Res Function(_UpdateProgress) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? taskId = null,
    Object? sent = null,
    Object? total = null,
  }) {
    return _then(_UpdateProgress(
      null == taskId
          ? _self.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      null == sent
          ? _self.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as int,
      null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _TaskCompleted implements UploadQueueEvent {
  const _TaskCompleted(this.taskId);

  final String taskId;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TaskCompletedCopyWith<_TaskCompleted> get copyWith =>
      __$TaskCompletedCopyWithImpl<_TaskCompleted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TaskCompleted &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  @override
  String toString() {
    return 'UploadQueueEvent.taskCompleted(taskId: $taskId)';
  }
}

/// @nodoc
abstract mixin class _$TaskCompletedCopyWith<$Res>
    implements $UploadQueueEventCopyWith<$Res> {
  factory _$TaskCompletedCopyWith(
          _TaskCompleted value, $Res Function(_TaskCompleted) _then) =
      __$TaskCompletedCopyWithImpl;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$TaskCompletedCopyWithImpl<$Res>
    implements _$TaskCompletedCopyWith<$Res> {
  __$TaskCompletedCopyWithImpl(this._self, this._then);

  final _TaskCompleted _self;
  final $Res Function(_TaskCompleted) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_TaskCompleted(
      null == taskId
          ? _self.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _TaskFailed implements UploadQueueEvent {
  const _TaskFailed(this.taskId, this.error);

  final String taskId;
  final String error;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TaskFailedCopyWith<_TaskFailed> get copyWith =>
      __$TaskFailedCopyWithImpl<_TaskFailed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TaskFailed &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId, error);

  @override
  String toString() {
    return 'UploadQueueEvent.taskFailed(taskId: $taskId, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$TaskFailedCopyWith<$Res>
    implements $UploadQueueEventCopyWith<$Res> {
  factory _$TaskFailedCopyWith(
          _TaskFailed value, $Res Function(_TaskFailed) _then) =
      __$TaskFailedCopyWithImpl;
  @useResult
  $Res call({String taskId, String error});
}

/// @nodoc
class __$TaskFailedCopyWithImpl<$Res> implements _$TaskFailedCopyWith<$Res> {
  __$TaskFailedCopyWithImpl(this._self, this._then);

  final _TaskFailed _self;
  final $Res Function(_TaskFailed) _then;

  /// Create a copy of UploadQueueEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? taskId = null,
    Object? error = null,
  }) {
    return _then(_TaskFailed(
      null == taskId
          ? _self.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$UploadQueueState {
  List<UploadTask> get tasks;

  /// Create a copy of UploadQueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UploadQueueStateCopyWith<UploadQueueState> get copyWith =>
      _$UploadQueueStateCopyWithImpl<UploadQueueState>(
          this as UploadQueueState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UploadQueueState &&
            const DeepCollectionEquality().equals(other.tasks, tasks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(tasks));

  @override
  String toString() {
    return 'UploadQueueState(tasks: $tasks)';
  }
}

/// @nodoc
abstract mixin class $UploadQueueStateCopyWith<$Res> {
  factory $UploadQueueStateCopyWith(
          UploadQueueState value, $Res Function(UploadQueueState) _then) =
      _$UploadQueueStateCopyWithImpl;
  @useResult
  $Res call({List<UploadTask> tasks});
}

/// @nodoc
class _$UploadQueueStateCopyWithImpl<$Res>
    implements $UploadQueueStateCopyWith<$Res> {
  _$UploadQueueStateCopyWithImpl(this._self, this._then);

  final UploadQueueState _self;
  final $Res Function(UploadQueueState) _then;

  /// Create a copy of UploadQueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
  }) {
    return _then(_self.copyWith(
      tasks: null == tasks
          ? _self.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<UploadTask>,
    ));
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
  TResult map<TResult extends Object?>(
    TResult Function(_UploadQueueState value) $default,
  ) {
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UploadQueueState value)? $default,
  ) {
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
    TResult Function(List<UploadTask> tasks)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UploadQueueState() when $default != null:
        return $default(_that.tasks);
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
    TResult Function(List<UploadTask> tasks) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadQueueState():
        return $default(_that.tasks);
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
    TResult? Function(List<UploadTask> tasks)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadQueueState() when $default != null:
        return $default(_that.tasks);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UploadQueueState implements UploadQueueState {
  const _UploadQueueState({final List<UploadTask> tasks = const []})
      : _tasks = tasks;

  final List<UploadTask> _tasks;
  @override
  @JsonKey()
  List<UploadTask> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

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
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tasks));

  @override
  String toString() {
    return 'UploadQueueState(tasks: $tasks)';
  }
}

/// @nodoc
abstract mixin class _$UploadQueueStateCopyWith<$Res>
    implements $UploadQueueStateCopyWith<$Res> {
  factory _$UploadQueueStateCopyWith(
          _UploadQueueState value, $Res Function(_UploadQueueState) _then) =
      __$UploadQueueStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<UploadTask> tasks});
}

/// @nodoc
class __$UploadQueueStateCopyWithImpl<$Res>
    implements _$UploadQueueStateCopyWith<$Res> {
  __$UploadQueueStateCopyWithImpl(this._self, this._then);

  final _UploadQueueState _self;
  final $Res Function(_UploadQueueState) _then;

  /// Create a copy of UploadQueueState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tasks = null,
  }) {
    return _then(_UploadQueueState(
      tasks: null == tasks
          ? _self._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<UploadTask>,
    ));
  }
}

// dart format on
