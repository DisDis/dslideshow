import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/benchmarks/json_io.dart';
import 'package:dslideshow_tools/src/benchmarks/media.dart';
import 'package:dslideshow_tools/src/benchmarks/native_cache.dart';
import 'package:dslideshow_tools/src/benchmarks/provenance.dart';
import 'package:dslideshow_tools/src/repository.dart';
import 'package:image/image.dart' as image;
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test('Dart literals roundtrip hostile paths using the actual parser', () async {
    final root = Directory.systemTemp.createTempSync("gallery-literal-'\$-");
    addTearDown(() => root.deleteSync(recursive: true));
    final values = [
      "quote'and\"double",
      r'$unbound ${throw StateError("injected")}',
      'back\\slash\nand\rnewline',
      '\u2028\u2029',
      'кириллица',
      p.join(root.path, "file'\$\nname"),
    ];
    final source = File(p.join(root.path, "parse'\$\n.dart"))
      ..writeAsStringSync(
        "import 'dart:convert'; import 'dart:io'; void main() { stdout.write(jsonEncode([${values.map(dartString).join(',')}])); }",
      );
    final result = await Process.run(cli.dartExecutable!, ['--suppress-analytics', 'run', source.path]);
    expect(result.exitCode, 0, reason: result.stderr.toString());
    expect(jsonDecode(result.stdout.toString()), values);
  });
  test('new generator is deterministic and retains requested dimensions', () {
    final a = benchmarkPhoto(80, 60, 0, Random(42)), b = benchmarkPhoto(80, 60, 0, Random(42));
    expect([a.width, a.height], [80, 60]);
    expect(image.encodeJpg(a, quality: 93), image.encodeJpg(b, quality: 93));
  });
  test('frozen benchmark assets keep independent checksums and dimensions', () {
    final folder = Directory(p.join(findRepository().path, 'benchmarks/assets/media'));
    final manifest = readJson(File(p.join(folder.path, 'manifest.json')), []);
    for (final entry in asList(manifest['files'])) {
      final file = File(p.join(folder.path, entry['name'] as String));
      expect(digest(file), entry['sha256']);
      expect(file.lengthSync(), entry['bytes']);
      if (entry['kind'] == 'video') continue;
      final bytes = file.readAsBytesSync();
      final decoder = image.findDecoderForData(bytes);
      expect(decoder, isNotNull);
      final info = decoder!.startDecode(bytes);
      expect(info, isNotNull);
      expect([info!.width, info.height], [entry['width'], entry['height']]);
    }
  });
}
