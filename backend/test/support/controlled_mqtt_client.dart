import 'dart:async';
import 'dart:convert';

import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_data.dart' as typed;

class ControlledMqttClient extends MqttServerClient {
  ControlledMqttClient() : super('unused.invalid', 'local-test') {
    messages = StreamController.broadcast(
      sync: true,
      onListen: () => updateListeners++,
      onCancel: () => updateListeners--,
    );
  }

  late final StreamController<List<MqttReceivedMessage<MqttMessage>>> messages;
  final status = MqttClientConnectionStatus();
  final connecting = Completer<void>();
  final connection = Completer<MqttClientConnectionStatus?>();
  final subscriptions = <(String, MqttQos)>[];
  final publications = <({String topic, MqttQos qos, String payload})>[];
  int updateListeners = 0;
  int connectCalls = 0;
  int disconnectCalls = 0;
  Object? publishError;
  Stream<List<MqttReceivedMessage<MqttMessage>>>? updateStream;

  @override
  MqttClientConnectionStatus get connectionStatus => status;

  @override
  Stream<List<MqttReceivedMessage<MqttMessage>>> get updates =>
      updateStream ?? messages.stream;

  @override
  Future<MqttClientConnectionStatus?> connect([
    String? username,
    String? password,
  ]) {
    connectCalls++;
    if (!connecting.isCompleted) connecting.complete();
    return connection.future;
  }

  void connected() {
    status.state = MqttConnectionState.connected;
    onConnected?.call();
    connection.complete(status);
  }

  @override
  void disconnect() {
    disconnectCalls++;
    status.state = MqttConnectionState.disconnected;
    onDisconnected?.call();
  }

  @override
  Subscription? subscribe(String topic, MqttQos qosLevel) {
    subscriptions.add((topic, qosLevel));
    return null;
  }

  @override
  int publishMessage(
    String topic,
    MqttQos qualityOfService,
    typed.Uint8Buffer data, {
    bool retain = false,
  }) {
    final error = publishError;
    if (error != null) throw error;
    publications.add((
      topic: topic,
      qos: qualityOfService,
      payload: utf8.decode(data),
    ));
    return publications.length;
  }

  void receive(List<(String, String)> batch) {
    messages.add([
      for (final (topic, value) in batch)
        MqttReceivedMessage(
          topic,
          MqttPublishMessage().publishData(
            (MqttClientPayloadBuilder()..addUTF8String(value)).payload!,
          ),
        ),
    ]);
  }
}

class CancellationFailureStream<T> extends Stream<T> {
  CancellationFailureStream(this.source);

  final Stream<T> source;

  @override
  StreamSubscription<T> listen(
    void Function(T)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) => _CancellationFailureSubscription(
    source.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    ),
  );
}

class _CancellationFailureSubscription<T> implements StreamSubscription<T> {
  _CancellationFailureSubscription(this.delegate);

  final StreamSubscription<T> delegate;

  @override
  Future<void> cancel() async {
    await delegate.cancel();
    throw StateError('private cancellation URL');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ControlledMqttApplicationState implements ApplicationStateService {
  ControlledMqttApplicationState() {
    changes = StreamController.broadcast(
      sync: true,
      onListen: () => listeners++,
      onCancel: () => listeners--,
    );
  }

  late final StreamController<ApplicationState> changes;
  int listeners = 0;

  @override
  ApplicationState state = const ApplicationState();

  @override
  Stream<ApplicationState> get onChangedState => changes.stream;

  @override
  void update(ApplicationState value) {
    state = value;
    changes.add(value);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
