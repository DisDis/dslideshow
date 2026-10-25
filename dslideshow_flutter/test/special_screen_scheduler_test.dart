import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_slide.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/special_screen_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const media = MediaSlide(MediaItem.empty);
  test('an unavailable appearance does not advance the camera cursor', () {
    final screen = SpecialScreenConfig(
      id: 'cam',
      type: SpecialScreenType.cameras,
      enabled: true,
      schedule: SpecialScreenSchedule(count: 1),
      options: CamerasScreenOptions(
        mode: CameraDisplayMode.sequence,
        cameras: [
          CameraConfig(id: 'a', url: 'http://camera/a'),
          CameraConfig(id: 'b', url: 'http://camera/b'),
        ],
      ),
    );
    final scheduler = SpecialScreenScheduler([screen]);
    addTearDown(scheduler.close);
    scheduler.shown(media);
    scheduler.skipped(scheduler.next()!);
    scheduler.shown(media);
    expect(scheduler.next()!.cameraIndex, 0);
  });
  SpecialScreenConfig clock(String id) => SpecialScreenConfig(
    id: id,
    type: SpecialScreenType.clock,
    enabled: true,
    schedule: SpecialScreenSchedule(count: 1),
  );
  test('simultaneous screens are fair and separated by ordinary slides', () {
    final scheduler = SpecialScreenScheduler([clock('a'), clock('b')]);
    addTearDown(scheduler.close);
    expect(scheduler.next(), isNull);
    scheduler.shown(media);
    final a = scheduler.next()!;
    expect(a.config.id, 'a');
    scheduler.shown(a);
    expect(scheduler.next(), isNull);
    scheduler.shown(media);
    final b = scheduler.next()!;
    expect(b.config.id, 'b');
    scheduler.shown(b);
    scheduler.shown(media);
    expect(scheduler.next()!.config.id, 'a');
  });
  test('interval uses active time and ignores suspended wall time', () {
    var elapsed = Duration.zero;
    final scheduler = SpecialScreenScheduler([
      SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
        enabled: true,
        schedule: SpecialScreenSchedule(
          type: SpecialScreenScheduleType.interval,
          intervalMs: 10000,
        ),
      ),
    ], elapsed: () => elapsed);
    addTearDown(scheduler.close);
    scheduler.setActive(true);
    scheduler.shown(media);
    elapsed += const Duration(seconds: 5);
    scheduler.setActive(false);
    elapsed += const Duration(hours: 1);
    expect(scheduler.next(), isNull);
    scheduler.setActive(true);
    elapsed += const Duration(seconds: 5);
    expect(scheduler.next()!.config.id, 'clock');
  });
  test('each camera screen keeps its own round robin cursor', () {
    SpecialScreenConfig cameras(String id) => SpecialScreenConfig(
      id: id,
      type: SpecialScreenType.cameras,
      enabled: true,
      schedule: SpecialScreenSchedule(count: 1),
      options: CamerasScreenOptions(
        mode: CameraDisplayMode.sequence,
        cameras: [
          CameraConfig(id: '1', url: 'http://camera/1'),
          CameraConfig(id: '2', url: 'http://camera/2'),
        ],
      ),
    );
    final scheduler = SpecialScreenScheduler([cameras('a'), cameras('b')]);
    addTearDown(scheduler.close);
    final observed = <String>[];
    for (var i = 0; i < 6; i++) {
      scheduler.shown(media);
      final slide = scheduler.next()!;
      observed.add('${slide.config.id}:${slide.cameraIndex}');
      scheduler.shown(slide);
    }
    expect(observed, ['a:0', 'b:0', 'a:1', 'b:1', 'a:0', 'b:0']);
  });
  test('disabled, unknown and empty camera screens are ignored', () {
    final scheduler = SpecialScreenScheduler([
      SpecialScreenConfig(id: 'off', type: SpecialScreenType.clock),
      SpecialScreenConfig(
        id: 'future',
        type: SpecialScreenType.unknown,
        enabled: true,
      ),
      SpecialScreenConfig(
        id: 'empty',
        type: SpecialScreenType.cameras,
        enabled: true,
      ),
    ]);
    addTearDown(scheduler.close);
    for (var i = 0; i < 20; i++) {
      scheduler.shown(media);
    }
    expect(scheduler.next(), isNull);
  });
  test('failed screens back off without being counted as media', () {
    final scheduler = SpecialScreenScheduler([clock('a')]);
    addTearDown(scheduler.close);
    scheduler.shown(media);
    scheduler.skipped(scheduler.next()!);
    expect(scheduler.next(), isNull);
    scheduler.shown(media);
    expect(scheduler.next(), isNotNull);
  });
}
