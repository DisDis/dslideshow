import 'dart:ui' as ui;

import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Widget previewApp(AssetBundle bundle, Widget child) => DefaultAssetBundle(
  bundle: bundle,
  child: MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: SingleChildScrollView(child: child)),
  ),
);

Future<void> waitForPreview(
  WidgetTester tester,
  bool Function() ready, {
  String reason = 'Preview did not become ready',
}) async {
  final watch = Stopwatch()..start();
  await tester.pump();
  while (!ready()) {
    if (watch.elapsed > const Duration(seconds: 10)) fail(reason);
    await tester.runAsync(() => Future<void>(() {}));
    await tester.pump();
  }
}

Future<void> preparePreview(WidgetTester tester) async {
  // Startup/resume schedules preparation after the mounting frame. Build the
  // loading state before deciding that an absent indicator means ready.
  await tester.pump();
  await waitForPreview(
    tester,
    () => find.byType(LinearProgressIndicator).evaluate().isEmpty,
    reason: 'Photo preparation did not finish',
  );
}

FixedAnimationController previewClock(WidgetTester tester) => tester
    .widgetList<AnimatedBuilder>(
      find.descendant(
        of: find.byType(SlideshowPreview),
        matching: find.byType(AnimatedBuilder),
      ),
    )
    .where((widget) => widget.child == null)
    .map((widget) => widget.animation)
    .whereType<FixedAnimationController>()
    .single;

Future<void> finishPreview(WidgetTester tester) async {
  await preparePreview(tester);
  final clock = previewClock(tester);
  for (var frames = 0; frames < 100 && !clock.isCompleted; frames++) {
    await tester.pump(const Duration(milliseconds: 16));
  }
  expect(clock.isCompleted, true, reason: 'Transition did not finish');
}

List<ui.Image> previewPhotos(WidgetTester tester) => tester
    .widgetList<RawImage>(find.byType(RawImage))
    .map((widget) => widget.image!)
    .toSet()
    .toList();

Future<List<List<int>>> previewColors(WidgetTester tester) async {
  final result = <List<int>>[];
  for (final image in previewPhotos(tester)) {
    final data = (await tester.runAsync(
      () => image.toByteData(format: ui.ImageByteFormat.rawRgba),
    ))!;
    final offset = ((image.height ~/ 2) * image.width + image.width ~/ 2) * 4;
    result.add(data.buffer.asUint8List().sublist(offset, offset + 4));
  }
  return result;
}

void expectPhotoReleased(ui.Image image) {
  expect(image.debugDisposed, true);
  expect(
    image.debugGetOpenHandleStackTraces(),
    isEmpty,
    reason: 'Every borrowed RenderImage handle must detach before release',
  );
}

Future<Uint8List> previewViewportPixels(
  WidgetTester tester,
  GlobalKey boundaryKey,
  Finder viewport,
) async {
  final boundary =
      boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final bounds = tester
      .getRect(viewport)
      .shift(-tester.getTopLeft(find.byKey(boundaryKey)));
  return (await tester.runAsync(() async {
    final image = await boundary.toImage();
    try {
      final rgba = (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!
          .buffer
          .asUint8List();
      final left = bounds.left.round(), top = bounds.top.round();
      final width = bounds.width.round(), height = bounds.height.round();
      final result = Uint8List(width * height * 4);
      for (var row = 0; row < height; row++) {
        final source = ((top + row) * image.width + left) * 4;
        result.setRange(row * width * 4, (row + 1) * width * 4, rgba, source);
      }
      return result;
    } finally {
      image.dispose();
    }
  }))!;
}
