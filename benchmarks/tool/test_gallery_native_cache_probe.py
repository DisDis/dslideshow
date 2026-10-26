"""Parse generated literals with the actual Dart VM, including hostile paths."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

import gallery_native_cache_probe as probe


class DartLiteralTest(unittest.TestCase):
    def test_paths_and_interpolation_are_round_tripped_by_dart_parser(self):
        values = ["quote'and\"double", '$unbound ${throw StateError("injected")}',
                  'back\\slash\nand\rnewline', '\u2028\u2029', 'кириллица']
        with tempfile.TemporaryDirectory(prefix="gallery-literal-'$-") as temporary:
            values.append(str(Path(temporary) / "file'$\nname"))
            source = Path(temporary) / "parse'$\n.dart"
            source.write_text("import 'dart:convert'; import 'dart:io';\n"
                              'void main() { stdout.write(jsonEncode([' +
                              ','.join(probe.dart_string(value) for value in values) + '])); }\n')
            result = subprocess.run([str(probe.FLUTTER / 'dart-sdk/bin/dart'),
                                     '--disable-dart-dev', str(source)],
                                    env=os.environ | {'DASH__SUPPRESS_ANALYTICS': 'true'},
                                    capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(json.loads(result.stdout), values)


if __name__ == '__main__':
    unittest.main()
