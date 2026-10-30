import 'package:dslideshow_backend/command.dart';

/// Optional diagnostics supported by the panel's WebSocket client.
abstract interface class RealtimeDiagnostics {
  int get requestTimeouts;
}

abstract class RealtimeService {
  String get authCode;
  Uri get connectUri;
  Future<WebSocketResult> connect(Uri uri, String code);
  void disconnect();
  Stream get onDisconnect;
  Future<WebSocketResult> send(WebSocketCommand cmd, {Duration? timeout});
  void sendOneWay(WebSocketCommand cmd);
  void response(WebSocketResult result);
}
