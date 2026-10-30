import 'package:config_app/features/gallery/presentation/bloc/gallery_file_path_bloc.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_file_path.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

Widget _app(Widget child, {ThemeData? theme, double textScale = 1}) =>
    MaterialApp(
      theme: theme ?? createLightTheme(),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );

void main() {
  test('relative path preserves literal names and root; absolute paths and parent traversal never reach the UI or logs', () async {
    final messages = <String>[];
    final level = Logger.root.level;
    Logger.root.level = Level.ALL;
    final subscription = Logger.root.onRecord.listen(
      (r) => messages.add(r.message),
    );
    addTearDown(() async {
      await subscription.cancel();
      Logger.root.level = level;
    });
    final nested = GalleryFilePathBloc(
      relativePath: 'Фото/100%25/Кадр 1.jpg',
      name: 'fallback',
    );
    expect(nested.state.displayPath, '/Фото/100%25/Кадр 1.jpg');
    expect(nested.state.folders, ['Фото', '100%25']);
    final expanded = nested.stream.first;
    nested.add(GalleryFilePathEvent.toggle);
    expect((await expanded).expanded, isTrue);
    await nested.close();
    final root = GalleryFilePathBloc(
      relativePath: 'photo.jpg',
      name: 'fallback',
    );
    expect(root.state.displayPath, '/photo.jpg');
    expect(root.state.folders, isEmpty);
    await root.close();
    for (final invalid in [
      '/srv/private/photo.jpg',
      '../private/photo.jpg',
      'album/../private/photo.jpg',
      r'C:\private\photo.jpg',
    ]) {
      final bloc = GalleryFilePathBloc(
        relativePath: invalid,
        name: 'photo.jpg',
      );
      expect(bloc.state.displayPath, isNull);
      expect(bloc.state.name, 'photo.jpg');
      await bloc.close();
    }
    expect(messages.join(), isNot(contains('private')));
    expect(messages.where((m) => m.contains('pathRejected')), hasLength(4));
    expect(
      messages.any(
        (m) =>
            m.contains('pathExpansionChanged') && m.contains('expanded=true'),
      ),
      isTrue,
    );
  });

  testWidgets(
    'nearest folder hides ancestors until full path is expanded and remains selectable',
    (tester) async {
      const full = '/Photos/Family/2026/Summer/Novgorod/photo.jpg';
      await tester.pumpWidget(
        _app(
          const GalleryFilePath(
            relativePath: 'Photos/Family/2026/Summer/Novgorod/photo.jpg',
            name: 'photo.jpg',
            style: GalleryFilePathStyle.nearestFolder,
          ),
        ),
      );
      expect(find.text('photo.jpg'), findsOneWidget);
      expect(find.text('Family'), findsNothing);
      expect(find.text('Novgorod'), findsOneWidget);
      expect(find.text('Photos'), findsNothing);
      expect(find.text(full), findsNothing);
      await tester.tap(find.text('Full path'));
      await tester.pump();
      expect(find.widgetWithText(SelectableText, full), findsOneWidget);
      expect(find.text('Family'), findsOneWidget);
      await tester.tap(find.text('Hide full path'));
      await tester.pump();
      expect(find.text(full), findsNothing);
      expect(find.text('Family'), findsNothing);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets(
    'breadcrumbs show each folder and the filename; root path and metadata arrival keep the right location',
    (tester) async {
      Widget view(String? path) => _app(
        GalleryFilePath(
          relativePath: path,
          name: 'photo.jpg',
          style: GalleryFilePathStyle.breadcrumbs,
        ),
      );
      await tester.pumpWidget(view(null));
      expect(find.text('photo.jpg'), findsOneWidget);
      expect(find.text('Full path'), findsNothing);
      await tester.pumpWidget(view('album/trip/photo.jpg'));
      expect(find.text('Location'), findsOneWidget);
      expect(find.text('album'), findsOneWidget);
      expect(find.text('trip'), findsOneWidget);
      expect(find.text('photo.jpg'), findsOneWidget);
      await tester.pumpWidget(view('photo.jpg'));
      expect(find.text('/'), findsOneWidget);
      expect(find.text('album'), findsNothing);
      await tester.tap(find.text('Full path'));
      await tester.pump();
      expect(find.text('/photo.jpg'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets(
    'both path styles fit 320px and enlarged text with long names in the app themes',
    (tester) async {
      tester.view.physicalSize = const Size(320, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      for (final style in GalleryFilePathStyle.values) {
        await tester.pumpWidget(
          _app(
            GalleryFilePath(
              relativePath: 'Archive/Photos from the long family trip/Summer/Originals/a_very_long_filename_with_no_spaces_and_details.jpg',
              name: 'photo.jpg',
              style: style,
            ),
            theme: style == GalleryFilePathStyle.breadcrumbs
                ? createLightTheme()
                : createDarkTheme(),
            textScale: 1.5,
          ),
        );
        await tester.ensureVisible(find.text('Full path'));
        await tester.tap(find.text('Full path'));
        await tester.pump();
        expect(
          find.widgetWithText(
            SelectableText,
            '/Archive/Photos from the long family trip/Summer/Originals/a_very_long_filename_with_no_spaces_and_details.jpg',
          ),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);
      }
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
