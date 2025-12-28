// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wifi_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WiFiScanCommand {

 int get id; String get type;
/// Create a copy of WiFiScanCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WiFiScanCommandCopyWith<WiFiScanCommand> get copyWith => _$WiFiScanCommandCopyWithImpl<WiFiScanCommand>(this as WiFiScanCommand, _$identity);

  /// Serializes this WiFiScanCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WiFiScanCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type);

@override
String toString() {
  return 'WiFiScanCommand(id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $WiFiScanCommandCopyWith<$Res>  {
  factory $WiFiScanCommandCopyWith(WiFiScanCommand value, $Res Function(WiFiScanCommand) _then) = _$WiFiScanCommandCopyWithImpl;
@useResult
$Res call({
 int id, String type
});




}
/// @nodoc
class _$WiFiScanCommandCopyWithImpl<$Res>
    implements $WiFiScanCommandCopyWith<$Res> {
  _$WiFiScanCommandCopyWithImpl(this._self, this._then);

  final WiFiScanCommand _self;
  final $Res Function(WiFiScanCommand) _then;

/// Create a copy of WiFiScanCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WiFiScanCommand].
extension WiFiScanCommandPatterns on WiFiScanCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WiFiScanCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WiFiScanCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WiFiScanCommand value)  $default,){
final _that = this;
switch (_that) {
case _WiFiScanCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WiFiScanCommand value)?  $default,){
final _that = this;
switch (_that) {
case _WiFiScanCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WiFiScanCommand() when $default != null:
return $default(_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _WiFiScanCommand():
return $default(_that.id,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _WiFiScanCommand() when $default != null:
return $default(_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WiFiScanCommand implements WiFiScanCommand {
  const _WiFiScanCommand({required this.id, this.type = WiFiScanCommand.TYPE});
  factory _WiFiScanCommand.fromJson(Map<String, dynamic> json) => _$WiFiScanCommandFromJson(json);

@override final  int id;
@override@JsonKey() final  String type;

/// Create a copy of WiFiScanCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WiFiScanCommandCopyWith<_WiFiScanCommand> get copyWith => __$WiFiScanCommandCopyWithImpl<_WiFiScanCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WiFiScanCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WiFiScanCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type);

@override
String toString() {
  return 'WiFiScanCommand(id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$WiFiScanCommandCopyWith<$Res> implements $WiFiScanCommandCopyWith<$Res> {
  factory _$WiFiScanCommandCopyWith(_WiFiScanCommand value, $Res Function(_WiFiScanCommand) _then) = __$WiFiScanCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, String type
});




}
/// @nodoc
class __$WiFiScanCommandCopyWithImpl<$Res>
    implements _$WiFiScanCommandCopyWith<$Res> {
  __$WiFiScanCommandCopyWithImpl(this._self, this._then);

  final _WiFiScanCommand _self;
  final $Res Function(_WiFiScanCommand) _then;

/// Create a copy of WiFiScanCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,}) {
  return _then(_WiFiScanCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WiFiScanResult {

 List<WiFiNetworkInfo> get networks; int get id;
/// Create a copy of WiFiScanResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WiFiScanResultCopyWith<WiFiScanResult> get copyWith => _$WiFiScanResultCopyWithImpl<WiFiScanResult>(this as WiFiScanResult, _$identity);

  /// Serializes this WiFiScanResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WiFiScanResult&&const DeepCollectionEquality().equals(other.networks, networks)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(networks),id);

@override
String toString() {
  return 'WiFiScanResult(networks: $networks, id: $id)';
}


}

/// @nodoc
abstract mixin class $WiFiScanResultCopyWith<$Res>  {
  factory $WiFiScanResultCopyWith(WiFiScanResult value, $Res Function(WiFiScanResult) _then) = _$WiFiScanResultCopyWithImpl;
@useResult
$Res call({
 List<WiFiNetworkInfo> networks, int id
});




}
/// @nodoc
class _$WiFiScanResultCopyWithImpl<$Res>
    implements $WiFiScanResultCopyWith<$Res> {
  _$WiFiScanResultCopyWithImpl(this._self, this._then);

  final WiFiScanResult _self;
  final $Res Function(WiFiScanResult) _then;

/// Create a copy of WiFiScanResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? networks = null,Object? id = null,}) {
  return _then(_self.copyWith(
networks: null == networks ? _self.networks : networks // ignore: cast_nullable_to_non_nullable
as List<WiFiNetworkInfo>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WiFiScanResult].
extension WiFiScanResultPatterns on WiFiScanResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WiFiScanResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WiFiScanResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WiFiScanResult value)  $default,){
final _that = this;
switch (_that) {
case _WiFiScanResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WiFiScanResult value)?  $default,){
final _that = this;
switch (_that) {
case _WiFiScanResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WiFiNetworkInfo> networks,  int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WiFiScanResult() when $default != null:
return $default(_that.networks,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WiFiNetworkInfo> networks,  int id)  $default,) {final _that = this;
switch (_that) {
case _WiFiScanResult():
return $default(_that.networks,_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WiFiNetworkInfo> networks,  int id)?  $default,) {final _that = this;
switch (_that) {
case _WiFiScanResult() when $default != null:
return $default(_that.networks,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WiFiScanResult implements WiFiScanResult {
  const _WiFiScanResult({required final  List<WiFiNetworkInfo> networks, required this.id}): _networks = networks;
  factory _WiFiScanResult.fromJson(Map<String, dynamic> json) => _$WiFiScanResultFromJson(json);

 final  List<WiFiNetworkInfo> _networks;
@override List<WiFiNetworkInfo> get networks {
  if (_networks is EqualUnmodifiableListView) return _networks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_networks);
}

@override final  int id;

/// Create a copy of WiFiScanResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WiFiScanResultCopyWith<_WiFiScanResult> get copyWith => __$WiFiScanResultCopyWithImpl<_WiFiScanResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WiFiScanResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WiFiScanResult&&const DeepCollectionEquality().equals(other._networks, _networks)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_networks),id);

@override
String toString() {
  return 'WiFiScanResult(networks: $networks, id: $id)';
}


}

/// @nodoc
abstract mixin class _$WiFiScanResultCopyWith<$Res> implements $WiFiScanResultCopyWith<$Res> {
  factory _$WiFiScanResultCopyWith(_WiFiScanResult value, $Res Function(_WiFiScanResult) _then) = __$WiFiScanResultCopyWithImpl;
@override @useResult
$Res call({
 List<WiFiNetworkInfo> networks, int id
});




}
/// @nodoc
class __$WiFiScanResultCopyWithImpl<$Res>
    implements _$WiFiScanResultCopyWith<$Res> {
  __$WiFiScanResultCopyWithImpl(this._self, this._then);

  final _WiFiScanResult _self;
  final $Res Function(_WiFiScanResult) _then;

/// Create a copy of WiFiScanResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? networks = null,Object? id = null,}) {
  return _then(_WiFiScanResult(
networks: null == networks ? _self._networks : networks // ignore: cast_nullable_to_non_nullable
as List<WiFiNetworkInfo>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WiFiNetworkInfo {

 String get BSSID; String get SSID; int get signal; int get channel; int get rate; String get security;
/// Create a copy of WiFiNetworkInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WiFiNetworkInfoCopyWith<WiFiNetworkInfo> get copyWith => _$WiFiNetworkInfoCopyWithImpl<WiFiNetworkInfo>(this as WiFiNetworkInfo, _$identity);

  /// Serializes this WiFiNetworkInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WiFiNetworkInfo&&(identical(other.BSSID, BSSID) || other.BSSID == BSSID)&&(identical(other.SSID, SSID) || other.SSID == SSID)&&(identical(other.signal, signal) || other.signal == signal)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.security, security) || other.security == security));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,BSSID,SSID,signal,channel,rate,security);

@override
String toString() {
  return 'WiFiNetworkInfo(BSSID: $BSSID, SSID: $SSID, signal: $signal, channel: $channel, rate: $rate, security: $security)';
}


}

/// @nodoc
abstract mixin class $WiFiNetworkInfoCopyWith<$Res>  {
  factory $WiFiNetworkInfoCopyWith(WiFiNetworkInfo value, $Res Function(WiFiNetworkInfo) _then) = _$WiFiNetworkInfoCopyWithImpl;
@useResult
$Res call({
 String BSSID, String SSID, int signal, int channel, int rate, String security
});




}
/// @nodoc
class _$WiFiNetworkInfoCopyWithImpl<$Res>
    implements $WiFiNetworkInfoCopyWith<$Res> {
  _$WiFiNetworkInfoCopyWithImpl(this._self, this._then);

  final WiFiNetworkInfo _self;
  final $Res Function(WiFiNetworkInfo) _then;

/// Create a copy of WiFiNetworkInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? BSSID = null,Object? SSID = null,Object? signal = null,Object? channel = null,Object? rate = null,Object? security = null,}) {
  return _then(_self.copyWith(
BSSID: null == BSSID ? _self.BSSID : BSSID // ignore: cast_nullable_to_non_nullable
as String,SSID: null == SSID ? _self.SSID : SSID // ignore: cast_nullable_to_non_nullable
as String,signal: null == signal ? _self.signal : signal // ignore: cast_nullable_to_non_nullable
as int,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as int,security: null == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WiFiNetworkInfo].
extension WiFiNetworkInfoPatterns on WiFiNetworkInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WiFiNetworkInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WiFiNetworkInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WiFiNetworkInfo value)  $default,){
final _that = this;
switch (_that) {
case _WiFiNetworkInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WiFiNetworkInfo value)?  $default,){
final _that = this;
switch (_that) {
case _WiFiNetworkInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String BSSID,  String SSID,  int signal,  int channel,  int rate,  String security)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WiFiNetworkInfo() when $default != null:
return $default(_that.BSSID,_that.SSID,_that.signal,_that.channel,_that.rate,_that.security);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String BSSID,  String SSID,  int signal,  int channel,  int rate,  String security)  $default,) {final _that = this;
switch (_that) {
case _WiFiNetworkInfo():
return $default(_that.BSSID,_that.SSID,_that.signal,_that.channel,_that.rate,_that.security);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String BSSID,  String SSID,  int signal,  int channel,  int rate,  String security)?  $default,) {final _that = this;
switch (_that) {
case _WiFiNetworkInfo() when $default != null:
return $default(_that.BSSID,_that.SSID,_that.signal,_that.channel,_that.rate,_that.security);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WiFiNetworkInfo implements WiFiNetworkInfo {
  const _WiFiNetworkInfo({required this.BSSID, required this.SSID, required this.signal, required this.channel, required this.rate, required this.security});
  factory _WiFiNetworkInfo.fromJson(Map<String, dynamic> json) => _$WiFiNetworkInfoFromJson(json);

@override final  String BSSID;
@override final  String SSID;
@override final  int signal;
@override final  int channel;
@override final  int rate;
@override final  String security;

/// Create a copy of WiFiNetworkInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WiFiNetworkInfoCopyWith<_WiFiNetworkInfo> get copyWith => __$WiFiNetworkInfoCopyWithImpl<_WiFiNetworkInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WiFiNetworkInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WiFiNetworkInfo&&(identical(other.BSSID, BSSID) || other.BSSID == BSSID)&&(identical(other.SSID, SSID) || other.SSID == SSID)&&(identical(other.signal, signal) || other.signal == signal)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.security, security) || other.security == security));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,BSSID,SSID,signal,channel,rate,security);

@override
String toString() {
  return 'WiFiNetworkInfo(BSSID: $BSSID, SSID: $SSID, signal: $signal, channel: $channel, rate: $rate, security: $security)';
}


}

/// @nodoc
abstract mixin class _$WiFiNetworkInfoCopyWith<$Res> implements $WiFiNetworkInfoCopyWith<$Res> {
  factory _$WiFiNetworkInfoCopyWith(_WiFiNetworkInfo value, $Res Function(_WiFiNetworkInfo) _then) = __$WiFiNetworkInfoCopyWithImpl;
@override @useResult
$Res call({
 String BSSID, String SSID, int signal, int channel, int rate, String security
});




}
/// @nodoc
class __$WiFiNetworkInfoCopyWithImpl<$Res>
    implements _$WiFiNetworkInfoCopyWith<$Res> {
  __$WiFiNetworkInfoCopyWithImpl(this._self, this._then);

  final _WiFiNetworkInfo _self;
  final $Res Function(_WiFiNetworkInfo) _then;

/// Create a copy of WiFiNetworkInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? BSSID = null,Object? SSID = null,Object? signal = null,Object? channel = null,Object? rate = null,Object? security = null,}) {
  return _then(_WiFiNetworkInfo(
BSSID: null == BSSID ? _self.BSSID : BSSID // ignore: cast_nullable_to_non_nullable
as String,SSID: null == SSID ? _self.SSID : SSID // ignore: cast_nullable_to_non_nullable
as String,signal: null == signal ? _self.signal : signal // ignore: cast_nullable_to_non_nullable
as int,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as int,security: null == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WiFiConnectionInfo {

 String get name; String get UUID; String get type; String get device;
/// Create a copy of WiFiConnectionInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WiFiConnectionInfoCopyWith<WiFiConnectionInfo> get copyWith => _$WiFiConnectionInfoCopyWithImpl<WiFiConnectionInfo>(this as WiFiConnectionInfo, _$identity);

  /// Serializes this WiFiConnectionInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WiFiConnectionInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.UUID, UUID) || other.UUID == UUID)&&(identical(other.type, type) || other.type == type)&&(identical(other.device, device) || other.device == device));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,UUID,type,device);

@override
String toString() {
  return 'WiFiConnectionInfo(name: $name, UUID: $UUID, type: $type, device: $device)';
}


}

/// @nodoc
abstract mixin class $WiFiConnectionInfoCopyWith<$Res>  {
  factory $WiFiConnectionInfoCopyWith(WiFiConnectionInfo value, $Res Function(WiFiConnectionInfo) _then) = _$WiFiConnectionInfoCopyWithImpl;
@useResult
$Res call({
 String name, String UUID, String type, String device
});




}
/// @nodoc
class _$WiFiConnectionInfoCopyWithImpl<$Res>
    implements $WiFiConnectionInfoCopyWith<$Res> {
  _$WiFiConnectionInfoCopyWithImpl(this._self, this._then);

  final WiFiConnectionInfo _self;
  final $Res Function(WiFiConnectionInfo) _then;

/// Create a copy of WiFiConnectionInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? UUID = null,Object? type = null,Object? device = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,UUID: null == UUID ? _self.UUID : UUID // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,device: null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WiFiConnectionInfo].
extension WiFiConnectionInfoPatterns on WiFiConnectionInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WiFiConnectionInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WiFiConnectionInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WiFiConnectionInfo value)  $default,){
final _that = this;
switch (_that) {
case _WiFiConnectionInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WiFiConnectionInfo value)?  $default,){
final _that = this;
switch (_that) {
case _WiFiConnectionInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String UUID,  String type,  String device)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WiFiConnectionInfo() when $default != null:
return $default(_that.name,_that.UUID,_that.type,_that.device);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String UUID,  String type,  String device)  $default,) {final _that = this;
switch (_that) {
case _WiFiConnectionInfo():
return $default(_that.name,_that.UUID,_that.type,_that.device);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String UUID,  String type,  String device)?  $default,) {final _that = this;
switch (_that) {
case _WiFiConnectionInfo() when $default != null:
return $default(_that.name,_that.UUID,_that.type,_that.device);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WiFiConnectionInfo implements WiFiConnectionInfo {
  const _WiFiConnectionInfo({required this.name, required this.UUID, required this.type, required this.device});
  factory _WiFiConnectionInfo.fromJson(Map<String, dynamic> json) => _$WiFiConnectionInfoFromJson(json);

@override final  String name;
@override final  String UUID;
@override final  String type;
@override final  String device;

/// Create a copy of WiFiConnectionInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WiFiConnectionInfoCopyWith<_WiFiConnectionInfo> get copyWith => __$WiFiConnectionInfoCopyWithImpl<_WiFiConnectionInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WiFiConnectionInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WiFiConnectionInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.UUID, UUID) || other.UUID == UUID)&&(identical(other.type, type) || other.type == type)&&(identical(other.device, device) || other.device == device));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,UUID,type,device);

@override
String toString() {
  return 'WiFiConnectionInfo(name: $name, UUID: $UUID, type: $type, device: $device)';
}


}

/// @nodoc
abstract mixin class _$WiFiConnectionInfoCopyWith<$Res> implements $WiFiConnectionInfoCopyWith<$Res> {
  factory _$WiFiConnectionInfoCopyWith(_WiFiConnectionInfo value, $Res Function(_WiFiConnectionInfo) _then) = __$WiFiConnectionInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, String UUID, String type, String device
});




}
/// @nodoc
class __$WiFiConnectionInfoCopyWithImpl<$Res>
    implements _$WiFiConnectionInfoCopyWith<$Res> {
  __$WiFiConnectionInfoCopyWithImpl(this._self, this._then);

  final _WiFiConnectionInfo _self;
  final $Res Function(_WiFiConnectionInfo) _then;

/// Create a copy of WiFiConnectionInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? UUID = null,Object? type = null,Object? device = null,}) {
  return _then(_WiFiConnectionInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,UUID: null == UUID ? _self.UUID : UUID // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,device: null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WiFiRemoveCommand {

 String get connectionId; int get id; String get type;
/// Create a copy of WiFiRemoveCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WiFiRemoveCommandCopyWith<WiFiRemoveCommand> get copyWith => _$WiFiRemoveCommandCopyWithImpl<WiFiRemoveCommand>(this as WiFiRemoveCommand, _$identity);

  /// Serializes this WiFiRemoveCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WiFiRemoveCommand&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,connectionId,id,type);

@override
String toString() {
  return 'WiFiRemoveCommand(connectionId: $connectionId, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $WiFiRemoveCommandCopyWith<$Res>  {
  factory $WiFiRemoveCommandCopyWith(WiFiRemoveCommand value, $Res Function(WiFiRemoveCommand) _then) = _$WiFiRemoveCommandCopyWithImpl;
@useResult
$Res call({
 String connectionId, int id, String type
});




}
/// @nodoc
class _$WiFiRemoveCommandCopyWithImpl<$Res>
    implements $WiFiRemoveCommandCopyWith<$Res> {
  _$WiFiRemoveCommandCopyWithImpl(this._self, this._then);

  final WiFiRemoveCommand _self;
  final $Res Function(WiFiRemoveCommand) _then;

/// Create a copy of WiFiRemoveCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connectionId = null,Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WiFiRemoveCommand].
extension WiFiRemoveCommandPatterns on WiFiRemoveCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WiFiRemoveCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WiFiRemoveCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WiFiRemoveCommand value)  $default,){
final _that = this;
switch (_that) {
case _WiFiRemoveCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WiFiRemoveCommand value)?  $default,){
final _that = this;
switch (_that) {
case _WiFiRemoveCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String connectionId,  int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WiFiRemoveCommand() when $default != null:
return $default(_that.connectionId,_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String connectionId,  int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _WiFiRemoveCommand():
return $default(_that.connectionId,_that.id,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String connectionId,  int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _WiFiRemoveCommand() when $default != null:
return $default(_that.connectionId,_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WiFiRemoveCommand implements WiFiRemoveCommand {
  const _WiFiRemoveCommand({required this.connectionId, required this.id, this.type = WiFiRemoveCommand.TYPE});
  factory _WiFiRemoveCommand.fromJson(Map<String, dynamic> json) => _$WiFiRemoveCommandFromJson(json);

@override final  String connectionId;
@override final  int id;
@override@JsonKey() final  String type;

/// Create a copy of WiFiRemoveCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WiFiRemoveCommandCopyWith<_WiFiRemoveCommand> get copyWith => __$WiFiRemoveCommandCopyWithImpl<_WiFiRemoveCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WiFiRemoveCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WiFiRemoveCommand&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,connectionId,id,type);

@override
String toString() {
  return 'WiFiRemoveCommand(connectionId: $connectionId, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$WiFiRemoveCommandCopyWith<$Res> implements $WiFiRemoveCommandCopyWith<$Res> {
  factory _$WiFiRemoveCommandCopyWith(_WiFiRemoveCommand value, $Res Function(_WiFiRemoveCommand) _then) = __$WiFiRemoveCommandCopyWithImpl;
@override @useResult
$Res call({
 String connectionId, int id, String type
});




}
/// @nodoc
class __$WiFiRemoveCommandCopyWithImpl<$Res>
    implements _$WiFiRemoveCommandCopyWith<$Res> {
  __$WiFiRemoveCommandCopyWithImpl(this._self, this._then);

  final _WiFiRemoveCommand _self;
  final $Res Function(_WiFiRemoveCommand) _then;

/// Create a copy of WiFiRemoveCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connectionId = null,Object? id = null,Object? type = null,}) {
  return _then(_WiFiRemoveCommand(
connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WiFiAddCommand {

 String get name; String get SSID; String get psk; int get id; String get type;
/// Create a copy of WiFiAddCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WiFiAddCommandCopyWith<WiFiAddCommand> get copyWith => _$WiFiAddCommandCopyWithImpl<WiFiAddCommand>(this as WiFiAddCommand, _$identity);

  /// Serializes this WiFiAddCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WiFiAddCommand&&(identical(other.name, name) || other.name == name)&&(identical(other.SSID, SSID) || other.SSID == SSID)&&(identical(other.psk, psk) || other.psk == psk)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,SSID,psk,id,type);

@override
String toString() {
  return 'WiFiAddCommand(name: $name, SSID: $SSID, psk: $psk, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $WiFiAddCommandCopyWith<$Res>  {
  factory $WiFiAddCommandCopyWith(WiFiAddCommand value, $Res Function(WiFiAddCommand) _then) = _$WiFiAddCommandCopyWithImpl;
@useResult
$Res call({
 String name, String SSID, String psk, int id, String type
});




}
/// @nodoc
class _$WiFiAddCommandCopyWithImpl<$Res>
    implements $WiFiAddCommandCopyWith<$Res> {
  _$WiFiAddCommandCopyWithImpl(this._self, this._then);

  final WiFiAddCommand _self;
  final $Res Function(WiFiAddCommand) _then;

/// Create a copy of WiFiAddCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? SSID = null,Object? psk = null,Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,SSID: null == SSID ? _self.SSID : SSID // ignore: cast_nullable_to_non_nullable
as String,psk: null == psk ? _self.psk : psk // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WiFiAddCommand].
extension WiFiAddCommandPatterns on WiFiAddCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WiFiAddCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WiFiAddCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WiFiAddCommand value)  $default,){
final _that = this;
switch (_that) {
case _WiFiAddCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WiFiAddCommand value)?  $default,){
final _that = this;
switch (_that) {
case _WiFiAddCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String SSID,  String psk,  int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WiFiAddCommand() when $default != null:
return $default(_that.name,_that.SSID,_that.psk,_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String SSID,  String psk,  int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _WiFiAddCommand():
return $default(_that.name,_that.SSID,_that.psk,_that.id,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String SSID,  String psk,  int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _WiFiAddCommand() when $default != null:
return $default(_that.name,_that.SSID,_that.psk,_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WiFiAddCommand implements WiFiAddCommand {
  const _WiFiAddCommand({required this.name, required this.SSID, required this.psk, required this.id, this.type = WiFiAddCommand.TYPE});
  factory _WiFiAddCommand.fromJson(Map<String, dynamic> json) => _$WiFiAddCommandFromJson(json);

@override final  String name;
@override final  String SSID;
@override final  String psk;
@override final  int id;
@override@JsonKey() final  String type;

/// Create a copy of WiFiAddCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WiFiAddCommandCopyWith<_WiFiAddCommand> get copyWith => __$WiFiAddCommandCopyWithImpl<_WiFiAddCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WiFiAddCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WiFiAddCommand&&(identical(other.name, name) || other.name == name)&&(identical(other.SSID, SSID) || other.SSID == SSID)&&(identical(other.psk, psk) || other.psk == psk)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,SSID,psk,id,type);

@override
String toString() {
  return 'WiFiAddCommand(name: $name, SSID: $SSID, psk: $psk, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$WiFiAddCommandCopyWith<$Res> implements $WiFiAddCommandCopyWith<$Res> {
  factory _$WiFiAddCommandCopyWith(_WiFiAddCommand value, $Res Function(_WiFiAddCommand) _then) = __$WiFiAddCommandCopyWithImpl;
@override @useResult
$Res call({
 String name, String SSID, String psk, int id, String type
});




}
/// @nodoc
class __$WiFiAddCommandCopyWithImpl<$Res>
    implements _$WiFiAddCommandCopyWith<$Res> {
  __$WiFiAddCommandCopyWithImpl(this._self, this._then);

  final _WiFiAddCommand _self;
  final $Res Function(_WiFiAddCommand) _then;

/// Create a copy of WiFiAddCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? SSID = null,Object? psk = null,Object? id = null,Object? type = null,}) {
  return _then(_WiFiAddCommand(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,SSID: null == SSID ? _self.SSID : SSID // ignore: cast_nullable_to_non_nullable
as String,psk: null == psk ? _self.psk : psk // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WiFiGetConnectionsCommand {

 int get id; String get type;
/// Create a copy of WiFiGetConnectionsCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WiFiGetConnectionsCommandCopyWith<WiFiGetConnectionsCommand> get copyWith => _$WiFiGetConnectionsCommandCopyWithImpl<WiFiGetConnectionsCommand>(this as WiFiGetConnectionsCommand, _$identity);

  /// Serializes this WiFiGetConnectionsCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WiFiGetConnectionsCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type);

@override
String toString() {
  return 'WiFiGetConnectionsCommand(id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $WiFiGetConnectionsCommandCopyWith<$Res>  {
  factory $WiFiGetConnectionsCommandCopyWith(WiFiGetConnectionsCommand value, $Res Function(WiFiGetConnectionsCommand) _then) = _$WiFiGetConnectionsCommandCopyWithImpl;
@useResult
$Res call({
 int id, String type
});




}
/// @nodoc
class _$WiFiGetConnectionsCommandCopyWithImpl<$Res>
    implements $WiFiGetConnectionsCommandCopyWith<$Res> {
  _$WiFiGetConnectionsCommandCopyWithImpl(this._self, this._then);

  final WiFiGetConnectionsCommand _self;
  final $Res Function(WiFiGetConnectionsCommand) _then;

/// Create a copy of WiFiGetConnectionsCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WiFiGetConnectionsCommand].
extension WiFiGetConnectionsCommandPatterns on WiFiGetConnectionsCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WiFiGetConnectionsCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WiFiGetConnectionsCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WiFiGetConnectionsCommand value)  $default,){
final _that = this;
switch (_that) {
case _WiFiGetConnectionsCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WiFiGetConnectionsCommand value)?  $default,){
final _that = this;
switch (_that) {
case _WiFiGetConnectionsCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WiFiGetConnectionsCommand() when $default != null:
return $default(_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _WiFiGetConnectionsCommand():
return $default(_that.id,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _WiFiGetConnectionsCommand() when $default != null:
return $default(_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WiFiGetConnectionsCommand implements WiFiGetConnectionsCommand {
  const _WiFiGetConnectionsCommand({required this.id, this.type = WiFiGetConnectionsCommand.TYPE});
  factory _WiFiGetConnectionsCommand.fromJson(Map<String, dynamic> json) => _$WiFiGetConnectionsCommandFromJson(json);

@override final  int id;
@override@JsonKey() final  String type;

/// Create a copy of WiFiGetConnectionsCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WiFiGetConnectionsCommandCopyWith<_WiFiGetConnectionsCommand> get copyWith => __$WiFiGetConnectionsCommandCopyWithImpl<_WiFiGetConnectionsCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WiFiGetConnectionsCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WiFiGetConnectionsCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type);

@override
String toString() {
  return 'WiFiGetConnectionsCommand(id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$WiFiGetConnectionsCommandCopyWith<$Res> implements $WiFiGetConnectionsCommandCopyWith<$Res> {
  factory _$WiFiGetConnectionsCommandCopyWith(_WiFiGetConnectionsCommand value, $Res Function(_WiFiGetConnectionsCommand) _then) = __$WiFiGetConnectionsCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, String type
});




}
/// @nodoc
class __$WiFiGetConnectionsCommandCopyWithImpl<$Res>
    implements _$WiFiGetConnectionsCommandCopyWith<$Res> {
  __$WiFiGetConnectionsCommandCopyWithImpl(this._self, this._then);

  final _WiFiGetConnectionsCommand _self;
  final $Res Function(_WiFiGetConnectionsCommand) _then;

/// Create a copy of WiFiGetConnectionsCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,}) {
  return _then(_WiFiGetConnectionsCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WiFiGetConnectionsResult {

 List<WiFiConnectionInfo> get networks; int get id;
/// Create a copy of WiFiGetConnectionsResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WiFiGetConnectionsResultCopyWith<WiFiGetConnectionsResult> get copyWith => _$WiFiGetConnectionsResultCopyWithImpl<WiFiGetConnectionsResult>(this as WiFiGetConnectionsResult, _$identity);

  /// Serializes this WiFiGetConnectionsResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WiFiGetConnectionsResult&&const DeepCollectionEquality().equals(other.networks, networks)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(networks),id);

@override
String toString() {
  return 'WiFiGetConnectionsResult(networks: $networks, id: $id)';
}


}

/// @nodoc
abstract mixin class $WiFiGetConnectionsResultCopyWith<$Res>  {
  factory $WiFiGetConnectionsResultCopyWith(WiFiGetConnectionsResult value, $Res Function(WiFiGetConnectionsResult) _then) = _$WiFiGetConnectionsResultCopyWithImpl;
@useResult
$Res call({
 List<WiFiConnectionInfo> networks, int id
});




}
/// @nodoc
class _$WiFiGetConnectionsResultCopyWithImpl<$Res>
    implements $WiFiGetConnectionsResultCopyWith<$Res> {
  _$WiFiGetConnectionsResultCopyWithImpl(this._self, this._then);

  final WiFiGetConnectionsResult _self;
  final $Res Function(WiFiGetConnectionsResult) _then;

/// Create a copy of WiFiGetConnectionsResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? networks = null,Object? id = null,}) {
  return _then(_self.copyWith(
networks: null == networks ? _self.networks : networks // ignore: cast_nullable_to_non_nullable
as List<WiFiConnectionInfo>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WiFiGetConnectionsResult].
extension WiFiGetConnectionsResultPatterns on WiFiGetConnectionsResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WiFiGetConnectionsResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WiFiGetConnectionsResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WiFiGetConnectionsResult value)  $default,){
final _that = this;
switch (_that) {
case _WiFiGetConnectionsResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WiFiGetConnectionsResult value)?  $default,){
final _that = this;
switch (_that) {
case _WiFiGetConnectionsResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WiFiConnectionInfo> networks,  int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WiFiGetConnectionsResult() when $default != null:
return $default(_that.networks,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WiFiConnectionInfo> networks,  int id)  $default,) {final _that = this;
switch (_that) {
case _WiFiGetConnectionsResult():
return $default(_that.networks,_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WiFiConnectionInfo> networks,  int id)?  $default,) {final _that = this;
switch (_that) {
case _WiFiGetConnectionsResult() when $default != null:
return $default(_that.networks,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WiFiGetConnectionsResult implements WiFiGetConnectionsResult {
  const _WiFiGetConnectionsResult({required final  List<WiFiConnectionInfo> networks, required this.id}): _networks = networks;
  factory _WiFiGetConnectionsResult.fromJson(Map<String, dynamic> json) => _$WiFiGetConnectionsResultFromJson(json);

 final  List<WiFiConnectionInfo> _networks;
@override List<WiFiConnectionInfo> get networks {
  if (_networks is EqualUnmodifiableListView) return _networks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_networks);
}

@override final  int id;

/// Create a copy of WiFiGetConnectionsResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WiFiGetConnectionsResultCopyWith<_WiFiGetConnectionsResult> get copyWith => __$WiFiGetConnectionsResultCopyWithImpl<_WiFiGetConnectionsResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WiFiGetConnectionsResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WiFiGetConnectionsResult&&const DeepCollectionEquality().equals(other._networks, _networks)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_networks),id);

@override
String toString() {
  return 'WiFiGetConnectionsResult(networks: $networks, id: $id)';
}


}

/// @nodoc
abstract mixin class _$WiFiGetConnectionsResultCopyWith<$Res> implements $WiFiGetConnectionsResultCopyWith<$Res> {
  factory _$WiFiGetConnectionsResultCopyWith(_WiFiGetConnectionsResult value, $Res Function(_WiFiGetConnectionsResult) _then) = __$WiFiGetConnectionsResultCopyWithImpl;
@override @useResult
$Res call({
 List<WiFiConnectionInfo> networks, int id
});




}
/// @nodoc
class __$WiFiGetConnectionsResultCopyWithImpl<$Res>
    implements _$WiFiGetConnectionsResultCopyWith<$Res> {
  __$WiFiGetConnectionsResultCopyWithImpl(this._self, this._then);

  final _WiFiGetConnectionsResult _self;
  final $Res Function(_WiFiGetConnectionsResult) _then;

/// Create a copy of WiFiGetConnectionsResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? networks = null,Object? id = null,}) {
  return _then(_WiFiGetConnectionsResult(
networks: null == networks ? _self._networks : networks // ignore: cast_nullable_to_non_nullable
as List<WiFiConnectionInfo>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
