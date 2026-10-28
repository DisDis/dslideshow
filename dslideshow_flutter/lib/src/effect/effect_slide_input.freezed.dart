// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'effect_slide_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EffectSlideInput {

 Widget get view; PreparedPhoto? get photo;
/// Create a copy of EffectSlideInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EffectSlideInputCopyWith<EffectSlideInput> get copyWith => _$EffectSlideInputCopyWithImpl<EffectSlideInput>(this as EffectSlideInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EffectSlideInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EffectSlideInput&&(identical(other.view, _this.view) || other.view == _this.view)&&(identical(other.photo, _this.photo) || other.photo == _this.photo));
}


@override
int get hashCode {
  final _this = this as EffectSlideInput;
  return Object.hash(runtimeType,_this.view,_this.photo);
}

@override
String toString() {
  final _this = this as EffectSlideInput;
  return 'EffectSlideInput(view: ${_this.view}, photo: ${_this.photo})';
}


}

/// @nodoc
abstract mixin class $EffectSlideInputCopyWith<$Res>  {
  factory $EffectSlideInputCopyWith(EffectSlideInput value, $Res Function(EffectSlideInput) _then) = _$EffectSlideInputCopyWithImpl;
@useResult
$Res call({
 Widget view, PreparedPhoto? photo
});


$PreparedPhotoCopyWith<$Res>? get photo;

}
/// @nodoc
class _$EffectSlideInputCopyWithImpl<$Res>
    implements $EffectSlideInputCopyWith<$Res> {
  _$EffectSlideInputCopyWithImpl(this._self, this._then);

  final EffectSlideInput _self;
  final $Res Function(EffectSlideInput) _then;

/// Create a copy of EffectSlideInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? view = null,Object? photo = freezed,}) {
  return _then(EffectSlideInput(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as Widget,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as PreparedPhoto?,
  ));
}
/// Create a copy of EffectSlideInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PreparedPhotoCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $PreparedPhotoCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}
}


/// Adds pattern-matching-related methods to [EffectSlideInput].
extension EffectSlideInputPatterns on EffectSlideInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EffectSlideInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EffectSlideInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EffectSlideInput value)  $default,){
final _that = this;
switch (_that) {
case _EffectSlideInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EffectSlideInput value)?  $default,){
final _that = this;
switch (_that) {
case _EffectSlideInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Widget view,  PreparedPhoto? photo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EffectSlideInput() when $default != null:
return $default(_that.view,_that.photo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Widget view,  PreparedPhoto? photo)  $default,) {final _that = this;
switch (_that) {
case _EffectSlideInput():
return $default(_that.view,_that.photo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Widget view,  PreparedPhoto? photo)?  $default,) {final _that = this;
switch (_that) {
case _EffectSlideInput() when $default != null:
return $default(_that.view,_that.photo);case _:
  return null;

}
}

}

/// @nodoc


class _EffectSlideInput extends EffectSlideInput {
  const _EffectSlideInput({required this.view, this.photo}): super._();
  

@override final  Widget view;
@override final  PreparedPhoto? photo;

/// Create a copy of EffectSlideInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EffectSlideInputCopyWith<_EffectSlideInput> get copyWith => __$EffectSlideInputCopyWithImpl<_EffectSlideInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EffectSlideInput&&(identical(other.view, view) || other.view == view)&&(identical(other.photo, photo) || other.photo == photo));
}


@override
int get hashCode {
    return Object.hash(runtimeType,view,photo);
}

@override
String toString() {
    return 'EffectSlideInput(view: $view, photo: $photo)';
}


}

/// @nodoc
abstract mixin class _$EffectSlideInputCopyWith<$Res> implements $EffectSlideInputCopyWith<$Res> {
  factory _$EffectSlideInputCopyWith(_EffectSlideInput value, $Res Function(_EffectSlideInput) _then) = __$EffectSlideInputCopyWithImpl;
@override @useResult
$Res call({
 Widget view, PreparedPhoto? photo
});


@override $PreparedPhotoCopyWith<$Res>? get photo;

}
/// @nodoc
class __$EffectSlideInputCopyWithImpl<$Res>
    implements _$EffectSlideInputCopyWith<$Res> {
  __$EffectSlideInputCopyWithImpl(this._self, this._then);

  final _EffectSlideInput _self;
  final $Res Function(_EffectSlideInput) _then;

/// Create a copy of EffectSlideInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? view = null,Object? photo = freezed,}) {
  return _then(_EffectSlideInput(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as Widget,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as PreparedPhoto?,
  ));
}

/// Create a copy of EffectSlideInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PreparedPhotoCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $PreparedPhotoCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}
}

/// @nodoc
mixin _$PreparedPhoto {

 ui.Image get bitmap; PhotoCamera get camera;
/// Create a copy of PreparedPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreparedPhotoCopyWith<PreparedPhoto> get copyWith => _$PreparedPhotoCopyWithImpl<PreparedPhoto>(this as PreparedPhoto, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PreparedPhoto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreparedPhoto&&(identical(other.bitmap, _this.bitmap) || other.bitmap == _this.bitmap)&&(identical(other.camera, _this.camera) || other.camera == _this.camera));
}


@override
int get hashCode {
  final _this = this as PreparedPhoto;
  return Object.hash(runtimeType,_this.bitmap,_this.camera);
}

@override
String toString() {
  final _this = this as PreparedPhoto;
  return 'PreparedPhoto(bitmap: ${_this.bitmap}, camera: ${_this.camera})';
}


}

/// @nodoc
abstract mixin class $PreparedPhotoCopyWith<$Res>  {
  factory $PreparedPhotoCopyWith(PreparedPhoto value, $Res Function(PreparedPhoto) _then) = _$PreparedPhotoCopyWithImpl;
@useResult
$Res call({
 ui.Image bitmap, PhotoCamera camera
});


$PhotoCameraCopyWith<$Res> get camera;

}
/// @nodoc
class _$PreparedPhotoCopyWithImpl<$Res>
    implements $PreparedPhotoCopyWith<$Res> {
  _$PreparedPhotoCopyWithImpl(this._self, this._then);

  final PreparedPhoto _self;
  final $Res Function(PreparedPhoto) _then;

/// Create a copy of PreparedPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bitmap = null,Object? camera = null,}) {
  return _then(PreparedPhoto(
bitmap: null == bitmap ? _self.bitmap : bitmap // ignore: cast_nullable_to_non_nullable
as ui.Image,camera: null == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as PhotoCamera,
  ));
}
/// Create a copy of PreparedPhoto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhotoCameraCopyWith<$Res> get camera {
  
  return $PhotoCameraCopyWith<$Res>(_self.camera, (value) {
    return _then(_self.copyWith(camera: value));
  });
}
}


/// Adds pattern-matching-related methods to [PreparedPhoto].
extension PreparedPhotoPatterns on PreparedPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreparedPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreparedPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreparedPhoto value)  $default,){
final _that = this;
switch (_that) {
case _PreparedPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreparedPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _PreparedPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ui.Image bitmap,  PhotoCamera camera)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreparedPhoto() when $default != null:
return $default(_that.bitmap,_that.camera);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ui.Image bitmap,  PhotoCamera camera)  $default,) {final _that = this;
switch (_that) {
case _PreparedPhoto():
return $default(_that.bitmap,_that.camera);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ui.Image bitmap,  PhotoCamera camera)?  $default,) {final _that = this;
switch (_that) {
case _PreparedPhoto() when $default != null:
return $default(_that.bitmap,_that.camera);case _:
  return null;

}
}

}

/// @nodoc


class _PreparedPhoto implements PreparedPhoto {
  const _PreparedPhoto({required this.bitmap, this.camera = const PhotoCamera()});
  

@override final  ui.Image bitmap;
@override@JsonKey() final  PhotoCamera camera;

/// Create a copy of PreparedPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreparedPhotoCopyWith<_PreparedPhoto> get copyWith => __$PreparedPhotoCopyWithImpl<_PreparedPhoto>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreparedPhoto&&(identical(other.bitmap, bitmap) || other.bitmap == bitmap)&&(identical(other.camera, camera) || other.camera == camera));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bitmap,camera);
}

@override
String toString() {
    return 'PreparedPhoto(bitmap: $bitmap, camera: $camera)';
}


}

/// @nodoc
abstract mixin class _$PreparedPhotoCopyWith<$Res> implements $PreparedPhotoCopyWith<$Res> {
  factory _$PreparedPhotoCopyWith(_PreparedPhoto value, $Res Function(_PreparedPhoto) _then) = __$PreparedPhotoCopyWithImpl;
@override @useResult
$Res call({
 ui.Image bitmap, PhotoCamera camera
});


@override $PhotoCameraCopyWith<$Res> get camera;

}
/// @nodoc
class __$PreparedPhotoCopyWithImpl<$Res>
    implements _$PreparedPhotoCopyWith<$Res> {
  __$PreparedPhotoCopyWithImpl(this._self, this._then);

  final _PreparedPhoto _self;
  final $Res Function(_PreparedPhoto) _then;

/// Create a copy of PreparedPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bitmap = null,Object? camera = null,}) {
  return _then(_PreparedPhoto(
bitmap: null == bitmap ? _self.bitmap : bitmap // ignore: cast_nullable_to_non_nullable
as ui.Image,camera: null == camera ? _self.camera : camera // ignore: cast_nullable_to_non_nullable
as PhotoCamera,
  ));
}

/// Create a copy of PreparedPhoto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhotoCameraCopyWith<$Res> get camera {
  
  return $PhotoCameraCopyWith<$Res>(_self.camera, (value) {
    return _then(_self.copyWith(camera: value));
  });
}
}

/// @nodoc
mixin _$PhotoCamera {

 double get scale; double get dx; double get dy;
/// Create a copy of PhotoCamera
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoCameraCopyWith<PhotoCamera> get copyWith => _$PhotoCameraCopyWithImpl<PhotoCamera>(this as PhotoCamera, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PhotoCamera;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoCamera&&(identical(other.scale, _this.scale) || other.scale == _this.scale)&&(identical(other.dx, _this.dx) || other.dx == _this.dx)&&(identical(other.dy, _this.dy) || other.dy == _this.dy));
}


@override
int get hashCode {
  final _this = this as PhotoCamera;
  return Object.hash(runtimeType,_this.scale,_this.dx,_this.dy);
}

@override
String toString() {
  final _this = this as PhotoCamera;
  return 'PhotoCamera(scale: ${_this.scale}, dx: ${_this.dx}, dy: ${_this.dy})';
}


}

/// @nodoc
abstract mixin class $PhotoCameraCopyWith<$Res>  {
  factory $PhotoCameraCopyWith(PhotoCamera value, $Res Function(PhotoCamera) _then) = _$PhotoCameraCopyWithImpl;
@useResult
$Res call({
 double scale, double dx, double dy
});




}
/// @nodoc
class _$PhotoCameraCopyWithImpl<$Res>
    implements $PhotoCameraCopyWith<$Res> {
  _$PhotoCameraCopyWithImpl(this._self, this._then);

  final PhotoCamera _self;
  final $Res Function(PhotoCamera) _then;

/// Create a copy of PhotoCamera
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scale = null,Object? dx = null,Object? dy = null,}) {
  return _then(PhotoCamera(
scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,dx: null == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double,dy: null == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoCamera].
extension PhotoCameraPatterns on PhotoCamera {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoCamera value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoCamera() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoCamera value)  $default,){
final _that = this;
switch (_that) {
case _PhotoCamera():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoCamera value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoCamera() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double scale,  double dx,  double dy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoCamera() when $default != null:
return $default(_that.scale,_that.dx,_that.dy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double scale,  double dx,  double dy)  $default,) {final _that = this;
switch (_that) {
case _PhotoCamera():
return $default(_that.scale,_that.dx,_that.dy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double scale,  double dx,  double dy)?  $default,) {final _that = this;
switch (_that) {
case _PhotoCamera() when $default != null:
return $default(_that.scale,_that.dx,_that.dy);case _:
  return null;

}
}

}

/// @nodoc


class _PhotoCamera extends PhotoCamera {
  const _PhotoCamera({this.scale = 1.0, this.dx = 0.0, this.dy = 0.0}): assert(scale > 0 && scale < double.infinity, 'Expected a positive finite scale'),assert(dx > double.negativeInfinity && dx < double.infinity && dy > double.negativeInfinity && dy < double.infinity, 'Expected finite translation'),super._();
  

@override@JsonKey() final  double scale;
@override@JsonKey() final  double dx;
@override@JsonKey() final  double dy;

/// Create a copy of PhotoCamera
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoCameraCopyWith<_PhotoCamera> get copyWith => __$PhotoCameraCopyWithImpl<_PhotoCamera>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoCamera&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy));
}


@override
int get hashCode {
    return Object.hash(runtimeType,scale,dx,dy);
}

@override
String toString() {
    return 'PhotoCamera(scale: $scale, dx: $dx, dy: $dy)';
}


}

/// @nodoc
abstract mixin class _$PhotoCameraCopyWith<$Res> implements $PhotoCameraCopyWith<$Res> {
  factory _$PhotoCameraCopyWith(_PhotoCamera value, $Res Function(_PhotoCamera) _then) = __$PhotoCameraCopyWithImpl;
@override @useResult
$Res call({
 double scale, double dx, double dy
});




}
/// @nodoc
class __$PhotoCameraCopyWithImpl<$Res>
    implements _$PhotoCameraCopyWith<$Res> {
  __$PhotoCameraCopyWithImpl(this._self, this._then);

  final _PhotoCamera _self;
  final $Res Function(_PhotoCamera) _then;

/// Create a copy of PhotoCamera
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scale = null,Object? dx = null,Object? dy = null,}) {
  return _then(_PhotoCamera(
scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,dx: null == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double,dy: null == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
