import 'dart:async';

import 'package:config_app/features/upload/data/android_documents.dart';
import 'package:config_app/features/upload/domain/upload_folder_file.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('test/documents');
  const documents = AndroidDocuments(channel: channel);
  final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  const root = 'content://documents/tree/root/document/root';
  const child = '$root/sub';
  const image = '$child/photo.jpg';
  Map<String, Object?> entry(String uri, String name, {bool directory = false}) => {
    'uri': uri,
    'name': name,
    'directory': directory,
    'size': directory ? null : 3,
  };

  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  test('walks document pages and subfolders, preserving relative paths and closing every cursor', () async {
    final pages = <int, int>{};
    final closed = <int>[];
    final readers = <int>[];
    var chunks = 0;
    messenger.setMockMethodCallHandler(channel, (call) async {
      final args = call.arguments as Map?;
      switch (call.method) {
        case 'describe':
          return entry(root, 'Photos', directory: true);
        case 'openDirectory':
          return args!['uri'] == root ? 1 : 2;
        case 'readDirectory':
          final handle = args!['handle'] as int;
          final page = pages.update(handle, (value) => value + 1, ifAbsent: () => 0);
          if (page > 0) return <Object>[];
          return handle == 1 ? [entry(child, '2026', directory: true)] : [entry(image, 'photo.jpg')];
        case 'closeDirectory':
          closed.add(args!['handle'] as int);
          return null;
        case 'openRead':
          expect(args!['uri'], image);
          readers.add(9);
          return 9;
        case 'readChunk':
          return chunks++ == 0 ? Uint8List.fromList([1, 2, 3]) : null;
        case 'closeRead':
          readers.add(-(args!['handle'] as int));
          return null;
        default:
          fail('Unexpected method ${call.method}');
      }
    });
    final files = await documents.listDirectory(root).toList();
    final file = files.single as DocumentUploadFolderFile;
    expect(file.relativePath, 'Photos/2026/photo.jpg');
    expect(file.file.path, isNull);
    expect(await file.file.length(), 3);
    expect(readers, isEmpty);
    expect(closed, [2, 1]);
    expect(await file.file.readAsByteStream().expand((bytes) => bytes).toList(), [1, 2, 3]);
    expect(readers, [9, -9]);
  });

  test('cancelling a recursive scan closes child and parent without reading later pages', () async {
    final closed = <int>[];
    var reads = 0;
    messenger.setMockMethodCallHandler(channel, (call) async {
      final args = call.arguments as Map?;
      switch (call.method) {
        case 'describe':
          return entry(root, 'Photos', directory: true);
        case 'openDirectory':
          return args!['uri'] == root ? 1 : 2;
        case 'readDirectory':
          reads++;
          return args!['handle'] == 1 ? [entry(child, 'sub', directory: true)] : [entry(image, 'photo.jpg')];
        case 'closeDirectory':
          closed.add(args!['handle'] as int);
          return null;
        default:
          fail('Unexpected method ${call.method}');
      }
    });
    final scan = StreamIterator(documents.listDirectory(root));
    expect(await scan.moveNext(), isTrue);
    await scan.cancel();
    expect(closed, [2, 1]);
    expect(reads, 2);
  });

  test('read failure closes its stream handle and scan failure closes its cursor', () async {
    final closed = <String>[];
    var listed = false;
    messenger.setMockMethodCallHandler(channel, (call) async {
      switch (call.method) {
        case 'describe':
          return entry(root, 'Photos', directory: true);
        case 'openDirectory':
          return 1;
        case 'readDirectory':
          if (listed) return <Object>[];
          listed = true;
          return [entry(image, 'photo.jpg')];
        case 'closeDirectory':
          closed.add('directory');
          return null;
        case 'openRead':
          return 3;
        case 'readChunk':
          throw PlatformException(code: 'documents_SecurityException');
        case 'closeRead':
          closed.add('reader');
          return null;
        default:
          fail('Unexpected method ${call.method}');
      }
    });
    final file = (await documents.listDirectory(root).single) as DocumentUploadFolderFile;
    await expectLater(file.file.readAsByteStream().drain<void>(), throwsA(isA<PlatformException>()));
    expect(closed, ['directory', 'reader']);
  });
}
