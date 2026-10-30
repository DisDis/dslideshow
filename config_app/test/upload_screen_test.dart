import 'dart:typed_data';

import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:config_app/features/upload/presentation/pages/upload_screen.dart';
import 'package:config_app/src/web_client/web_client.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/upload_support.dart';

void main() {
  testWidgets(
    'typed error, retry, progress and cancellation use the working upload queue',
    (tester) async {
      final transport = ControlledUploadHttpClient();
      final bloc = UploadQueueBloc(
        client: UploadRealtimeService(),
        webClientFactory: () => WebClient(
          host: 'frame',
          port: 80,
          code: '',
          clientFactory: () => transport,
        ),
      );
      addTearDown(bloc.close);
      final file = SelectedUploadFile('photo.jpg', size: null);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider.value(value: bloc, child: const UploadScreen()),
        ),
      );
      bloc.add(UploadQueueEvent.addPlatformFiles(files: [file], rootPath: ''));
      await tester.pump();
      expect(bloc.state.tasks.single.status, UploadStatus.error);
      expect(find.text('Could not determine the file size.'), findsOneWidget);
      expect(find.byTooltip('Retry'), findsOneWidget);
      file.size = 4;
      await tester.tap(find.byTooltip('Retry'));
      await tester.pump();
      expect(bloc.state.tasks.single.status, UploadStatus.uploading);
      expect(find.byTooltip('Cancel'), findsOneWidget);
      file.chunks.add(Uint8List.fromList([1, 2]));
      await tester.pump();
      expect(find.text('50'), findsOneWidget);
      await tester.tap(find.byTooltip('Cancel'));
      await tester.pump();
      await tester.pump();
      expect(bloc.state.tasks, isEmpty);
      expect(find.text('Queue is empty'), findsOneWidget);
      expect(transport.closed, isTrue);
      expect(file.cancelStarted.isCompleted, isTrue);
      expect(file.byteReads, 0);
    },
  );
}
