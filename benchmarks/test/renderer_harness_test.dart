import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:benchmarks/renderer_main.dart';

void main() {
  test('late FrameTiming batches retain only the closed measurement window', () {
    final harness = RendererHarness(Directory.systemTemp)
      ..measuring = true
      ..frameWindowStartUs = 100
      ..frameWindowEndUs = 200;
    FrameTiming frame(int start) => FrameTiming(
      vsyncStart: start,
      buildStart: start + 1,
      buildFinish: start + 2,
      rasterStart: start + 3,
      rasterFinish: start + 4,
      rasterFinishWallTime: start + 4,
    );
    harness.timings([frame(99), frame(100), frame(150), frame(200), frame(201)]);
    expect(harness.frames.map((frame) => frame.vsyncUs), [150, 200]);
    harness.measuring = false;
    harness.timings([frame(175)]);
    expect(harness.frames.map((frame) => frame.vsyncUs), [150, 200]);
  });

  test('a later painted marker drains a window without an exact end frame', () async {
    final harness = RendererHarness(Directory.systemTemp)
      ..measuring = true
      ..frameWindowStartUs = 100
      ..frameWindowEndUs = 200;
    FrameTiming frame(int start) => FrameTiming(
      vsyncStart: start, buildStart: start + 1, buildFinish: start + 2,
      rasterStart: start + 3, rasterFinish: start + 4,
      rasterFinishWallTime: start + 4,
    );
    final drained = harness.drainTimings();
    harness.timings([frame(150), frame(199), frame(201)]);
    await drained;
    expect(harness.frames.map((frame) => frame.vsyncUs), [150, 199]);
    expect(harness.lastTimingTimestampUs, 201);
  });
}
