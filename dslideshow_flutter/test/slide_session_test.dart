import 'dart:async';
import 'dart:io';

import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/slide_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fake_video_controller.dart';

void main() {
  testWidgets('video slide shares preparation and releases its player once', (
    tester,
  ) async {
    await tester.pumpWidget(const SizedBox());
    final context = tester.element(find.byType(SizedBox));
    final initialized = Completer<void>();
    final player = FakeVideoController(gate: initialized);
    final session = VideoSlideSession(
      video: VideoSession(
        File('/tmp/shared-slide-preparation.mp4'),
        controller: player,
        supported: true,
      ),
      view: const SizedBox(),
    );
    addTearDown(() => tester.runAsync(session.dispose));

    session.setActivity(
      role: SlideSessionRole.pending,
      playing: true,
      screenOn: true,
    );
    await tester.pump();
    expect(player.initializations, 0);
    expect(player.plays, 0);
    expect(player.pauses, 0);

    final first = session.prepare(context);
    final second = session.prepare(context);
    expect(player.initializations, 1);
    initialized.complete();
    expect(await tester.runAsync(() => Future.wait([first, second])), [
      true,
      true,
    ]);
    expect(await session.prepare(context), true);
    expect(player.initializations, 1);

    await tester.runAsync(
      () => Future.wait([session.dispose(), session.dispose()]),
    );
    expect(player.disposals, 1);
    expect(await session.prepare(context), false);
    expect(player.initializations, 1);
    session.setActivity(
      role: SlideSessionRole.current,
      playing: true,
      screenOn: true,
    );
    await tester.pump();
    expect(player.plays, 0);
    expect(player.disposals, 1);
  });
}
