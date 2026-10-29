import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as path;

final _random = Random.secure();
final _uploadTemporaryNamePattern = RegExp(r'^\.upload-[0-9a-f]{32}\.part$');
String galleryToken() => List.generate(
  16,
  (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0'),
).join();

Directory galleryStateDirectory(Directory originals) =>
    Directory('${path.normalize(originals.absolute.path)}.gallery');

bool isGalleryStagingPath(String name) =>
    _uploadTemporaryNamePattern.hasMatch(path.basename(name));
