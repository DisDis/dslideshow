import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import '../repository.dart';
import 'probe.dart';

final _log = Logger('ambient');
ArgParser ambientParser({String? defaultStateDirectory}) => ArgParser()
  ..addFlag('help', abbr: 'h', negatable: false)
  ..addOption('client-file', help: 'Google OAuth client JSON (TVs and Limited Input devices)')
  ..addOption('state-dir', defaultsTo: defaultStateDirectory ?? p.join(findRepository().path, '.local/ambient-api'))
  ..addOption('output-dir', help: 'Parent for a new private run directory')
  ..addOption('display-name', defaultsTo: 'DSlideshow local Ambient probe')
  ..addOption('source-id', help: 'AmbientDevice.mediaSources ID, not a Library API album ID')
  ..addFlag('configure', negatable: false)
  ..addFlag('reauthorize', negatable: false)
  ..addFlag('delete-device', negatable: false)
  ..addOption('photos', defaultsTo: '1')
  ..addOption('videos', defaultsTo: '1')
  ..addOption('page-size', defaultsTo: '100')
  ..addOption('max-pages', defaultsTo: '10')
  ..addOption('max-download-bytes', defaultsTo: '${512 * 1024 * 1024}')
  ..addOption('request-timeout', defaultsTo: '30')
  ..addOption('download-timeout', defaultsTo: '300')
  ..addOption('auth-timeout', defaultsTo: '600')
  ..addOption('selection-timeout', defaultsTo: '600');

void validateAmbientOptions(ArgResults args) {
  if (args.rest.isNotEmpty || args.option('client-file') == null) {
    throw const FormatException('--client-file is required; see --help');
  }
  for (final name in ['photos', 'videos', 'page-size', 'max-pages', 'max-download-bytes']) {
    if (int.tryParse(args.option(name)!) == null) throw FormatException('--$name must be an integer');
  }
  final photos = int.parse(args.option('photos')!), videos = int.parse(args.option('videos')!);
  final pageSize = int.parse(args.option('page-size')!), maxPages = int.parse(args.option('max-pages')!);
  if (photos < 0 ||
      videos < 0 ||
      pageSize < 1 ||
      pageSize > 100 ||
      maxPages < 1 ||
      maxPages > 240 ||
      int.parse(args.option('max-download-bytes')!) <= 0 ||
      args.option('display-name')!.isEmpty ||
      args.option('display-name')!.length > 100) {
    throw const FormatException('Invalid counts, limits or display name; see --help');
  }
  for (final name in ['request-timeout', 'download-timeout', 'auth-timeout', 'selection-timeout']) {
    try {
      positive(args.option(name));
    } on ProbeError catch (error) {
      throw FormatException(error.message);
    }
  }
}

Future<int> runAmbient(
  List<String> arguments, {
  String? defaultStateDirectory,
  AmbientHttp? http,
  Future<String> Function(String)? prompt,
  void Function(String)? say,
  Future<void> Function(Duration)? sleep,
  double Function()? monotonic,
  double Function()? wall,
  StringSink? output,
  StringSink? errors,
}) async {
  final out = output ?? stdout;
  final err = errors ?? stderr;
  final parser = ambientParser(defaultStateDirectory: defaultStateDirectory);
  ArgResults options;
  try {
    options = parser.parse(arguments);
    if (options.flag('help')) {
      out.writeln('Usage: dslideshow_tools ambient [options]\n${parser.usage}');
      return 0;
    }
    validateAmbientOptions(options);
  } on FormatException catch (error) {
    err.writeln('${error.message}\n${parser.usage}');
    return 64;
  }
  StreamIterator<String>? input;
  final probe = Probe(
    options,
    http: http,
    sleep: sleep,
    monotonic: monotonic,
    wall: wall,
    say: say ?? out.writeln,
    prompt:
        prompt ??
        (message) async {
          out.write(message);
          input ??= StreamIterator(stdin.transform(utf8.decoder).transform(const LineSplitter()));
          if (!await input!.moveNext()) throw const ProbeError('Interactive input closed');
          return input!.current;
        },
  );
  final subscriptions = <StreamSubscription<ProcessSignal>>[];
  final operation = uuidV4();
  final clock = Stopwatch()..start();
  var status = ProbeExit.failed.code;
  var cancellationCode = ProbeExit.interrupted.code;
  try {
    subscriptions.add(
      ProcessSignal.sigint.watch().listen((_) {
        cancellationCode = 130;
        probe.cancel();
      }),
    );
    if (!Platform.isWindows) {
      subscriptions.add(
        ProcessSignal.sigterm.watch().listen((_) {
          cancellationCode = 143;
          probe.cancel();
        }),
      );
    }
    return await withStateLock(Directory(options.option('state-dir')!), () async {
      final parent = privateDirectory(
        Directory(options.option('output-dir') ?? p.join(options.option('state-dir')!, 'runs')),
      );
      probe.output = privateTemporaryDirectory(
        parent,
        '${DateTime.now().toUtc().toIso8601String().replaceAll(':', '')}-',
      );
      probe.say('Результаты: ${probe.output.path}');
      _log.info('component=ambient operation=$operation action=run result=started');
      try {
        status = (await probe.run()).code;
      } on ProbeInterrupted {
        status = cancellationCode;
        (probe.report['errors'] as List).add({'error': 'Interrupted by user'});
        _log.info('component=ambient operation=$operation action=run result=cancelled');
      } on Exception catch (error, stack) {
        final message = probe.http.clean(error);
        status = ProbeExit.failed.code;
        (probe.report['errors'] as List).add({'error': message});
        err.writeln('Ошибка на этапе ${probe.stage.wireName}: $message');
        _log.warning(
          'component=ambient operation=$operation action=run result=failed stage=${probe.stage.wireName} type=${error.runtimeType}',
          error,
          stack,
        );
      }
      probe.report.addAll({'exit_code': status, 'last_stage': probe.stage.wireName});
      saveAmbientJson(File(p.join(probe.output.path, 'report.json')), probe.report);
      probe.say('Код результата: $status; отчёт: ${p.join(probe.output.path, 'report.json')}');
      _log.info(
        'component=ambient operation=$operation action=run result=finished exit=$status success=${(probe.report['downloads'] as List).length} failed=${(probe.report['errors'] as List).length} durationMs=${clock.elapsedMilliseconds}',
      );
      return status;
    });
  } on ProbeInterrupted {
    return cancellationCode;
  } on Exception catch (error, stack) {
    err.writeln('Ошибка: ${probe.http.clean(error)}');
    _log.warning(
      'component=ambient operation=$operation action=run result=failed type=${error.runtimeType}',
      error,
      stack,
    );
    return ProbeExit.failed.code;
  } finally {
    for (final subscription in subscriptions) {
      await subscription.cancel();
    }
    await input?.cancel();
    probe.http.close();
  }
}
