"""Check pre-build analysis/test coverage and failure propagation without SDKs."""

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
    def run_fixture(self, failed_package=None, failed_action="test", analyzer_infos=False):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for package in (
                "common", "rpc_serializers_generator", "backend", "i18n", "system_metrics_widget",
                "dslideshow_flutter", "config_app", "benchmarks", "autover/example", "deb_factory",
            ):
                (root / package).mkdir(parents=True, exist_ok=True)
            runner = root / "deb_factory/run_tests.sh"
            shutil.copy2(FACTORY / "run_tests.sh", runner)
            shutil.copy2(FACTORY / "run_analysis.sh", root / "deb_factory/run_analysis.sh")
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
                "if (pathlib.Path.cwd().name == os.environ.get('PREFLIGHT_FAIL')\n"
                "        and sys.argv[1] == os.environ.get('PREFLIGHT_FAIL_ACTION')):\n"
                "    sys.exit(7)\n"
                "if sys.argv[1] == 'analyze' and os.environ.get('PREFLIGHT_INFOS') == '1':\n"
                "    print('info: fixture analyzer diagnostic')\n"
                "    if ('--fatal-infos' in sys.argv or\n"
                "            (pathlib.Path(sys.argv[0]).name == 'flutter'\n"
                "             and '--no-fatal-infos' not in sys.argv)):\n"
                "        sys.exit(1)\n"
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
                PREFLIGHT_FAIL_ACTION=failed_action,
                PREFLIGHT_INFOS="1" if analyzer_infos else "0",
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
        self.assertEqual(dart_packages, {"common", "rpc_serializers_generator", "backend"})
        self.assertEqual(flutter_packages, {"i18n", "system_metrics_widget", "dslideshow_flutter", "config_app"})
        python_commands = [args for tool, cwd, args in commands if tool == "python3"]
        self.assertEqual(len(python_commands), 2)
        for args in python_commands:
            self.assertEqual(args[:3], ["-m", "unittest", "discover"])
        tested_dirs = {Path(args[args.index("-s") + 1]) for args in python_commands}
        self.assertEqual({path.name for path in tested_dirs}, {"tool", "deb_factory"})
        tool_dir = next(path for path in tested_dirs if path.name == "tool")
        self.assertEqual(tool_dir.parent.name, "dslideshow_flutter")

        analyzed = [(tool, cwd, args) for tool, cwd, args in commands if args[0] == "analyze"]
        self.assertEqual({cwd for tool, cwd, _ in analyzed if tool == "dart"}, {
            "common", "rpc_serializers_generator", "backend", "autover", "example",
        })
        self.assertEqual({cwd for tool, cwd, _ in analyzed if tool == "flutter"}, {
            "i18n", "system_metrics_widget", "dslideshow_flutter", "config_app", "benchmarks",
        })
        for tool, _, args in analyzed:
            self.assertIn("--fatal-warnings", args)
            self.assertNotIn("--fatal-infos", args)
            self.assertNotIn("--no-fatal-warnings", args)
            if tool == "flutter":
                self.assertIn("--no-fatal-infos", args)
                self.assertIn("--no-pub", args)
        self.assertEqual([tuple(command) for command in commands[:len(analyzed)]], analyzed)

    def test_analysis_failure_stops_before_tests_and_tools(self):
        result, commands = self.run_fixture(failed_package="config_app", failed_action="analyze")
        self.assertEqual(result.returncode, 7)
        self.assertTrue(all(args[0] == "analyze" for _, _, args in commands))
        self.assertEqual(commands[-1][:2], ["flutter", "config_app"])

    def test_infos_are_visible_and_do_not_block_tests(self):
        result, commands = self.run_fixture(analyzer_infos=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("info: fixture analyzer diagnostic", result.stdout)
        self.assertTrue(any(args[0] == "test" for _, _, args in commands))
        self.assertEqual(commands[-1][0], "python3")

    def test_failure_stops_before_remaining_packages_and_tools(self):
        result, commands = self.run_fixture(failed_package="backend")
        self.assertEqual(result.returncode, 7)
        self.assertEqual([(tool, cwd) for tool, cwd, args in commands if args[0] == "test"], [
            ("dart", "common"), ("dart", "rpc_serializers_generator"), ("dart", "backend"),
        ])

    def test_generator_failure_stops_before_backend_and_flutter(self):
        result, commands = self.run_fixture(failed_package="rpc_serializers_generator")
        self.assertEqual(result.returncode, 7)
        self.assertEqual([(tool, cwd) for tool, cwd, args in commands if args[0] == "test"], [
            ("dart", "common"), ("dart", "rpc_serializers_generator"),
        ])


if __name__ == "__main__":
    unittest.main()
