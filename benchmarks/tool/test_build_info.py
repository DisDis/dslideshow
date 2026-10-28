from pathlib import Path
import tempfile
import unittest

from build_info import source_fingerprint


class BuildInfoFingerprintTest(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.app = self.root / 'benchmarks'
        self.inputs = {
            'benchmarks/lib/main.dart': 'void main() {}',
            'benchmarks/shaders/radial.frag': 'void main() { fragColor = vec4(1); }',
            'dslideshow_flutter/lib/main.dart': 'production',
            'backend/lib/main.dart': 'backend',
            'common/lib/effects.dart': 'effects',
            'benchmarks/pubspec.lock': 'lock',
            'benchmarks/pubspec.yaml': 'pubspec',
            'benchmarks/assets/media/manifest.json': '{"media": []}',
            'dslideshow_flutter/pubspec.yaml': 'frontend-pubspec',
            'benchmarks/tool/build_info.py': 'tool',
            'benchmarks/run.sh': '#!/bin/sh',
            'benchmarks/config/example.json': '{"repeats": 3}',
        }
        for name, content in self.inputs.items():
            self.write(name, content)

    def write(self, name, content):
        file = self.root / name
        file.parent.mkdir(parents=True, exist_ok=True)
        file.write_text(content, encoding='utf-8')
        return file

    def fingerprint(self):
        return source_fingerprint(self.root, self.app)

    def test_shader_change_changes_fingerprint_and_restoring_bytes_restores_it(self):
        original = self.fingerprint()
        shader = self.app / 'shaders/radial.frag'
        shader.write_text('void main() { fragColor = vec4(0); }', encoding='utf-8')
        self.assertNotEqual(original, self.fingerprint())
        shader.write_text(self.inputs['benchmarks/shaders/radial.frag'], encoding='utf-8')
        self.assertEqual(original, self.fingerprint())

    def test_shader_addition_and_asset_rename_are_inputs(self):
        original = self.fingerprint()
        added = self.write('benchmarks/shaders/nested/other.frag', 'other shader')
        self.assertNotEqual(original, self.fingerprint())
        added.unlink()
        self.assertEqual(original, self.fingerprint())
        (self.app / 'shaders/radial.frag').rename(self.app / 'shaders/renamed.frag')
        self.assertNotEqual(original, self.fingerprint())

    def test_generated_build_info_and_build_outputs_do_not_change_fingerprint(self):
        original = self.fingerprint()
        for name in [
            'benchmarks/assets/build-info.json',
            'benchmarks/build/flutter-pi/pi5-64/app.so',
            'benchmarks/build/unit_test_assets/shaders/radial.frag',
            'benchmarks/.dart_tool/flutter_build/assets/shaders/radial.frag',
            'dslideshow_flutter/build/app.so',
        ]:
            file = self.write(name, 'first generated result')
            self.assertEqual(original, self.fingerprint(), name)
            file.write_text('second generated result', encoding='utf-8')
            self.assertEqual(original, self.fingerprint(), name)

    def test_unchanged_inputs_are_deterministic_across_creation_order_and_checkout(self):
        original = self.fingerprint()
        self.assertEqual(original, self.fingerprint())
        with tempfile.TemporaryDirectory() as other:
            checkout = Path(other)
            for name, content in reversed(list(self.inputs.items())):
                file = checkout / name
                file.parent.mkdir(parents=True, exist_ok=True)
                file.write_text(content, encoding='utf-8')
            self.assertEqual(original, source_fingerprint(checkout, checkout / 'benchmarks'))


if __name__ == '__main__':
    unittest.main()
