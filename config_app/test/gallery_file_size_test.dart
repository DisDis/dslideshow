import 'package:config_app/features/gallery/presentation/widgets/gallery_file_size.dart';
import 'package:config_app/features/gallery/presentation/widgets/metadata_panel.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/gallery_management_harness.dart';

Widget _app(Widget child, {Locale locale = const Locale('en')}) => MaterialApp(
  locale: locale,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);

void main() {
  testWidgets(
    'sizes always use decimal megabytes, including tiny and multi-gigabyte files',
    (tester) async {
      await tester.pumpWidget(
        _app(
          Column(
            children: [
              for (final bytes in [0, 1, 9999, 10000, 2500000, 2500000000])
                GalleryFileSize(bytes: bytes),
            ],
          ),
        ),
      );
      expect(find.text('0.00 MB'), findsOneWidget);
      expect(find.text('< 0.01 MB'), findsNWidgets(2));
      expect(find.text('0.01 MB'), findsOneWidget);
      expect(find.text('2.50 MB'), findsOneWidget);
      expect(find.text('2,500.00 MB'), findsOneWidget);
      expect(find.textContaining('bytes'), findsNothing);
      expect(find.byTooltip('Exact size: 9999 bytes'), findsOneWidget);
      expect(find.byTooltip('Exact size: 2500000000 bytes'), findsOneWidget);
    },
  );

  testWidgets('precise bytes appear only after opening the tooltip', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(const GalleryFileSize(bytes: 2500123, showLabel: true)),
    );
    expect(find.text('File size: 2.50 MB'), findsOneWidget);
    expect(find.text('Exact size: 2500123 bytes'), findsNothing);
    await tester.longPress(find.text('File size: 2.50 MB'));
    await tester.pump();
    expect(find.text('Exact size: 2500123 bytes'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Russian size labels and decimal separators are localized', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(const GalleryFileSize(bytes: 2500123), locale: const Locale('ru')),
    );
    expect(find.text('2,50 МБ'), findsOneWidget);
    expect(find.byTooltip('Точный размер: 2500123 байт'), findsOneWidget);
  });

  testWidgets(
    'viewer metadata uses the same megabyte display with selectable text and precise tooltip',
    (tester) async {
      await tester.pumpWidget(
        _app(
          MetadataPanel(
            item: managedPhoto('a'),
            metadata: photoMetadata('a').copyWith(sizeBytes: 2500123),
          ),
        ),
      );
      expect(find.widgetWithText(SelectableText, '2.50 MB'), findsOneWidget);
      expect(find.byTooltip('Exact size: 2500123 bytes'), findsOneWidget);
      expect(find.textContaining('2500123'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}
