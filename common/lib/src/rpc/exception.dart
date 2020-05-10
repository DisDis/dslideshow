import 'package:dslideshow_common/src/rpc/command.dart';

class RpcErrorResultException implements Exception{
  final RpcErrorResult errorResult;

  RpcErrorResultException(this.errorResult);

  String toString() {
    return "RpcErrorResultException: ${errorResult.error}";
  }
}