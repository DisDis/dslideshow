// Uses the exact xterm version supplied by the production page path dependency.
// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:benchmarks/ota_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xterm/xterm.dart';

void main() {
  testWidgets(
    'history probe scrolls the terminal past a scrollable status panel',
    (tester) async {
      final harness = OtaHarness(Directory.systemTemp);
      final terminal = Terminal(maxLines: 3000)..write(otaLogLines(0, 200));
      final terminalScroll = ScrollController();
      final statusScroll = ScrollController();
      addTearDown(() async {
        await harness.frontend.close();
        await harness.route.close();
        await harness.timingBatches.close();
        harness.mounted.dispose();
        harness.marker.dispose();
        terminalScroll.dispose();
        statusScroll.dispose();
      });
      await tester.pumpWidget(
        MaterialApp(
          home: RepaintBoundary(
            key: harness.rootKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: SingleChildScrollView(
                    controller: statusScroll,
                    child: Text(
                      List.filled(100, 'Installing firmware').join('\n'),
                    ),
                  ),
                ),
                Expanded(
                  child: TerminalView(
                    terminal,
                    readOnly: true,
                    scrollController: terminalScroll,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      expect(harness.scrollable.position, same(terminalScroll.position));
      harness.scrollable.position.jumpTo(
        terminalScroll.position.maxScrollExtent - 400,
      );
      await tester.pump();
      expect(terminalScroll.position.extentAfter, greaterThan(100));
      final history = terminalScroll.offset;
      terminal.write(otaLogLines(200, 50));
      await tester.pump();
      expect(terminalScroll.offset, history);
      expect(statusScroll.offset, 0);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
