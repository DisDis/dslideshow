"""Check pre-build test coverage and failure propagation without invoking SDKs."""

import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


FACTORY = Path(__file__).resolve().parent


class TestRunnerTest(unittest.TestCase):
    def run_fixture(self, failed_package=None):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for package in (
                "common", "backend", "i18n", "system_metrics_widget",
                "dslideshow_flutter", "config_app", "deb_factory",
            ):
                (root / package).mkdir()
            runner = root / "deb_factory/run_tests.sh"
            shutil.copy2(FACTORY / "run_tests.sh", runner)
            binary_dir = root / "bin"
            binary_dir.mkdir()
            log = root / "commands.jsonl"
            # Use the host interpreter directly, since python3 itself is stubbed.
            fake_tool = (
                f"#!{sys.executable}\n"
                "import json, os, pathlib, sys\n"
                "with open(os.environ['PREFLIGHT_LOG'], 'a') as log:\n"
                "    log.write(json.dumps([pathlib.Path(sys.argv[0]).name, "
                "pathlib.Path.cwd().name, sys.argv[1:]]) + '\\n')\n"
                "if pathlib.Path.cwd().name == os.environ.get('PREFLIGHT_FAIL'):\n"
                "    sys.exit(7)\n"
            )
            for tool in ("dart", "flutter", "python3"):
                executable = binary_dir / tool
                executable.write_text(fake_tool)
                executable.chmod(0o755)
            env = dict(
                os.environ,
                PATH=f"{binary_dir}{os.pathsep}{os.environ['PATH']}",
                PREFLIGHT_LOG=str(log),
                PREFLIGHT_FAIL=failed_package or "",
            )
            result = subprocess.run(
                [str(runner)], cwd=root, env=env, capture_output=True, text=True,
            )
            commands = [json.loads(line) for line in log.read_text().splitlines()]
            return result, commands

    def test_runs_all_production_package_and_build_tool_tests(self):
        result, commands = self.run_fixture()
        self.assertEqual(result.returncode, 0, result.stderr)
        dart_packages = {cwd for tool, cwd, args in commands if tool == "dart" and args[0] == "test"}
        flutter_packages = {cwd for tool, cwd, args in commands if tool == "flutter" and args[0] == "test"}
        self.assertEqual(dart_packages, {"common", "backend"})
        self.assertEqual(flutter_packages, {"i18n", "system_metrics_widget", "dslideshow_flutter", "config_app"})
        python_commands = [args for tool, cwd, args in commands if tool == "python3"]
        self.assertEqual(len(python_commands), 2)
        for args in python_commands:
            self.assertEqual(args[:3], ["-m", "unittest", "discover"])
        tested_dirs = {Path(args[args.index("-s") + 1]) for args in python_commands}
        self.assertEqual({path.name for path in tested_dirs}, {"tool", "deb_factory"})
        tool_dir = next(path for path in tested_dirs if path.name == "tool")
        self.assertEqual(tool_dir.parent.name, "dslideshow_flutter")

    def test_failure_stops_before_remaining_packages_and_tools(self):
        result, commands = self.run_fixture(failed_package="backend")
        self.assertEqual(result.returncode, 7)
        self.assertEqual([(tool, cwd) for tool, cwd, _ in commands], [("dart", "common"), ("dart", "backend")])


if __name__ == "__main__":
    unittest.main()
