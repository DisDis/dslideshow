import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// A readiness protocol that proves overlap without elapsed-time assertions.
class ProcessGate {
  ProcessGate._(this.server) {
    _subscription = server.listen((socket) async {
      final lines = socket.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter());
      final iterator = StreamIterator(lines);
      if (!await iterator.moveNext()) return;
      final value = jsonDecode(iterator.current) as Map<String, dynamic>;
      final label = value['label'] as String;
      connections[label] = socket;
      pids[label] = value['pid'] as int;
      _changes.add(null);
    });
  }
  static Future<ProcessGate> start() async => ProcessGate._(await ServerSocket.bind(InternetAddress.loopbackIPv4, 0));
  final ServerSocket server;
  late final StreamSubscription<Socket> _subscription;
  final connections = <String, Socket>{};
  final pids = <String, int>{};
  final _changes = StreamController<void>.broadcast();
  int get port => server.port;
  Future<void> ready(int count) async {
    if (connections.length >= count) return;
    await _changes.stream.firstWhere((_) => connections.length >= count).timeout(const Duration(seconds: 15));
  }

  void send(String label, String command) => connections[label]!.writeln(command);
  Future<void> close() async {
    for (final socket in connections.values) {
      socket.destroy();
    }
    await _subscription.cancel();
    await server.close();
    await _changes.close();
  }
}
