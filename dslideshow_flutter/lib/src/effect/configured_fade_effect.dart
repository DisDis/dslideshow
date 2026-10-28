import 'dart:ui' as ui;

import 'package:dslideshow_common/effects.dart';
import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';
import 'effect_geometry.dart';
import 'fade_effect.dart';
import 'blure_fade_effect.dart';
import 'fade_through_color_effect.dart';
import 'optical_transition_effect.dart';

class ConfiguredFadeEffect extends MediaSliderItemEffect {
  final FadeEffectOptions options;
  ConfiguredFadeEffect(this.options);
  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) => page;
  @override
  Widget createTransformWidget(
    BuildContext context,
    Widget currentWidget,
    Widget nextWidget,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    final t = effectCurve(options.blendCurve)
        .transform(controller.value.clamp(0, 1));
    final animation = AlwaysStoppedAnimation(t);
    switch (options.style) {
      case FadeStyle.plain:
        return FadeEffect().createTransformWidget(
          context,
          currentWidget,
          nextWidget,
          animation,
          screenW,
          screenH,
        );
      case FadeStyle.linearLight:
        return OpticalTransitionEffect(OpticalTransitionKind.filmDissolve)
            .createTransformWidget(
              context,
              currentWidget,
              nextWidget,
              animation,
              screenW,
              screenH,
            );
      case FadeStyle.throughColor:
        if (options.holdFraction == 0 && options.fadeOutShare == .5) {
          return FadeThroughColorEffect(color: Color(options.color))
              .createTransformWidget(
                context,
                currentWidget,
                nextWidget,
                animation,
                screenW,
                screenH,
              );
        }
        final fadeOut = (1 - options.holdFraction) * options.fadeOutShare;
        final fadeIn = 1 - fadeOut - options.holdFraction;
        return Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: Color(options.color)),
            Opacity(
              opacity: (1 - t / fadeOut).clamp(0, 1),
              child: currentWidget,
            ),
            Opacity(
              opacity: ((t - fadeOut - options.holdFraction) / fadeIn).clamp(
                0,
                1,
              ),
              child: nextWidget,
            ),
          ],
        );
      case FadeStyle.blur:
        if (options.blurTarget == BlurTarget.outgoing) {
          return BlurFadeEffect(maxSigma: options.maxSigma)
              .createTransformWidget(
                context,
                currentWidget,
                nextWidget,
                animation,
                screenW,
                screenH,
              );
        }
        Widget blur(Widget child, double sigma) => ImageFiltered(
          enabled: sigma > 0,
          imageFilter: ui.ImageFilter.blur(
            sigmaX: sigma,
            sigmaY: sigma,
            tileMode: TileMode.decal,
          ),
          child: child,
        );
        return Stack(
          fit: StackFit.expand,
          children: [
            blur(nextWidget, options.maxSigma * (1 - t)),
            Opacity(
              opacity: 1 - t,
              child: options.blurTarget == BlurTarget.both
                  ? blur(currentWidget, options.maxSigma * t)
                  : currentWidget,
            ),
          ],
        );
    }
  }
}
