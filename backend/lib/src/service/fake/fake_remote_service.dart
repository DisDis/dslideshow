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
  Future<RpcResult> sendStr<T extends RpcCommand>(T cmd) async {
    _log.info(cmd.toString());
    return EmptyResult.respond(cmd);
  }

  @override
  Future<Object> transparentSend(Object cmd) async {
    return <dynamic>[];
  }

  @override
  Future<String> transparentSendStr(String cmdStr) async {
    return '';
  }

  @override
  Future<RpcResult> send<T extends RpcCommand>(T cmd) async {
    _log.info(cmd.toString());
    return EmptyResult.respond(cmd);
  }
}
