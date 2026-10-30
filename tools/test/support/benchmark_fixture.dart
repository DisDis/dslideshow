import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

void materializeBenchmarkFixture(Directory root, Map<String, dynamic> inputs) {
  for (final entry in inputs.entries) {
    final path = p.join(root.path, entry.key);
    if (entry.value == null) {
      Directory(path).createSync(recursive: true);
    } else {
      final file = File(path);
      file.parent.createSync(recursive: true);
      file.writeAsBytesSync(base64Decode(entry.value as String));
    }
  }
}
