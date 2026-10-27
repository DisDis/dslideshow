import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

/// Faceted glass: each pane shifts and magnifies the live image while blending
/// to the next. All panes borrow the same prepared media and video sessions.
class GlassEffect extends MediaSliderItemEffect {
  final int paneCount;

  GlassEffect({this.paneCount = 8}) : assert(paneCount > 0);

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
    final t = controller.value.clamp(0.0, 1.0);
    final envelope = t <= 0 || t >= 1 ? 0.0 : math.sin(math.pi * t);
    final blend = Curves.easeInOut.transform(t);
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          for (var i = 0; i < paneCount; i++)
            Positioned(
              left: screenW * i / paneCount,
              top: 0,
              bottom: 0,
              width: screenW * (i + 1) / paneCount - screenW * i / paneCount,
              child: ClipRect(
                child: CustomPaint(
                  foregroundPainter: _GlassGlint(envelope),
                  child: OverflowBox(
                    alignment: Alignment.topLeft,
                    minWidth: screenW,
                    maxWidth: screenW,
                    minHeight: screenH,
                    maxHeight: screenH,
                    child: Transform.translate(
                      offset: Offset(-screenW * i / paneCount, 0),
                      child: Transform.translate(
                        offset: Offset(
                          math.sin(i * 2.4 + .7) * screenW * .018 * envelope,
                          math.cos(i * 1.7) * screenH * .012 * envelope,
                        ),
                        child: Transform.scale(
                          // Overscan covers both axes even at the largest shift.
                          scale: 1 + .05 * envelope,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ColoredBox(
                                color: Colors.black,
                                child: currentWidget,
                              ),
                              Opacity(
                                opacity: blend,
                                child: ColoredBox(
                                  color: Colors.black,
                                  child: nextWidget,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GlassGlint extends CustomPainter {
  final double envelope;

  _GlassGlint(this.envelope);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final shader = ui.Gradient.linear(
      Offset.zero,
      Offset(size.width, 0),
      [
        Colors.white.withValues(alpha: .25 * envelope),
        const Color(0x00e0f7ff),
        const Color(0xff03263d).withValues(alpha: .14 * envelope),
        Colors.white.withValues(alpha: .1 * envelope),
      ],
      const [0, .1, .9, 1],
    );
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
    shader.dispose();
  }

  @override
  bool shouldRepaint(_GlassGlint oldDelegate) =>
      envelope != oldDelegate.envelope;
}
