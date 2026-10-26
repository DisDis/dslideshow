import 'dart:async';

import 'package:config_app/features/gallery/presentation/widgets/video_grid_item.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/video_player.dart';

class _Controller extends VideoPlayerController {
  _Controller() : super.networkUrl(Uri.parse('http://localhost/video.mp4'));
  Completer<void>? pauseGate;
  Completer<void>? playGate;
  int plays = 0;
  int pauses = 0;
  @override
  Future<void> initialize() async {
    value = value.copyWith(
      isInitialized: true,
      duration: const Duration(seconds: 10),
      size: const Size(320, 180),
    );
  }

  @override
  Future<void> setLooping(bool looping) async {}
  @override
  Future<void> play() async {
    plays++;
    await playGate?.future;
    value = value.copyWith(isPlaying: true);
  }

  @override
  Future<void> pause() async {
    pauses++;
    await pauseGate?.future;
    value = value.copyWith(isPlaying: false);
  }
}

void main() {
  testWidgets(
    'startup play finishing after hide is immediately reconciled to paused',
    (tester) async {
      final controller = _Controller()..playGate = Completer<void>();
      VideoPlayerController factory(Uri _) => controller;
      Widget app(bool active) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizedBox(
          width: 200,
          height: 200,
          child: VideoGridItem(
            url: 'http://localhost/video.mp4',
            title: 'video',
            active: active,
            controllerFactory: factory,
          ),
        ),
      );
      await tester.pumpWidget(app(true));
      await tester.tap(find.byType(IconButton).first);
      await tester.pump();
      expect(controller.plays, 1);
      await tester.pumpWidget(app(false));
      await tester.pump();
      controller.playGate!.complete();
      await tester.pump();
      await tester.pump();
      expect(controller.pauses, 1);
      expect(controller.value.isPlaying, isFalse);
      await tester.pumpWidget(app(true));
      await tester.pump();
      expect(controller.plays, 2);
      expect(controller.value.isPlaying, isTrue);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
    variant: TargetPlatformVariant.only(TargetPlatform.android),
  );

  testWidgets(
    'visibility never autoloads; rapid return serializes late pause before resume',
    (tester) async {
      final controller = _Controller();
      var creations = 0;
      VideoPlayerController factory(Uri _) {
        creations++;
        return controller;
      }

      Widget app(bool active) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizedBox(
          width: 200,
          height: 200,
          child: VideoGridItem(
            url: 'http://localhost/video.mp4',
            title: 'video',
            active: active,
            controllerFactory: factory,
          ),
        ),
      );
      await tester.pumpWidget(app(false));
      await tester.pump();
      expect(creations, 0);
      await tester.pumpWidget(app(true));
      await tester.pump();
      expect(creations, 0);
      await tester.tap(find.byType(IconButton).first);
      await tester.pump();
      await tester.pump();
      expect(controller.plays, 1);
      controller.pauseGate = Completer<void>();
      await tester.pumpWidget(app(false));
      await tester.pump();
      expect(controller.pauses, 1);
      await tester.pumpWidget(app(true));
      await tester.pump();
      expect(controller.plays, 1);
      controller.pauseGate!.complete();
      await tester.pump();
      await tester.pump();
      expect(controller.plays, 2);
      expect(controller.value.isPlaying, isTrue);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
    variant: TargetPlatformVariant.only(TargetPlatform.android),
  );
}
