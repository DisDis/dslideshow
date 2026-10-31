import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/storage_status.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestFrontend implements FrontendService {
  @override
  StorageStatusEnum get storageStatus => StorageStatusEnum.off;
  @override
  Stream<StorageStatusEnum> get onStorageStatusChanged => const Stream.empty();
  final buttons = StreamController<ButtonEvent>.broadcast();
  final screens = StreamController<bool>.broadcast();
  final actions = StreamController<ActionWithParam>.broadcast();
  final screenTurns = <bool>[];
  final lockChanges = <bool>[];
  final locks = <Completer<RpcResult>>[];
  bool holdLocks = false;
  Completer<void>? turn;
  Completer<MediaItem>? media;
  Future<Object?> Function()? onStorageNext;
  Future<MediaItem> Function()? onReadStorageCurrent;
  int loads = 0;
  int reads = 0;
  @override
  Stream<ButtonEvent> get onButtonEvent => buttons.stream;
  @override
  Stream<bool> get onScreenStateChangePreparation => screens.stream;
  @override
  Stream<ActionWithParam> get onAction => actions.stream;
  @override
  Future<void> updateFrontendState({bool? isPaused, bool? isMenu}) async {}

  @override
  Future<Object?> storageNext() async {
    loads++;
    return onStorageNext?.call();
  }

  @override
  Future<MediaItem> getStorageCurrentItem() async {
    reads++;
    final read = onReadStorageCurrent;
    if (read != null) return read();
    return media == null ? MediaItem.empty : await media!.future;
  }

  @override
  Future<RpcResult> changeScreenLock(bool value) async {
    lockChanges.add(value);
    if (holdLocks) {
      final completion = Completer<RpcResult>();
      locks.add(completion);
      return completion.future;
    }
    return const EmptyResult(id: 1);
  }

  @override
  Future<RpcResult> screenTurn(bool value) async {
    screenTurns.add(value);
    await turn?.future;
    return const EmptyResult(id: 1);
  }

  Future<void> close() async {
    await buttons.close();
    await screens.close();
    await actions.close();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// Keep the unrelated hint timer out of the screen renderer regression.
class HiddenHints extends Cubit<ButtonsHintState> implements ButtonsHintBloc {
  HiddenHints()
    : super(
        const ButtonsHintDisplayState(
          isShow: false,
          normalColor: Colors.white,
          pushColor: Colors.white,
          button0Icon: Icons.check,
          button0isPush: false,
          button1Icon: Icons.check,
          button1isPush: false,
          button2Icon: Icons.check,
          button2isPush: false,
          button3Icon: Icons.check,
          button3isPush: false,
        ),
      );
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
