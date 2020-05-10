import 'package:dslideshow_common/rpc.dart';
import 'dart:async';

abstract class RpcService{
//  Future<RpcResult> executeCommandStr(String commandJson);
  Future<RpcResult> executeCommand(RpcCommand command);
}

