import 'package:config_app/features/config/presentation/wigdgets/argb_color_field.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_test/flutter_test.dart';

Widget app(
  Widget child, {
  Locale locale = const Locale('en'),
  double scale = 1,
}) => MaterialApp(
  locale: locale,
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
    child: child!,
  ),
  home: Scaffold(body: Form(child: child)),
);

void main() {
  testWidgets(
    'ARGB typing, picker cancellation and alpha commit keep draft validation',
    (tester) async {
      var value = 0xff112233;
      var valid = true;
      await tester.pumpWidget(
        app(
          StatefulBuilder(
            builder: (context, update) => ArgbColorField(
              label: 'Color',
              value: value,
              onValidityChanged: (value) => valid = value,
              onChanged: (color) => update(() => value = color),
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextFormField), '80123456');
      await tester.pump();
      expect(value, 0x80123456);
      await tester.enterText(find.byType(TextFormField), 'bad');
      await tester.pump();
      expect(valid, isFalse);
      expect(value, 0x80123456);
      await tester.tap(find.byTooltip('Choose color'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<ColorPicker>(find.byType(ColorPicker)).enableAlpha,
        isTrue,
      );
      tester
          .widget<ColorPicker>(find.byType(ColorPicker))
          .onColorChanged(const Color(0x40887766));
      await tester.pump();
      expect(value, 0x80123456);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(valid, isFalse);
      expect(
        tester
            .widget<TextFormField>(find.byType(TextFormField))
            .controller!
            .text,
        'bad',
      );
      await tester.tap(find.byTooltip('Choose color'));
      await tester.pumpAndSettle();
      tester
          .widget<ColorPicker>(find.byType(ColorPicker))
          .onColorChanged(const Color(0x40887766));
      await tester.pump();
      expect(find.text('40887766'), findsOneWidget);
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();
      expect(value, 0x40887766);
      expect(valid, isTrue);
      expect(
        tester
            .widget<TextFormField>(find.byType(TextFormField))
            .controller!
            .text,
        '40887766',
      );
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('picker preserves the selected hue while saturation is zero', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(ArgbColorField(label: 'Color', value: 0xff000000, onChanged: (_) {})),
    );
    await tester.tap(find.byTooltip('Choose color'));
    await tester.pumpAndSettle();
    const hsv = HSVColor.fromAHSV(.5, 230, 0, .4);
    final picker = tester.widget<ColorPicker>(find.byType(ColorPicker));
    picker.onColorChanged(hsv.toColor());
    picker.onHsvColorChanged!(hsv);
    await tester.pump();
    expect(
      tester.widget<ColorPicker>(find.byType(ColorPicker)).pickerHsvColor,
      hsv,
    );
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  const locale = Locale('en');
  testWidgets(
    'picker fits a narrow screen with large text (${locale.languageCode})',
    (tester) async {
      tester.view.physicalSize = const Size(390, 700);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var value = 0x80123456;
      await tester.pumpWidget(
        app(
          ArgbColorField(
            label: 'Background color (AARRGGBB)',
            value: value,
            onChanged: (color) => value = color,
          ),
          locale: locale,
          scale: 1.5,
        ),
      );
      await tester.tap(find.byIcon(Icons.palette_outlined));
      await tester.pumpAndSettle();
      expect(find.byType(ColorPicker), findsOneWidget);
      await tester.ensureVisible(find.text('Apply'));
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();
      expect(value, 0x80123456);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets('removing the field closes its picker without a late edit', (
    tester,
  ) async {
    var shown = true;
    var changes = 0;
    late StateSetter update;
    await tester.pumpWidget(
      app(
        StatefulBuilder(
          builder: (context, setState) {
            update = setState;
            return shown
                ? ArgbColorField(
                    label: 'Color',
                    value: 0xff112233,
                    onChanged: (_) => changes++,
                  )
                : const SizedBox();
          },
        ),
      ),
    );
    await tester.tap(find.byTooltip('Choose color'));
    await tester.pumpAndSettle();
    tester
        .widget<ColorPicker>(find.byType(ColorPicker))
        .onColorChanged(Colors.red);
    update(() => shown = false);
    await tester.pumpAndSettle();
    expect(find.byType(ColorPicker), findsNothing);
    expect(changes, 0);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });
}
