"""Private tracefs controls exercised against a temporary, mocked filesystem."""

import json
import os
from pathlib import Path
import shutil
import signal
import tempfile
import unittest
from unittest import mock

import trace_instance as capture


class TraceInstanceTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="native-trace-test-")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.tracefs = self.root / "tracefs"
        self.tracefs.mkdir()
        (self.tracefs / "instances").mkdir()
        self.name = "dslideshow_native_test_1"
        self.instance = self.tracefs / "instances" / self.name
        self.output = self.root / "capture"
        self.events = (*capture._DRM, capture._CL[1], "v3d/v3d_rcl_irq")
        for event in self.events:
            directory = self.tracefs / "events" / event
            directory.mkdir(parents=True)
            (directory / "enable").write_text("GLOBAL disabled")
            (directory / "format").write_text(f"name: {event}\nfield: unsigned int seqno;\n")
        (self.tracefs / "available_events").write_text("\n".join(self.events))
        for name in ("trace", "tracing_on", "trace_clock", "buffer_size_kb", "current_tracer"):
            (self.tracefs / name).write_text(f"GLOBAL {name} unchanged")
        self.globals = {path: path.read_bytes() for path in self.tracefs.rglob("*") if path.is_file()}
        self.create = mock.patch.object(capture, "_create_instance", self.create_instance)
        self.remove = mock.patch.object(capture, "_remove_instance", self.remove_instance)
        self.create.start()
        self.remove.start()
        self.addCleanup(self.create.stop)
        self.addCleanup(self.remove.stop)
        self.addCleanup(self.assert_global_controls_unchanged)

    def create_instance(self, instance):
        instance.mkdir()  # Real tracefs mkdir creates these virtual descendants.
        for name, value in {
            "tracing_on": "0", "trace_clock": "[local] global mono mono_raw",
            "current_tracer": "nop", "buffer_size_kb": "1024", "trace": "",
        }.items():
            (instance / name).write_text(value)
        shutil.copytree(self.tracefs / "events", instance / "events")
        for index in range(2):
            directory = instance / "per_cpu" / f"cpu{index}"
            directory.mkdir(parents=True)
            (directory / "stats").write_text(
                "entries: 12\noverrun: 0\ncommit overrun: 0\nbytes: 1024\n"
                "oldest event ts: 1.234\nnow ts: 2.345\ndropped events: 0\nread events: 0\n"
            )

    def remove_instance(self, instance):
        self.assertEqual(instance, self.instance)
        self.assertEqual((instance / "tracing_on").read_text(), "0")
        shutil.rmtree(instance)  # Only regular fake files need recursive removal.

    def assert_global_controls_unchanged(self):
        for path, contents in self.globals.items():
            if path.exists():
                self.assertEqual(path.read_bytes(), contents, path)

    def run_capture(self, action, **kwargs):
        capture.run(action, self.name, self.output, tracefs=self.tracefs, **kwargs)

    def provenance(self):
        return json.loads((self.output / "trace-provenance.json").read_text())

    def test_init_records_optional_unavailability_formats_and_only_private_controls(self):
        self.run_capture("init", buffer_size_kb=16384)
        state = self.provenance()
        self.assertEqual(state["status"], "initialized")
        self.assertEqual(state["initial_cpus"], ["cpu0", "cpu1"])
        self.assertEqual(state["buffer_size_kb_per_cpu_actual"], "16384")
        self.assertEqual(state["trace_clock"], "mono")
        self.assertEqual(state["missing_required"], [])
        for event in self.events:
            self.assertTrue(state["events"][event]["selected"])
            self.assertIn("seqno", state["events"][event]["format"])
            self.assertEqual((self.instance / "events" / event / "enable").read_text(), "1")
        missing = state["events"]["v3d/v3d_csd_irq"]
        self.assertEqual(missing, {"available": False, "required": False,
                                   "required_group": None, "selected": False, "format": None})
        self.run_capture("close")
        self.run_capture("close")  # Supervisor cleanup can safely be repeated.
        self.assertFalse(self.instance.exists())

    def test_start_stop_save_raw_events_stats_loss_and_provenance(self):
        self.run_capture("init")
        (self.instance / "trace").write_text("old trace must be cleared")
        self.run_capture("start")
        self.assertEqual((self.instance / "trace").read_text(), "")
        self.assertEqual((self.instance / "tracing_on").read_text(), "1")
        raw = "render-42 [001] .... 123.456: v3d_rcl_irq: dev=0, seqno=57\n"
        (self.instance / "trace").write_text(raw)
        (self.instance / "per_cpu/cpu1/stats").write_text("entries: 4\noverrun: 3\ncommit overrun: 1\n")
        self.run_capture("stop")
        self.assertEqual((self.instance / "tracing_on").read_text(), "0")
        self.assertEqual((self.output / "trace.txt").read_text(), raw)
        stats = json.loads((self.output / "trace-stats.json").read_text())
        self.assertTrue(stats["stats_complete"])
        self.assertTrue(stats["loss_detected"])
        self.assertEqual(stats["per_cpu"]["cpu1"]["counters"]["overrun"], 3)
        self.assertIn("oldest event ts: 1.234", stats["per_cpu"]["cpu0"]["raw"])
        state = self.provenance()
        self.assertEqual(state["status"], "stopped")
        self.assertLessEqual(state["started"]["monotonic_ns"], state["stopped"]["monotonic_ns"])
        self.run_capture("close")
        self.assertEqual((self.output / "trace.txt").read_text(), raw)

    def test_missing_cpu_stats_is_explicit_unknown_not_zero_loss(self):
        self.run_capture("init")
        self.run_capture("start")
        (self.instance / "per_cpu/cpu1/stats").unlink()
        self.run_capture("stop")
        stats = json.loads((self.output / "trace-stats.json").read_text())
        self.assertFalse(stats["stats_complete"])
        self.assertIsNone(stats["loss_detected"])
        self.assertEqual(stats["missing_cpus"], ["cpu1"])
        self.run_capture("close")

    def test_complete_zero_stats_are_recorded_without_fabricated_other_counters(self):
        self.run_capture("init")
        self.run_capture("start")
        self.run_capture("stop")
        stats = json.loads((self.output / "trace-stats.json").read_text())
        self.assertTrue(stats["stats_complete"])
        self.assertFalse(stats["loss_detected"])
        self.assertNotIn("nonexistent_counter", stats["per_cpu"]["cpu0"]["counters"])
        self.run_capture("close")

    def test_collision_never_adopts_stops_or_removes_existing_instance(self):
        self.create_instance(self.instance)
        (self.instance / "tracing_on").write_text("1")
        with self.assertRaises(FileExistsError):
            self.run_capture("init")
        self.assertTrue(self.instance.is_dir())
        self.assertEqual((self.instance / "tracing_on").read_text(), "1")
        self.assertEqual(self.provenance()["status"], "failed")
        with self.assertRaisesRegex(capture.TraceError, "identity changed"):
            self.run_capture("close")
        self.assertEqual((self.instance / "tracing_on").read_text(), "1")

    def test_existing_output_and_artifact_are_never_overwritten(self):
        self.output.mkdir()
        sentinel = self.output / "trace.txt"
        sentinel.write_text("preserve")
        with self.assertRaises(FileExistsError):
            self.run_capture("init")
        self.assertEqual(sentinel.read_text(), "preserve")
        self.assertFalse(self.instance.exists())

    def test_missing_required_events_fail_with_availability_evidence(self):
        for event in (capture._DRM[0], capture._CL[1]):
            with self.subTest(event=event):
                format_path = self.tracefs / "events" / event / "format"
                original = format_path.read_text()
                format_path.unlink()
                with self.assertRaisesRegex(capture.TraceError, "Missing required"):
                    self.run_capture("init")
                state = self.provenance()
                self.assertEqual(state["status"], "failed")
                self.assertTrue(state["missing_required"])
                self.assertIsNone(state["events"][event]["format"])
                self.assertFalse(self.instance.exists())
                shutil.rmtree(self.output)
                format_path.write_text(original)

    def test_partial_initialization_error_disables_and_removes_only_owned_instance(self):
        original_create = self.create_instance

        def create_without_mono(instance):
            original_create(instance)
            (instance / "trace_clock").write_text("[local] global")

        with mock.patch.object(capture, "_create_instance", create_without_mono):
            with self.assertRaisesRegex(capture.TraceError, "no mono clock"):
                self.run_capture("init")
        self.assertFalse(self.instance.exists())
        self.assertEqual(self.provenance()["cleanup_errors"], [])
        self.run_capture("close")

    def test_interrupted_event_enable_records_failure_and_cleans_owned_instance(self):
        original = Path.write_text

        def interrupt(path, text, *args, **kwargs):
            if path == self.instance / "events" / capture._DRM[1] / "enable":
                capture._interrupted(signal.SIGTERM, None)
            return original(path, text, *args, **kwargs)

        with mock.patch.object(Path, "write_text", interrupt):
            with self.assertRaisesRegex(capture.TraceError, "SIGTERM"):
                self.run_capture("init")
        self.assertFalse(self.instance.exists())
        state = self.provenance()
        self.assertEqual(state["status"], "failed")
        self.assertIsNotNone(state["instance_inode"])
        self.assertEqual(state["cleanup_errors"], [])

    def test_stop_output_collision_preserves_file_and_cleans_running_instance(self):
        self.run_capture("init")
        self.run_capture("start")
        (self.output / "trace.txt").write_text("preserve")
        with self.assertRaises(FileExistsError):
            self.run_capture("stop")
        self.assertFalse(self.instance.exists())
        self.assertEqual((self.output / "trace.txt").read_text(), "preserve")
        self.assertEqual(self.provenance()["status"], "failed")

    def test_changed_instance_identity_is_left_untouched(self):
        self.run_capture("init")
        state = self.provenance()
        state["instance_inode"] += 1
        (self.output / "trace-provenance.json").write_text(json.dumps(state))
        (self.instance / "tracing_on").write_text("1")
        with self.assertRaisesRegex(capture.TraceError, "identity changed"):
            self.run_capture("close")
        self.assertTrue(self.instance.exists())
        self.assertEqual((self.instance / "tracing_on").read_text(), "1")

    def test_invalid_names_paths_and_buffers_do_not_create_outputs(self):
        for name in ("global", "dslideshow_native_../bad", "dslideshow_native_", "dslideshow_native_x/y"):
            with self.subTest(name=name), self.assertRaises(capture.TraceError):
                capture.run("init", name, self.output, tracefs=self.tracefs)
        for value in (0, 8191, 16385, True):
            with self.subTest(buffer=value), self.assertRaises(capture.TraceError):
                self.run_capture("init", buffer_size_kb=value)
        for output in (Path("relative-output"), self.tracefs / "bad-output"):
            with self.subTest(output=output), self.assertRaises(capture.TraceError):
                capture.run("init", self.name, output, tracefs=self.tracefs)
        symlink = self.root / "linked"
        symlink.symlink_to(self.root, target_is_directory=True)
        with self.assertRaises(capture.TraceError):
            capture.run("init", self.name, symlink / "capture", tracefs=self.tracefs)
        self.assertFalse(self.output.exists())

    def test_kernel_clock_readback_selects_the_bracketed_clock(self):
        self.assertEqual(capture._active_clock("local global [mono] mono_raw\n"), "mono")
        self.assertEqual(capture._active_clock("[local] global mono\n"), "local")
        self.assertIsNone(capture._active_clock("local global mono\n"))

    def test_sudo_chowns_only_the_new_output_directory_even_on_preflight_failure(self):
        (self.tracefs / "events" / capture._DRM[0] / "format").unlink()
        with (mock.patch.object(os, "geteuid", return_value=0),
              mock.patch.dict(os.environ, {"SUDO_UID": "1001", "SUDO_GID": "1002"}),
              mock.patch.object(os, "chown") as chown):
            with self.assertRaisesRegex(capture.TraceError, "Missing required"):
                self.run_capture("init")
            chown.assert_called_once_with(self.output, 1001, 1002)
            self.assertEqual(self.provenance()["output_owner"], {"uid": 1001, "gid": 1002})
            with self.assertRaises(FileExistsError):
                self.run_capture("init")
            chown.assert_called_once_with(self.output, 1001, 1002)

    def test_malformed_sudo_owner_fails_before_mkdir_or_chown(self):
        for uid, gid in (("wrong", "1002"), ("1001", ""), ("-1", "1002"),
                         ("1001", "4294967295"), ("1001", None)):
            environment = {"SUDO_UID": uid}
            if gid is not None:
                environment["SUDO_GID"] = gid
            with (self.subTest(uid=uid, gid=gid),
                  mock.patch.object(os, "geteuid", return_value=0),
                  mock.patch.dict(os.environ, environment, clear=True),
                  mock.patch.object(os, "chown") as chown):
                with self.assertRaisesRegex(capture.TraceError, "valid numeric IDs"):
                    self.run_capture("init")
                self.assertFalse(self.output.exists())
                chown.assert_not_called()


if __name__ == "__main__":
    unittest.main()
