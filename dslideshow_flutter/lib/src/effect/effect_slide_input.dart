import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'effect_slide_input.freezed.dart';

/// A slide as seen by an effect. The caller retains ownership of every resource.
@freezed
abstract class EffectSlideInput with _$EffectSlideInput {
  const EffectSlideInput._();

  const factory EffectSlideInput({required Widget view, PreparedPhoto? photo}) =
      _EffectSlideInput;

  /// Changes the view's geometry and explicitly keeps its live representation.
  /// The original photo's sampling coordinates no longer describe this view.
  EffectSlideInput liveView(Widget view) => copyWith(view: view, photo: null);
}

/// Borrowed pixels with their immutable viewport camera. Never disposes pixels.
@freezed
abstract class PreparedPhoto with _$PreparedPhoto {
  const factory PreparedPhoto({
    required ui.Image bitmap,
    @Default(PhotoCamera()) PhotoCamera camera,
  }) = _PreparedPhoto;
}

/// PhotoMotion's positive uniform scale and translation about viewport centre.
/// Scalars make an accepted transition independent of later Matrix4 mutations.
@freezed
abstract class PhotoCamera with _$PhotoCamera {
  const PhotoCamera._();

  @Assert(
    'scale > 0 && scale < double.infinity',
    'Expected a positive finite scale',
  )
  @Assert(
    'dx > double.negativeInfinity && dx < double.infinity && '
        'dy > double.negativeInfinity && dy < double.infinity',
    'Expected finite translation',
  )
  const factory PhotoCamera({
    @Default(1.0) double scale,
    @Default(0.0) double dx,
    @Default(0.0) double dy,
  }) = _PhotoCamera;

  factory PhotoCamera.fromMatrix(Matrix4? matrix) {
    if (matrix == null) return const PhotoCamera();
    final values = matrix.storage;
    if (!values[0].isFinite ||
        values[0] <= 0 ||
        values[0] != values[5] ||
        !values[12].isFinite ||
        !values[13].isFinite) {
      throw ArgumentError.value(
        matrix,
        'matrix',
        'Expected positive uniform scale and translation',
      );
    }
    for (var index = 0; index < values.length; index++) {
      if (index == 0 || index == 5 || index == 12 || index == 13) continue;
      final expected = index == 10 || index == 15 ? 1.0 : 0.0;
      if (values[index] != expected) {
        throw ArgumentError.value(
          matrix,
          'matrix',
          'Rotation, skew and perspective are unsupported',
        );
      }
    }
    return PhotoCamera(scale: values[0], dx: values[12], dy: values[13]);
  }

  bool get isIdentity => scale == 1 && dx == 0 && dy == 0;
}
