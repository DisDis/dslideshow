import 'dart:ui' as ui;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/src/service/screen_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/frontend_remote.dart';

void main() {
  testWidgets('physical screen presses delegate toggles while accepted wake is still invisible', (tester) async {
    final h = FrontendHarness();
    final slideshow = SlideshowBloc(
      frontendService: h.frontend,
      config: AppConfig.fromJson({}).slideshow,
      statusBloc: h.status,
    );
    await h.rpc.executeCommand(const ScreenTurnCommand(id: 510, enabled: false));
    Future<void> press() async {
      await h.rpc.executeCommand(
        const ButtonChangeStateCommand(
          id: 511,
          button: ButtonType.button1,
          event: ButtonEventType.released,
          durationMs: 900,
        ),
      );
      await tester.pump();
      final toggle = h.backend.requests.whereType<ScreenToggleCommand>().last;
      h.backend.respond(toggle, EmptyResult.respond(toggle));
      await tester.pump();
    }

    await press();
    await tester.pump(const Duration(milliseconds: 900));
    expect(h.frontend.isScreenVisible, isFalse);
    await press();
    expect(h.backend.requests.whereType<ScreenToggleCommand>(), hasLength(2));
    expect(h.backend.requests.whereType<ScreenTurnCommand>(), isEmpty);

    // Backend visibility may also change because of MQTT or automatic control.
    // The next button still delegates the decision to the same owner.
    await h.rpc.executeCommand(const ScreenTurnCommand(id: 512, enabled: true));
    await press();
    expect(h.backend.requests.whereType<ScreenToggleCommand>(), hasLength(3));
    expect(h.backend.requests.whereType<ScreenTurnCommand>(), isEmpty);
    await tester.runAsync(() async {
      await slideshow.close();
      await h.close();
    });
  });
  testWidgets('night-enabled frontend stays hidden until backend supplies visibility; late slideshow starts asleep', (
    tester,
  ) async {
    final h = FrontendHarness(
      config: AppConfig.fromJson({
        'nightMode': {'enabled': true},
      }),
    );
    expect(h.frontend.isScreenVisible, isFalse);
    await h.rpc.executeCommand(const ScreenTurnCommand(id: 500, enabled: false));
    final slideshow = SlideshowBloc(
      frontendService: h.frontend,
      config: AppConfig.fromJson({}).slideshow,
      statusBloc: h.status,
    );
    expect(slideshow.state.isScreenLocked, isTrue);
    await tester.runAsync(slideshow.close);
    await tester.runAsync(h.close);
  });

  testWidgets('late route paints black after an early OFF and reveals only after backend ON', (tester) async {
    final h = FrontendHarness();
    await h.rpc.executeCommand(const ScreenTurnCommand(id: 501, enabled: false));
    final visibility = ScreenVisibilityCubit(h.frontend);
    final key = GlobalKey();
    tester.view.physicalSize = const Size(32, 32);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      BlocProvider.value(
        value: visibility,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: RepaintBoundary(
            key: key,
            child: const ScreenVisibility(child: ColoredBox(color: Colors.white)),
          ),
        ),
      ),
    );
    Future<int> redChannel() async {
      final image = await (key.currentContext!.findRenderObject()! as RenderRepaintBoundary).toImage();
      final bytes = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      image.dispose();
      return bytes!.getUint8(0);
    }

    expect(await tester.runAsync(redChannel), 0);
    await h.rpc.executeCommand(const ScreenTurnCommand(id: 502, enabled: true));
    await tester.pumpAndSettle();
    expect(await tester.runAsync(redChannel), 255);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(visibility.close);
    await tester.runAsync(h.close);
  });
}
