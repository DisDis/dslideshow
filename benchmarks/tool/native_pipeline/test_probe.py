#!/usr/bin/env python3
"""Compile an isolated native ABI mock; never opens GPU/DRM/EGL devices."""
import errno
import os
from pathlib import Path
import shutil
import struct
import subprocess
import tempfile
import unittest


HERE = Path(__file__).resolve().parent
HEADER = struct.Struct("<8s8I6Q2I4Q")
RECORD = struct.Struct("<IHH5QIi q6QIIQ")


class PipelineProbeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temporary = tempfile.TemporaryDirectory(prefix="native-pipeline-mock-")
        cls.build = Path(cls.temporary.name)
        cls.cc = shutil.which(os.environ.get("CC", "cc"))
        if cls.cc is None:
            raise unittest.SkipTest("C compiler unavailable")
        include = str(HERE / "test/include")
        flags = [cls.cc, "-std=c11", "-O2", "-Wall", "-Wextra", "-Werror", "-I", include]
        cls.library = cls.build / "libnative_pipeline.so"
        subprocess.run(flags + ["-fPIC", "-shared", "-Wl,-z,defs", str(HERE / "pipeline_probe.c"), "-o", str(cls.library), "-ldl"], check=True)
        subprocess.run(flags + ["-fPIC", "-shared", str(HERE / "test/fake_pipeline.c"), "-o", str(cls.build / "libfake_pipeline.so"), "-ldl"], check=True)
        cls.failure_library = cls.build / "libfailure.so"
        subprocess.run(flags + ["-fPIC", "-shared", str(HERE / "test/failure_injection.c"), "-o", str(cls.failure_library), "-ldl"], check=True)
        cls.probe = cls.build / "probe"
        subprocess.run(flags + [str(HERE / "test/probe.c"), "-o", str(cls.probe), "-L", str(cls.build), "-lfake_pipeline", "-pthread", f"-Wl,-rpath,{cls.build}"], check=True)

    @classmethod
    def tearDownClass(cls):
        if hasattr(cls, "temporary"):
            cls.temporary.cleanup()

    def setUp(self):
        self.case = tempfile.TemporaryDirectory(dir=self.build)
        self.addCleanup(self.case.cleanup)
        self.output = Path(self.case.name) / "pipeline.bin"

    def run_probe(self, *args, output=True, target=None, **extra):
        environment = {key: value for key, value in os.environ.items() if not key.startswith(("BENCH_NATIVE_PIPELINE_", "MOCK_"))}
        environment.update(LD_PRELOAD=str(self.library), BENCH_NATIVE_PIPELINE_TARGET=str(target or self.probe))
        if output:
            environment["BENCH_NATIVE_PIPELINE_OUTPUT"] = str(self.output)
        environment.update({key: str(value) for key, value in extra.items()})
        return subprocess.run([str(self.probe), *args], env=environment, capture_output=True, timeout=10)

    def read_output(self):
        data = self.output.read_bytes()
        fields = HEADER.unpack_from(data)
        keys = ("magic", "version", "endian", "header_size", "record_size", "capacity", "pid", "flags", "init_errno", "reserved_count", "committed_count", "dropped_count", "start_monotonic_ns", "start_realtime_ns", "closed_monotonic_ns", "lifecycle", "clock_errors", "reserved0", "reserved1", "reserved2", "reserved3")
        header = dict(zip(keys, fields))
        self.assertEqual(header["magic"], b"NPIPV001")
        self.assertEqual((header["version"], header["endian"], header["header_size"], header["record_size"]), (1, 0x01020304, 128, 128))
        self.assertEqual(len(data), 128 + header["capacity"] * 128)
        rows = [RECORD.unpack_from(data, 128 + i * 128) for i in range(min(header["reserved_count"], header["capacity"]))]
        return header, rows

    def test_forwards_arguments_results_and_errno_for_all_functions(self):
        result = self.run_probe()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stderr, b"")
        header, rows = self.read_output()
        self.assertEqual((header["reserved_count"], header["committed_count"], header["dropped_count"]), (7, 7, 0))
        self.assertEqual((header["lifecycle"], header["clock_errors"], header["init_errno"], header["flags"]), (2, 0, 0, 3))
        self.assertGreater(header["start_monotonic_ns"], 0)
        self.assertGreater(header["closed_monotonic_ns"], header["start_monotonic_ns"])
        expected = [(0, errno.EAGAIN), (1, errno.ERANGE), (0x88, errno.EINTR), (0, errno.EIO), (-7, errno.EBUSY), (3, errno.ENOTTY), (0x99, errno.ENODEV)]
        for index, row in enumerate(rows):
            committed, function, depth, sequence, start, end, cpu_start, cpu_end, tid, result_errno, returned, *tail = row
            self.assertEqual((committed, function, depth, sequence), (1, index + 1, 0, index + 1))
            self.assertEqual((returned, result_errno), expected[index])
            self.assertGreater(start, 0)
            self.assertGreaterEqual(end, start)
            self.assertGreater(cpu_start, 0)
            self.assertGreaterEqual(cpu_end, cpu_start)
            self.assertGreater(tid, 0)
            self.assertEqual(tail[6], 77)
        self.assertEqual(rows[0][11:17], (0x11, 0x22, 0, 0, 0, 0))
        self.assertEqual(rows[1][11:17], (0x11, 0x22, 0x33, 0x44, 0, 0))
        self.assertEqual(rows[4][11:17], (9, 0xaa, 0xbb, 0xcc, 0, 0))
        self.assertEqual(rows[5][11:17], (9, 10, 11, 12, 0xdd, 0))

    def test_disabled_without_output_preserves_forwarding(self):
        result = self.run_probe(output=False)
        self.assertEqual((result.returncode, result.stderr), (0, b""))
        self.assertFalse(self.output.exists())

    def test_other_target_and_help_quietly_skip_output(self):
        for args, target in [((), Path("/bin/true")), (("--help",), self.probe), (("-h",), self.probe)]:
            result = self.run_probe(*args, target=target)
            self.assertEqual((result.returncode, result.stderr), (0, b""))
            self.assertFalse(self.output.exists())

    def test_target_identity_accepts_symlink(self):
        alias = Path(self.case.name) / "probe-alias"
        alias.symlink_to(self.probe)
        result = self.run_probe(target=alias)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.read_output()[0]["committed_count"], 7)

    def test_missing_relative_or_nonexistent_target_fails_observably(self):
        for target in ("", "relative-path", str(Path(self.case.name) / "absent")):
            result = self.run_probe(BENCH_NATIVE_PIPELINE_TARGET=target)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn(b"operation=target", result.stderr)
            self.assertFalse(self.output.exists())

    def test_existing_file_or_symlink_is_not_modified(self):
        sentinel = Path(self.case.name) / "sentinel"
        sentinel.write_bytes(b"do not overwrite")
        for link in (False, True):
            if self.output.exists() or self.output.is_symlink():
                self.output.unlink()
            if link:
                self.output.symlink_to(sentinel)
            else:
                self.output.write_bytes(sentinel.read_bytes())
            result = self.run_probe()
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn(b"operation=open", result.stderr)
            self.assertEqual(self.output.read_bytes(), b"do not overwrite")
            self.assertEqual(sentinel.read_bytes(), b"do not overwrite")

    def test_invalid_capacity_fails_observably_without_affecting_calls(self):
        for value in ("0", "-1", "999999999999999999", "10x", "1048577"):
            result = self.run_probe(BENCH_NATIVE_PIPELINE_CAPACITY=value)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn(b"operation=capacity", result.stderr)
            self.assertFalse(self.output.exists())

    def test_storage_allocation_failure_does_not_affect_application_calls(self):
        result = self.run_probe(MOCK_FAIL_ALLOCATION=1, LD_PRELOAD=f"{self.failure_library}:{self.library}")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn(b"operation=posix_fallocate", result.stderr)
        # A created but uninitialized file cannot be mistaken for valid evidence.
        self.assertNotEqual(self.output.read_bytes()[:8], b"NPIPV001")

    def test_clock_failure_is_explicit_and_preserves_real_call_errno(self):
        result = self.run_probe(MOCK_FAIL_CPU_CLOCK=1, LD_PRELOAD=f"{self.failure_library}:{self.library}")
        self.assertEqual((result.returncode, result.stderr), (0, b""))
        header, rows = self.read_output()
        self.assertEqual((header["clock_errors"], header["committed_count"]), (14, 7))
        self.assertTrue(all(row[6] == 0 and row[7] == 0 for row in rows))

    def test_overflow_keeps_bounded_records_and_explicit_counts(self):
        result = self.run_probe(BENCH_NATIVE_PIPELINE_CAPACITY=2)
        self.assertEqual(result.returncode, 0, result.stderr)
        header, rows = self.read_output()
        self.assertEqual((header["capacity"], header["reserved_count"], header["committed_count"], header["dropped_count"]), (2, 7, 2, 5))
        self.assertEqual([row[1] for row in rows], [1, 2])

    def test_nested_call_preserves_depth_and_parent_timing(self):
        result = self.run_probe(MOCK_NESTED=1)
        self.assertEqual(result.returncode, 0, result.stderr)
        _, rows = self.read_output()
        self.assertEqual([(row[1], row[2]) for row in rows[:3]], [(1, 0), (2, 1), (2, 0)])
        self.assertLessEqual(rows[0][4], rows[1][4])
        self.assertGreaterEqual(rows[0][5], rows[1][5])

    def test_multithreaded_records_are_unique_complete_and_thread_local(self):
        result = self.run_probe("threads")
        self.assertEqual(result.returncode, 0, result.stderr)
        header, rows = self.read_output()
        self.assertEqual((header["reserved_count"], header["committed_count"], header["dropped_count"]), (560, 560, 0))
        self.assertEqual([row[3] for row in rows], list(range(1, 561)))
        self.assertEqual(len({row[8] for row in rows}), 4)
        self.assertTrue(all(row[0] == 1 and row[2] == 0 for row in rows))

    def test_completed_records_survive_immediate_exit(self):
        result = self.run_probe("exit")
        self.assertEqual(result.returncode, 0, result.stderr)
        header, rows = self.read_output()
        self.assertEqual((header["lifecycle"], header["closed_monotonic_ns"], header["committed_count"]), (1, 0, 7))
        self.assertTrue(all(row[0] == 1 for row in rows))

    def test_exit_during_real_call_preserves_incomplete_marker(self):
        result = self.run_probe(MOCK_DIE_IN_CALL=1)
        self.assertEqual(result.returncode, 17, result.stderr)
        header, rows = self.read_output()
        self.assertEqual((header["reserved_count"], header["committed_count"], header["lifecycle"]), (1, 0, 1))
        self.assertEqual((rows[0][0], rows[0][1], rows[0][5]), (0, 1, 0))
        self.assertGreater(rows[0][4], 0)

    def test_fork_child_does_not_pollute_parent_mapping(self):
        result = self.run_probe("fork")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.read_output()[0]["reserved_count"], 7)

    def test_inherited_preload_subprocess_is_quiet_and_does_not_touch_output(self):
        result = self.run_probe("spawn")
        self.assertEqual((result.returncode, result.stderr), (0, b""))
        self.assertEqual(self.read_output()[0]["reserved_count"], 7)


if __name__ == "__main__":
    unittest.main()
