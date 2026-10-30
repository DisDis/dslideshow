import 'dart:async';

import 'package:config_app/features/ota/presentation/bloc/ota_client.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_event.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'support/ota_panel_support.dart';

enum _LengthStage { selection, upload }

void main() {
  test('selection is lazy, a textual code is preserved, and one explicit submit owns upload', () async {
    final file = TestFirmwareFile();
    final gateway = ControlledOtaClient();
    final bloc = ObservedPanelOtaBloc(
      initialState: const OtaState(phase: OtaPhase.ready, version: '1.2.3'),
      client: PanelRealtime(),
      picker: () async => file,
      otaClientFactory: (_) => gateway,
    );
    addTearDown(bloc.close);
    expect(bloc.state.canSubmit, isFalse);
    await bloc.dispatch(const OtaEvent.upload());
    expect(gateway.uploads, 0);
    await bloc.dispatch(const OtaEvent.pickFile());
    expect(bloc.state.filename, 'firmware.deb');
    expect(file.byteReads, 0);
    expect(file.streamReads, 0);
    await bloc.dispatch(const OtaEvent.codeChanged('00 text-code'));
    expect(bloc.state.canSubmit, isTrue);
    await bloc.dispatch(const OtaEvent.upload());
    expect(gateway.sentCode, '00 text-code');
    expect(gateway.sentFile, same(file));
    expect(gateway.sentLength, 3);
    expect(gateway.uploads, 1);
    expect(gateway.closes, 1);
    expect(bloc.state.phase, OtaPhase.completed);
  });

  test('cancelled selection clears the previous file; invalid and empty files never become sendable', () async {
    TestFirmwareFile? selection = TestFirmwareFile();
    final bloc = ObservedPanelOtaBloc(
      initialState: const OtaState(phase: OtaPhase.ready, version: '1'),
      client: PanelRealtime(),
      picker: () async => selection,
    );
    addTearDown(bloc.close);
    await bloc.dispatch(const OtaEvent.codeChanged('code'));
    await bloc.dispatch(const OtaEvent.pickFile());
    expect(bloc.state.canSubmit, isTrue);
    selection = null;
    await bloc.dispatch(const OtaEvent.pickFile());
    expect(bloc.state.filename, isNull);
    expect(bloc.state.canSubmit, isFalse);
    selection = TestFirmwareFile(name: 'not-firmware.jpg');
    await bloc.dispatch(const OtaEvent.pickFile());
    expect(bloc.state.failure, OtaFailure.invalidFile);
    selection = TestFirmwareFile(bytes: []);
    await bloc.dispatch(const OtaEvent.pickFile());
    expect(bloc.state.failure, OtaFailure.emptyFile);
    expect(bloc.state.canSubmit, isFalse);
  });

  test('missing file length is a safe selection failure', () async {
    final bloc = ObservedPanelOtaBloc(
      initialState: const OtaState(phase: OtaPhase.ready, version: '1'),
      client: PanelRealtime(),
      picker: () async => TestFirmwareFile(lengthResult: () async => null),
    );
    addTearDown(bloc.close);
    await bloc.dispatch(const OtaEvent.pickFile());
    expect(bloc.state.failure, OtaFailure.fileUnavailable);
    expect(bloc.state.filename, isNull);
  });

  test('reset cancels a pending picker and ignores its late result', () async {
    final selection = Completer<TestFirmwareFile?>();
    final entered = Completer<void>();
    final bloc = ObservedPanelOtaBloc(
      initialState: const OtaState(phase: OtaPhase.ready, version: '1'),
      client: PanelRealtime(),
      picker: () {
        entered.complete();
        return selection.future;
      },
    );
    addTearDown(bloc.close);
    final pending = bloc.dispatch(const OtaEvent.pickFile());
    await entered.future;
    await bloc.dispatch(const OtaEvent.reset());
    await pending;
    selection.complete(TestFirmwareFile());
    await Future<void>(() {});
    expect(bloc.state.phase, OtaPhase.uninitialized);
    expect(bloc.state.filename, isNull);
    expect(bloc.state.pickingFile, isFalse);
  });

  for (final close in [false, true]) {
    test(
      '${close ? 'close' : 'reset'} cancels upload, consumes late failure, and preserves operation diagnostics',
      () async {
        final gateway = ControlledOtaClient()..upload = Completer<void>();
        final bloc = ObservedPanelOtaBloc(
          initialState: const OtaState(phase: OtaPhase.ready, version: '1'),
          client: PanelRealtime(),
          picker: () async => TestFirmwareFile(),
          otaClientFactory: (_) => gateway,
        );
        addTearDown(bloc.close);
        final records = <LogRecord>[];
        final oldLevel = Logger.root.level;
        Logger.root.level = Level.ALL;
        final subscription = Logger.root.onRecord.listen(records.add);
        addTearDown(() async {
          await subscription.cancel();
          Logger.root.level = oldLevel;
        });
        await bloc.dispatch(const OtaEvent.codeChanged('synthetic-code'));
        await bloc.dispatch(const OtaEvent.pickFile());
        final pending = bloc.dispatch(const OtaEvent.upload());
        await gateway.uploadEntered.future;
        if (close) {
          await bloc.close();
        } else {
          await bloc.dispatch(const OtaEvent.reset());
        }
        await pending;
        gateway.progress!(3, 3);
        gateway.upload!.completeError(const OtaClientException(OtaFailure.requestFailed));
        await Future<void>(() {});
        expect(gateway.closes, 1);
        expect(close ? bloc.isClosed : bloc.state.phase == OtaPhase.uninitialized, isTrue);
        final cancelled = records.where((r) => r.loggerName == 'OtaBloc' && r.message.contains('event=cancelled'));
        expect(cancelled, hasLength(1));
        expect(cancelled.single.message, contains('action=upload'));
        expect(cancelled.single.message, isNot(contains('operationId=')));
        expect(cancelled.single.level, Level.INFO);
        expect(records.map((r) => '${r.message} ${r.error}').join(), isNot(contains('synthetic-code')));
      },
    );
  }

  test('retry after an init failure is explicit and late init cannot overwrite reset', () async {
    final first = ControlledOtaClient()..initialization = Completer<String>();
    final second = ControlledOtaClient();
    var calls = 0;
    final bloc = ObservedPanelOtaBloc(client: PanelRealtime(), otaClientFactory: (_) => calls++ == 0 ? first : second);
    addTearDown(bloc.close);
    final pending = bloc.dispatch(const OtaEvent.init());
    await bloc.stream.firstWhere((s) => s.phase == OtaPhase.initializing);
    await bloc.dispatch(const OtaEvent.reset());
    await pending;
    await bloc.dispatch(const OtaEvent.init());
    first.initialization!.complete('old');
    await Future<void>(() {});
    expect(bloc.state.version, '1.2.3');
    expect(bloc.state.phase, OtaPhase.ready);
    expect(first.closes, 1);
  });

  test('reset retains operation ownership until asynchronous transport cleanup completes', () async {
    final gateway = ControlledOtaClient()
      ..upload = Completer<void>()
      ..cleanup = Completer<void>();
    var factories = 0;
    final bloc = ObservedPanelOtaBloc(
      initialState: const OtaState(phase: OtaPhase.ready, version: '1'),
      client: PanelRealtime(),
      picker: () async => TestFirmwareFile(),
      otaClientFactory: (_) {
        factories++;
        return gateway;
      },
    );
    addTearDown(bloc.close);
    await bloc.dispatch(const OtaEvent.codeChanged('code'));
    await bloc.dispatch(const OtaEvent.pickFile());
    final uploading = bloc.dispatch(const OtaEvent.upload());
    await gateway.uploadEntered.future;
    var resetDone = false;
    final resetting = bloc.dispatch(const OtaEvent.reset()).then((_) => resetDone = true);
    await Future<void>(() {});
    expect(resetDone, isFalse);
    await bloc.dispatch(const OtaEvent.init());
    expect(factories, 1);
    gateway.cleanup!.complete();
    await resetting;
    await uploading;
    expect(bloc.state.phase, OtaPhase.uninitialized);
    gateway.upload!.complete();
  });

  for (final closing in [false, true]) {
    for (final stage in _LengthStage.values) {
      test('${closing ? 'close' : 'reset'} waits for ${stage.name} metadata and ignores its late result', () async {
        final entered = Completer<void>();
        final metadata = Completer<int?>();
        var reads = 0;
        final file = TestFirmwareFile(
          lengthResult: () {
            reads++;
            if (stage == _LengthStage.upload && reads == 1) {
              return Future.value(3);
            }
            entered.complete();
            return metadata.future;
          },
        );
        var pickerCalls = 0;
        var factories = 0;
        final bloc = ObservedPanelOtaBloc(
          initialState: const OtaState(phase: OtaPhase.ready, version: '1'),
          client: PanelRealtime(),
          picker: () async {
            pickerCalls++;
            return file;
          },
          otaClientFactory: (_) {
            factories++;
            return ControlledOtaClient();
          },
        );
        addTearDown(bloc.close);
        addTearDown(() {
          if (!metadata.isCompleted) metadata.complete(3);
        });
        await bloc.dispatch(const OtaEvent.codeChanged('code'));
        if (stage == _LengthStage.upload) {
          await bloc.dispatch(const OtaEvent.pickFile());
        }
        final pending = bloc.dispatch(stage == _LengthStage.selection ? OtaEvent.pickFile() : OtaEvent.upload());
        await entered.future;
        var stopped = false;
        final stopping = (closing ? bloc.close() : bloc.dispatch(const OtaEvent.reset())).then((_) => stopped = true);
        await Future<void>(() {});
        expect(stopped, isFalse);
        await bloc.dispatch(const OtaEvent.init());
        await bloc.dispatch(const OtaEvent.pickFile());
        expect(pickerCalls, 1);
        expect(factories, 0);
        if (stage == _LengthStage.upload) {
          metadata.completeError(StateError('late metadata failure'));
        } else {
          metadata.complete(3);
        }
        await stopping;
        await pending;
        expect(file.streamReads, 0);
        expect(file.byteReads, 0);
        expect(factories, 0);
        if (closing) {
          expect(bloc.isClosed, isTrue);
        } else {
          expect(bloc.state.phase, OtaPhase.uninitialized);
          expect(bloc.state.filename, isNull);
          await bloc.dispatch(const OtaEvent.init());
          expect(factories, 1);
          expect(bloc.state.phase, OtaPhase.ready);
        }
      });
    }
  }
}
