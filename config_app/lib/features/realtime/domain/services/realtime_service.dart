import 'package:dslideshow_backend/command.dart';

abstract class RealtimeService {
  Future<WebSocketResult> connect(Uri uri, String code);
  void disconnect();
  Stream get onDisconnect;
  Future<WebSocketResult> send(WebSocketCommand cmd);
  void sendOneWay(WebSocketCommand cmd);
  void response(WebSocketResult result);
}
