import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:flutter/rendering.dart';
import 'package:logging/logging.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ClientServiceImpl implements RealtimeService {
  static final _log = Logger('ClientService');
  WebSocketChannel? channel;
  bool _isAuth = false;
  bool get isAuth => _isAuth;
  final _onDisconnect = StreamController.broadcast();
  // final _onConnect = StreamController.broadcast();
  // final _onCommand = StreamController<WebSocketCommand>.broadcast();
  // final _onAuth = StreamController<bool>.broadcast();
  // Stream<WebSocketCommand> get onCommand => _onCommand.stream;
  @override
  Stream get onDisconnect => _onDisconnect.stream;
  // Stream get onConnect => _onConnect.stream;
  // Stream<bool> get onAuth => _onAuth.stream;
  String _authCode = '';
  @override
  String get authCode => _authCode;

  Uri _connectUri = Uri.parse('http://127.0.0.1');

  @override
  Uri get connectUri => _connectUri;

  final _resultQueue = <int, Completer<WebSocketResult>>{};
  ClientServiceImpl();
  @override
  Future<WebSocketResult> connect(Uri uri, String code) {
    if (channel != null) {
      disconnect();
    }
    // Completer<bool> _result = Completer();
    _isAuth = false;
    _authCode = code;
    _connectUri = uri;
    channel = WebSocketChannel.connect(_connectUri);
    channel!.stream.listen(_parseMessage, onError: (error) {
      _log.info('onError: $error');
      // _result.completeError(error);
    }).onDone(disconnect);
    _log.info('User is connecting');

    return send(WSAuthCommand(
      userName: "admin",
      id: RpcCommand.generateId(),
      code: _authCode,
    ));
    //return _result.future;
  }

  @override
  void disconnect() {
    _isAuth = false;
    if (channel == null) {
      return;
    }
    channel!.sink.close(status.goingAway);
    channel = null;
    _onDisconnect.add(null);
    _resultQueue.forEach((key, value) {
      value.completeError(WSErrorResult.byId('disconnect', key));
    });
    _resultQueue.clear();
    _log.info('User disconnected');
  }

  @override
  Future<WebSocketResult> send(WebSocketCommand cmd) {
    sendOneWay(cmd);
    return _addMessageToQueue(cmd.id);
  }

  @override
  void sendOneWay(WebSocketCommand cmd) {
    final message = json.encode(serializers.serialize(cmd));
    _log.info('user> "$message"');
    if (channel == null) {
      throw ErrorDescription('Channel is null');
    }
    channel!.sink.add(message);
  }

  Future<WebSocketResult> _addMessageToQueue(int id) {
    final result = _resultQueue.putIfAbsent(id, () => Completer<WebSocketResult>());
    return result.future;
  }

  @override
  void response(WebSocketResult result) {
    final message = json.encode(serializers.serialize(result));
    _log.info('user> result "$message"');
    if (channel == null) {
      throw ErrorDescription('Channel is null');
    }
    channel!.sink.add(message);
  }

  void _parseMessage(dynamic message) {
    try {
      _log.info('user< "$message"');
      final msg = serializers.deserialize(json.decode(message.toString())) as WebSocketResult;
      if (msg is WebSocketCommand) {
        _execCommand(msg);
      } else {
        _processResult(msg);
      }
    } catch (e, st) {
      _log.severe(e.toString(), e, st);
    }
  }

  void _execCommand(WebSocketCommand command) {
    try {
      WebSocketResult result;
      switch (command.type) {
        case WSHelloCommand.TYPE:
          result = _executeWSHelloCommand(command as WSHelloCommand);
          break;
        default:
          result = WSErrorResult.byCommand('Unknown command', command);
          break;
      }
      response(result);
    } catch (e, st) {
      _log.severe(e.toString(), e, st);
      response(WSErrorResult.byCommand(e.toString(), command));
    }
  }

  void _processResult(WebSocketResult msg) {
    final completer = _resultQueue.remove(msg.id);
    if (completer != null) {
      if (msg is WebSocketErrorResult) {
        completer.completeError(msg);
      } else {
        completer.complete(msg);
      }
    }
  }

  WebSocketResult _executeWSHelloCommand(WSHelloCommand msg) {
    _isAuth = true;
    // _onAuth.add(true);
    return WSResultOk.byCommand(msg);
  }
}
