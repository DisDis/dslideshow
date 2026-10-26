// Asynchronous filesystem work keeps HTTP and RPC event loops responsive.
// ignore_for_file: avoid_slow_async_io
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

import 'catalog_state.dart';

final _random = Random.secure();
String galleryToken() => List.generate(
  16,
  (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0'),
).join();

Directory galleryStateDirectory(Directory originals) =>
    Directory('${path.normalize(originals.absolute.path)}.gallery');

bool isGalleryStagingPath(String name) =>
    RegExp(r'^\.upload-[0-9a-f]{32}\.part$').hasMatch(path.basename(name));

/// Filesystem notifications are hints; this durable marker also crosses isolates.
/// The source is never ready while a managed publisher owns a dirty marker.
class GalleryPublication {
  final File marker;
  final File pending;
  final String token;
  GalleryPublication._(this.marker, this.pending, this.token);

  static File markerFor(Directory state, String relativePath) => File(
    path.join(
      state.path,
      'publications',
      sha256.convert(utf8.encode(relativePath)).toString(),
      'current.json',
    ),
  );

  static Future<GalleryPublication> begin(
    Directory state,
    String relativePath,
  ) async {
    final marker = markerFor(state, relativePath);
    final token = galleryToken();
    final pending = File(path.join(marker.parent.path, '$token.pending'));
    await _write(
      pending,
      GalleryPublicationRecord(
        token: token,
        dirty: true,
        ownerPid: pid,
        ownerStart: await _processStart(pid) ?? '',
      ),
    );
    try {
      await _notify(state);
    } catch (_) {
      if (await pending.exists()) await pending.delete();
      rethrow;
    }
    return GalleryPublication._(marker, pending, token);
  }

  Future<void> finish() async {
    // Each publisher owns a separate pending file: finishing one must not make
    // an overlapping publisher look ready. Atomic rename of current supplies a
    // fresh generation after every completed publication without isolate locks.
    await _write(
      marker,
      GalleryPublicationRecord(token: token, dirty: false, ownerPid: pid),
    );
    if (await pending.exists()) await pending.delete();
    await _notify(marker.parent.parent.parent);
  }

  static Future<String> version(Directory state) async {
    try {
      return await File(path.join(state.path, 'publication.version'))
          .readAsString();
    } on FileSystemException catch (error) {
      if (error.osError?.errorCode == 2) return '';
      rethrow;
    }
  }

  static Future<void> _notify(Directory state) async {
    await state.create(recursive: true);
    final temporary = File(
      path.join(state.path, 'publication-${galleryToken()}.tmp'),
    );
    try {
      await temporary.writeAsString(galleryToken(), flush: true);
      await temporary.rename(path.join(state.path, 'publication.version'));
    } finally {
      if (await temporary.exists()) await temporary.delete();
    }
  }

  static Future<String?> _processStart(int processId) async {
    if (!Platform.isLinux) return processId == pid ? 'self' : null;
    try {
      final stat = await File('/proc/$processId/stat').readAsString();
      return stat
          .substring(stat.lastIndexOf(')') + 1)
          .trim()
          .split(RegExp(r'\s+'))[19];
    } on FileSystemException catch (error) {
      if (error.osError?.errorCode == 2 || error.osError?.errorCode == 3)
        return null;
      rethrow;
    }
  }

  static Future<GalleryPublicationRecord?> current(File marker) async {
    if (!await marker.parent.exists()) return null;
    await for (final entity in marker.parent.list()) {
      if (entity is! File || !entity.path.endsWith('.pending')) continue;
      final record = await read(entity);
      if (record == null) continue;
      final start = await _processStart(record.ownerPid);
      if (start != null &&
          (record.ownerStart.isEmpty || start == record.ownerStart)) {
        throw const GalleryPublicationBusy();
      }
      // A crashed publisher's pending marker gets a new generation, so its
      // potentially published file cannot inherit any prior derived cache key.
      await _write(
        marker,
        GalleryPublicationRecord(
          token: galleryToken(),
          dirty: false,
          ownerPid: pid,
        ),
      );
      if (await entity.exists()) await entity.delete();
    }
    return read(marker);
  }

  static Future<GalleryPublicationRecord?> read(File marker) async {
    try {
      return GalleryPublicationRecord.fromJson(
        jsonDecode(await marker.readAsString()) as Map<String, dynamic>,
      );
    } on FileSystemException catch (error) {
      if (error.osError?.errorCode == 2) return null;
      rethrow;
    }
  }

  static Future<void> _write(
    File marker,
    GalleryPublicationRecord record,
  ) async {
    await marker.parent.create(recursive: true);
    final temporary = File('${marker.path}.${galleryToken()}.tmp');
    try {
      await temporary.writeAsString(jsonEncode(record.toJson()), flush: true);
      await temporary.rename(marker.path);
    } finally {
      if (await temporary.exists()) await temporary.delete();
    }
  }
}

class GalleryPublicationBusy implements Exception {
  const GalleryPublicationBusy();
}
