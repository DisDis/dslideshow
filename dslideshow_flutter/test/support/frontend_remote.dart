import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:dslideshow_flutter/src/service/frame_frontend_controller.dart';

class ControlledFrontendRemote implements RemoteService {
  final requests = <RpcCommand>[];
  final pending = <int, Completer<RpcResult>>{};

  @override
  Future<RpcResult> send<T extends RpcCommand>(T command) {
    requests.add(command);
    if (command is UpdateFrontendStateCommand) {
      return Future.value(EmptyResult.respond(command));
    }
    final response = Completer<RpcResult>();
    pending[command.id] = response;
    return response.future;
  }

  void respond(RpcCommand command, RpcResult response) => pending.remove(command.id)!.complete(response);
  void fail(RpcCommand command, Object error) => pending.remove(command.id)!.completeError(error);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FrontendHarness {
  final backend = ControlledFrontendRemote();
  final ota = ControlledFrontendRemote();
  final route = RouteBloc();
  late final FrontendService frontend;
  late final SlideshowStatusBloc status;
  Future<void>? _closeFuture;

  FrontendHarness({Duration refreshInterval = const Duration(minutes: 1)}) {
    final controller = FrameFrontendController(
      statusBloc: () => status,
      routeBloc: route,
      displayInfo: FrameFrontendController.readDisplayInfo,
    );
    frontend = FrontendService(
      AppConfig.fromJson({}),
      backend,
      ota,
      frameController: controller,
      systemInfoInterval: refreshInterval,
    );
    status = SlideshowStatusBloc(frontendService: frontend, config: SlideShowConfig.fromJson({}));
    frontend.onSystemInfoUpdate.listen(controller.updateSystemInfo);
  }

  Future<void> close() => _closeFuture ??= _close();
  Future<void> _close() async {
    await frontend.dispose();
    await status.close();
    await route.close();
  }
}
