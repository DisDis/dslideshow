// Filesystem reads yield to the web isolate while the CLI owns image processing.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'gallery_catalog_service.dart';
import 'gallery_files.dart';
import 'gallery_tool_runner.dart';

enum _CzkawkaCliGeneration { version8, version12 }

enum _CzkawkaExitClass { unavailable, success, findings, signal, error }

typedef _CandidateSnapshot = ({
  String root,
  bool rootAliased,
  int skipped,
  int unreadable,
  Map<String, GalleryDuplicateMember> candidates,
});

/// Owns one headless CLI task independently from page and catalog lifetimes.
class GalleryDuplicateService {
  static final _log = Logger('GalleryDuplicateService');
  static final _operationPattern = RegExp(r'^[a-zA-Z0-9_-]{1,100}$');
  static final _versionPattern = RegExp(
    r'^czkawka(?:_cli)?\s+([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})(?:\s|$)',
  );
  static final _numericVersionPattern = RegExp(
    r'^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$',
  );
  final GalleryCatalogService catalog;
  final GalleryToolRunner _runner;
  final bool _ownsRunner;
  final Directory directory;
  final String executable;
  final Duration processTimeout;
  final int maxCandidates;
  final int threads;
  GalleryDuplicateJob _job = const GalleryDuplicateJob(
    jobId: '',
    status: GalleryDuplicateStatus.idle,
  );
  GalleryDuplicateJob? _previous;
  final Map<String, GalleryDuplicateJob> _history = {};
  Future<void>? _initializing;
  Future<void>? _work;
  Future<void>? _closing;
  Completer<void>? _cancel;
  bool _starting = false;
  Completer<void>? _startDone;
  bool _closed = false;

  GalleryDuplicateService({
    required this.catalog,
    GalleryToolRunner? runner,
    Directory? directory,
    this.executable = 'czkawka_cli',
    this.processTimeout = const Duration(hours: 6),
    this.maxCandidates = 100000,
    this.threads = 1,
  }) : directory =
           directory ??
           Directory(path.join(catalog.stateDirectory.path, 'duplicates')),
       _runner = runner ?? ProcessGalleryToolRunner(),
       _ownsRunner = runner == null {
    if (maxCandidates < 1 || threads < 1 || processTimeout <= Duration.zero) {
      throw ArgumentError('Invalid duplicate search limits');
    }
    final originals = path.normalize(catalog.originals.absolute.path);
    final working = path.normalize(this.directory.absolute.path);
    if (working == originals || path.isWithin(originals, working)) {
      throw ArgumentError('Search results must be outside originals');
    }
  }

  File get _stateFile => File(path.join(directory.path, 'job.json'));

  Future<void> _initialize() => _initializing ??= _load();

  Future<void> _load() async {
    await directory.create(recursive: true);
    if (!await _stateFile.exists()) return;
    try {
      final decoded = await _readJson(_stateFile);
      _job = GalleryDuplicateJob.fromJson(decoded as Map<String, dynamic>);
      final loadedGroups = _job.groups;
      _job = _job.copyWith(groups: await _deduplicateGroups(loadedGroups));
      if (_job.status == GalleryDuplicateStatus.running ||
          _job.status == GalleryDuplicateStatus.stopping) {
        _job = _job.copyWith(
          status: GalleryDuplicateStatus.interrupted,
          finishedAt: DateTime.now().toUtc(),
        );
        await _save();
      }
      if (_job.jobId.isNotEmpty) _remember(_job);
      _log.info(
        () =>
            'Search state recovered operation=${_operationLabel(_job.jobId)} '
            'status=${_job.status.name} groups=${_job.groups.length} reportedGroups=${loadedGroups.length} '
            'groupMembers=${_job.groups.fold<int>(0, (count, group) => count + group.items.length)}',
      );
    } on FileSystemException catch (error) {
      if (error.osError?.errorCode != 2) rethrow;
    } on FormatException {
      throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
    } on TypeError {
      throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
    }
  }

  Future<GalleryDuplicateJob> status() async {
    _ensureOpen();
    await _initialize();
    _log.fine(
      () =>
          'Search status operation=${_operationLabel(_job.jobId)} '
          'status=${_job.status.name} active=${_work != null}',
    );
    if (_work != null &&
        _job.status != GalleryDuplicateStatus.running &&
        _job.status != GalleryDuplicateStatus.stopping) {
      return _job.copyWith(
        status: _cancel?.isCompleted == true
            ? GalleryDuplicateStatus.stopping
            : GalleryDuplicateStatus.running,
        finishedAt: null,
        error: null,
        groups: const [],
      );
    }
    return _job;
  }

  Future<GalleryDuplicateJob> start(
    GalleryDuplicateStartRequest request,
  ) async {
    _ensureOpen();
    if (!_operationPattern.hasMatch(request.operationId) ||
        request.modes.isEmpty ||
        request.modes.toSet().length != request.modes.length) {
      throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
    }
    await _initialize();
    final modes = request.modes.toList()
      ..sort((a, b) => a.index.compareTo(b.index));
    final existing = _history[request.operationId];
    if (existing != null) {
      _log.fine(
        () =>
            'Search start replay operation=${_operationLabel(request.operationId)} '
            'status=${existing.status.name}',
      );
      if (!_sameModes(existing.modes, modes)) {
        throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
      }
      if (_job.jobId == request.operationId) return status();
      if (_previous?.jobId == request.operationId) return _previous!;
      if (existing.status == GalleryDuplicateStatus.completed) {
        throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
      }
      return existing;
    }
    if (_starting || _work != null)
      throw const GalleryCatalogFailure(GalleryErrorCode.busy);
    _starting = true;
    final startDone = _startDone = Completer<void>();
    try {
      _ensureOpen();
      _previous = _job.status == GalleryDuplicateStatus.completed
          ? _job
          : _previous;
      _job = GalleryDuplicateJob(
        jobId: request.operationId,
        status: GalleryDuplicateStatus.running,
        startedAt: DateTime.now().toUtc(),
        modes: modes,
      );
      _cancel = Completer<void>();
      _remember(_job);
      _log.info(
        () =>
            'Search started operation=${_operationLabel(request.operationId)} '
            'modes=${modes.map((mode) => mode.name).join(',')} '
            'maxCandidates=$maxCandidates '
            'timeoutMs=${processTimeout.inMilliseconds} threads=$threads',
      );
      await _save();
      final cancellation = _cancel!;
      _work = _run(request.operationId, modes, cancellation);
      return _job;
    } on Object catch (error) {
      final code = error is GalleryCatalogFailure
          ? error.code
          : GalleryErrorCode.unavailable;
      final diagnostics = GalleryDuplicateDiagnostics(
        stage: GalleryDuplicateStage.persistence,
        failureReason: _failureReason(code, GalleryDuplicateStage.persistence),
      );
      _log.warning(
        () =>
            'Search start failed operation=${_operationLabel(request.operationId)} '
            'code=${code.name} ${_diagnosticLog(diagnostics)}',
      );
      _job = _job.copyWith(
        status: GalleryDuplicateStatus.failed,
        finishedAt: DateTime.now().toUtc(),
        error: code,
        groups: _previous?.groups ?? const [],
        diagnostics: diagnostics,
      );
      _remember(_job);
      final cancel = _cancel;
      if (cancel != null && !cancel.isCompleted) cancel.complete();
      _cancel = null;
      rethrow;
    } finally {
      _starting = false;
      startDone.complete();
      if (identical(_startDone, startDone)) _startDone = null;
    }
  }

  static bool _sameModes(
    List<GalleryDuplicateMode> first,
    List<GalleryDuplicateMode> second,
  ) => first.length == second.length && first.every(second.contains);

  Future<GalleryDuplicateJob> stop(String jobId) async {
    _ensureOpen();
    await _initialize();
    if (_job.jobId != jobId)
      throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
    final cancel = _cancel;
    if (cancel != null &&
        !cancel.isCompleted &&
        (_job.status == GalleryDuplicateStatus.running ||
            _job.status == GalleryDuplicateStatus.stopping)) {
      _job = _job.copyWith(status: GalleryDuplicateStatus.stopping);
      _log.info(
        () =>
            'Search stop requested operation=${_operationLabel(jobId)} status=stopping',
      );
      _remember(_job);
      cancel.complete();
    }
    await _startDone?.future;
    await _work;
    _log.info(
      () =>
          'Search stop finished operation=${_operationLabel(jobId)} status=${_job.status.name}',
    );
    return _job;
  }

  void _remember(GalleryDuplicateJob job) {
    // Retain receipts, not 64 potentially large result collections. Full groups
    // belong only to the current task and the preceding successful result.
    _history[job.jobId] = job.copyWith(groups: const []);
    while (_history.length > 64) {
      _history.remove(_history.keys.first);
    }
  }

  Future<void> _run(
    String jobId,
    List<GalleryDuplicateMode> modes,
    Completer<void> cancel,
  ) async {
    final clock = Stopwatch()..start();
    Directory? temporary;
    var diagnostics = const GalleryDuplicateDiagnostics(
      stage: GalleryDuplicateStage.snapshot,
    );
    void publishDiagnostics() {
      _job = _job.copyWith(diagnostics: diagnostics);
    }

    Future<void> verifyRoot(String root) async {
      try {
        await _assertRoot(root, cancel);
      } on GalleryCatalogFailure catch (error) {
        if (error.code != GalleryErrorCode.cancelled) {
          diagnostics = diagnostics.copyWith(
            failureReason: GalleryDuplicateFailureReason.storageUnavailable,
          );
        }
        rethrow;
      }
    }

    publishDiagnostics();
    try {
      final snapshot = await _snapshot(cancel);
      diagnostics = diagnostics.copyWith(
        candidateCount: snapshot.candidates.length,
        snapshotSkippedCount: snapshot.skipped,
        rootAliased: snapshot.rootAliased,
      );
      publishDiagnostics();
      _log.log(
        snapshot.candidates.isEmpty || snapshot.unreadable > 0
            ? Level.WARNING
            : Level.INFO,
        () =>
            'Search snapshot operation=${_operationLabel(jobId)} '
            '${_diagnosticLog(diagnostics)} unreadable=${snapshot.unreadable} '
            'elapsedMs=${clock.elapsedMilliseconds}',
      );
      if (snapshot.candidates.isEmpty && snapshot.unreadable > 0) {
        diagnostics = diagnostics.copyWith(
          failureReason: GalleryDuplicateFailureReason.storageUnavailable,
        );
        throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
      }
      await verifyRoot(snapshot.root);
      temporary = await directory.createTemp('scan-');
      final environment = {
        'XDG_CACHE_HOME': path.join(temporary.path, 'cache'),
        'XDG_CONFIG_HOME': path.join(temporary.path, 'config'),
      };
      diagnostics = diagnostics.copyWith(
        stage: GalleryDuplicateStage.versionProbe,
      );
      publishDiagnostics();
      final version = await _runner.run(
        executable,
        const ['--version'],
        timeout: const Duration(seconds: 10),
        cancellation: cancel.future,
        maxOutputBytes: 4096,
        environment: environment,
      );
      final match = _versionPattern.firstMatch(version.stdout.trim());
      diagnostics = diagnostics.copyWith(
        toolVersion: match?.group(1),
        exitCode: version.exitCode,
      );
      if (version.exitCode != 0) {
        diagnostics = diagnostics.copyWith(
          failureReason: GalleryDuplicateFailureReason.versionProbeFailed,
        );
        throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
      }
      final generation = switch (match?.group(1)?.split('.').first) {
        '8' => _CzkawkaCliGeneration.version8,
        '12' => _CzkawkaCliGeneration.version12,
        _ => null,
      };
      if (generation == null) {
        diagnostics = diagnostics.copyWith(
          failureReason: GalleryDuplicateFailureReason.unsupportedVersion,
        );
        throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
      }
      _log.fine(
        () =>
            'Search probe completed operation=${_operationLabel(jobId)} '
            'generation=${generation.name} ${_diagnosticLog(diagnostics)}',
      );
      final groups = <GalleryDuplicateGroup>[];
      var skipped = 0;
      for (final mode in modes) {
        final modeClock = Stopwatch()..start();
        final previousGroups = groups.length;
        final previousSkipped = skipped;
        await verifyRoot(snapshot.root);
        diagnostics = diagnostics.copyWith(
          stage: GalleryDuplicateStage.scanning,
          mode: mode,
          exitCode: null,
        );
        publishDiagnostics();
        _log.info(
          () =>
              'Search mode started operation=${_operationLabel(jobId)} '
              '${_diagnosticLog(diagnostics)}',
        );
        final output = File(path.join(temporary.path, '${mode.name}.json'));
        final result = await _runner.run(
          executable,
          [
            mode == GalleryDuplicateMode.exact ? 'dup' : 'image',
            '--directories',
            snapshot.root,
            '--compact-file-to-save',
            output.absolute.path,
            '--thread-number',
            '$threads',
            '--minimal-file-size',
            '1',
            '--allowed-extensions',
            'jpg,jpeg,png,webp,bmp,tif,tiff,avif,heic,heif',
            '--excluded-items',
            '*/.upload-*.part',
            if (generation == _CzkawkaCliGeneration.version12) ...[
              '--disable-cache',
              '--do-not-print-results',
              '--ignore-error-code-on-found',
            ],
            if (mode == GalleryDuplicateMode.exact) ...[
              '--search-method',
              'HASH',
              '--hash-type',
              'BLAKE3',
            ],
          ],
          timeout: processTimeout,
          cancellation: cancel.future,
          discardStdout: true,
          maxOutputBytes: 1 << 20,
          environment: environment,
        );
        diagnostics = diagnostics.copyWith(exitCode: result.exitCode);
        await verifyRoot(snapshot.root);
        if (result.exitCode != 0 && result.exitCode != 11) {
          diagnostics = diagnostics.copyWith(
            failureReason: GalleryDuplicateFailureReason.processFailed,
          );
          throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
        }
        diagnostics = diagnostics.copyWith(
          stage: GalleryDuplicateStage.validation,
        );
        publishDiagnostics();
        final decoded = await _readJson(output);
        final rawGroups = _extractGroups(decoded, mode);
        var rawMembers = 0;
        for (final raw in rawGroups) {
          rawMembers += raw.length;
          final members = <String, GalleryDuplicateMember>{};
          for (final data in raw) {
            _checkCancelled(cancel);
            if (data is! Map<String, dynamic> ||
                data['path'] is! String ||
                data['size'] is! int ||
                (data['size'] as int) < 0) {
              throw const GalleryCatalogFailure(
                GalleryErrorCode.processingFailed,
              );
            }
            final rawPath = data['path'] as String;
            final absolute = path.normalize(rawPath);
            final candidate = snapshot.candidates[absolute];
            if (!path.isAbsolute(rawPath) ||
                candidate == null ||
                data['size'] != candidate.sizeBytes ||
                !await _isCurrent(candidate, root: snapshot.root)) {
              skipped++;
              continue;
            }
            members[candidate.mediaId] = candidate.copyWith(
              width: _dimension(data['width']),
              height: _dimension(data['height']),
            );
          }
          if (members.length < 2) continue;
          final sorted = members.values.toList()
            ..sort((a, b) => a.path.compareTo(b.path));
          final digest = sha256.convert(
            utf8.encode(
              '${mode.name}:${sorted.map((m) => '${m.mediaId}:${m.sourceRevision}').join(',')}',
            ),
          );
          groups.add(
            GalleryDuplicateGroup(
              groupId: digest.toString(),
              mode: mode,
              items: sorted,
            ),
          );
        }
        diagnostics = diagnostics.copyWith(
          matchedFileCount: _matchedCount(groups),
          rejectedResultCount: skipped,
        );
        publishDiagnostics();
        _log.info(
          () =>
              'Search mode completed operation=${_operationLabel(jobId)} '
              'groups=${groups.length - previousGroups} '
              'reportedGroups=${rawGroups.length} reportedMembers=$rawMembers '
              'skipped=${skipped - previousSkipped} ${_diagnosticLog(diagnostics)} '
              'elapsedMs=${modeClock.elapsedMilliseconds}',
        );
      }
      // An earlier mode's files may have changed while a later mode ran.
      diagnostics = diagnostics.copyWith(
        stage: GalleryDuplicateStage.validation,
        mode: null,
      );
      publishDiagnostics();
      final validated = <GalleryDuplicateGroup>[];
      for (final group in groups) {
        final members = <GalleryDuplicateMember>[];
        for (final member in group.items) {
          _checkCancelled(cancel);
          if (await _isCurrent(member, root: snapshot.root)) {
            members.add(member);
          } else {
            skipped++;
          }
        }
        if (members.length >= 2) validated.add(group.copyWith(items: members));
      }
      await verifyRoot(snapshot.root);
      final uniqueGroups = await _deduplicateGroups(validated);
      _checkCancelled(cancel);
      if (uniqueGroups.length != validated.length) {
        _log.info(
          'Search groups normalized operation=${_operationLabel(jobId)} reportedGroups=${validated.length} groups=${uniqueGroups.length}',
        );
      }
      diagnostics = diagnostics.copyWith(
        matchedFileCount: _matchedCount(uniqueGroups),
        rejectedResultCount: skipped,
      );
      _job = _job.copyWith(
        status: GalleryDuplicateStatus.completed,
        finishedAt: DateTime.now().toUtc(),
        groups: uniqueGroups,
        skipped: skipped,
        diagnostics: diagnostics,
      );
    } on GalleryCatalogFailure catch (error) {
      diagnostics = diagnostics.copyWith(
        failureReason: cancel.isCompleted
            ? null
            : diagnostics.failureReason ??
                  _failureReason(error.code, diagnostics.stage),
      );
      _job = _job.copyWith(
        status: cancel.isCompleted
            ? GalleryDuplicateStatus.cancelled
            : GalleryDuplicateStatus.failed,
        finishedAt: DateTime.now().toUtc(),
        error: cancel.isCompleted ? null : error.code,
        groups: _previous?.groups ?? const [],
        diagnostics: diagnostics,
      );
    } on Object catch (error) {
      diagnostics = diagnostics.copyWith(
        failureReason: cancel.isCompleted
            ? null
            : error is FileSystemException
            ? GalleryDuplicateFailureReason.storageUnavailable
            : diagnostics.stage == GalleryDuplicateStage.validation
            ? GalleryDuplicateFailureReason.invalidResult
            : GalleryDuplicateFailureReason.unexpected,
      );
      _job = _job.copyWith(
        status: cancel.isCompleted
            ? GalleryDuplicateStatus.cancelled
            : GalleryDuplicateStatus.failed,
        finishedAt: DateTime.now().toUtc(),
        error: cancel.isCompleted ? null : GalleryErrorCode.processingFailed,
        groups: _previous?.groups ?? const [],
        diagnostics: diagnostics,
      );
    } finally {
      if (temporary != null) {
        try {
          await temporary.delete(recursive: true);
        } on FileSystemException {
          _log.warning(
            () =>
                'Search temporary cleanup failed operation=${_operationLabel(jobId)} '
                'code=${GalleryErrorCode.unavailable.name}',
          );
        }
      }
      try {
        await _save();
      } on Object catch (error) {
        diagnostics = diagnostics.copyWith(
          stage: GalleryDuplicateStage.persistence,
          failureReason:
              error is GalleryCatalogFailure &&
                  error.code == GalleryErrorCode.outputLimitExceeded
              ? GalleryDuplicateFailureReason.outputLimitExceeded
              : GalleryDuplicateFailureReason.storageUnavailable,
        );
        _job = _job.copyWith(
          status: GalleryDuplicateStatus.failed,
          error: error is GalleryCatalogFailure
              ? error.code
              : GalleryErrorCode.unavailable,
          groups: _previous?.groups ?? const [],
          diagnostics: diagnostics,
        );
        try {
          await _save();
        } on Object {
          /* Keep a readable previous journal if storage is unavailable. */
        }
      }
      _remember(_job);
      _log.log(
        _job.status == GalleryDuplicateStatus.failed
            ? Level.WARNING
            : Level.INFO,
        () =>
            'Search finished operation=${_operationLabel(jobId)} status=${_job.status.name} '
            'code=${_job.error?.name ?? 'none'} groups=${_job.groups.length} '
            'groupMembers=${_job.groups.fold<int>(0, (count, group) => count + group.items.length)} '
            'skipped=${_job.skipped} ${_diagnosticLog(diagnostics)} '
            'elapsedMs=${clock.elapsedMilliseconds}',
      );
      if (identical(_cancel, cancel)) _cancel = null;
      _work = null;
    }
  }

  // Operation IDs are supplied by clients. Hashing also keeps malformed or
  // deliberately sensitive identifiers out of otherwise useful correlation.
  static String _operationLabel(String value) =>
      'id-${sha256.convert(utf8.encode(value)).toString().substring(0, 12)}';

  static Future<List<GalleryDuplicateGroup>> _deduplicateGroups(
    List<GalleryDuplicateGroup> groups,
  ) => Isolate.run(() {
    final unique = <String, GalleryDuplicateGroup>{};
    for (final group in groups) {
      final members = group.items.toList()
        ..sort((a, b) {
          final byId = a.mediaId.compareTo(b.mediaId);
          return byId == 0
              ? a.sourceRevision.compareTo(b.sourceRevision)
              : byId;
        });
      final key = sha256
          .convert(
            utf8.encode(
              jsonEncode([
                for (final member in members)
                  [member.mediaId, member.sourceRevision],
              ]),
            ),
          )
          .toString();
      final previous = unique[key];
      if (previous == null ||
          (previous.mode != GalleryDuplicateMode.exact &&
              group.mode == GalleryDuplicateMode.exact)) {
        unique[key] = group;
      }
    }
    return unique.values.toList();
  });

  static int _matchedCount(List<GalleryDuplicateGroup> groups) => groups
      .expand((group) => group.items)
      .map((member) => member.mediaId)
      .toSet()
      .length;

  static GalleryDuplicateFailureReason _failureReason(
    GalleryErrorCode code,
    GalleryDuplicateStage stage,
  ) => switch (code) {
    GalleryErrorCode.timeout => GalleryDuplicateFailureReason.timeout,
    GalleryErrorCode.outputLimitExceeded =>
      GalleryDuplicateFailureReason.outputLimitExceeded,
    GalleryErrorCode.unsupported =>
      GalleryDuplicateFailureReason.unsupportedVersion,
    GalleryErrorCode.unavailable
        when stage == GalleryDuplicateStage.versionProbe ||
            stage == GalleryDuplicateStage.scanning =>
      GalleryDuplicateFailureReason.toolUnavailable,
    GalleryErrorCode.unavailable || GalleryErrorCode.revisionMismatch =>
      GalleryDuplicateFailureReason.storageUnavailable,
    _ when stage == GalleryDuplicateStage.validation =>
      GalleryDuplicateFailureReason.invalidResult,
    _ => GalleryDuplicateFailureReason.unexpected,
  };

  static _CzkawkaExitClass _exitClass(int? exitCode) => switch (exitCode) {
    null => _CzkawkaExitClass.unavailable,
    0 => _CzkawkaExitClass.success,
    11 => _CzkawkaExitClass.findings,
    < 0 => _CzkawkaExitClass.signal,
    _ => _CzkawkaExitClass.error,
  };

  static String _diagnosticLog(GalleryDuplicateDiagnostics diagnostics) {
    final version = diagnostics.toolVersion;
    final safeVersion =
        version != null && _numericVersionPattern.hasMatch(version)
        ? version
        : 'unknown';
    return 'tool=czkawka_cli version=$safeVersion stage=${diagnostics.stage.name} '
        'mode=${diagnostics.mode?.name ?? 'none'} '
        'reason=${diagnostics.failureReason?.name ?? 'none'} '
        'exit=${diagnostics.exitCode ?? 'none'} '
        'exitClass=${_exitClass(diagnostics.exitCode).name} '
        'candidates=${diagnostics.candidateCount} matchedFiles=${diagnostics.matchedFileCount} '
        'rejectedResults=${diagnostics.rejectedResultCount} '
        'snapshotSkipped=${diagnostics.snapshotSkippedCount} rootAliased=${diagnostics.rootAliased}';
  }

  static int? _dimension(Object? value) {
    if (value == null) return null;
    if (value is! int || value <= 0)
      throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
    return value;
  }

  static List<List<dynamic>> _extractGroups(
    Object? decoded,
    GalleryDuplicateMode mode,
  ) {
    final groups = <List<dynamic>>[];
    if (mode == GalleryDuplicateMode.exact) {
      if (decoded is! Map<String, dynamic>)
        throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
      for (final entries in decoded.values) {
        if (entries is! List)
          throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
        for (final group in entries) {
          if (group is! List)
            throw const GalleryCatalogFailure(
              GalleryErrorCode.processingFailed,
            );
          groups.add(group);
        }
      }
    } else {
      if (decoded is! List)
        throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
      for (final group in decoded) {
        if (group is! List)
          throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
        groups.add(group);
      }
    }
    return groups;
  }

  Future<_CandidateSnapshot> _snapshot(Completer<void> cancel) async {
    final snapshot = <String, GalleryDuplicateMember>{};
    final root = path.normalize(await catalog.originals.resolveSymbolicLinks());
    await _assertRoot(root, cancel);
    final current = await catalog.catalog();
    var imageEntries = 0;
    var unreadable = 0;
    for (final entry in current.entries) {
      _checkCancelled(cancel);
      if (entry.kind != GalleryEntryKind.image) continue;
      imageEntries++;
      if (entry.sourceRevision == null) continue;
      if (snapshot.length >= maxCandidates)
        throw const GalleryCatalogFailure(GalleryErrorCode.outputLimitExceeded);
      try {
        final source = await catalog.resolve(
          entry.mediaId,
          revision: entry.sourceRevision,
        );
        final absolute = path.normalize(source.absolutePath);
        final resolved = await File(absolute).resolveSymbolicLinks();
        if (!path.isWithin(root, resolved) ||
            resolved != path.join(root, entry.path))
          continue;
        if (await FileSystemEntity.type(absolute, followLinks: false) !=
            FileSystemEntityType.file)
          continue;
        try {
          // stat/length alone succeed for chmod000 files. Czkawka may then
          // return exit0 plus empty JSON, keeping read errors only on stdout.
          // Open no more than one descriptor and read no image bytes here.
          final handle = await File(absolute).open(mode: FileMode.read);
          await handle.close();
        } on FileSystemException catch (error) {
          if (error.osError?.errorCode != 2 && error.osError?.errorCode != 20) {
            unreadable++;
          }
          continue;
        }
        // Czkawka emits canonical paths even when --directories is an alias.
        // Relative paths and catalog identities remain unchanged for actions.
        snapshot[path.normalize(resolved)] = GalleryDuplicateMember(
          mediaId: entry.mediaId,
          sourceRevision: entry.sourceRevision!,
          path: entry.path,
          name: entry.name,
          sizeBytes: await File(absolute).length(),
        );
      } on GalleryCatalogFailure catch (error) {
        if (error.code != GalleryErrorCode.notFound &&
            error.code != GalleryErrorCode.revisionMismatch &&
            error.code != GalleryErrorCode.unavailable)
          rethrow;
      } on FileSystemException {
        /* A candidate can disappear during enumeration. */
      }
    }
    return (
      root: root,
      rootAliased: root != path.normalize(catalog.originals.absolute.path),
      skipped: imageEntries - snapshot.length,
      unreadable: unreadable,
      candidates: snapshot,
    );
  }

  /// Included directories may disappear while the CLI starts. Czkawka can
  /// report that case as exit 0 plus an empty JSON, so validate the pinned root
  /// independently instead of accepting that as a successful empty search.
  Future<void> _assertRoot(String root, Completer<void> cancel) async {
    _checkCancelled(cancel);
    try {
      final current = path.normalize(
        await catalog.originals.resolveSymbolicLinks(),
      );
      if (current != root) {
        throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
      }
      if (await FileSystemEntity.type(root, followLinks: false) !=
          FileSystemEntityType.directory) {
        throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
      }
      // Read at most the first directory entry, including the valid empty case.
      await Directory(root).list(followLinks: false).take(1).drain<void>();
    } on FileSystemException {
      throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
    }
    _checkCancelled(cancel);
  }

  Future<bool> _isCurrent(GalleryDuplicateMember member, {String? root}) async {
    try {
      final source = await catalog.resolve(
        member.mediaId,
        revision: member.sourceRevision,
      );
      final currentRoot = path.normalize(
        await catalog.originals.resolveSymbolicLinks(),
      );
      if (root != null && root != currentRoot) return false;
      final resolved = await File(source.absolutePath).resolveSymbolicLinks();
      return source.entry.path == member.path &&
          resolved == path.join(currentRoot, member.path) &&
          path.isWithin(currentRoot, resolved) &&
          await FileSystemEntity.type(
                source.absolutePath,
                followLinks: false,
              ) ==
              FileSystemEntityType.file;
    } on GalleryCatalogFailure catch (error) {
      if (error.code == GalleryErrorCode.notFound ||
          error.code == GalleryErrorCode.revisionMismatch ||
          error.code == GalleryErrorCode.unavailable)
        return false;
      rethrow;
    } on FileSystemException {
      return false;
    }
  }

  Future<GalleryDuplicateGroupPage> group(String jobId, int index) async {
    _ensureOpen();
    await _initialize();
    final job = _job;
    if (job.jobId != jobId) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
    if (index < 0 || index > job.groups.length) {
      throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
    }
    for (var position = index; position < job.groups.length; position++) {
      final original = job.groups[position];
      final current = <GalleryDuplicateMember>[];
      for (final member in original.items) {
        if (_closed) {
          throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
        }
        if (await _isCurrent(member)) current.add(member);
      }
      if (!identical(job, _job)) {
        throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
      }
      if (current.length < 2) continue;
      _log.fine(
        () =>
            'Duplicate group ready index=$position members=${current.length} skippedGroups=${position - index}',
      );
      return GalleryDuplicateGroupPage(
        jobId: jobId,
        index: position,
        group: original.copyWith(items: current),
      );
    }
    _ensureOpen();
    if (!identical(job, _job))
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    _log.fine(
      () =>
          'Duplicate review finished skippedGroups=${job.groups.length - index}',
    );
    return GalleryDuplicateGroupPage(jobId: jobId, index: job.groups.length);
  }

  /// Invoked under the file-operation lock, before any selected file is moved.
  Future<void> validateTrash(GalleryOperationRequest request) async {
    if (request.duplicateJobId == null) return;
    await _initialize();
    final job = _job;
    final usable =
        job.status == GalleryDuplicateStatus.completed ||
        ((job.status == GalleryDuplicateStatus.cancelled ||
                job.status == GalleryDuplicateStatus.failed) &&
            job.groups.isNotEmpty);
    if (request.action != GalleryMutation.trash ||
        request.duplicateJobId != job.jobId ||
        !usable) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
    final chosen = {
      for (final item in request.items) item.mediaId: item.sourceRevision,
    };
    final members = {
      for (final group in job.groups)
        for (final item in group.items) item.mediaId: item,
    };
    for (final selection in chosen.entries) {
      final member = members[selection.key];
      if (member == null ||
          member.sourceRevision != selection.value ||
          !await _isCurrent(member)) {
        throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
      }
    }
    for (final group in job.groups) {
      if (!group.items.any((item) => chosen.containsKey(item.mediaId)))
        continue;
      var remaining = false;
      for (final member in group.items) {
        if (!chosen.containsKey(member.mediaId) && await _isCurrent(member)) {
          remaining = true;
          break;
        }
      }
      if (!remaining)
        throw const GalleryCatalogFailure(GalleryErrorCode.conflict);
    }
  }

  static Future<Object?> _readJson(File file) async {
    if (await FileSystemEntity.type(file.path, followLinks: false) !=
        FileSystemEntityType.file) {
      throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
    }
    final encoded = await file.readAsString();
    return Isolate.run(() => jsonDecode(encoded));
  }

  Future<void> _save() async {
    final data = _job.toJson();
    final encoded = await Isolate.run(() => jsonEncode(data));
    final temporary = File(
      path.join(directory.path, 'job-${galleryToken()}.tmp'),
    );
    try {
      await temporary.writeAsString(encoded, flush: true);
      await temporary.rename(_stateFile.path);
    } finally {
      if (await temporary.exists()) await temporary.delete();
    }
  }

  void _checkCancelled(Completer<void> cancel) {
    if (cancel.isCompleted || _closed)
      throw const GalleryCatalogFailure(GalleryErrorCode.cancelled);
  }

  void _ensureOpen() {
    if (_closed)
      throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
  }

  Future<void> close() => _closing ??= _close();

  Future<void> _close() async {
    _closed = true;
    _log.fine(() => 'Search service closing active=${_work != null}');
    await _startDone?.future;
    final cancel = _cancel;
    if (cancel != null && !cancel.isCompleted) cancel.complete();
    await _work;
    if (_ownsRunner) await _runner.close();
    _log.fine('Search service closed');
  }
}
