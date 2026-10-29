import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/widgets/folder_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_state.dart';
import 'package:config_app/features/ota/presentation/pages/ota_main_page.dart';
import 'package:config_app/features/power/presentation/bloc/power_bloc.dart';
import 'package:config_app/features/power/presentation/bloc/power_state.dart';
import 'package:config_app/features/power/presentation/widgets/power_tab.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:config_app/features/upload/presentation/pages/upload_screen.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:config_app/features/wifi_config/presentation/widgets/wifi_tab.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

final class _Client implements RealtimeService {
  @override
  Uri get connectUri => Uri.parse('ws://frame.local:8080/ws');

  @override
  String get authCode => '12345';

  @override
  Stream get onDisconnect => const Stream.empty();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Picker extends FilePickerPlatform {
  int calls = 0;

  @override
  Future<List<PlatformFile>> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    int compressionQuality = 0,
    AndroidOptions androidOptions = const AndroidOptions(),
    DarwinOptions darwinOptions = const DarwinOptions(),
    WindowsOptions windowsOptions = const WindowsOptions(),
    LinuxOptions linuxOptions = const LinuxOptions(),
    WebOptions webOptions = const WebOptions(),
  }) async {
    calls++;
    return [];
  }
}

Widget _app(Widget child) => MaterialApp(
  locale: const Locale('ru'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  theme: createDarkTheme(),
  home: child,
);

void main() {
  testWidgets(
    'empty uploads expose a translated action that opens the picker',
    (tester) async {
      final oldPicker = FilePickerPlatform.instance;
      final picker = _Picker();
      FilePickerPlatform.instance = picker;
      addTearDown(() => FilePickerPlatform.instance = oldPicker);
      final bloc = UploadQueueBloc(client: _Client());
      addTearDown(bloc.close);
      await tester.pumpWidget(
        _app(BlocProvider.value(value: bloc, child: const UploadScreen())),
      );
      await tester.pumpAndSettle();

      expect(find.text('Очередь пуста'), findsOneWidget);
      final add = find.byKey(const ValueKey('upload-add-files'));
      expect(add, findsOneWidget);
      expect(
        find.descendant(of: add, matching: find.text('Добавить файлы')),
        findsOneWidget,
      );
      await tester.tap(add);
      await tester.pumpAndSettle();
      expect(picker.calls, 1);
      expect(bloc.state.tasks, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Wi-Fi delete dialog is translated and cancellation keeps the network',
    (tester) async {
      final bloc = WifiTabBloc(
        initialState: const InWifiTabState(
          availableNetworks: [],
          connections: [
            WiFiConnectionInfo(
              name: 'Kitchen Wi-Fi',
              UUID: 'uuid',
              type: 'wifi',
              device: 'wlan0',
            ),
          ],
        ),
        client: _Client(),
      );
      addTearDown(bloc.close);
      await tester.pumpWidget(
        _app(BlocProvider.value(value: bloc, child: const WiFiConfigTab())),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Удалить подключение'));
      await tester.pumpAndSettle();

      expect(find.text('Забыть сеть?'), findsOneWidget);
      expect(
        find.text('Удалить сохранённое подключение «Kitchen Wi-Fi»?'),
        findsOneWidget,
      );
      final delete = tester.widget<FilledButton>(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(FilledButton),
        ),
      );
      final context = tester.element(find.byType(AlertDialog));
      expect(
        delete.style?.backgroundColor?.resolve({}),
        Theme.of(context).colorScheme.error,
      );
      expect(
        delete.style?.foregroundColor?.resolve({}),
        Theme.of(context).colorScheme.onError,
      );
      await tester.tap(find.text('Отмена'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Kitchen Wi-Fi'), findsOneWidget);
    },
  );

  testWidgets('power dialogs show the action label instead of a generic OK', (
    tester,
  ) async {
    final bloc = PowerBloc(
      initialState: InitializedPowerState(AppConfig.fromJson({})),
      client: _Client(),
    );
    addTearDown(bloc.close);
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: BlocProvider.value(value: bloc, child: const PowerTab()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Перезапустить приложение'));
    await tester.pumpAndSettle();

    final dialog = find.byType(AlertDialog);
    expect(
      find.descendant(of: dialog, matching: find.text('Перезапустить')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: dialog, matching: find.text('ОК')),
      findsNothing,
    );
    await tester.tap(find.text('Отмена'));
    await tester.pumpAndSettle();
    expect(bloc.state, isA<InitializedPowerState>());
  });

  testWidgets(
    'OTA version and upload labels use the active language and theme',
    (tester) async {
      final bloc = OtaBloc(
        initialState: const InitializedOtaState(version: '1.2.3'),
        client: _Client(),
      );
      addTearDown(bloc.close);
      await tester.pumpWidget(
        _app(
          Scaffold(
            body: BlocProvider.value(
              value: bloc,
              child: const OtaPageContent(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Версия: 1.2.3'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Код обновления'), findsOneWidget);
      expect(find.text('Выбрать файл'), findsOneWidget);
      expect(find.text('Обновить'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'OTA progress uses a Russian decimal separator and percent spacing',
    (tester) async {
      final bloc = OtaBloc(
        initialState: const UploadingOtaState(progress: .125),
        client: _Client(),
      );
      addTearDown(bloc.close);
      await tester.pumpWidget(
        _app(
          Scaffold(
            body: BlocProvider.value(
              value: bloc,
              child: const OtaPageContent(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Загрузка прошивки…'), findsOneWidget);
      expect(find.text('12,5\u00a0%'), findsOneWidget);
      expect(find.text('12.5%'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('gallery directories cannot be selected for file operations', (
    tester,
  ) async {
    final bloc = GalleryBloc(
      initialState: LoadedGalleryState(
        items: [
          GalleryItem(
            uri: Uri.parse('http://frame.local/album'),
            title: 'album',
          ),
        ],
      ),
      client: _Client(),
    );
    addTearDown(bloc.close);
    await tester.pumpWidget(
      _app(BlocProvider.value(value: bloc, child: const GalleryWidget())),
    );
    await tester.pumpAndSettle();
    await tester.longPress(find.byType(FolderGridItem));
    await tester.pumpAndSettle();

    expect(find.text('Выбран 1 файл'), findsNothing);
    expect(find.byTooltip('Снять выделение'), findsOneWidget);
    expect(
      tester
          .widget<IconButton>(find.widgetWithIcon(IconButton, Icons.close))
          .onPressed,
      isNull,
    );
    expect(find.text('Галерея'), findsWidgets);
  });
}
