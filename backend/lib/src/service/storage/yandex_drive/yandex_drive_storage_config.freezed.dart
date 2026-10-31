// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yandex_drive_storage_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YandexDriveStorageConfig {

@YandexSyncPeriodConverter() Duration get syncPeriod; List<YandexDriveAccountConfig> get accounts;
/// Create a copy of YandexDriveStorageConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexDriveStorageConfigCopyWith<YandexDriveStorageConfig> get copyWith => _$YandexDriveStorageConfigCopyWithImpl<YandexDriveStorageConfig>(this as YandexDriveStorageConfig, _$identity);

  /// Serializes this YandexDriveStorageConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YandexDriveStorageConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexDriveStorageConfig&&(identical(other.syncPeriod, _this.syncPeriod) || other.syncPeriod == _this.syncPeriod)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YandexDriveStorageConfig;
  return Object.hash(runtimeType,_this.syncPeriod,const DeepCollectionEquality().hash(_this.accounts));
}

@override
String toString() {
  final _this = this as YandexDriveStorageConfig;
  return 'YandexDriveStorageConfig(syncPeriod: ${_this.syncPeriod}, accounts: ${_this.accounts})';
}


}

/// @nodoc
abstract mixin class $YandexDriveStorageConfigCopyWith<$Res>  {
  factory $YandexDriveStorageConfigCopyWith(YandexDriveStorageConfig value, $Res Function(YandexDriveStorageConfig) _then) = _$YandexDriveStorageConfigCopyWithImpl;
@useResult
$Res call({
@YandexSyncPeriodConverter() Duration syncPeriod, List<YandexDriveAccountConfig> accounts
});




}
/// @nodoc
class _$YandexDriveStorageConfigCopyWithImpl<$Res>
    implements $YandexDriveStorageConfigCopyWith<$Res> {
  _$YandexDriveStorageConfigCopyWithImpl(this._self, this._then);

  final YandexDriveStorageConfig _self;
  final $Res Function(YandexDriveStorageConfig) _then;

/// Create a copy of YandexDriveStorageConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? syncPeriod = null,Object? accounts = null,}) {
  return _then(YandexDriveStorageConfig(
syncPeriod: null == syncPeriod ? _self.syncPeriod : syncPeriod // ignore: cast_nullable_to_non_nullable
as Duration,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<YandexDriveAccountConfig>,
  ));
}

}


/// Adds pattern-matching-related methods to [YandexDriveStorageConfig].
extension YandexDriveStorageConfigPatterns on YandexDriveStorageConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexDriveStorageConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexDriveStorageConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexDriveStorageConfig value)  $default,){
final _that = this;
switch (_that) {
case _YandexDriveStorageConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexDriveStorageConfig value)?  $default,){
final _that = this;
switch (_that) {
case _YandexDriveStorageConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@YandexSyncPeriodConverter()  Duration syncPeriod,  List<YandexDriveAccountConfig> accounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexDriveStorageConfig() when $default != null:
return $default(_that.syncPeriod,_that.accounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@YandexSyncPeriodConverter()  Duration syncPeriod,  List<YandexDriveAccountConfig> accounts)  $default,) {final _that = this;
switch (_that) {
case _YandexDriveStorageConfig():
return $default(_that.syncPeriod,_that.accounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@YandexSyncPeriodConverter()  Duration syncPeriod,  List<YandexDriveAccountConfig> accounts)?  $default,) {final _that = this;
switch (_that) {
case _YandexDriveStorageConfig() when $default != null:
return $default(_that.syncPeriod,_that.accounts);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _YandexDriveStorageConfig extends YandexDriveStorageConfig {
  const _YandexDriveStorageConfig({@YandexSyncPeriodConverter() this.syncPeriod = const Duration(hours: 1),  List<YandexDriveAccountConfig> accounts = const []}): _accounts = accounts,super._();
  factory _YandexDriveStorageConfig.fromJson(Map<String, dynamic> json) => _$YandexDriveStorageConfigFromJson(json);

@override@JsonKey()@YandexSyncPeriodConverter() final  Duration syncPeriod;
 final  List<YandexDriveAccountConfig> _accounts;
@override@JsonKey() List<YandexDriveAccountConfig> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}


/// Create a copy of YandexDriveStorageConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexDriveStorageConfigCopyWith<_YandexDriveStorageConfig> get copyWith => __$YandexDriveStorageConfigCopyWithImpl<_YandexDriveStorageConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YandexDriveStorageConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexDriveStorageConfig&&(identical(other.syncPeriod, syncPeriod) || other.syncPeriod == syncPeriod)&&const DeepCollectionEquality().equals(other.accounts, _accounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,syncPeriod,const DeepCollectionEquality().hash(_accounts));
}

@override
String toString() {
    return 'YandexDriveStorageConfig(syncPeriod: $syncPeriod, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class _$YandexDriveStorageConfigCopyWith<$Res> implements $YandexDriveStorageConfigCopyWith<$Res> {
  factory _$YandexDriveStorageConfigCopyWith(_YandexDriveStorageConfig value, $Res Function(_YandexDriveStorageConfig) _then) = __$YandexDriveStorageConfigCopyWithImpl;
@override @useResult
$Res call({
@YandexSyncPeriodConverter() Duration syncPeriod, List<YandexDriveAccountConfig> accounts
});




}
/// @nodoc
class __$YandexDriveStorageConfigCopyWithImpl<$Res>
    implements _$YandexDriveStorageConfigCopyWith<$Res> {
  __$YandexDriveStorageConfigCopyWithImpl(this._self, this._then);

  final _YandexDriveStorageConfig _self;
  final $Res Function(_YandexDriveStorageConfig) _then;

/// Create a copy of YandexDriveStorageConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? syncPeriod = null,Object? accounts = null,}) {
  return _then(_YandexDriveStorageConfig(
syncPeriod: null == syncPeriod ? _self.syncPeriod : syncPeriod // ignore: cast_nullable_to_non_nullable
as Duration,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<YandexDriveAccountConfig>,
  ));
}


}


/// @nodoc
mixin _$YandexDriveAccountConfig {

 String get accountId; String get label; List<String> get paths; bool get enabled;
/// Create a copy of YandexDriveAccountConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexDriveAccountConfigCopyWith<YandexDriveAccountConfig> get copyWith => _$YandexDriveAccountConfigCopyWithImpl<YandexDriveAccountConfig>(this as YandexDriveAccountConfig, _$identity);

  /// Serializes this YandexDriveAccountConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YandexDriveAccountConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexDriveAccountConfig&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.label, _this.label) || other.label == _this.label)&&const DeepCollectionEquality().equals(other.paths, _this.paths)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YandexDriveAccountConfig;
  return Object.hash(runtimeType,_this.accountId,_this.label,const DeepCollectionEquality().hash(_this.paths),_this.enabled);
}

@override
String toString() {
  final _this = this as YandexDriveAccountConfig;
  return 'YandexDriveAccountConfig(accountId: ${_this.accountId}, label: ${_this.label}, paths: ${_this.paths}, enabled: ${_this.enabled})';
}


}

/// @nodoc
abstract mixin class $YandexDriveAccountConfigCopyWith<$Res>  {
  factory $YandexDriveAccountConfigCopyWith(YandexDriveAccountConfig value, $Res Function(YandexDriveAccountConfig) _then) = _$YandexDriveAccountConfigCopyWithImpl;
@useResult
$Res call({
 String accountId, String label, List<String> paths, bool enabled
});




}
/// @nodoc
class _$YandexDriveAccountConfigCopyWithImpl<$Res>
    implements $YandexDriveAccountConfigCopyWith<$Res> {
  _$YandexDriveAccountConfigCopyWithImpl(this._self, this._then);

  final YandexDriveAccountConfig _self;
  final $Res Function(YandexDriveAccountConfig) _then;

/// Create a copy of YandexDriveAccountConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? label = null,Object? paths = null,Object? enabled = null,}) {
  return _then(YandexDriveAccountConfig(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,paths: null == paths ? _self.paths : paths // ignore: cast_nullable_to_non_nullable
as List<String>,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [YandexDriveAccountConfig].
extension YandexDriveAccountConfigPatterns on YandexDriveAccountConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexDriveAccountConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexDriveAccountConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexDriveAccountConfig value)  $default,){
final _that = this;
switch (_that) {
case _YandexDriveAccountConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexDriveAccountConfig value)?  $default,){
final _that = this;
switch (_that) {
case _YandexDriveAccountConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountId,  String label,  List<String> paths,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexDriveAccountConfig() when $default != null:
return $default(_that.accountId,_that.label,_that.paths,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountId,  String label,  List<String> paths,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _YandexDriveAccountConfig():
return $default(_that.accountId,_that.label,_that.paths,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountId,  String label,  List<String> paths,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _YandexDriveAccountConfig() when $default != null:
return $default(_that.accountId,_that.label,_that.paths,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YandexDriveAccountConfig implements YandexDriveAccountConfig {
  const _YandexDriveAccountConfig({required this.accountId, this.label = '',  List<String> paths = const [], this.enabled = true}): _paths = paths;
  factory _YandexDriveAccountConfig.fromJson(Map<String, dynamic> json) => _$YandexDriveAccountConfigFromJson(json);

@override final  String accountId;
@override@JsonKey() final  String label;
 final  List<String> _paths;
@override@JsonKey() List<String> get paths {
  if (_paths is EqualUnmodifiableListView) return _paths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paths);
}

@override@JsonKey() final  bool enabled;

/// Create a copy of YandexDriveAccountConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexDriveAccountConfigCopyWith<_YandexDriveAccountConfig> get copyWith => __$YandexDriveAccountConfigCopyWithImpl<_YandexDriveAccountConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YandexDriveAccountConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexDriveAccountConfig&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.paths, _paths)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,accountId,label,const DeepCollectionEquality().hash(_paths),enabled);
}

@override
String toString() {
    return 'YandexDriveAccountConfig(accountId: $accountId, label: $label, paths: $paths, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$YandexDriveAccountConfigCopyWith<$Res> implements $YandexDriveAccountConfigCopyWith<$Res> {
  factory _$YandexDriveAccountConfigCopyWith(_YandexDriveAccountConfig value, $Res Function(_YandexDriveAccountConfig) _then) = __$YandexDriveAccountConfigCopyWithImpl;
@override @useResult
$Res call({
 String accountId, String label, List<String> paths, bool enabled
});




}
/// @nodoc
class __$YandexDriveAccountConfigCopyWithImpl<$Res>
    implements _$YandexDriveAccountConfigCopyWith<$Res> {
  __$YandexDriveAccountConfigCopyWithImpl(this._self, this._then);

  final _YandexDriveAccountConfig _self;
  final $Res Function(_YandexDriveAccountConfig) _then;

/// Create a copy of YandexDriveAccountConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? label = null,Object? paths = null,Object? enabled = null,}) {
  return _then(_YandexDriveAccountConfig(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,paths: null == paths ? _self._paths : paths // ignore: cast_nullable_to_non_nullable
as List<String>,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
