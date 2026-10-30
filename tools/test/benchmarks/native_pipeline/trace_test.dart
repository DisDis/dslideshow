import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_tools/src/benchmarks/native_pipeline/trace_instance.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory root;
  late String tracefs, output, instance;
  late Map<String, String> globals;
  const name = 'dslideshow_native_test_1';
  final events = [...drmEvents, clEvents[1], 'v3d/v3d_rcl_irq'];
  void write(String file, String value) {
    final target = File(file);
    target.parent.createSync(recursive: true);
    target.writeAsStringSync(value);
  }

  void create(String path) {
    Directory(path).createSync();
    for (final entry in {
      'tracing_on': '0',
      'trace_clock': '[local] global mono mono_raw',
      'current_tracer': 'nop',
      'buffer_size_kb': '1024',
      'trace': '',
    }.entries) {
      write(p.join(path, entry.key), entry.value);
    }
    for (final event in events) {
      write(
        p.join(path, 'events', event, 'format'),
        File(p.join(tracefs, 'events', event, 'format')).readAsStringSync(),
      );
      write(p.join(path, 'events', event, 'enable'), '0');
    }
    for (var cpu = 0; cpu < 2; cpu++) {
      write(
        p.join(path, 'per_cpu', 'cpu$cpu', 'stats'),
        'entries: 12\noverrun: 0\ncommit overrun: 0\nbytes: 1024\ndropped events: 0\n',
      );
    }
  }

  void remove(String path) {
    expect(path, instance);
    expect(File(p.join(path, 'tracing_on')).readAsStringSync(), '0');
    Directory(path).deleteSync(recursive: true);
  }

  TraceSession session({void Function(String)? creator, int buffer = 8192}) =>
      TraceSession(tracefs: tracefs, bufferSizeKb: buffer, createInstance: creator ?? create, removeInstance: remove);
  Map<String, dynamic> state() =>
      jsonDecode(File(p.join(output, 'trace-provenance.json')).readAsStringSync()) as Map<String, dynamic>;
  setUp(() {
    root = Directory.systemTemp.createTempSync('native-trace-');
    tracefs = p.join(root.path, 'tracefs');
    output = p.join(root.path, 'capture');
    instance = p.join(tracefs, 'instances', name);
    Directory(p.join(tracefs, 'instances')).createSync(recursive: true);
    for (final event in events) {
      write(p.join(tracefs, 'events', event, 'format'), 'name: $event\nfield: unsigned int seqno;\n');
      write(p.join(tracefs, 'events', event, 'enable'), 'GLOBAL disabled');
    }
    write(p.join(tracefs, 'available_events'), events.join('\n'));
    for (final control in ['trace', 'tracing_on', 'trace_clock', 'buffer_size_kb', 'current_tracer']) {
      write(p.join(tracefs, control), 'GLOBAL $control unchanged');
    }
    globals = {
      for (final file in Directory(tracefs).listSync(recursive: true).whereType<File>())
        file.path: file.readAsStringSync(),
    };
  });
  tearDown(() {
    for (final entry in globals.entries) {
      if (File(entry.key).existsSync()) expect(File(entry.key).readAsStringSync(), entry.value, reason: entry.key);
    }
    root.deleteSync(recursive: true);
  });
  test('init changes private controls only records actual clocks events and CPU inventory', () async {
    final tool = session(buffer: 16384);
    await tool.run(TraceAction.init, name, output);
    final value = state();
    expect(value['status'], 'initialized');
    expect(value['initial_cpus'], ['cpu0', 'cpu1']);
    expect(value['buffer_size_kb_per_cpu_actual'], '16384');
    expect(value['trace_clock'], 'mono');
    expect(value['missing_required'], isEmpty);
    final inventory = value['events'] as Map<String, dynamic>;
    for (final event in events) {
      expect((inventory[event] as Map)['selected'], true);
      expect((inventory[event] as Map)['format'], contains('seqno'));
      expect(File(p.join(instance, 'events', event, 'enable')).readAsStringSync(), '1');
    }
    expect(inventory['v3d/v3d_csd_irq'], {
      'available': false,
      'required': false,
      'required_group': null,
      'selected': false,
      'format': null,
    });
    await tool.run(TraceAction.close, name, output);
    await tool.run(TraceAction.close, name, output);
    expect(Directory(instance).existsSync(), false);
  });
  test('start stop preserve raw trace and actual loss counters', () async {
    final tool = session();
    await tool.run(TraceAction.init, name, output);
    write(p.join(instance, 'trace'), 'old');
    await tool.run(TraceAction.start, name, output);
    expect(File(p.join(instance, 'trace')).readAsStringSync(), '');
    expect(File(p.join(instance, 'tracing_on')).readAsStringSync(), '1');
    const raw = 'render-42 [001] .... 123.456: v3d_rcl_irq: dev=0, seqno=57\n';
    write(p.join(instance, 'trace'), raw);
    write(p.join(instance, 'per_cpu/cpu1/stats'), 'overrun: 3\ncommit overrun: 1\n');
    await tool.run(TraceAction.stop, name, output);
    expect(File(p.join(output, 'trace.txt')).readAsStringSync(), raw);
    expect(File(p.join(instance, 'tracing_on')).readAsStringSync(), '0');
    final stats = jsonDecode(File(p.join(output, 'trace-stats.json')).readAsStringSync()) as Map<String, dynamic>;
    expect(stats['stats_complete'], true);
    expect(stats['loss_detected'], true);
    expect((((stats['per_cpu'] as Map)['cpu1'] as Map)['counters'] as Map)['commit_overrun'], 1);
    expect(
      (state()['stopped'] as Map)['monotonic_ns'],
      greaterThan((state()['started'] as Map)['monotonic_ns'] as int),
    );
    await tool.run(TraceAction.close, name, output);
  });
  test('missing CPU stats remain unknown; absent counters are never fabricated', () async {
    final tool = session();
    await tool.run(TraceAction.init, name, output);
    await tool.run(TraceAction.start, name, output);
    File(p.join(instance, 'per_cpu/cpu1/stats')).deleteSync();
    await tool.run(TraceAction.stop, name, output);
    final stats = jsonDecode(File(p.join(output, 'trace-stats.json')).readAsStringSync()) as Map<String, dynamic>;
    expect(stats['missing_cpus'], ['cpu1']);
    expect(stats['stats_complete'], false);
    expect(stats['loss_detected'], isNull);
  });
  test('existing instance and output are never adopted stopped or overwritten', () async {
    create(instance);
    write(p.join(instance, 'tracing_on'), '1');
    final tool = session();
    await expectLater(tool.run(TraceAction.init, name, output), throwsA(isA<FileSystemException>()));
    expect(state()['status'], 'failed');
    expect(File(p.join(instance, 'tracing_on')).readAsStringSync(), '1');
    await expectLater(tool.run(TraceAction.close, name, output), throwsStateError);
    expect(Directory(instance).existsSync(), true);
    write(p.join(output, 'sentinel'), 'preserve');
    await expectLater(tool.run(TraceAction.init, name, output), throwsA(isA<FileSystemException>()));
    expect(File(p.join(output, 'sentinel')).readAsStringSync(), 'preserve');
  });
  test('missing required events preserve evidence without creating instance', () async {
    for (final event in [drmEvents.first, clEvents[1]]) {
      final file = File(p.join(tracefs, 'events', event, 'format')), original = file.readAsStringSync();
      file.deleteSync();
      await expectLater(session().run(TraceAction.init, name, output), throwsStateError);
      expect(state()['status'], 'failed');
      expect(state()['missing_required'], isNotEmpty);
      expect(Directory(instance).existsSync(), false);
      Directory(output).deleteSync(recursive: true);
      file.writeAsStringSync(original);
    }
  });
  test('partial initialization and interruption clean only owned instance', () async {
    final tool = session(
      creator: (path) {
        create(path);
        write(p.join(path, 'trace_clock'), '[local] global');
      },
    );
    await expectLater(tool.run(TraceAction.init, name, output), throwsStateError);
    expect(Directory(instance).existsSync(), false);
    expect(state()['cleanup_errors'], isEmpty);
    Directory(output).deleteSync(recursive: true);
    var checks = 0;
    await expectLater(
      session().run(
        TraceAction.init,
        name,
        output,
        checkCancelled: () {
          if (++checks == 2) throw StateError('Interrupted by SIGTERM');
        },
      ),
      throwsStateError,
    );
    expect(Directory(instance).existsSync(), false);
    expect(state()['instance_inode'], isNotNull);
    expect(state()['status'], 'failed');
    expect(state()['cleanup_errors'], isEmpty);
  });
  test('stop output collision preserves file and cleans running instance', () async {
    final tool = session();
    await tool.run(TraceAction.init, name, output);
    await tool.run(TraceAction.start, name, output);
    write(p.join(output, 'trace.txt'), 'preserve');
    await expectLater(tool.run(TraceAction.stop, name, output), throwsA(isA<FileSystemException>()));
    expect(Directory(instance).existsSync(), false);
    expect(File(p.join(output, 'trace.txt')).readAsStringSync(), 'preserve');
    expect(state()['status'], 'failed');
  });
  test('changed instance identity is untouched', () async {
    final tool = session();
    await tool.run(TraceAction.init, name, output);
    final value = state();
    value['instance_inode'] = (value['instance_inode'] as int) + 1;
    write(p.join(output, 'trace-provenance.json'), jsonEncode(value));
    write(p.join(instance, 'tracing_on'), '1');
    await expectLater(tool.run(TraceAction.close, name, output), throwsStateError);
    expect(File(p.join(instance, 'tracing_on')).readAsStringSync(), '1');
  });
  test('invalid names buffers paths and symlink ancestors fail before output', () async {
    for (final invalid in ['global', 'dslideshow_native_../bad', 'dslideshow_native_', 'dslideshow_native_x/y']) {
      await expectLater(session().run(TraceAction.init, invalid, output), throwsArgumentError);
    }
    for (final buffer in [0, 8191, 16385]) {
      await expectLater(session(buffer: buffer).run(TraceAction.init, name, output), throwsArgumentError);
    }
    for (final invalid in ['relative-output', p.join(tracefs, 'bad')]) {
      await expectLater(session().run(TraceAction.init, name, invalid), throwsArgumentError);
    }
    Link(p.join(root.path, 'linked')).createSync(root.path);
    await expectLater(session().run(TraceAction.init, name, p.join(root.path, 'linked/capture')), throwsArgumentError);
    expect(Directory(output).existsSync(), false);
  });
  test('selected clock and sudo owner validation remain explicit', () {
    expect(activeClock('local global [mono] mono_raw\n'), 'mono');
    expect(activeClock('[local] global mono'), 'local');
    expect(activeClock('local global mono'), isNull);
    expect(outputOwner(environment: {'SUDO_UID': '1001', 'SUDO_GID': '1002'}, effectiveUid: 0), [1001, 1002]);
    for (final values in [('wrong', '1002'), ('1001', ''), ('-1', '1002'), ('1001', '4294967295'), ('1001', null)]) {
      expect(
        () => outputOwner(
          environment: {'SUDO_UID': values.$1, if (values.$2 != null) 'SUDO_GID': values.$2!},
          effectiveUid: 0,
        ),
        throwsArgumentError,
      );
    }
  });
  test('sudo chown only applies to newly created output even preflight fails', () async {
    File(p.join(tracefs, 'events', drmEvents.first, 'format')).deleteSync();
    final calls = <(String, List<int>)>[];
    final tool = TraceSession(
      tracefs: tracefs,
      effectiveUid: 0,
      environment: {'SUDO_UID': '1001', 'SUDO_GID': '1002'},
      createInstance: create,
      removeInstance: remove,
      changeOwner: (path, ids) => calls.add((path, ids)),
    );
    await expectLater(tool.run(TraceAction.init, name, output), throwsStateError);
    expect(calls.length, 1);
    expect(calls.single.$1, output);
    expect(calls.single.$2, [1001, 1002]);
    expect(state()['output_owner'], {'uid': 1001, 'gid': 1002});
    await expectLater(tool.run(TraceAction.init, name, output), throwsA(isA<FileSystemException>()));
    expect(calls.length, 1);
  });
}
