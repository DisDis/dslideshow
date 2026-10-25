"""Exercise renderer selection without starting an engine or touching services."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


class LauncherRendererTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        shutil.copy2(Path(__file__).resolve().parents[1] / 'run.sh', self.root / 'run.sh')
        (self.root / 'bundle/assets').mkdir(parents=True)
        (self.root / 'bundle/app.so').touch()
        (self.root / 'bundle/assets/build-info.json').write_text(json.dumps({'mode': 'release'}))
        (self.root / 'tool').mkdir()
        # Aggregation/resume have their own tests; here a fake engine records
        # exactly which renderer processes the real launcher would start.
        (self.root / 'tool/collect_reports.py').write_text('')
        (self.root / 'tool/resume_plan.py').write_text("print('done')\n")
        runtime = self.root / 'fake-flutter-pi'
        runtime.write_text('''#!/usr/bin/env bash
set -eu
if [[ "$1" == --help ]]; then exit 0; fi
printf '%s\\n' "$BENCHMARK_RENDERER" >> "$RENDERER_RECORD"
''')
        runtime.chmod(0o755)
        self.environment = dict(os.environ)
        for name in list(self.environment):
            if name.startswith('BENCHMARK_') or name == 'FLUTTER_PI':
                del self.environment[name]
        self.environment.update(
            FLUTTER_PI=str(runtime),
            XDG_RUNTIME_DIR=str(self.root),
            RENDERER_RECORD=str(self.root / 'renderers.txt'),
        )

    def launch(self, *arguments, renderer_environment=None):
        if renderer_environment is not None:
            self.environment['BENCHMARK_RENDERERS'] = renderer_environment
        result = subprocess.run(
            ['bash', str(self.root / 'run.sh'), '--suite', 'smoke', *arguments],
            cwd=self.root, env=self.environment, text=True,
            capture_output=True, timeout=20,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        return (self.root / 'renderers.txt').read_text().splitlines()

    def test_default_starts_only_opengl(self):
        self.assertEqual(self.launch(), ['opengl'])
        collection = next(p for p in (self.root / 'reports').glob('*smoke-*') if p.is_dir())
        self.assertFalse((collection / 'vulkan').exists())

    def test_both_renderers_require_explicit_selection(self):
        self.assertEqual(self.launch('--renderers', 'both'), ['opengl', 'vulkan'])

    def test_explicit_environment_can_select_future_vulkan_runtime(self):
        self.assertEqual(self.launch(renderer_environment='vulkan'), ['vulkan'])

    def test_cli_overrides_environment(self):
        self.assertEqual(
            self.launch('--renderers', 'opengl', renderer_environment='both'),
            ['opengl'],
        )


if __name__ == '__main__':
    unittest.main()
