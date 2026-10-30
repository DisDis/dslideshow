"""Regression checks for the coverage report, using independent LCOV fixtures."""

import json
from pathlib import Path
import tempfile
import unittest

import test_coverage as coverage


class CoverageReportTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.source = self.root / "backend/lib/service.dart"
        self.source.parent.mkdir(parents=True)
        self.source.write_text("void run() {\n  action();\n}\n")

    def report(self, text):
        path = self.root / "input.info"
        path.write_text(text)
        return coverage.read_lcov(path, self.root, "backend")

    def test_duplicate_lcov_records_preserve_uncovered_lines_and_branches(self):
        records = self.report("SF:lib/service.dart\nDA:1,0\nDA:2,1\nBRDA:2,0,0,-\nLF:999\nend_of_record\n"
                              "SF:lib/service.dart\nDA:2,3\nDA:3,0\nBRDA:2,0,0,2\nBRDA:2,0,1,0\nend_of_record\n")
        self.assertEqual(records["backend/lib/service.dart"]["lines"], {1: 0, 2: 4, 3: 0})
        self.assertEqual(coverage.totals(records), {"lines_found": 3, "lines_hit": 1, "branches_found": 2,
                                                   "branches_hit": 1, "line_percent": 33.33, "branch_percent": 50.0,
                                                   "functions_found": 0, "functions_hit": 0, "function_percent": None})

    def test_paths_across_packages_file_uris_and_spaces(self):
        text = (f"SF:{self.source.as_uri()}\nDA:1,1\nend_of_record\n"
                "SF:../config_app/lib/a%20b.dart\nDA:2,1\nend_of_record\n"
                "SF:package:dslideshow_flutter/a.dart\nDA:1,0\nend_of_record\n"
                "SF:/outside/repo.dart\nDA:1,99\nend_of_record\n")
        records = self.report(text)
        self.assertEqual(set(records), {"backend/lib/service.dart", "config_app/lib/a%20b.dart", "dslideshow_flutter/lib/a.dart"})

    def test_missing_sources_are_unknown_instead_of_fake_zero_denominators(self):
        missing = self.source.with_name("never_imported.dart")
        missing.write_text("int answer() => 42;\n")
        self.source.with_name("service.freezed.dart").write_text("generated\n")
        run = self.root / "run"
        (run / "backend").mkdir(parents=True)
        coverage.write_json(run / "manifest.json", {"status": "finished", "packages": ["backend"], "snapshot": coverage.source_snapshot(self.root)})
        (run / "backend/lcov.info").write_text("SF:lib/service.dart\nDA:2,1\nend_of_record\n")
        summary = coverage.summarize(run, self.root)
        self.assertEqual(summary["packages"]["backend"]["own_suite"]["line_percent"], 100.0)
        self.assertEqual(summary["packages"]["backend"]["not_measured"], ["backend/lib/never_imported.dart"])
        self.assertEqual(summary["excluded_generated"], ["backend/lib/service.freezed.dart"])
        self.assertEqual(summary["source_changed"], [])
        self.assertIn("not_measured", (run / "files.csv").read_text())
        missing.write_text("int answer() => 43;\n")
        self.assertEqual(coverage.summarize(run, self.root)["source_changed"], ["backend/lib/never_imported.dart"])

    def test_cross_suite_union_and_overlap_do_not_double_count_lines(self):
        a = self.report("SF:lib/service.dart\nDA:1,1\nDA:2,0\nend_of_record\n")
        b = self.report("SF:lib/service.dart\nDA:1,3\nDA:2,1\nend_of_record\n")
        union = coverage.merge_records([a, b])
        self.assertEqual(coverage.totals(union)["lines_hit"], 2)
        self.assertEqual(coverage.overlap({"a": a, "b": b}), [{"left": "a", "right": "b", "shared_hit_lines": 1,
                         "left_only": 0, "right_only": 1, "jaccard_percent": 50.0}])
        normalized = self.root / "normalized.info"
        coverage.write_lcov(normalized, union)
        self.assertEqual(coverage.read_lcov(normalized, self.root, ""), union)

    def test_html_escapes_source_paths(self):
        self.source.with_name("<unsafe>.dart").write_text("void action() {}")
        run = self.root / "run"
        run.mkdir()
        coverage.write_json(run / "manifest.json", {"status": "finished", "packages": [], "snapshot": coverage.source_snapshot(self.root)})
        coverage.summarize(run, self.root)
        self.assertIn("&lt;unsafe&gt;", (run / "index.html").read_text())
        self.assertNotIn("<unsafe>", (run / "index.html").read_text())

    def test_machine_events_distinguish_skips_hidden_failures_and_unfinished(self):
        path = self.root / "events.jsonl"
        events = [{"type": "suite", "suite": {"id": 1, "path": "test/example_test.dart"}}]
        for key in range(5):
            events.append({"type": "testStart", "test": {"id": key, "name": f"scenario {key}", "suiteID": 1}})
        events.extend([
            {"type": "testDone", "testID": 0, "result": "success"},
            {"type": "testDone", "testID": 1, "result": "success", "skipped": True},
            {"type": "testDone", "testID": 2, "result": "success", "hidden": True},
            {"type": "testDone", "testID": 3, "result": "error"},
        ])
        path.write_text("VM preamble\n" + "\n".join(map(json.dumps, events)))
        result = coverage.test_results(path)
        self.assertEqual({k: result[k] for k in ("passed", "skipped", "hidden", "failed", "unfinished")},
                         {"passed": 1, "skipped": 1, "hidden": 1, "failed": 1, "unfinished": 1})
        self.assertEqual(result["failures"], [{"name": "scenario 3", "suite": "test/example_test.dart"}])

    def test_function_declarations_without_hits_stay_uncovered(self):
        records = self.report("SF:lib/service.dart\nFN:1,run\nFN:3,unused\nFNDA:4,run\nDA:1,4\nend_of_record\n")
        self.assertEqual(coverage.totals(records)["function_percent"], 50.0)
        path = self.root / "normalized.info"
        coverage.write_lcov(path, records)
        self.assertEqual(coverage.read_lcov(path, self.root, ""), records)

    def test_merge_replaces_rerun_and_rejects_different_snapshot(self):
        runs = [self.root / "old", self.root / "new"]
        for run, count in zip(runs, [5, 2]):
            (run / "backend").mkdir(parents=True)
            coverage.write_json(run / "manifest.json", {"status": "finished", "packages": ["backend"],
                "snapshot": coverage.source_snapshot(self.root), "results": {"backend": {"tests": {"exit_code": 0}}}})
            (run / "backend/lcov.info").write_text(f"SF:lib/service.dart\nDA:1,{count}\nend_of_record\n")
        output = self.root / "merged"
        summary = coverage.merge_runs(runs, output, self.root)
        self.assertTrue(summary["checks_passed"])
        record = coverage.read_lcov(output / "union.lcov.info", self.root, "")
        self.assertEqual(record["backend/lib/service.dart"]["lines"], {1: 2})
        with self.assertRaises(FileExistsError):
            coverage.merge_runs(runs, output, self.root)
        with self.assertRaisesRegex(ValueError, "outside every input"):
            coverage.merge_runs(runs, runs[0] / "backend/nested", self.root)
        selected = json.loads((runs[1] / "manifest.json").read_text())
        selected["tests"] = ["test/selected_test.dart"]
        coverage.write_json(runs[1] / "manifest.json", selected)
        with self.assertRaisesRegex(ValueError, "full-suite reruns"):
            coverage.merge_runs(runs, self.root / "partial", self.root)
        del selected["tests"]
        coverage.write_json(runs[1] / "manifest.json", selected)
        manifest = json.loads((runs[1] / "manifest.json").read_text())
        manifest["snapshot"]["sha256"] = "changed"
        coverage.write_json(runs[1] / "manifest.json", manifest)
        with self.assertRaisesRegex(ValueError, "different source snapshots"):
            coverage.merge_runs(runs, self.root / "invalid", self.root)

    def test_saved_inventory_survives_deleted_source_and_warns_about_drift(self):
        run = self.root / "run"
        (run / "backend").mkdir(parents=True)
        sources, excluded = coverage.inventory(self.root)
        coverage.write_json(run / "manifest.json", {"status": "finished", "packages": ["backend"],
            "snapshot": coverage.source_snapshot(self.root), "inventory": sources, "excluded_generated": excluded})
        (run / "backend/lcov.info").write_text("SF:lib/service.dart\nDA:1,1\nend_of_record\n")
        self.source.unlink()
        summary = coverage.summarize(run, self.root)
        self.assertFalse(summary["checks_passed"])
        self.assertEqual(summary["packages"]["backend"]["source_files"], 1)
        self.assertEqual(summary["source_changed"], ["backend/lib/service.dart"])

    def test_unavailable_coverage_fails_before_implicit_dependency_resolution(self):
        config = self.root / "backend/.dart_tool/package_config.json"
        config.parent.mkdir()
        coverage.write_json(config, {"packages": []})
        with self.assertRaisesRegex(RuntimeError, "already be resolved"):
            coverage.require_package_configs(self.root, ["backend"])
        coverage.write_json(config, {"packages": [{"name": "coverage", "rootUri": "../../missing"}]})
        with self.assertRaisesRegex(RuntimeError, "unavailable"):
            coverage.require_package_configs(self.root, ["backend"])
        binary = self.root / "missing/bin/test_with_coverage.dart"
        binary.parent.mkdir(parents=True)
        binary.write_text("// fixture")
        coverage.require_package_configs(self.root, ["backend"])


if __name__ == "__main__":
    unittest.main()
