import hashlib
import json
import os
from pathlib import Path
import subprocess
import tarfile
import tempfile
import unittest

from collect_reports import collect, render
from resume_plan import checkpoint

APP = Path(__file__).resolve().parents[1]


class ReportTests(unittest.TestCase):
    def test_vulkan_video_cli_reaches_runtime_as_explicit_policy(self):
        with tempfile.TemporaryDirectory() as temporary:
            root=Path(temporary);bundle=root/'bundle';bundle.mkdir();(bundle/'app.so').touch()
            runtime=root/'runtime'
            runtime.write_text("""#!/usr/bin/env python3
import os,sys,pathlib,json
if '--help' in sys.argv:sys.exit(0)
p=pathlib.Path(os.environ['BENCHMARK_OUTPUT'])
(p/'policy.txt').write_text(os.environ.get('BENCHMARK_VULKAN_VIDEO','default-false'))
(p/'summary.json').write_text(json.dumps(dict(status='completed',expected_cases=1,observed_cases=1,metadata={},cases=[])))
""")
            runtime.chmod(0o755)
            for index,(flags,expected) in enumerate([([], 'default-false'),(['--vulkan-video'],'true'),(['--vulkan-video','--no-vulkan-video'],'false')]):
                output=root/f'reports-{index}'
                env={**os.environ,'XDG_RUNTIME_DIR':str(root)}
                env.pop('BENCHMARK_VULKAN_VIDEO',None)
                run=subprocess.run(['bash',str(APP/'run.sh'),'--renderers','vulkan','--suite','smoke',
                    '--bundle',str(bundle),'--flutter-pi',str(runtime),'--output',str(output),*flags],capture_output=True,text=True,timeout=20,env=env)
                self.assertEqual(run.returncode,0,run.stdout+run.stderr)
                self.assertEqual(next(output.glob('*/vulkan/attempt-001/policy.txt')).read_text(),expected)

    def test_unverified_visual_capture_is_not_successful_acceptance(self):
        with tempfile.TemporaryDirectory() as temporary:
            root=Path(temporary);renderer=root/'vulkan';attempt=renderer/'attempt-001';(attempt/'audit').mkdir(parents=True)
            plan=[dict(id='photo',effect='Fade',media='photo-photo')]
            (attempt/'summary.json').write_text(json.dumps(dict(status='completed',expected_cases=1,observed_cases=1,
                metadata=dict(plan=plan,executed_case_ids=['photo'],config=dict(visual_audit=True)),
                cases=[dict(id='photo',failed=0,passed=1,runs=1)])))
            (attempt/'launcher-status.json').write_text('{"exit_code":0}')
            (attempt/'audit/photo.json').write_text(json.dumps(dict(case=plan[0],status='unverified_capture')))
            checkpoint(renderer,attempt,0)
            result=collect(root)['renderers']['vulkan']
            self.assertEqual(result['visual_verification'],'unverified_capture')
            self.assertFalse(result['successful'])
            self.assertTrue(result['complete'])
            self.assertEqual(result['status'],'completed_with_unverified_visuals')

    def test_raw_repeats_after_checkpoint_survive_native_crash(self):
        with tempfile.TemporaryDirectory() as temporary:
            root=Path(temporary);renderer=root/'opengl';attempt=renderer/'attempt-001'
            attempt.mkdir(parents=True)
            plan=[dict(id='Cube--video-video',effect='Cube',media='video-video')]
            (attempt/'summary.json').write_text(json.dumps(dict(status='running',metadata=dict(plan=plan),cases=[])))
            (attempt/'active-case.json').write_text(json.dumps(dict(id=plan[0]['id'])))
            (attempt/'launcher-status.json').write_text('{"exit_code":139}')
            samples=[dict(case_id=plan[0]['id'],case=plan[0],phase='measured',repeat=i,status='passed',
                          frames=100,actual_ms=2000+i,raster_ms=dict(p95=20+i)) for i in range(2)]
            (attempt/'runs.jsonl').write_text(''.join(json.dumps(s)+'\n' for s in samples)+'{"truncated":')
            checkpoint(renderer,attempt,139)
            result=collect(root)['renderers']['opengl'];row=result['cases'][0]
            self.assertEqual(row['passed'],2)
            self.assertEqual(row['frames'],200)
            self.assertEqual(row['actual_mean_ms'],2000.5)
            self.assertEqual(row['native_failures'],1)
            self.assertEqual(result['measured_runs'],2)
            self.assertFalse(result['successful'])
            self.assertTrue(result['warnings'])

    def test_unsupported_cases_and_late_runtime_errors_are_separate(self):
        with tempfile.TemporaryDirectory() as temporary:
            root=Path(temporary);renderer=root/'vulkan';attempt=renderer/'attempt-001'
            attempt.mkdir(parents=True)
            plan=[dict(id='photo',effect='Fade',media='photo-photo'),dict(id='video',effect='Fade',media='video-video')]
            meta=dict(plan=plan,executed_case_ids=['photo'],unsupported_case_ids=['video'])
            (attempt/'summary.json').write_text(json.dumps(dict(status='completed',metadata=meta,cases=[dict(id='photo',passed=1,runs=1,failed=0)])))
            (attempt/'launcher-status.json').write_text('{"exit_code":0}')
            (attempt/'errors.jsonl').write_text(json.dumps(dict(case_id='photo',kind='runtime',stage='cleanup',error='late cancel'))+'\n')
            checkpoint(renderer,attempt,0)
            result=collect(root)['renderers']['vulkan']
            self.assertEqual(result['unsupported_cases'],1)
            self.assertEqual(result['supported_cases'],1)
            self.assertEqual(result['failed_runs'],0)
            self.assertEqual(result['error_counts'],{'runtime':1})
            self.assertEqual(result['status'],'completed_with_failures')
            self.assertTrue(result['all_supported_cases_attempted'])
            self.assertFalse(result['all_cases_attempted'])
            self.assertFalse(result['successful'])
            self.assertTrue(next(r for r in result['cases'] if r['id']=='photo')['has_errors'])
            self.assertEqual(next(r for r in result['cases'] if r['id']=='video')['status'],'unsupported')

    def test_resume_advances_past_native_failure_and_preserves_its_metrics(self):
        with tempfile.TemporaryDirectory() as temporary:
            renderer = Path(temporary) / 'opengl'
            first = renderer / 'attempt-001'
            first.mkdir(parents=True)
            plan = [dict(id=name, effect=name, media='video-video') for name in ['a','b','c']]
            (first / 'summary.json').write_text(json.dumps(dict(status='running',
                metadata=dict(plan=plan,executed_case_ids=['a','b','c']),
                cases=[dict(id='a',runs=1,failed=0,passed=1,frames=50),
                       dict(id='b',runs=1,failed=0,passed=1,frames=50)])))
            (first / 'native.log').write_text('BENCHMARK_CASE a cycle=0\nBENCHMARK_CASE b cycle=0\n')
            (first / 'launcher-status.json').write_text('{"exit_code":139}')
            self.assertTrue(checkpoint(renderer, first, 139))
            self.assertEqual(json.loads((renderer / 'skip.json').read_text()), ['a','b'])
            second = renderer / 'attempt-002'
            second.mkdir()
            (second / 'summary.json').write_text(json.dumps(dict(status='completed',
                metadata=dict(plan=plan,executed_case_ids=['c']),
                cases=[dict(id='c',runs=1,failed=0,passed=1,frames=50)])))
            (second / 'launcher-status.json').write_text('{"exit_code":0}')
            self.assertFalse(checkpoint(renderer, second, 0))
            result = collect(Path(temporary))['renderers']['opengl']
            self.assertEqual(result['observed_cases'], 3)
            self.assertEqual(result['native_crashes'], 1)
            self.assertEqual(result['failed_runs'], 1)
            self.assertTrue(result['all_cases_attempted'])
            self.assertFalse(result['complete'])
            failed = next(row for row in result['cases'] if row['id']=='b')
            self.assertEqual(failed['frames'], 50)
            self.assertEqual(failed['native_failures'], 1)

    def test_failed_or_partial_backend_is_not_reported_as_complete(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            for renderer, code, status in [("opengl", 0, "completed"), ("vulkan", 139, "running")]:
                directory = root / renderer
                directory.mkdir()
                (directory / "summary.json").write_text(json.dumps(dict(status=status,
                    expected_cases=5, observed_cases=5, metadata={}, cases=[])))
                (directory / "launcher-status.json").write_text(json.dumps(dict(exit_code=code)))
            result = collect(root)
            self.assertTrue(result["renderers"]["opengl"]["complete"])
            self.assertFalse(result["renderers"]["vulkan"]["complete"])
            self.assertFalse(result["performance_comparable"])

    def test_matching_conditions_and_missing_metrics(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            for renderer in ("opengl", "vulkan"):
                directory = root / renderer
                directory.mkdir()
                (directory / "launch.json").write_text(json.dumps(dict(flutter_pi_sha256="same")))
                (directory / "summary.json").write_text(json.dumps(dict(status="completed", metadata={
                    key: {"same": True} for key in ("display", "config", "media", "build")},
                    cases=[dict(id="<unsafe>", raster_p95_mean_ms=None, failed=0)])))
            result = collect(root)
            self.assertTrue(result["performance_comparable"])
            self.assertIsNone(result["comparison"][0]["vulkan_over_opengl_raster_ratio"])
            document = render(result)
            self.assertIn("&lt;unsafe&gt;", document)
            self.assertNotIn("<unsafe>", document)

    def test_ssh_launcher_automatically_runs_both_and_archives_native_crash(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            bundle = root / "bundle with spaces"
            bundle.mkdir()
            (bundle / "app.so").touch()
            runtime = root / "fake-flutter-pi"
            runtime.write_text('''#!/usr/bin/env python3
import json, os, pathlib, sys
if '--help' in sys.argv:
    print('fake flutter-pi --vulkan'); sys.exit(0)
output = pathlib.Path(os.environ['BENCHMARK_OUTPUT'])
renderer = os.environ['BENCHMARK_RENDERER']
print('launch renderer=' + renderer, flush=True)
if renderer == 'vulkan':
    print('native video texture failure', flush=True); sys.exit(42)
(output / 'summary.json').write_text(json.dumps(dict(status='completed',
    expected_cases=1, observed_cases=1, failed_runs=0, metadata={}, cases=[])))
''')
            runtime.chmod(0o755)
            process = subprocess.run(["bash", str(APP / "run.sh"), "--suite", "smoke",
                "--flutter-pi", str(runtime), "--bundle", str(bundle),
                "--output", str(root / "reports")], text=True, capture_output=True, timeout=20,
                env={**os.environ, "XDG_RUNTIME_DIR":str(root)})
            self.assertEqual(process.returncode, 2, process.stdout + process.stderr)
            archives = list((root / "reports").glob("*.tar.gz"))
            self.assertEqual(len(archives), 1)
            with tarfile.open(archives[0]) as archive:
                names = archive.getnames()
                self.assertTrue(any(n.endswith("/opengl/attempt-001/native.log") for n in names))
                self.assertTrue(any(n.endswith("/vulkan/attempt-001/native.log") for n in names))
                name = next(n for n in names if n.endswith("/vulkan/attempt-001/launcher-status.json"))
                status = json.load(archive.extractfile(name))
                self.assertEqual(status["exit_code"], 42)
                name = next(n for n in names if n.endswith("/collection-summary.json"))
                report = json.load(archive.extractfile(name))
                self.assertTrue(report["renderers"]["opengl"]["complete"])
                self.assertFalse(report["renderers"]["vulkan"]["complete"])

    def test_fixture_checksums_and_actual_image_dimensions(self):
        # Pillow is only needed when regenerating fixtures; validate dimensions
        # here when the developer environment has it, not on the Raspberry Pi.
        from PIL import Image
        manifest = json.loads((APP / "assets/media/manifest.json").read_text())
        for entry in manifest["files"]:
            file = APP / "assets/media" / entry["name"]
            self.assertEqual(hashlib.sha256(file.read_bytes()).hexdigest(), entry["sha256"])
            self.assertEqual(file.stat().st_size, entry["bytes"])
            if entry["kind"] != "video":
                with Image.open(file) as image:
                    self.assertEqual(image.size, (entry["width"], entry["height"]))


if __name__ == "__main__":
    unittest.main()
