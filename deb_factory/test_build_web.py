"""Check Wasm build arguments and dependency preparation without Flutter."""

import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


BUILD_WEB = Path(__file__).resolve().parent.parent / "config_app/build_web.sh"


class WebBuildTest(unittest.TestCase):
    def run_fixture(self, arguments=(), fail_pub=False):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            log = root / "commands.jsonl"
            flutter = root / "flutter"
            flutter.write_text(
                f"#!{sys.executable}\n"
                "import json, os, sys\n"
                "with open(os.environ['WEB_BUILD_LOG'], 'a') as log:\n"
                "    log.write(json.dumps(sys.argv[1:]) + '\\n')\n"
                "if sys.argv[1:3] == ['pub', 'get'] and os.environ['WEB_BUILD_FAIL_PUB'] == '1':\n"
                "    sys.exit(7)\n"
            )
            flutter.chmod(0o755)
            result = subprocess.run(
                [str(BUILD_WEB), *arguments], cwd=root,
                env=dict(os.environ, PATH=f"{root}{os.pathsep}{os.environ['PATH']}",
                         WEB_BUILD_LOG=str(log), WEB_BUILD_FAIL_PUB="1" if fail_pub else "0"),
                capture_output=True, text=True, timeout=10,
            )
            return result, [json.loads(line) for line in log.read_text().splitlines()]

    def test_default_prepares_dependencies_once_before_build(self):
        result, commands = self.run_fixture()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(commands, [
            ["pub", "get"],
            ["build", "web", "--release", "--no-pub", "--no-web-resources-cdn", "--wasm"],
        ])

    def test_parallel_mode_builds_without_changing_dependencies(self):
        result, commands = self.run_fixture(("--no-pub", "--dart-define=EXAMPLE=value"))
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(commands, [[
            "build", "web", "--release", "--no-pub", "--no-web-resources-cdn", "--wasm",
            "--dart-define=EXAMPLE=value",
        ]])

    def test_dependency_failure_prevents_compilation(self):
        result, commands = self.run_fixture(fail_pub=True)
        self.assertEqual(result.returncode, 7)
        self.assertEqual(commands, [["pub", "get"]])


if __name__ == "__main__":
    unittest.main()
