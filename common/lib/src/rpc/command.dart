// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:isolate';

abstract class RpcCommand implements RpcResult {
  static int _id = 0;

  static int generateId() => _id++;

  String get type;
}

abstract class RpcResult {
  int get id;
}

abstract class RpcErrorResult extends RpcResult {
  String get error;
}

class HandshakeMessage {
  final SendPort commanOPort;
  final List<SendPort> resultOPorts;

  HandshakeMessage({required this.commanOPort, required this.resultOPorts});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commanOPort': commanOPort,
      'resultOPorts': resultOPorts,
    };
  }

  factory HandshakeMessage.fromMap(Map<String, dynamic> map) {
    return HandshakeMessage(
      commanOPort: (map['commanOPort']) as SendPort,
      resultOPorts: List<SendPort>.from((map['resultOPorts'])),
    );
  }
}
