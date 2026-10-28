import hashlib
import importlib.util
import json
import os
from pathlib import Path
import tempfile
import unittest

_SPEC = importlib.util.spec_from_file_location('capture_process', Path(__file__).with_name('capture_process.py'))
capture_process = importlib.util.module_from_spec(_SPEC)
_SPEC.loader.exec_module(capture_process)


class CaptureProcessTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.engine = self.root / 'libflutter_engine.so'
        self.engine.write_bytes(b'frozen-engine')
        self.digest = hashlib.sha256(self.engine.read_bytes()).hexdigest()
        self.proc = self.root / 'proc'
        self.process = self.proc / '123'
        self.process.mkdir(parents=True)
        (self.process / 'stat').write_text('123 (flutter-pi test) S ' + ' '.join(['0'] * 18 + ['567'] + ['0'] * 8))
        (self.process / 'cmdline').write_bytes(b'/opt/dslideshow/flutter-pi\0--release\0bundle\0')
        self.mapping = self._mapping(self.engine)
        (self.process / 'maps').write_text(self.mapping + '\n')

    def _mapping(self, path):
        stat = path.stat()
        return f'00010000-00020000 r-xp 00000000 {os.major(stat.st_dev):02x}:{os.minor(stat.st_dev):02x} {stat.st_ino} {path}'

    def capture(self):
        return capture_process.capture(123, self.engine, self.digest, self.proc)

    def test_actual_mapped_inode_and_hash_are_verified(self):
        result = self.capture()
        self.assertEqual(result['status'], 'verified')
        self.assertEqual(result['pid'], 123)
        self.assertEqual(result['process_start_ticks'], 567)
        self.assertEqual(result['engine']['sha256'], self.digest)
        self.assertFalse(result['timing_results_valid'])
        self.assertIn(self.mapping, result['maps'])

    def test_absent_mapping_is_retryable(self):
        (self.process / 'maps').write_text('')
        with self.assertRaises(capture_process.EngineNotMapped):
            self.capture()

    def test_different_mapped_file_is_rejected_even_with_identical_bytes(self):
        alternate = self.root / 'other' / self.engine.name
        alternate.parent.mkdir()
        alternate.write_bytes(self.engine.read_bytes())
        (self.process / 'maps').write_text(self._mapping(alternate))
        with self.assertRaisesRegex(ValueError, 'path/device/inode'):
            self.capture()

    def test_deleted_mapping_is_rejected(self):
        (self.process / 'maps').write_text(self.mapping + ' (deleted)')
        with self.assertRaisesRegex(ValueError, 'deleted'):
            self.capture()

    def test_wrong_hash_is_rejected(self):
        self.digest = '0' * 64
        with self.assertRaisesRegex(ValueError, 'SHA-256'):
            self.capture()

    def test_write_does_not_replace_existing_or_symlink_output(self):
        output = self.root / 'output.json'
        capture_process.write_exclusive(output, {'status': 'verified'})
        self.assertEqual(json.loads(output.read_text())['status'], 'verified')
        with self.assertRaises(FileExistsError):
            capture_process.write_exclusive(output, {})
        link = self.root / 'linked.json'
        link.symlink_to(output)
        with self.assertRaises(FileExistsError):
            capture_process.write_exclusive(link, {})
        self.assertEqual(json.loads(output.read_text())['status'], 'verified')


if __name__ == '__main__':
    unittest.main()
