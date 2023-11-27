import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

class FakeRemoteService implements RemoteService {
  late Logger _log;

  FakeRemoteService({String name = "FakeRemoteService"}) {
    _log = new Logger("FRS-$name");
  }

  @override
  FutureOr<RpcResult> sendStr(RpcCommand cmd) {
    _log.info(cmd.toString());
    return new EmptyResult.respond(cmd);
  }

  @override
  FutureOr<Object> transparentSend(Object cmd) {
    return <dynamic>[];
  }

  @override
  FutureOr<String> transparentSendStr(String cmdStr) {
    return '';
  }

  @override
  FutureOr<RpcResult> send(RpcCommand cmd) {
    _log.info(cmd.toString());
    return new EmptyResult.respond(cmd);
  }
}
