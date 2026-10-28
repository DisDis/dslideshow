import hashlib
import json
from pathlib import Path
import struct
import tempfile
import unittest
from unittest.mock import patch

import finalize_capture as tool

_HEADER = struct.Struct('<8s8I6Q2I4Q')
_RECORD = struct.Struct('<IHH5QIiq6QIIQ')


class FinalizeCaptureTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.proc = self.root / 'proc'
        self.proc.mkdir()
        self.native = self.root / 'native-pipeline.bin'
        self.launch = self.root / 'launcher-status.json'
        self.proof = self.root / 'native-pipeline-provenance.json'
        self.write_native()
        self.launch.write_text(json.dumps({'exit_code': 0, 'finished_utc': '2026-10-28T00:00:00Z'}))
        self.proof.write_text(json.dumps({'schema_version': 1, 'kind': 'native_pipeline_loaded_engine',
                                         'status': 'verified', 'pid': 123, 'process_start_ticks': 99,
                                         'engine': {'path': '/frozen/libflutter_engine.so', 'sha256': 'a' * 64},
                                         'timing_results_valid': False, 'captured_monotonic_ns': 1050}))

    def write_native(self, committed=1, complete=1, dropped=0):
        header = _HEADER.pack(b'NPIPV001', 1, 0x01020304, 128, 128, 1, 123, 3, 0,
                              1, committed, dropped, 1000, 2000, 0, 1, 0, 0, 0, 0, 0)
        record = _RECORD.pack(complete, 1, 0, 1, 1100, 1200, 100, 110,
                              123, 0, 1, *([0] * 6), 0, 0, 0)
        self.native.write_bytes(header + record)

    def verify(self):
        return tool.verify(self.root, self.proc)

    def test_exited_process_gets_separate_proof_without_modifying_raw_header(self):
        before = self.native.read_bytes()
        proof = self.verify()
        self.assertEqual(proof['status'], 'verified')
        self.assertEqual(proof['raw_lifecycle'], 1)
        self.assertEqual(proof['raw_closed_monotonic_ns'], 0)
        self.assertEqual(proof['pid'], 123)
        self.assertEqual(proof['process_start_ticks'], 99)
        self.assertEqual(proof['native_capture']['sha256'], hashlib.sha256(before).hexdigest())
        self.assertEqual(proof['launcher_status']['sha256'], hashlib.sha256(self.launch.read_bytes()).hexdigest())
        self.assertEqual(self.native.read_bytes(), before)

    def test_live_or_reused_pid_is_rejected(self):
        (self.proc / '123').mkdir()
        with self.assertRaisesRegex(ValueError, 'PID still exists'):
            self.verify()

    def test_permission_error_does_not_mean_absent_process(self):
        with patch.object(Path, 'stat', side_effect=PermissionError('unreadable')):
            with self.assertRaises(PermissionError):
                tool._assert_absent(self.proc / '123')

    def test_pending_or_dropped_records_are_not_finalized(self):
        for options in [dict(committed=0), dict(complete=0), dict(dropped=1)]:
            with self.subTest(options=options):
                self.write_native(**options)
                with self.assertRaisesRegex(ValueError, 'Incomplete'):
                    self.verify()

    def test_failed_launcher_is_not_finalized(self):
        self.launch.write_text(json.dumps({'exit_code': 2}))
        with self.assertRaisesRegex(ValueError, 'successful process exit'):
            self.verify()

    def test_different_engine_process_is_not_finalized(self):
        proof = json.loads(self.proof.read_text())
        proof['pid'] = 124
        self.proof.write_text(json.dumps(proof))
        with self.assertRaisesRegex(ValueError, 'this process'):
            self.verify()

    def test_incomplete_loaded_engine_proof_is_not_finalized(self):
        proof = json.loads(self.proof.read_text())
        del proof['engine']
        self.proof.write_text(json.dumps(proof))
        with self.assertRaisesRegex(ValueError, 'this process'):
            self.verify()

    def test_changed_bytes_are_rejected_even_with_matching_stat_metadata(self):
        original = tool._snapshot
        calls = 0
        def snapshot(path):
            nonlocal calls
            data, identity = original(path)
            if path == self.native:
                calls += 1
                if calls == 2:
                    data = data[:-1] + bytes([data[-1] ^ 1])
            return data, identity
        with patch.object(tool, '_snapshot', side_effect=snapshot):
            with self.assertRaisesRegex(ValueError, 'changed during finalization'):
                self.verify()


if __name__ == '__main__':
    unittest.main()
