import 'dart:async';
import 'dart:convert';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TestWebSocketChannel implements WebSocketChannel {
  final incoming = StreamController<dynamic>(sync: true);
  final sent = <WebSocketResult>[];

  void receive(WebSocketResult message) =>
      incoming.add(jsonEncode(serializers.serialize(message)));

  @override
  late final TestWebSocketSink sink = TestWebSocketSink(sent);

  @override
  Stream<dynamic> get stream => incoming.stream;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestWebSocketSink implements WebSocketSink {
  TestWebSocketSink(this.sent);

  final List<WebSocketResult> sent;
  int closeCalls = 0;

  @override
  void add(dynamic message) {
    sent.add(
      serializers.deserialize(jsonDecode(message as String)) as WebSocketResult,
    );
  }

  @override
  Future<void> close([int? closeCode, String? closeReason]) async {
    closeCalls++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
