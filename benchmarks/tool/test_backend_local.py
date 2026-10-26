"""Verify local benchmark fixtures, measurement accounting and failure cleanup."""
import json
import os
from pathlib import Path
import shutil
import sys
import tempfile
import unittest

import backend_local as bench
from backend_local_trace import process_creations


class BackendLocalToolsTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)

    def test_fixture_is_reusable_and_detects_changed_files(self):
        root = self.root / "nested"
        manifest = bench.fixture(root, 101, "nested")
        self.assertEqual(manifest, bench.fixture(root, 101, "nested"))
        self.assertEqual(len(list((root / "images").rglob("*.jpg"))), 101)
        next((root / "images").rglob("*.jpg")).write_text("changed")
        with self.assertRaisesRegex(ValueError, "content mismatch"):
            bench.fixture(root, 101, "nested")

    def test_refuses_incomplete_fixture(self):
        (self.root / "partial").mkdir()
        (self.root / "partial/unrelated").write_text("preserve")
        with self.assertRaisesRegex(ValueError, "Refusing to overwrite"):
            bench.fixture(self.root / "partial", 3, "flat")
        self.assertEqual((self.root / "partial/unrelated").read_text(), "preserve")

    def test_quantiles_retain_sample_count_and_missing_values(self):
        self.assertEqual(bench.distribution([]), {"n": 0, "p50": None, "p95": None, "p99": None, "max": None})
        self.assertEqual(bench.distribution([1, 2, 30])["p99"], 30)

    def test_process_trace_counts_children_but_not_threads_or_failed_clones(self):
        trace = """10 clone3({flags=CLONE_VM|CLONE_THREAD}, 88) = -1 ENOSYS (Function not implemented)
10 clone(child_stack=NULL, flags=CLONE_VM|CLONE_THREAD) = 11
10 clone(child_stack=NULL, flags=CLONE_VM|CLONE_VFORK|SIGCHLD <unfinished ...>
10 <... clone resumed>) = 12
12 vfork() = 13
13 clone3({flags=SIGCHLD}, 88) = 14
"""
        self.assertEqual(process_creations(trace), [12, 13, 14])

    def test_nonzero_and_deadline_are_errors(self):
        with self.assertRaisesRegex(RuntimeError, "Exit 3"):
            bench.run_process([sys.executable, "-c", "raise SystemExit(3)"])
        with self.assertRaisesRegex(RuntimeError, "Deadline"):
            bench.run_process([sys.executable, "-c", "import time; time.sleep(30)"], timeout=.05)

    def test_deadline_terminates_descendants_holding_pipes(self):
        child_file = self.root / "child-pid"
        script = ("import subprocess,time,signal,sys; "
                  "child=subprocess.Popen(['sleep','30']); "
                  "signal.signal(signal.SIGTERM, lambda s,f:(child.wait(),sys.exit(0))); "
                  f"open({str(child_file)!r},'w').write(str(child.pid)); time.sleep(30)")
        with self.assertRaisesRegex(RuntimeError, "Deadline"):
            bench.run_process([sys.executable, "-c", script], timeout=.2)
        child = Path("/proc") / child_file.read_text() / "stat"
        if child.exists():
            self.assertEqual(child.read_text().split(") ", 1)[1].split()[0], "Z")

    def test_deadline_also_terminates_a_detached_command_session(self):
        child_file = self.root / "detached-child"
        script = ("import subprocess,time,signal,sys; "
                  "child=subprocess.Popen(['sleep','30'],start_new_session=True); "
                  "signal.signal(signal.SIGTERM, lambda s,f:(child.wait(),sys.exit(0))); "
                  f"open({str(child_file)!r},'w').write(str(child.pid)); time.sleep(30)")
        with self.assertRaisesRegex(RuntimeError, "Deadline"):
            bench.run_process([sys.executable, "-c", script], timeout=.2)
        child = Path("/proc") / child_file.read_text() / "stat"
        if child.exists():
            self.assertEqual(child.read_text().split(") ", 1)[1].split()[0], "Z")

    def test_source_snapshot_preserves_backend_and_common(self):
        packages = []
        for name in ("dslideshow_backend", "dslideshow_common"):
            root = self.root / name
            (root / "lib").mkdir(parents=True)
            (root / "lib/example.dart").write_text("// frozen\n")
            packages.append({"name": name, "rootUri": root.as_uri(), "packageUri": "lib/"})
        config = self.root / "packages.json"
        config.write_text(json.dumps({"configVersion": 2, "packages": packages}))
        destination = self.root / "variant"
        destination.mkdir()
        frozen, _, provenance = bench.snapshot(config, destination)
        (self.root / "dslideshow_backend/lib/example.dart").write_text("// edited\n")
        self.assertEqual((destination / "sources/backend/lib/example.dart").read_text(), "// frozen\n")
        self.assertTrue(all(item["rootUri"].startswith("file:///") for item in json.loads(frozen.read_text())["packages"]))
        self.assertEqual(provenance["source_archive_sha256"], bench.digest(destination / "source.tar.gz"))


class BackendLocalDartTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.dart = os.environ.get("DART_EXECUTABLE")
        if cls.dart is None:
            candidate = Path("/home/dis/bin/flutter/bin/cache/dart-sdk/bin/dart")
            cls.dart = str(candidate) if candidate.exists() else shutil.which("dart")
        cls.packages = bench.ROOT / "backend/.dart_tool/package_config.json"
        if cls.dart is None or not cls.packages.exists() or sys.platform != "linux":
            raise unittest.SkipTest("Existing Linux Dart SDK and backend package config required; never installs dependencies")

    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)

    def execute(self, scenario, root, count=None, successful=True):
        argv = [self.dart, f"--packages={self.packages}", str(bench.TOOL / "backend_local.dart"), f"--scenario={scenario}"]
        if count is not None:
            argv.append(f"--count={count}")
        import subprocess
        result = subprocess.run(argv, env=os.environ | {"DSLIDESHOW_ROOT": str(root)},
                                capture_output=True, text=True, timeout=30)
        self.assertEqual(result.returncode, 0 if successful else 2, result.stdout + result.stderr)
        return json.loads(result.stdout.strip().splitlines()[-1])

    def test_exact_cycle_and_single_file(self):
        for count in (1, 7):
            root = self.root / str(count)
            bench.fixture(root, count, "nested")
            result = self.execute("storage", root, count)
            self.assertEqual(result["selected_count"], count)
            self.assertEqual(result["unique_count"], count)
            self.assertIsNotNone(result["after"]["hwm_bytes"])

    def test_missing_directory_is_reported_and_exits(self):
        result = self.execute("storage", self.root / "missing", 1, successful=False)
        self.assertEqual(result["status"], "failed")
        self.assertIn("error", result)

    def test_rpc_worker_shuts_down_and_retains_raw_probes(self):
        root = self.root / "rpc"
        bench.fixture(root, 10, "flat")
        result = self.execute("responsiveness", root)
        self.assertTrue(result["rpc_probes"])
        self.assertTrue(result["event_loop_samples"])
        self.assertTrue(all(probe.get("status") in ("ok", "capacity_skipped") for probe in result["rpc_probes"]))

    def test_rpc_scan_error_completes_and_exits(self):
        result = self.execute("responsiveness", self.root / "missing", successful=False)
        self.assertEqual(result["status"], "failed")
        self.assertIn("error", result)


if __name__ == "__main__":
    unittest.main()
