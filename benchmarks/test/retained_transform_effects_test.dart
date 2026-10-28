import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/experimental/retained_transform_effects.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const _size = Size(160, 100);
const _sourceKey = ValueKey('source');
const _targetKey = ValueKey('target');

Widget _scene(
  MediaSliderItemEffect effect,
  double progress,
  Widget source,
  Widget target, {
  Key? captureKey,
}) => Directionality(
  textDirection: TextDirection.ltr,
  child: Center(
    child: RepaintBoundary(
      key: captureKey,
      child: SizedBox.fromSize(
        size: _size,
        child: ColoredBox(
          color: Colors.black,
          child: Builder(
            builder: (context) => effect.createTransformWidget(
              context,
              source,
              target,
              AlwaysStoppedAnimation(progress),
              _size.width,
              _size.height,
            ),
          ),
        ),
      ),
    ),
  ),
);

Future<List<int>> _pixels(WidgetTester tester, GlobalKey key) async {
  return (await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      return List<int>.of(
        data!.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
    } finally {
      image.dispose();
    }
  }))!;
}

List<Offset> _corners(WidgetTester tester, Key key) {
  final box = tester.renderObject<RenderBox>(find.byKey(key));
  return [
    Offset.zero,
    Offset(box.size.width, 0),
    Offset(0, box.size.height),
    Offset(box.size.width, box.size.height),
  ].map(box.localToGlobal).toList();
}

class _LiveSlide extends StatefulWidget {
  const _LiveSlide({
    required this.color,
    required this.onMount,
    required this.onDispose,
  });

  final ValueNotifier<Color> color;
  final VoidCallback onMount;
  final VoidCallback onDispose;

  @override
  State<_LiveSlide> createState() => _LiveSlideState();
}

class _LiveSlideState extends State<_LiveSlide> {
  @override
  void initState() {
    super.initState();
    widget.onMount();
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<Color>(
    valueListenable: widget.color,
    builder: (context, color, _) => Transform.rotate(
      // This belongs to the media, not the effect. Its sampling must be left
      // untouched by the candidate's effect-graph traversal.
      angle: .01,
      filterQuality: FilterQuality.low,
      child: ColoredBox(color: color),
    ),
  );
}

void main() {
  test('factory selects only Stretch and canonical ZoomOver variants', () {
    expect(
      createRetainedTransformExperiment(Effect.stretchEffect),
      isA<OptimizedStretchEffect>(),
    );
    expect(
      createRetainedTransformExperiment(Effect.zoomOverEffect),
      isA<OptimizedZoomOverEffect>(),
    );
    expect(
      createRetainedTransformExperiment(Effect.crossZoomEffect),
      isA<OptimizedZoomOverEffect>(),
    );
    expect(createRetainedTransformExperiment(Effect.glassEffect), isNull);
  });

  test(
    'hardware trial is the same photo matrix with warmup one and repeats three',
    () {
      final config = BenchmarkConfig.fromJson(
        jsonDecode(
          File('config/retained-transform-experiment.json').readAsStringSync(),
        ) as Map<String, dynamic>,
      );
      final plan = buildPlan(config);
      expect(config.warmups, 1);
      expect(config.repeats, 3);
      expect(config.productionPhotoInputs, isTrue);
      expect(config.captureFrames, isFalse);
      expect(plan, hasLength(3));
      expect(
        plan.every(
          (test) => test.media.name == 'photo-photo' && !test.injectStall,
        ),
        isTrue,
      );
      expect(plan.map((test) => test.effect!.canonical.type), [
        EffectType.stretch,
        EffectType.zoomOver,
        EffectType.radialBlur,
      ]);
      expect(
        (plan[1].effect!.options as ZoomOverEffectOptions).mode,
        ZoomMode.cross,
      );
    },
  );

  final configurations = [
    const Effect(
      EffectType.stretch,
      options: StretchEffectOptions(maxScale: 4),
    ),
    const Effect(
      EffectType.stretch,
      options: StretchEffectOptions(axis: EffectAxis.vertical, maxScale: 2),
    ),
    const Effect(
      EffectType.zoomOver,
      options: ZoomOverEffectOptions(
        origin: EffectOrigin.bottomRight,
        blurFraction: .01,
      ),
    ),
    Effect.crossZoomEffect,
  ];
  for (var index = 0; index < configurations.length; index++) {
    final configuration = configurations[index];
    testWidgets(
      'candidate $index preserves geometry, opacity and blur settings',
      (tester) async {
        final original = configuration.createEffect();
        final candidate = createRetainedTransformExperiment(configuration)!;
        for (final progress in [0.0, .13, .5, .87, 1.0]) {
          Future<(List<Offset>, List<Offset>, List<double>, List<String>)>
          observe(MediaSliderItemEffect effect) async {
            await tester.pumpWidget(
              _scene(
                effect,
                progress,
                const SizedBox.expand(key: _sourceKey),
                const SizedBox.expand(key: _targetKey),
              ),
            );
            return (
              _corners(tester, _sourceKey),
              _corners(tester, _targetKey),
              tester
                  .widgetList<Opacity>(find.byType(Opacity))
                  .map((widget) => widget.opacity)
                  .toList(),
              tester
                  .widgetList<ImageFiltered>(find.byType(ImageFiltered))
                  .map((widget) => '${widget.enabled}/${widget.imageFilter}')
                  .toList(),
            );
          }

          final expected = await observe(original);
          final actual = await observe(candidate);
          expect(actual.$1, expected.$1, reason: 'source progress=$progress');
          expect(actual.$2, expected.$2, reason: 'target progress=$progress');
          expect(actual.$3, expected.$3, reason: 'opacity progress=$progress');
          expect(actual.$4, expected.$4, reason: 'blur progress=$progress');
          final transforms = tester.widgetList<Transform>(
            find.byType(Transform),
          );
          expect(transforms, hasLength(2));
          expect(
            transforms.map((widget) => widget.filterQuality),
            everyElement(FilterQuality.high),
          );
          expect(tester.takeException(), isNull);
        }
      },
    );

    testWidgets(
      'candidate $index retains live borrowers and repaints changes',
      (tester) async {
        final candidate = createRetainedTransformExperiment(configuration)!;
        var mounts = 0, disposals = 0;
        final fromColor = ValueNotifier<Color>(Colors.red);
        final toColor = ValueNotifier<Color>(Colors.blue);
        final key = GlobalKey();
        final source = _LiveSlide(
          color: fromColor,
          onMount: () => mounts++,
          onDispose: () => disposals++,
        );
        final target = _LiveSlide(
          color: toColor,
          onMount: () => mounts++,
          onDispose: () => disposals++,
        );
        try {
          for (final progress in [0.0, .01, .5, .99, 1.0, .5]) {
            await tester.pumpWidget(
              _scene(candidate, progress, source, target, captureKey: key),
            );
            expect(mounts, 2);
            expect(disposals, 0);
            expect(
              tester
                  .widgetList<Transform>(find.byType(Transform))
                  .where((widget) => widget.filterQuality == FilterQuality.low),
              hasLength(2),
            );
          }
          final before = await _pixels(tester, key);
          fromColor.value = Colors.green;
          await tester.pump();
          final after = await _pixels(tester, key);
          expect(
            after,
            isNot(before),
            reason: 'a retained input must remain live',
          );
          expect(mounts, 2);
          expect(disposals, 0);
        } finally {
          await tester.pumpWidget(const SizedBox());
          fromColor.dispose();
          toColor.dispose();
        }
        expect(disposals, 2);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
