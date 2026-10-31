// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drive_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DriveCommand {

 int get id; StorageType get provider;@JsonKey(unknownEnumValue: DriveAction.unknown) DriveAction get action; String? get clientId; String? get clientSecret; String? get sessionId; String? get accountId; String? get path; int get offset; bool? get paused; String get type;
/// Create a copy of DriveCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveCommandCopyWith<DriveCommand> get copyWith => _$DriveCommandCopyWithImpl<DriveCommand>(this as DriveCommand, _$identity);

  /// Serializes this DriveCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriveCommand;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveCommand&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.provider, _this.provider) || other.provider == _this.provider)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.clientId, _this.clientId) || other.clientId == _this.clientId)&&(identical(other.clientSecret, _this.clientSecret) || other.clientSecret == _this.clientSecret)&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.path, _this.path) || other.path == _this.path)&&(identical(other.offset, _this.offset) || other.offset == _this.offset)&&(identical(other.paused, _this.paused) || other.paused == _this.paused)&&(identical(other.type, _this.type) || other.type == _this.type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriveCommand;
  return Object.hash(runtimeType,_this.id,_this.provider,_this.action,_this.clientId,_this.clientSecret,_this.sessionId,_this.accountId,_this.path,_this.offset,_this.paused,_this.type);
}



}

/// @nodoc
abstract mixin class $DriveCommandCopyWith<$Res>  {
  factory $DriveCommandCopyWith(DriveCommand value, $Res Function(DriveCommand) _then) = _$DriveCommandCopyWithImpl;
@useResult
$Res call({
 int id, StorageType provider,@JsonKey(unknownEnumValue: DriveAction.unknown) DriveAction action, String? clientId, String? clientSecret, String? sessionId, String? accountId, String? path, int offset, bool? paused, String type
});




}
/// @nodoc
class _$DriveCommandCopyWithImpl<$Res>
    implements $DriveCommandCopyWith<$Res> {
  _$DriveCommandCopyWithImpl(this._self, this._then);

  final DriveCommand _self;
  final $Res Function(DriveCommand) _then;

/// Create a copy of DriveCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? provider = null,Object? action = null,Object? clientId = freezed,Object? clientSecret = freezed,Object? sessionId = freezed,Object? accountId = freezed,Object? path = freezed,Object? offset = null,Object? paused = freezed,Object? type = null,}) {
  return _then(DriveCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as StorageType,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as DriveAction,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,paused: freezed == paused ? _self.paused : paused // ignore: cast_nullable_to_non_nullable
as bool?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DriveCommand].
extension DriveCommandPatterns on DriveCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveCommand() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveCommand value)  $default,){
final _that = this;
switch (_that) {
case _DriveCommand():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveCommand value)?  $default,){
final _that = this;
switch (_that) {
case _DriveCommand() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  StorageType provider, @JsonKey(unknownEnumValue: DriveAction.unknown)  DriveAction action,  String? clientId,  String? clientSecret,  String? sessionId,  String? accountId,  String? path,  int offset,  bool? paused,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveCommand() when $default != null:
return $default(_that.id,_that.provider,_that.action,_that.clientId,_that.clientSecret,_that.sessionId,_that.accountId,_that.path,_that.offset,_that.paused,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  StorageType provider, @JsonKey(unknownEnumValue: DriveAction.unknown)  DriveAction action,  String? clientId,  String? clientSecret,  String? sessionId,  String? accountId,  String? path,  int offset,  bool? paused,  String type)  $default,) {final _that = this;
switch (_that) {
case _DriveCommand():
return $default(_that.id,_that.provider,_that.action,_that.clientId,_that.clientSecret,_that.sessionId,_that.accountId,_that.path,_that.offset,_that.paused,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  StorageType provider, @JsonKey(unknownEnumValue: DriveAction.unknown)  DriveAction action,  String? clientId,  String? clientSecret,  String? sessionId,  String? accountId,  String? path,  int offset,  bool? paused,  String type)?  $default,) {final _that = this;
switch (_that) {
case _DriveCommand() when $default != null:
return $default(_that.id,_that.provider,_that.action,_that.clientId,_that.clientSecret,_that.sessionId,_that.accountId,_that.path,_that.offset,_that.paused,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriveCommand extends DriveCommand {
  const _DriveCommand({required this.id, required this.provider, @JsonKey(unknownEnumValue: DriveAction.unknown) required this.action, this.clientId, this.clientSecret, this.sessionId, this.accountId, this.path, this.offset = 0, this.paused, this.type = DriveCommand.TYPE}): super._();
  factory _DriveCommand.fromJson(Map<String, dynamic> json) => _$DriveCommandFromJson(json);

@override final  int id;
@override final  StorageType provider;
@override@JsonKey(unknownEnumValue: DriveAction.unknown) final  DriveAction action;
@override final  String? clientId;
@override final  String? clientSecret;
@override final  String? sessionId;
@override final  String? accountId;
@override final  String? path;
@override@JsonKey() final  int offset;
@override final  bool? paused;
@override@JsonKey() final  String type;

/// Create a copy of DriveCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveCommandCopyWith<_DriveCommand> get copyWith => __$DriveCommandCopyWithImpl<_DriveCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriveCommandToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.action, action) || other.action == action)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.path, path) || other.path == path)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.paused, paused) || other.paused == paused)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,provider,action,clientId,clientSecret,sessionId,accountId,path,offset,paused,type);
}



}

/// @nodoc
abstract mixin class _$DriveCommandCopyWith<$Res> implements $DriveCommandCopyWith<$Res> {
  factory _$DriveCommandCopyWith(_DriveCommand value, $Res Function(_DriveCommand) _then) = __$DriveCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, StorageType provider,@JsonKey(unknownEnumValue: DriveAction.unknown) DriveAction action, String? clientId, String? clientSecret, String? sessionId, String? accountId, String? path, int offset, bool? paused, String type
});




}
/// @nodoc
class __$DriveCommandCopyWithImpl<$Res>
    implements _$DriveCommandCopyWith<$Res> {
  __$DriveCommandCopyWithImpl(this._self, this._then);

  final _DriveCommand _self;
  final $Res Function(_DriveCommand) _then;

/// Create a copy of DriveCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? provider = null,Object? action = null,Object? clientId = freezed,Object? clientSecret = freezed,Object? sessionId = freezed,Object? accountId = freezed,Object? path = freezed,Object? offset = null,Object? paused = freezed,Object? type = null,}) {
  return _then(_DriveCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as StorageType,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as DriveAction,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,paused: freezed == paused ? _self.paused : paused // ignore: cast_nullable_to_non_nullable
as bool?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DriveResult {

 int get id; DriveState get state; DriveAuthorization? get authorization; DriveFolderPage? get folderPage;@JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? get error;
/// Create a copy of DriveResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveResultCopyWith<DriveResult> get copyWith => _$DriveResultCopyWithImpl<DriveResult>(this as DriveResult, _$identity);

  /// Serializes this DriveResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriveResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveResult&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.authorization, _this.authorization) || other.authorization == _this.authorization)&&(identical(other.folderPage, _this.folderPage) || other.folderPage == _this.folderPage)&&(identical(other.error, _this.error) || other.error == _this.error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriveResult;
  return Object.hash(runtimeType,_this.id,_this.state,_this.authorization,_this.folderPage,_this.error);
}

@override
String toString() {
  final _this = this as DriveResult;
  return 'DriveResult(id: ${_this.id}, state: ${_this.state}, authorization: ${_this.authorization}, folderPage: ${_this.folderPage}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $DriveResultCopyWith<$Res>  {
  factory $DriveResultCopyWith(DriveResult value, $Res Function(DriveResult) _then) = _$DriveResultCopyWithImpl;
@useResult
$Res call({
 int id, DriveState state, DriveAuthorization? authorization, DriveFolderPage? folderPage,@JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? error
});


$DriveStateCopyWith<$Res> get state;$DriveAuthorizationCopyWith<$Res>? get authorization;$DriveFolderPageCopyWith<$Res>? get folderPage;

}
/// @nodoc
class _$DriveResultCopyWithImpl<$Res>
    implements $DriveResultCopyWith<$Res> {
  _$DriveResultCopyWithImpl(this._self, this._then);

  final DriveResult _self;
  final $Res Function(DriveResult) _then;

/// Create a copy of DriveResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? state = null,Object? authorization = freezed,Object? folderPage = freezed,Object? error = freezed,}) {
  return _then(DriveResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as DriveState,authorization: freezed == authorization ? _self.authorization : authorization // ignore: cast_nullable_to_non_nullable
as DriveAuthorization?,folderPage: freezed == folderPage ? _self.folderPage : folderPage // ignore: cast_nullable_to_non_nullable
as DriveFolderPage?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as DriveFailure?,
  ));
}
/// Create a copy of DriveResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriveStateCopyWith<$Res> get state {
  
  return $DriveStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}/// Create a copy of DriveResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriveAuthorizationCopyWith<$Res>? get authorization {
    if (_self.authorization == null) {
    return null;
  }

  return $DriveAuthorizationCopyWith<$Res>(_self.authorization!, (value) {
    return _then(_self.copyWith(authorization: value));
  });
}/// Create a copy of DriveResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriveFolderPageCopyWith<$Res>? get folderPage {
    if (_self.folderPage == null) {
    return null;
  }

  return $DriveFolderPageCopyWith<$Res>(_self.folderPage!, (value) {
    return _then(_self.copyWith(folderPage: value));
  });
}
}


/// Adds pattern-matching-related methods to [DriveResult].
extension DriveResultPatterns on DriveResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveResult() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveResult value)  $default,){
final _that = this;
switch (_that) {
case _DriveResult():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveResult value)?  $default,){
final _that = this;
switch (_that) {
case _DriveResult() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DriveState state,  DriveAuthorization? authorization,  DriveFolderPage? folderPage, @JsonKey(unknownEnumValue: DriveFailure.unknown)  DriveFailure? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveResult() when $default != null:
return $default(_that.id,_that.state,_that.authorization,_that.folderPage,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DriveState state,  DriveAuthorization? authorization,  DriveFolderPage? folderPage, @JsonKey(unknownEnumValue: DriveFailure.unknown)  DriveFailure? error)  $default,) {final _that = this;
switch (_that) {
case _DriveResult():
return $default(_that.id,_that.state,_that.authorization,_that.folderPage,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DriveState state,  DriveAuthorization? authorization,  DriveFolderPage? folderPage, @JsonKey(unknownEnumValue: DriveFailure.unknown)  DriveFailure? error)?  $default,) {final _that = this;
switch (_that) {
case _DriveResult() when $default != null:
return $default(_that.id,_that.state,_that.authorization,_that.folderPage,_that.error);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _DriveResult implements DriveResult {
  const _DriveResult({required this.id, required this.state, this.authorization, this.folderPage, @JsonKey(unknownEnumValue: DriveFailure.unknown) this.error});
  factory _DriveResult.fromJson(Map<String, dynamic> json) => _$DriveResultFromJson(json);

@override final  int id;
@override final  DriveState state;
@override final  DriveAuthorization? authorization;
@override final  DriveFolderPage? folderPage;
@override@JsonKey(unknownEnumValue: DriveFailure.unknown) final  DriveFailure? error;

/// Create a copy of DriveResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveResultCopyWith<_DriveResult> get copyWith => __$DriveResultCopyWithImpl<_DriveResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriveResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveResult&&(identical(other.id, id) || other.id == id)&&(identical(other.state, state) || other.state == state)&&(identical(other.authorization, authorization) || other.authorization == authorization)&&(identical(other.folderPage, folderPage) || other.folderPage == folderPage)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,state,authorization,folderPage,error);
}

@override
String toString() {
    return 'DriveResult(id: $id, state: $state, authorization: $authorization, folderPage: $folderPage, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DriveResultCopyWith<$Res> implements $DriveResultCopyWith<$Res> {
  factory _$DriveResultCopyWith(_DriveResult value, $Res Function(_DriveResult) _then) = __$DriveResultCopyWithImpl;
@override @useResult
$Res call({
 int id, DriveState state, DriveAuthorization? authorization, DriveFolderPage? folderPage,@JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? error
});


@override $DriveStateCopyWith<$Res> get state;@override $DriveAuthorizationCopyWith<$Res>? get authorization;@override $DriveFolderPageCopyWith<$Res>? get folderPage;

}
/// @nodoc
class __$DriveResultCopyWithImpl<$Res>
    implements _$DriveResultCopyWith<$Res> {
  __$DriveResultCopyWithImpl(this._self, this._then);

  final _DriveResult _self;
  final $Res Function(_DriveResult) _then;

/// Create a copy of DriveResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? state = null,Object? authorization = freezed,Object? folderPage = freezed,Object? error = freezed,}) {
  return _then(_DriveResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as DriveState,authorization: freezed == authorization ? _self.authorization : authorization // ignore: cast_nullable_to_non_nullable
as DriveAuthorization?,folderPage: freezed == folderPage ? _self.folderPage : folderPage // ignore: cast_nullable_to_non_nullable
as DriveFolderPage?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as DriveFailure?,
  ));
}

/// Create a copy of DriveResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriveStateCopyWith<$Res> get state {
  
  return $DriveStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}/// Create a copy of DriveResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriveAuthorizationCopyWith<$Res>? get authorization {
    if (_self.authorization == null) {
    return null;
  }

  return $DriveAuthorizationCopyWith<$Res>(_self.authorization!, (value) {
    return _then(_self.copyWith(authorization: value));
  });
}/// Create a copy of DriveResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriveFolderPageCopyWith<$Res>? get folderPage {
    if (_self.folderPage == null) {
    return null;
  }

  return $DriveFolderPageCopyWith<$Res>(_self.folderPage!, (value) {
    return _then(_self.copyWith(folderPage: value));
  });
}
}


/// @nodoc
mixin _$DriveState {

 String get clientId; bool get clientSecretConfigured; List<DriveConnection> get connections; DriveRuntime get runtime;
/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveStateCopyWith<DriveState> get copyWith => _$DriveStateCopyWithImpl<DriveState>(this as DriveState, _$identity);

  /// Serializes this DriveState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriveState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveState&&(identical(other.clientId, _this.clientId) || other.clientId == _this.clientId)&&(identical(other.clientSecretConfigured, _this.clientSecretConfigured) || other.clientSecretConfigured == _this.clientSecretConfigured)&&const DeepCollectionEquality().equals(other.connections, _this.connections)&&(identical(other.runtime, _this.runtime) || other.runtime == _this.runtime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriveState;
  return Object.hash(runtimeType,_this.clientId,_this.clientSecretConfigured,const DeepCollectionEquality().hash(_this.connections),_this.runtime);
}

@override
String toString() {
  final _this = this as DriveState;
  return 'DriveState(clientId: ${_this.clientId}, clientSecretConfigured: ${_this.clientSecretConfigured}, connections: ${_this.connections}, runtime: ${_this.runtime})';
}


}

/// @nodoc
abstract mixin class $DriveStateCopyWith<$Res>  {
  factory $DriveStateCopyWith(DriveState value, $Res Function(DriveState) _then) = _$DriveStateCopyWithImpl;
@useResult
$Res call({
 String clientId, bool clientSecretConfigured, List<DriveConnection> connections, DriveRuntime runtime
});


$DriveRuntimeCopyWith<$Res> get runtime;

}
/// @nodoc
class _$DriveStateCopyWithImpl<$Res>
    implements $DriveStateCopyWith<$Res> {
  _$DriveStateCopyWithImpl(this._self, this._then);

  final DriveState _self;
  final $Res Function(DriveState) _then;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? clientSecretConfigured = null,Object? connections = null,Object? runtime = null,}) {
  return _then(DriveState(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientSecretConfigured: null == clientSecretConfigured ? _self.clientSecretConfigured : clientSecretConfigured // ignore: cast_nullable_to_non_nullable
as bool,connections: null == connections ? _self.connections : connections // ignore: cast_nullable_to_non_nullable
as List<DriveConnection>,runtime: null == runtime ? _self.runtime : runtime // ignore: cast_nullable_to_non_nullable
as DriveRuntime,
  ));
}
/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriveRuntimeCopyWith<$Res> get runtime {
  
  return $DriveRuntimeCopyWith<$Res>(_self.runtime, (value) {
    return _then(_self.copyWith(runtime: value));
  });
}
}


/// Adds pattern-matching-related methods to [DriveState].
extension DriveStatePatterns on DriveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveState value)  $default,){
final _that = this;
switch (_that) {
case _DriveState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveState value)?  $default,){
final _that = this;
switch (_that) {
case _DriveState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  bool clientSecretConfigured,  List<DriveConnection> connections,  DriveRuntime runtime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveState() when $default != null:
return $default(_that.clientId,_that.clientSecretConfigured,_that.connections,_that.runtime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  bool clientSecretConfigured,  List<DriveConnection> connections,  DriveRuntime runtime)  $default,) {final _that = this;
switch (_that) {
case _DriveState():
return $default(_that.clientId,_that.clientSecretConfigured,_that.connections,_that.runtime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  bool clientSecretConfigured,  List<DriveConnection> connections,  DriveRuntime runtime)?  $default,) {final _that = this;
switch (_that) {
case _DriveState() when $default != null:
return $default(_that.clientId,_that.clientSecretConfigured,_that.connections,_that.runtime);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _DriveState implements DriveState {
  const _DriveState({this.clientId = '', this.clientSecretConfigured = false,  List<DriveConnection> connections = const [], this.runtime = const DriveRuntime()}): _connections = connections;
  factory _DriveState.fromJson(Map<String, dynamic> json) => _$DriveStateFromJson(json);

@override@JsonKey() final  String clientId;
@override@JsonKey() final  bool clientSecretConfigured;
 final  List<DriveConnection> _connections;
@override@JsonKey() List<DriveConnection> get connections {
  if (_connections is EqualUnmodifiableListView) return _connections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_connections);
}

@override@JsonKey() final  DriveRuntime runtime;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveStateCopyWith<_DriveState> get copyWith => __$DriveStateCopyWithImpl<_DriveState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriveStateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveState&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientSecretConfigured, clientSecretConfigured) || other.clientSecretConfigured == clientSecretConfigured)&&const DeepCollectionEquality().equals(other.connections, _connections)&&(identical(other.runtime, runtime) || other.runtime == runtime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,clientId,clientSecretConfigured,const DeepCollectionEquality().hash(_connections),runtime);
}

@override
String toString() {
    return 'DriveState(clientId: $clientId, clientSecretConfigured: $clientSecretConfigured, connections: $connections, runtime: $runtime)';
}


}

/// @nodoc
abstract mixin class _$DriveStateCopyWith<$Res> implements $DriveStateCopyWith<$Res> {
  factory _$DriveStateCopyWith(_DriveState value, $Res Function(_DriveState) _then) = __$DriveStateCopyWithImpl;
@override @useResult
$Res call({
 String clientId, bool clientSecretConfigured, List<DriveConnection> connections, DriveRuntime runtime
});


@override $DriveRuntimeCopyWith<$Res> get runtime;

}
/// @nodoc
class __$DriveStateCopyWithImpl<$Res>
    implements _$DriveStateCopyWith<$Res> {
  __$DriveStateCopyWithImpl(this._self, this._then);

  final _DriveState _self;
  final $Res Function(_DriveState) _then;

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? clientSecretConfigured = null,Object? connections = null,Object? runtime = null,}) {
  return _then(_DriveState(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientSecretConfigured: null == clientSecretConfigured ? _self.clientSecretConfigured : clientSecretConfigured // ignore: cast_nullable_to_non_nullable
as bool,connections: null == connections ? _self._connections : connections // ignore: cast_nullable_to_non_nullable
as List<DriveConnection>,runtime: null == runtime ? _self.runtime : runtime // ignore: cast_nullable_to_non_nullable
as DriveRuntime,
  ));
}

/// Create a copy of DriveState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriveRuntimeCopyWith<$Res> get runtime {
  
  return $DriveRuntimeCopyWith<$Res>(_self.runtime, (value) {
    return _then(_self.copyWith(runtime: value));
  });
}
}


/// @nodoc
mixin _$DriveConnection {

 String get accountId; String get label;
/// Create a copy of DriveConnection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveConnectionCopyWith<DriveConnection> get copyWith => _$DriveConnectionCopyWithImpl<DriveConnection>(this as DriveConnection, _$identity);

  /// Serializes this DriveConnection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriveConnection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveConnection&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriveConnection;
  return Object.hash(runtimeType,_this.accountId,_this.label);
}

@override
String toString() {
  final _this = this as DriveConnection;
  return 'DriveConnection(accountId: ${_this.accountId}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $DriveConnectionCopyWith<$Res>  {
  factory $DriveConnectionCopyWith(DriveConnection value, $Res Function(DriveConnection) _then) = _$DriveConnectionCopyWithImpl;
@useResult
$Res call({
 String accountId, String label
});




}
/// @nodoc
class _$DriveConnectionCopyWithImpl<$Res>
    implements $DriveConnectionCopyWith<$Res> {
  _$DriveConnectionCopyWithImpl(this._self, this._then);

  final DriveConnection _self;
  final $Res Function(DriveConnection) _then;

/// Create a copy of DriveConnection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? label = null,}) {
  return _then(DriveConnection(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DriveConnection].
extension DriveConnectionPatterns on DriveConnection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveConnection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveConnection() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveConnection value)  $default,){
final _that = this;
switch (_that) {
case _DriveConnection():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveConnection value)?  $default,){
final _that = this;
switch (_that) {
case _DriveConnection() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountId,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveConnection() when $default != null:
return $default(_that.accountId,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountId,  String label)  $default,) {final _that = this;
switch (_that) {
case _DriveConnection():
return $default(_that.accountId,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountId,  String label)?  $default,) {final _that = this;
switch (_that) {
case _DriveConnection() when $default != null:
return $default(_that.accountId,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriveConnection implements DriveConnection {
  const _DriveConnection({required this.accountId, required this.label});
  factory _DriveConnection.fromJson(Map<String, dynamic> json) => _$DriveConnectionFromJson(json);

@override final  String accountId;
@override final  String label;

/// Create a copy of DriveConnection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveConnectionCopyWith<_DriveConnection> get copyWith => __$DriveConnectionCopyWithImpl<_DriveConnection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriveConnectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveConnection&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,accountId,label);
}

@override
String toString() {
    return 'DriveConnection(accountId: $accountId, label: $label)';
}


}

/// @nodoc
abstract mixin class _$DriveConnectionCopyWith<$Res> implements $DriveConnectionCopyWith<$Res> {
  factory _$DriveConnectionCopyWith(_DriveConnection value, $Res Function(_DriveConnection) _then) = __$DriveConnectionCopyWithImpl;
@override @useResult
$Res call({
 String accountId, String label
});




}
/// @nodoc
class __$DriveConnectionCopyWithImpl<$Res>
    implements _$DriveConnectionCopyWith<$Res> {
  __$DriveConnectionCopyWithImpl(this._self, this._then);

  final _DriveConnection _self;
  final $Res Function(_DriveConnection) _then;

/// Create a copy of DriveConnection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? label = null,}) {
  return _then(_DriveConnection(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DriveAuthorization {

 String get sessionId; DriveAuthorizationStatus get status; String? get userCode; Uri? get verificationUrl; DateTime? get expiresAt; String? get accountId;@JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? get error;
/// Create a copy of DriveAuthorization
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveAuthorizationCopyWith<DriveAuthorization> get copyWith => _$DriveAuthorizationCopyWithImpl<DriveAuthorization>(this as DriveAuthorization, _$identity);

  /// Serializes this DriveAuthorization to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriveAuthorization;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveAuthorization&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.userCode, _this.userCode) || other.userCode == _this.userCode)&&(identical(other.verificationUrl, _this.verificationUrl) || other.verificationUrl == _this.verificationUrl)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.error, _this.error) || other.error == _this.error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriveAuthorization;
  return Object.hash(runtimeType,_this.sessionId,_this.status,_this.userCode,_this.verificationUrl,_this.expiresAt,_this.accountId,_this.error);
}



}

/// @nodoc
abstract mixin class $DriveAuthorizationCopyWith<$Res>  {
  factory $DriveAuthorizationCopyWith(DriveAuthorization value, $Res Function(DriveAuthorization) _then) = _$DriveAuthorizationCopyWithImpl;
@useResult
$Res call({
 String sessionId, DriveAuthorizationStatus status, String? userCode, Uri? verificationUrl, DateTime? expiresAt, String? accountId,@JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? error
});




}
/// @nodoc
class _$DriveAuthorizationCopyWithImpl<$Res>
    implements $DriveAuthorizationCopyWith<$Res> {
  _$DriveAuthorizationCopyWithImpl(this._self, this._then);

  final DriveAuthorization _self;
  final $Res Function(DriveAuthorization) _then;

/// Create a copy of DriveAuthorization
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? status = null,Object? userCode = freezed,Object? verificationUrl = freezed,Object? expiresAt = freezed,Object? accountId = freezed,Object? error = freezed,}) {
  return _then(DriveAuthorization(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DriveAuthorizationStatus,userCode: freezed == userCode ? _self.userCode : userCode // ignore: cast_nullable_to_non_nullable
as String?,verificationUrl: freezed == verificationUrl ? _self.verificationUrl : verificationUrl // ignore: cast_nullable_to_non_nullable
as Uri?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as DriveFailure?,
  ));
}

}


/// Adds pattern-matching-related methods to [DriveAuthorization].
extension DriveAuthorizationPatterns on DriveAuthorization {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveAuthorization value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveAuthorization() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveAuthorization value)  $default,){
final _that = this;
switch (_that) {
case _DriveAuthorization():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveAuthorization value)?  $default,){
final _that = this;
switch (_that) {
case _DriveAuthorization() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  DriveAuthorizationStatus status,  String? userCode,  Uri? verificationUrl,  DateTime? expiresAt,  String? accountId, @JsonKey(unknownEnumValue: DriveFailure.unknown)  DriveFailure? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveAuthorization() when $default != null:
return $default(_that.sessionId,_that.status,_that.userCode,_that.verificationUrl,_that.expiresAt,_that.accountId,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  DriveAuthorizationStatus status,  String? userCode,  Uri? verificationUrl,  DateTime? expiresAt,  String? accountId, @JsonKey(unknownEnumValue: DriveFailure.unknown)  DriveFailure? error)  $default,) {final _that = this;
switch (_that) {
case _DriveAuthorization():
return $default(_that.sessionId,_that.status,_that.userCode,_that.verificationUrl,_that.expiresAt,_that.accountId,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  DriveAuthorizationStatus status,  String? userCode,  Uri? verificationUrl,  DateTime? expiresAt,  String? accountId, @JsonKey(unknownEnumValue: DriveFailure.unknown)  DriveFailure? error)?  $default,) {final _that = this;
switch (_that) {
case _DriveAuthorization() when $default != null:
return $default(_that.sessionId,_that.status,_that.userCode,_that.verificationUrl,_that.expiresAt,_that.accountId,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriveAuthorization implements DriveAuthorization {
  const _DriveAuthorization({required this.sessionId, required this.status, this.userCode, this.verificationUrl, this.expiresAt, this.accountId, @JsonKey(unknownEnumValue: DriveFailure.unknown) this.error});
  factory _DriveAuthorization.fromJson(Map<String, dynamic> json) => _$DriveAuthorizationFromJson(json);

@override final  String sessionId;
@override final  DriveAuthorizationStatus status;
@override final  String? userCode;
@override final  Uri? verificationUrl;
@override final  DateTime? expiresAt;
@override final  String? accountId;
@override@JsonKey(unknownEnumValue: DriveFailure.unknown) final  DriveFailure? error;

/// Create a copy of DriveAuthorization
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveAuthorizationCopyWith<_DriveAuthorization> get copyWith => __$DriveAuthorizationCopyWithImpl<_DriveAuthorization>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriveAuthorizationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveAuthorization&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.userCode, userCode) || other.userCode == userCode)&&(identical(other.verificationUrl, verificationUrl) || other.verificationUrl == verificationUrl)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,status,userCode,verificationUrl,expiresAt,accountId,error);
}



}

/// @nodoc
abstract mixin class _$DriveAuthorizationCopyWith<$Res> implements $DriveAuthorizationCopyWith<$Res> {
  factory _$DriveAuthorizationCopyWith(_DriveAuthorization value, $Res Function(_DriveAuthorization) _then) = __$DriveAuthorizationCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, DriveAuthorizationStatus status, String? userCode, Uri? verificationUrl, DateTime? expiresAt, String? accountId,@JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? error
});




}
/// @nodoc
class __$DriveAuthorizationCopyWithImpl<$Res>
    implements _$DriveAuthorizationCopyWith<$Res> {
  __$DriveAuthorizationCopyWithImpl(this._self, this._then);

  final _DriveAuthorization _self;
  final $Res Function(_DriveAuthorization) _then;

/// Create a copy of DriveAuthorization
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? status = null,Object? userCode = freezed,Object? verificationUrl = freezed,Object? expiresAt = freezed,Object? accountId = freezed,Object? error = freezed,}) {
  return _then(_DriveAuthorization(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DriveAuthorizationStatus,userCode: freezed == userCode ? _self.userCode : userCode // ignore: cast_nullable_to_non_nullable
as String?,verificationUrl: freezed == verificationUrl ? _self.verificationUrl : verificationUrl // ignore: cast_nullable_to_non_nullable
as Uri?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as DriveFailure?,
  ));
}


}


/// @nodoc
mixin _$DriveFolder {

 String get name; String get path;
/// Create a copy of DriveFolder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveFolderCopyWith<DriveFolder> get copyWith => _$DriveFolderCopyWithImpl<DriveFolder>(this as DriveFolder, _$identity);

  /// Serializes this DriveFolder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriveFolder;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveFolder&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.path, _this.path) || other.path == _this.path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriveFolder;
  return Object.hash(runtimeType,_this.name,_this.path);
}

@override
String toString() {
  final _this = this as DriveFolder;
  return 'DriveFolder(name: ${_this.name}, path: ${_this.path})';
}


}

/// @nodoc
abstract mixin class $DriveFolderCopyWith<$Res>  {
  factory $DriveFolderCopyWith(DriveFolder value, $Res Function(DriveFolder) _then) = _$DriveFolderCopyWithImpl;
@useResult
$Res call({
 String name, String path
});




}
/// @nodoc
class _$DriveFolderCopyWithImpl<$Res>
    implements $DriveFolderCopyWith<$Res> {
  _$DriveFolderCopyWithImpl(this._self, this._then);

  final DriveFolder _self;
  final $Res Function(DriveFolder) _then;

/// Create a copy of DriveFolder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? path = null,}) {
  return _then(DriveFolder(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DriveFolder].
extension DriveFolderPatterns on DriveFolder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveFolder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveFolder() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveFolder value)  $default,){
final _that = this;
switch (_that) {
case _DriveFolder():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveFolder value)?  $default,){
final _that = this;
switch (_that) {
case _DriveFolder() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveFolder() when $default != null:
return $default(_that.name,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String path)  $default,) {final _that = this;
switch (_that) {
case _DriveFolder():
return $default(_that.name,_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String path)?  $default,) {final _that = this;
switch (_that) {
case _DriveFolder() when $default != null:
return $default(_that.name,_that.path);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriveFolder implements DriveFolder {
  const _DriveFolder({required this.name, required this.path});
  factory _DriveFolder.fromJson(Map<String, dynamic> json) => _$DriveFolderFromJson(json);

@override final  String name;
@override final  String path;

/// Create a copy of DriveFolder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveFolderCopyWith<_DriveFolder> get copyWith => __$DriveFolderCopyWithImpl<_DriveFolder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriveFolderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveFolder&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,path);
}

@override
String toString() {
    return 'DriveFolder(name: $name, path: $path)';
}


}

/// @nodoc
abstract mixin class _$DriveFolderCopyWith<$Res> implements $DriveFolderCopyWith<$Res> {
  factory _$DriveFolderCopyWith(_DriveFolder value, $Res Function(_DriveFolder) _then) = __$DriveFolderCopyWithImpl;
@override @useResult
$Res call({
 String name, String path
});




}
/// @nodoc
class __$DriveFolderCopyWithImpl<$Res>
    implements _$DriveFolderCopyWith<$Res> {
  __$DriveFolderCopyWithImpl(this._self, this._then);

  final _DriveFolder _self;
  final $Res Function(_DriveFolder) _then;

/// Create a copy of DriveFolder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? path = null,}) {
  return _then(_DriveFolder(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DriveFolderPage {

 String get path; List<DriveFolder> get folders; int get offset; int? get nextOffset;
/// Create a copy of DriveFolderPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveFolderPageCopyWith<DriveFolderPage> get copyWith => _$DriveFolderPageCopyWithImpl<DriveFolderPage>(this as DriveFolderPage, _$identity);

  /// Serializes this DriveFolderPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriveFolderPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveFolderPage&&(identical(other.path, _this.path) || other.path == _this.path)&&const DeepCollectionEquality().equals(other.folders, _this.folders)&&(identical(other.offset, _this.offset) || other.offset == _this.offset)&&(identical(other.nextOffset, _this.nextOffset) || other.nextOffset == _this.nextOffset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriveFolderPage;
  return Object.hash(runtimeType,_this.path,const DeepCollectionEquality().hash(_this.folders),_this.offset,_this.nextOffset);
}

@override
String toString() {
  final _this = this as DriveFolderPage;
  return 'DriveFolderPage(path: ${_this.path}, folders: ${_this.folders}, offset: ${_this.offset}, nextOffset: ${_this.nextOffset})';
}


}

/// @nodoc
abstract mixin class $DriveFolderPageCopyWith<$Res>  {
  factory $DriveFolderPageCopyWith(DriveFolderPage value, $Res Function(DriveFolderPage) _then) = _$DriveFolderPageCopyWithImpl;
@useResult
$Res call({
 String path, List<DriveFolder> folders, int offset, int? nextOffset
});




}
/// @nodoc
class _$DriveFolderPageCopyWithImpl<$Res>
    implements $DriveFolderPageCopyWith<$Res> {
  _$DriveFolderPageCopyWithImpl(this._self, this._then);

  final DriveFolderPage _self;
  final $Res Function(DriveFolderPage) _then;

/// Create a copy of DriveFolderPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? folders = null,Object? offset = null,Object? nextOffset = freezed,}) {
  return _then(DriveFolderPage(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,folders: null == folders ? _self.folders : folders // ignore: cast_nullable_to_non_nullable
as List<DriveFolder>,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,nextOffset: freezed == nextOffset ? _self.nextOffset : nextOffset // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DriveFolderPage].
extension DriveFolderPagePatterns on DriveFolderPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveFolderPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveFolderPage() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveFolderPage value)  $default,){
final _that = this;
switch (_that) {
case _DriveFolderPage():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveFolderPage value)?  $default,){
final _that = this;
switch (_that) {
case _DriveFolderPage() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  List<DriveFolder> folders,  int offset,  int? nextOffset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveFolderPage() when $default != null:
return $default(_that.path,_that.folders,_that.offset,_that.nextOffset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  List<DriveFolder> folders,  int offset,  int? nextOffset)  $default,) {final _that = this;
switch (_that) {
case _DriveFolderPage():
return $default(_that.path,_that.folders,_that.offset,_that.nextOffset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  List<DriveFolder> folders,  int offset,  int? nextOffset)?  $default,) {final _that = this;
switch (_that) {
case _DriveFolderPage() when $default != null:
return $default(_that.path,_that.folders,_that.offset,_that.nextOffset);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _DriveFolderPage implements DriveFolderPage {
  const _DriveFolderPage({required this.path,  List<DriveFolder> folders = const [], this.offset = 0, this.nextOffset}): _folders = folders;
  factory _DriveFolderPage.fromJson(Map<String, dynamic> json) => _$DriveFolderPageFromJson(json);

@override final  String path;
 final  List<DriveFolder> _folders;
@override@JsonKey() List<DriveFolder> get folders {
  if (_folders is EqualUnmodifiableListView) return _folders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_folders);
}

@override@JsonKey() final  int offset;
@override final  int? nextOffset;

/// Create a copy of DriveFolderPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveFolderPageCopyWith<_DriveFolderPage> get copyWith => __$DriveFolderPageCopyWithImpl<_DriveFolderPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriveFolderPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveFolderPage&&(identical(other.path, path) || other.path == path)&&const DeepCollectionEquality().equals(other.folders, _folders)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.nextOffset, nextOffset) || other.nextOffset == nextOffset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,path,const DeepCollectionEquality().hash(_folders),offset,nextOffset);
}

@override
String toString() {
    return 'DriveFolderPage(path: $path, folders: $folders, offset: $offset, nextOffset: $nextOffset)';
}


}

/// @nodoc
abstract mixin class _$DriveFolderPageCopyWith<$Res> implements $DriveFolderPageCopyWith<$Res> {
  factory _$DriveFolderPageCopyWith(_DriveFolderPage value, $Res Function(_DriveFolderPage) _then) = __$DriveFolderPageCopyWithImpl;
@override @useResult
$Res call({
 String path, List<DriveFolder> folders, int offset, int? nextOffset
});




}
/// @nodoc
class __$DriveFolderPageCopyWithImpl<$Res>
    implements _$DriveFolderPageCopyWith<$Res> {
  __$DriveFolderPageCopyWithImpl(this._self, this._then);

  final _DriveFolderPage _self;
  final $Res Function(_DriveFolderPage) _then;

/// Create a copy of DriveFolderPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? folders = null,Object? offset = null,Object? nextOffset = freezed,}) {
  return _then(_DriveFolderPage(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,folders: null == folders ? _self._folders : folders // ignore: cast_nullable_to_non_nullable
as List<DriveFolder>,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,nextOffset: freezed == nextOffset ? _self.nextOffset : nextOffset // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DriveRuntime {

 bool get active; bool get running; bool get paused; DateTime? get lastSync; int get downloaded; int get skipped; int get failed;@JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? get error;
/// Create a copy of DriveRuntime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveRuntimeCopyWith<DriveRuntime> get copyWith => _$DriveRuntimeCopyWithImpl<DriveRuntime>(this as DriveRuntime, _$identity);

  /// Serializes this DriveRuntime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriveRuntime;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveRuntime&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.running, _this.running) || other.running == _this.running)&&(identical(other.paused, _this.paused) || other.paused == _this.paused)&&(identical(other.lastSync, _this.lastSync) || other.lastSync == _this.lastSync)&&(identical(other.downloaded, _this.downloaded) || other.downloaded == _this.downloaded)&&(identical(other.skipped, _this.skipped) || other.skipped == _this.skipped)&&(identical(other.failed, _this.failed) || other.failed == _this.failed)&&(identical(other.error, _this.error) || other.error == _this.error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriveRuntime;
  return Object.hash(runtimeType,_this.active,_this.running,_this.paused,_this.lastSync,_this.downloaded,_this.skipped,_this.failed,_this.error);
}

@override
String toString() {
  final _this = this as DriveRuntime;
  return 'DriveRuntime(active: ${_this.active}, running: ${_this.running}, paused: ${_this.paused}, lastSync: ${_this.lastSync}, downloaded: ${_this.downloaded}, skipped: ${_this.skipped}, failed: ${_this.failed}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $DriveRuntimeCopyWith<$Res>  {
  factory $DriveRuntimeCopyWith(DriveRuntime value, $Res Function(DriveRuntime) _then) = _$DriveRuntimeCopyWithImpl;
@useResult
$Res call({
 bool active, bool running, bool paused, DateTime? lastSync, int downloaded, int skipped, int failed,@JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? error
});




}
/// @nodoc
class _$DriveRuntimeCopyWithImpl<$Res>
    implements $DriveRuntimeCopyWith<$Res> {
  _$DriveRuntimeCopyWithImpl(this._self, this._then);

  final DriveRuntime _self;
  final $Res Function(DriveRuntime) _then;

/// Create a copy of DriveRuntime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? active = null,Object? running = null,Object? paused = null,Object? lastSync = freezed,Object? downloaded = null,Object? skipped = null,Object? failed = null,Object? error = freezed,}) {
  return _then(DriveRuntime(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,paused: null == paused ? _self.paused : paused // ignore: cast_nullable_to_non_nullable
as bool,lastSync: freezed == lastSync ? _self.lastSync : lastSync // ignore: cast_nullable_to_non_nullable
as DateTime?,downloaded: null == downloaded ? _self.downloaded : downloaded // ignore: cast_nullable_to_non_nullable
as int,skipped: null == skipped ? _self.skipped : skipped // ignore: cast_nullable_to_non_nullable
as int,failed: null == failed ? _self.failed : failed // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as DriveFailure?,
  ));
}

}


/// Adds pattern-matching-related methods to [DriveRuntime].
extension DriveRuntimePatterns on DriveRuntime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveRuntime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveRuntime() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveRuntime value)  $default,){
final _that = this;
switch (_that) {
case _DriveRuntime():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveRuntime value)?  $default,){
final _that = this;
switch (_that) {
case _DriveRuntime() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool active,  bool running,  bool paused,  DateTime? lastSync,  int downloaded,  int skipped,  int failed, @JsonKey(unknownEnumValue: DriveFailure.unknown)  DriveFailure? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveRuntime() when $default != null:
return $default(_that.active,_that.running,_that.paused,_that.lastSync,_that.downloaded,_that.skipped,_that.failed,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool active,  bool running,  bool paused,  DateTime? lastSync,  int downloaded,  int skipped,  int failed, @JsonKey(unknownEnumValue: DriveFailure.unknown)  DriveFailure? error)  $default,) {final _that = this;
switch (_that) {
case _DriveRuntime():
return $default(_that.active,_that.running,_that.paused,_that.lastSync,_that.downloaded,_that.skipped,_that.failed,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool active,  bool running,  bool paused,  DateTime? lastSync,  int downloaded,  int skipped,  int failed, @JsonKey(unknownEnumValue: DriveFailure.unknown)  DriveFailure? error)?  $default,) {final _that = this;
switch (_that) {
case _DriveRuntime() when $default != null:
return $default(_that.active,_that.running,_that.paused,_that.lastSync,_that.downloaded,_that.skipped,_that.failed,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriveRuntime implements DriveRuntime {
  const _DriveRuntime({this.active = false, this.running = false, this.paused = false, this.lastSync, this.downloaded = 0, this.skipped = 0, this.failed = 0, @JsonKey(unknownEnumValue: DriveFailure.unknown) this.error});
  factory _DriveRuntime.fromJson(Map<String, dynamic> json) => _$DriveRuntimeFromJson(json);

@override@JsonKey() final  bool active;
@override@JsonKey() final  bool running;
@override@JsonKey() final  bool paused;
@override final  DateTime? lastSync;
@override@JsonKey() final  int downloaded;
@override@JsonKey() final  int skipped;
@override@JsonKey() final  int failed;
@override@JsonKey(unknownEnumValue: DriveFailure.unknown) final  DriveFailure? error;

/// Create a copy of DriveRuntime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveRuntimeCopyWith<_DriveRuntime> get copyWith => __$DriveRuntimeCopyWithImpl<_DriveRuntime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriveRuntimeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveRuntime&&(identical(other.active, active) || other.active == active)&&(identical(other.running, running) || other.running == running)&&(identical(other.paused, paused) || other.paused == paused)&&(identical(other.lastSync, lastSync) || other.lastSync == lastSync)&&(identical(other.downloaded, downloaded) || other.downloaded == downloaded)&&(identical(other.skipped, skipped) || other.skipped == skipped)&&(identical(other.failed, failed) || other.failed == failed)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,active,running,paused,lastSync,downloaded,skipped,failed,error);
}

@override
String toString() {
    return 'DriveRuntime(active: $active, running: $running, paused: $paused, lastSync: $lastSync, downloaded: $downloaded, skipped: $skipped, failed: $failed, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DriveRuntimeCopyWith<$Res> implements $DriveRuntimeCopyWith<$Res> {
  factory _$DriveRuntimeCopyWith(_DriveRuntime value, $Res Function(_DriveRuntime) _then) = __$DriveRuntimeCopyWithImpl;
@override @useResult
$Res call({
 bool active, bool running, bool paused, DateTime? lastSync, int downloaded, int skipped, int failed,@JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? error
});




}
/// @nodoc
class __$DriveRuntimeCopyWithImpl<$Res>
    implements _$DriveRuntimeCopyWith<$Res> {
  __$DriveRuntimeCopyWithImpl(this._self, this._then);

  final _DriveRuntime _self;
  final $Res Function(_DriveRuntime) _then;

/// Create a copy of DriveRuntime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? active = null,Object? running = null,Object? paused = null,Object? lastSync = freezed,Object? downloaded = null,Object? skipped = null,Object? failed = null,Object? error = freezed,}) {
  return _then(_DriveRuntime(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,paused: null == paused ? _self.paused : paused // ignore: cast_nullable_to_non_nullable
as bool,lastSync: freezed == lastSync ? _self.lastSync : lastSync // ignore: cast_nullable_to_non_nullable
as DateTime?,downloaded: null == downloaded ? _self.downloaded : downloaded // ignore: cast_nullable_to_non_nullable
as int,skipped: null == skipped ? _self.skipped : skipped // ignore: cast_nullable_to_non_nullable
as int,failed: null == failed ? _self.failed : failed // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as DriveFailure?,
  ));
}


}

// dart format on
