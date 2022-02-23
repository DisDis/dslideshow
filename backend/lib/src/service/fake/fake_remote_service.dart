import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

class FakeRemoteService implements RemoteService {
  late Logger _log;

  FakeRemoteService({String name: "FakeRemoteService"}) {
    _log = new Logger("FRS-$name");
  }
  @override
  FutureOr<RpcResult> send(RpcCommand command) async {
    _log.info(command.toString());
    return new EmptyResult.respond(command);
  }

  @override
  FutureOr<String> transparentSend(String cmdStr) async {
    return '';
  }
}
