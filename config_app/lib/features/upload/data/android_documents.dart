import 'dart:typed_data';

import 'package:config_app/features/upload/domain/upload_folder_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

part 'android_documents.freezed.dart';

enum AndroidDocumentKind { file, directory }

@freezed
abstract class AndroidDocumentInfo with _$AndroidDocumentInfo {
  const factory AndroidDocumentInfo({
    required Uri uri,
    required String name,
    required AndroidDocumentKind kind,
    int? size,
  }) = _AndroidDocumentInfo;
}

class AndroidDocuments {
  const AndroidDocuments({this.channel = const MethodChannel('dslideshow/documents')});
  final MethodChannel channel;

  Future<String?> pickDirectory() => channel.invokeMethod<String>('pickDirectory');

  AndroidDocumentInfo _decode(Object? value) {
    if (value case {'uri': final String uri, 'name': final String name, 'directory': final bool directory}) {
      return AndroidDocumentInfo(
        uri: Uri.parse(uri),
        name: name,
        kind: directory ? AndroidDocumentKind.directory : AndroidDocumentKind.file,
        size: (value as Map)['size'] as int?,
      );
    }
    throw const FormatException('Invalid Android document metadata');
  }

  Stream<UploadFolderFile> listDirectory(String uri) async* {
    final root = _decode(await channel.invokeMethod<Object>('describe', {'uri': uri}));
    yield* _walk(root, root.name);
  }

  Stream<UploadFolderFile> _walk(AndroidDocumentInfo directory, String relativePath) async* {
    final handle = (await channel.invokeMethod<int>('openDirectory', {'uri': directory.uri.toString()}))!;
    try {
      while (true) {
        final page = (await channel.invokeListMethod<Object?>('readDirectory', {'handle': handle}))!;
        if (page.isEmpty) break;
        for (final value in page) {
          final entry = _decode(value);
          final path = p.posix.join(relativePath, entry.name);
          if (entry.kind == AndroidDocumentKind.directory) {
            yield* _walk(entry, path);
          } else {
            yield UploadFolderFile.document(_AndroidDocumentFile(entry, channel), path);
          }
        }
      }
    } finally {
      await channel.invokeMethod<void>('closeDirectory', {'handle': handle});
    }
  }
}

final class _AndroidDocumentFile extends PlatformFile {
  _AndroidDocumentFile(this.document, this.channel);
  final AndroidDocumentInfo document;
  final MethodChannel channel;
  @override
  String get name => document.name;
  @override
  Uri get uri => document.uri;
  @override
  Never get xFile => throw UnsupportedError('Android documents use ContentResolver streams');
  @override
  int? lengthSync() => document.size;
  @override
  Future<int?> length() async => document.size;
  @override
  Stream<Uint8List> readAsByteStream() async* {
    final handle = (await channel.invokeMethod<int>('openRead', {'uri': uri.toString()}))!;
    try {
      while (true) {
        final bytes = await channel.invokeMethod<Uint8List>('readChunk', {'handle': handle});
        if (bytes == null) break;
        yield bytes;
      }
    } finally {
      await channel.invokeMethod<void>('closeRead', {'handle': handle});
    }
  }

  @override
  Future<Uint8List> readAsBytes() async {
    final buffer = BytesBuilder(copy: false);
    await for (final bytes in readAsByteStream()) {
      buffer.add(bytes);
    }
    return buffer.takeBytes();
  }
}
