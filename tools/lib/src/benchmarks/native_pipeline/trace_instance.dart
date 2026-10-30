import 'dart:io';

import 'package:path/path.dart' as p;

import '../json_io.dart' show asMap, decodeStrictJson;
import 'clock.dart';
import 'posix.dart';

final _namePattern = RegExp(r'^dslideshow_native_[a-zA-Z0-9_]+$');
final _statPattern = RegExp(r'^([^:]+):\s*(\d+)\s*$');
final _digits = RegExp(r'^[0-9]+$');
final _whitespace = RegExp(r'\s+');
const drmEvents = ['drm/drm_vblank_event_queued', 'drm/drm_vblank_event_delivered'];
const clEvents = ['v3d/v3d_submit_cl', 'v3d/v3d_submit_cl_ioctl'];
const optionalEvents = [
  'v3d/v3d_bcl_irq',
  'v3d/v3d_rcl_irq',
  'v3d/v3d_submit_csd',
  'v3d/v3d_submit_csd_ioctl',
  'v3d/v3d_csd_irq',
  'v3d/v3d_submit_tfu',
  'v3d/v3d_submit_tfu_ioctl',
  'v3d/v3d_tfu_irq',
];
const _lossCounters = ['overrun', 'commit_overrun', 'dropped_events'];

enum TraceAction { init, start, stop, close }

enum TraceStatus { initializing, initialized, running, stopped, closed, failed }

String? activeClock(String value) {
  final tokens = value.trim().split(_whitespace);
  final selected = tokens.where((token) => token.startsWith('[') && token.endsWith(']')).toList();
  return selected.length == 1
      ? selected.single.substring(1, selected.single.length - 1)
      : tokens.length == 1
      ? tokens.single
      : null;
}

List<int>? outputOwner({Map<String, String>? environment, int? effectiveUid}) {
  environment ??= Platform.environment;
  effectiveUid ??= int.parse(Process.runSync('id', ['-u']).stdout.toString().trim());
  if (effectiveUid != 0) return null;
  final uid = environment['SUDO_UID'], gid = environment['SUDO_GID'];
  if (uid == null && gid == null) return null;
  if (uid == null ||
      gid == null ||
      !_digits.hasMatch(uid) ||
      !_digits.hasMatch(gid) ||
      BigInt.parse(uid) > BigInt.from(4294967294) ||
      BigInt.parse(gid) > BigInt.from(4294967294)) {
    throw ArgumentError('SUDO_UID and SUDO_GID must both be valid numeric IDs');
  }
  return [int.parse(uid), int.parse(gid)];
}

/// Owns one private tracefs instance and never writes global tracing controls.
class TraceSession {
  TraceSession({
    this.tracefs = '/sys/kernel/tracing',
    this.bufferSizeKb = 8192,
    this.clock = monotonicNanoseconds,
    void Function(String)? createInstance,
    void Function(String)? removeInstance,
    this.environment,
    this.effectiveUid,
    void Function(String, List<int>)? changeOwner,
  }) : createInstance = createInstance ?? ((path) => Directory(path).createSync()),
       removeInstance = removeInstance ?? ((path) => Directory(path).deleteSync()),
       changeOwner = changeOwner ?? _chown;

  final String tracefs;
  final int bufferSizeKb;
  final int Function() clock;
  final void Function(String) createInstance, removeInstance;
  final void Function(String, List<int>) changeOwner;
  final Map<String, String>? environment;
  final int? effectiveUid;

  static void _chown(String path, List<int> owner) {
    if (Process.runSync('chown', ['${owner[0]}:${owner[1]}', '--', path]).exitCode != 0) {
      throw FileSystemException('chown failed', path);
    }
  }

  Map<String, dynamic> _clock() => {
    'monotonic_ns': clock(),
    'realtime_ns': DateTime.now().microsecondsSinceEpoch * 1000,
  };
  TraceStatus _status(Map<String, dynamic> state) => TraceStatus.values.byName(state['status'] as String);
  void _setStatus(Map<String, dynamic> state, TraceStatus value) => state['status'] = value.name;

  List<String> _cleanup(String instance, Map<String, dynamic> state) {
    final errors = <String>[];
    if (FileSystemEntity.typeSync(instance, followLinks: false) != FileSystemEntityType.directory) return errors;
    if (inode(instance) != state['instance_inode']) return ['Instance identity changed; not removed'];
    try {
      File(p.join(instance, 'tracing_on')).writeAsStringSync('0');
    } on Object catch (error) {
      errors.add('disable: $error');
    }
    try {
      removeInstance(instance);
    } on Object catch (error) {
      errors.add('remove: $error');
    }
    return errors;
  }

  Map<String, dynamic> _inventory() => {
    for (final event in [...drmEvents, ...clEvents, ...optionalEvents])
      event: {
        'available': File(p.join(tracefs, 'events', event, 'format')).existsSync(),
        'required': drmEvents.contains(event),
        'required_group': clEvents.contains(event) ? 'cl_submission' : null,
        'selected': File(p.join(tracefs, 'events', event, 'format')).existsSync(),
        'format': File(p.join(tracefs, 'events', event, 'format')).existsSync()
            ? File(p.join(tracefs, 'events', event, 'format')).readAsStringSync()
            : null,
      },
  };

  Future<void> run(TraceAction action, String name, String output, {void Function()? checkCancelled}) async {
    if (!_namePattern.hasMatch(name)) {
      throw ArgumentError('Invalid instance name; expected dslideshow_native_[a-zA-Z0-9_]+');
    }
    if (bufferSizeKb < 8192 || bufferSizeKb > 16384) {
      throw ArgumentError('Per-CPU buffer must be between 8192 and 16384 KiB');
    }
    safePath(tracefs);
    safePath(output);
    if (output == tracefs || p.isWithin(tracefs, output)) throw ArgumentError('Output must be outside tracefs');
    final instance = p.join(tracefs, 'instances', name), provenance = p.join(output, 'trace-provenance.json');
    if (action == TraceAction.init) {
      final owner = outputOwner(environment: environment, effectiveUid: effectiveUid);
      final made = Process.runSync('mkdir', ['-m', '0700', '--', output]);
      if (made.exitCode != 0) throw FileSystemException('Output already exists or cannot be created', output);
      if (owner != null) changeOwner(output, owner);
    }
    final lockPath = p.join(output, '.session.lock');
    if (FileSystemEntity.typeSync(lockPath, followLinks: false) == FileSystemEntityType.link) {
      throw FileSystemException('Session lock is symlink', lockPath);
    }
    final lock = File(lockPath).openSync(mode: FileMode.append);
    try {
      lock.lockSync();
      if (action == TraceAction.init) {
        final owner = outputOwner(environment: environment, effectiveUid: effectiveUid);
        final kernel = <String, String>{
          for (final (name, flag) in [
            ('sysname', '-s'),
            ('nodename', '-n'),
            ('release', '-r'),
            ('version', '-v'),
            ('machine', '-m'),
          ])
            name: Process.runSync('uname', [flag]).stdout.toString().trim(),
        };
        final state = <String, dynamic>{
          'schema_version': 1,
          'instance_name': name,
          'tracefs': tracefs,
          'instance': instance,
          'instance_inode': null,
          'status': TraceStatus.initializing.name,
          'created': _clock(),
          'kernel': kernel,
          'buffer_size_kb_per_cpu_requested': bufferSizeKb,
          'output_owner': owner == null ? null : {'uid': owner[0], 'gid': owner[1]},
          'required_event_groups': {'drm': drmEvents, 'cl_submission_any': clEvents},
        };
        writeJson(provenance, state, exclusive: true);
        var owned = false;
        try {
          final events = _inventory();
          state['events'] = events;
          final available = File(p.join(tracefs, 'available_events'));
          state['available_events'] = available.existsSync() ? available.readAsStringSync() : null;
          final missing = [
            for (final event in drmEvents)
              if (asMap(events[event])['available'] != true) event,
          ];
          if (!clEvents.any((event) => asMap(events[event])['available'] == true)) {
            missing.add('cl_submission_any:${clEvents.join('|')}');
          }
          state['missing_required'] = missing;
          if (missing.isNotEmpty) throw StateError('Missing required trace events: ${missing.join(', ')}');
          if (FileSystemEntity.typeSync(instance, followLinks: false) != FileSystemEntityType.notFound) {
            throw FileSystemException('Trace instance already exists', instance);
          }
          createInstance(instance);
          owned = true;
          state['instance_inode'] = inode(instance);
          writeJson(provenance, state);
          await Future<void>.delayed(Duration.zero);
          checkCancelled?.call();
          File(p.join(instance, 'tracing_on')).writeAsStringSync('0');
          final clocks = File(p.join(instance, 'trace_clock')).readAsStringSync();
          state['trace_clock_available'] = clocks;
          if (!clocks
              .split(_whitespace)
              .map((value) => value.replaceAll('[', '').replaceAll(']', ''))
              .contains('mono')) {
            throw StateError('The private trace instance has no mono clock');
          }
          File(p.join(instance, 'trace_clock')).writeAsStringSync('mono');
          File(p.join(instance, 'current_tracer')).writeAsStringSync('nop');
          File(p.join(instance, 'buffer_size_kb')).writeAsStringSync('$bufferSizeKb');
          state['trace_clock_readback'] = File(p.join(instance, 'trace_clock')).readAsStringSync().trim();
          state['trace_clock'] = activeClock(state['trace_clock_readback'] as String);
          if (state['trace_clock'] != 'mono') {
            throw StateError('The private trace instance did not select the mono clock');
          }
          state['buffer_size_kb_per_cpu_actual'] = File(p.join(instance, 'buffer_size_kb')).readAsStringSync().trim();
          final cpus = Directory(p.join(instance, 'per_cpu'));
          state['initial_cpus'] = cpus.existsSync()
              ? (cpus.listSync().map((value) => p.basename(value.path)).where((name) => name.startsWith('cpu')).toList()
                  ..sort())
              : <String>[];
          for (final event in events.entries) {
            final info = asMap(event.value);
            if (info['selected'] == true) {
              info['format'] = File(p.join(instance, 'events', event.key, 'format')).readAsStringSync();
              File(p.join(instance, 'events', event.key, 'enable')).writeAsStringSync('1');
              events[event.key] = info;
              await Future<void>.delayed(Duration.zero);
              checkCancelled?.call();
            }
          }
          _setStatus(state, TraceStatus.initialized);
          writeJson(provenance, state);
        } on Object catch (error) {
          _setStatus(state, TraceStatus.failed);
          state.addAll({
            'error': '$error',
            'failed': _clock(),
            'cleanup_errors': owned ? _cleanup(instance, state) : <String>[],
          });
          writeJson(provenance, state);
          rethrow;
        }
        return;
      }
      final state = asMap(decodeStrictJson(File(provenance).readAsStringSync()));
      if (state['schema_version'] != 1 ||
          state['instance_name'] != name ||
          state['tracefs'] != tracefs ||
          state['instance'] != instance) {
        throw StateError('Output provenance does not identify this instance');
      }
      final removed =
          action == TraceAction.close &&
          [TraceStatus.closed, TraceStatus.failed].contains(_status(state)) &&
          !Directory(instance).existsSync();
      if (!removed &&
          (FileSystemEntity.typeSync(instance, followLinks: false) != FileSystemEntityType.directory ||
              inode(instance) != state['instance_inode'])) {
        throw StateError('Instance identity changed; refusing to operate on it');
      }
      try {
        switch (action) {
          case TraceAction.init:
            throw StateError('Already initialized');
          case TraceAction.start:
            if (_status(state) != TraceStatus.initialized) throw StateError('Start requires a new initialized capture');
            File(p.join(instance, 'trace')).writeAsStringSync('');
            state['started'] = _clock();
            File(p.join(instance, 'tracing_on')).writeAsStringSync('1');
            _setStatus(state, TraceStatus.running);
          case TraceAction.stop:
            if (_status(state) != TraceStatus.running) throw StateError('Stop requires a running capture');
            File(p.join(instance, 'tracing_on')).writeAsStringSync('0');
            state['stopped'] = _clock();
            final target = File(p.join(output, 'trace.txt'))..createSync(exclusive: true);
            await File(p.join(instance, 'trace')).copy(target.path);
            checkCancelled?.call();
            _saveStats(instance, output, state);
            _setStatus(state, TraceStatus.stopped);
          case TraceAction.close:
            final errors = _cleanup(instance, state);
            if (errors.isNotEmpty) throw StateError(errors.join('; '));
            _setStatus(state, TraceStatus.closed);
            state['closed'] = _clock();
        }
        writeJson(provenance, state);
      } on Object catch (error) {
        _setStatus(state, TraceStatus.failed);
        state.addAll({'error': '$error', 'failed': _clock(), 'cleanup_errors': _cleanup(instance, state)});
        writeJson(provenance, state);
        rethrow;
      }
    } finally {
      lock.closeSync();
    }
  }

  void _saveStats(String instance, String output, Map<String, dynamic> state) {
    final cpus = <String, dynamic>{};
    final parent = Directory(p.join(instance, 'per_cpu'));
    if (parent.existsSync()) {
      for (final cpu in parent.listSync().whereType<Directory>()) {
        final file = File(p.join(cpu.path, 'stats'));
        if (!file.existsSync()) continue;
        final raw = file.readAsStringSync(), counters = <String, int>{};
        for (final line in raw.split('\n')) {
          final match = _statPattern.firstMatch(line);
          if (match != null) counters[match[1]!.trim().replaceAll(' ', '_')] = int.parse(match[2]!);
        }
        cpus[p.basename(cpu.path)] = {'raw': raw, 'counters': counters};
      }
    }
    final initial = (state['initial_cpus'] as List<dynamic>).cast<String>();
    final missing = initial.where((name) => !cpus.containsKey(name)).toList()..sort();
    final complete =
        cpus.isNotEmpty &&
        missing.isEmpty &&
        cpus.values.every((value) => asMap(asMap(value)['counters']).containsKey('overrun'));
    final loss = cpus.values.any(
      (value) => _lossCounters.any((key) => (asMap(asMap(value)['counters'])[key] as int? ?? 0) > 0),
    );
    writeJson(p.join(output, 'trace-stats.json'), {
      'schema_version': 1,
      'collected': _clock(),
      'per_cpu': cpus,
      'missing_cpus': missing,
      'stats_complete': complete,
      'loss_detected': complete ? loss : null,
    }, exclusive: true);
    state['stats_complete'] = complete;
    state['loss_detected'] = complete ? loss : null;
  }
}
