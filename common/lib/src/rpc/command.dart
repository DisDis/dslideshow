abstract class RpcCommand implements RpcResult {
  static int _id = 0;

  static int generateId() => _id++;

  String get type;

  int get id;
}

abstract class RpcResult {
  int get id;
}

abstract class RpcErrorResult extends RpcResult {
  String get error;
}
