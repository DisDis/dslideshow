import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

class MediaCatalog {
  final Directory directory;
  final List<Map<String, Object?>> entries;
  MediaCatalog(this.directory, this.entries);

  File file(String name) => File(path.join(directory.path, name));

  static Future<MediaCatalog> load({
    required Directory cache,
    String? external,
  }) async {
    final manifest =
        (jsonDecode(await rootBundle.loadString('assets/media/manifest.json'))
                as Map)['files']
            as List;
    final directory = external == null ? cache : Directory(external);
    await directory.create(recursive: true);
    final entries = <Map<String, Object?>>[];
    for (final value in manifest) {
      final entry = (value as Map).cast<String, Object?>();
      final name = entry['name']! as String;
      final file = File(path.join(directory.path, name));
      String? hash;
      if (await file.exists()) {
        hash = (await sha256.bind(file.openRead()).first).toString();
      }
      if (external == null && hash != entry['sha256']) {
        final data = await rootBundle.load('assets/media/$name');
        final temporary = File('${file.path}.tmp');
        await temporary.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          flush: true,
        );
        await temporary.rename(file.path);
        hash = (await sha256.bind(file.openRead()).first).toString();
        if (hash != entry['sha256']) {
          throw StateError('Asset checksum mismatch: $name');
        }
      }
      if (hash == null) {
        throw FileSystemException('Missing benchmark media', file.path);
      }
      final actual = <String, Object?>{
        ...entry,
        'bytes': await file.length(),
        'sha256': hash,
        'bundled_original': hash == entry['sha256'],
      };
      if (entry['kind'] != 'video') {
        final buffer = await ui.ImmutableBuffer.fromFilePath(file.path);
        try {
          final descriptor = await ui.ImageDescriptor.encoded(buffer);
          actual['width'] = descriptor.width;
          actual['height'] = descriptor.height;
          descriptor.dispose();
        } finally {
          buffer.dispose();
        }
      } else if (external != null) {
        // Actual video dimensions/duration are read from the initialized decoder.
        actual.remove('width');
        actual.remove('height');
        actual.remove('fps');
        actual.remove('duration_seconds');
        actual.remove('codec');
        actual.remove('pixel_format');
      }
      entries.add(actual);
    }
    return MediaCatalog(directory, entries);
  }
}
