import 'dart:async';
import 'dart:typed_data';

import 'package:config_app/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_client.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_event.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:file_picker/file_picker.dart';

final class TestFirmwareFile extends PlatformFile {
  TestFirmwareFile({this.name = 'firmware.deb', List<int>? bytes, this.lengthResult})
    : content = Uint8List.fromList(bytes ?? [1, 2, 3]);

  @override
  final String name;
  final Uint8List content;
  final Future<int?> Function()? lengthResult;
  Stream<Uint8List> Function()? streamFactory;
  int byteReads = 0;
  int streamReads = 0;
  int lengths = 0;

  @override
  Uri get uri => Uri.parse('blob:firmware-review');
  @override
  int? lengthSync() => content.length;
  @override
  Future<int?> length() async {
    lengths++;
    return lengthResult == null ? content.length : await lengthResult!();
  }

  @override
  Future<Uint8List> readAsBytes() async {
    byteReads++;
    throw StateError('Firmware must be streamed');
  }

  @override
  Stream<Uint8List> readAsByteStream() {
    streamReads++;
    return streamFactory?.call() ?? Stream.value(content);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class PanelRealtime implements RealtimeService {
  @override
  Uri get connectUri => Uri.parse('ws://frame.local:8080/ws');
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ControlledOtaClient extends OTAClient {
  ControlledOtaClient() : super(baseUri: Uri.parse('http://frame.local:8282'));

  Completer<String>? initialization;
  Completer<void>? upload;
  Completer<void>? cleanup;
  final uploadEntered = Completer<void>();
  int uploads = 0;
  int closes = 0;
  String? sentCode;
  PlatformFile? sentFile;
  int? sentLength;
  void Function(int, int)? progress;
  Future<void>? _closeFuture;

  @override
  Future<String> start({required Future<void> cancellation}) async => initialization?.future ?? '1.2.3';

  @override
  Future<void> uploadFile({
    required String code,
    required PlatformFile file,
    required int length,
    required Future<void> cancellation,
    required void Function(int sent, int total) onProgress,
  }) async {
    uploads++;
    sentCode = code;
    sentFile = file;
    sentLength = length;
    progress = onProgress;
    if (!uploadEntered.isCompleted) uploadEntered.complete();
    await upload?.future;
  }

  @override
  Future<void> close() => _closeFuture ??= _close();

  Future<void> _close() async {
    closes++;
    await cleanup?.future;
  }
}

class ObservedPanelOtaBloc extends OtaBloc {
  ObservedPanelOtaBloc({super.initialState, required super.client, super.picker, super.otaClientFactory});

  final _done = Map<OtaEvent, Completer<void>>.identity();
  Future<void> dispatch(OtaEvent event) {
    final done = Completer<void>();
    _done[event] = done;
    add(event);
    return done.future;
  }

  @override
  void onDone(OtaEvent event, [Object? error, StackTrace? stackTrace]) {
    super.onDone(event, error, stackTrace);
    final done = _done.remove(event);
    if (done == null) return;
    if (error == null) {
      done.complete();
    } else {
      done.completeError(error, stackTrace);
    }
  }
}
