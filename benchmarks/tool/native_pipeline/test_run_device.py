"""Exercise the actual orchestration shell with host-only replacement tools."""
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


_RUNNER = Path(__file__).with_name('run-device.sh')


def _script(path, source):
    path.write_text(f'#!{sys.executable}\n'+source)
    path.chmod(0o700)


class RunDeviceTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.tools = self.root/'tools'
        self.tools.mkdir()
        self.runner = self.tools/'run-device.sh'
        shutil.copyfile(_RUNNER,self.runner)
        self.benchmark = self.root/'benchmark'
        self.benchmark.mkdir()
        self.experiment = self.root/'experiment'
        (self.experiment/'config').mkdir(parents=True)
        (self.experiment/'config/native-pipeline-photo.json').write_text('{}')
        self.bundle = self.root/'bundle'
        self.bundle.mkdir()
        (self.bundle/'app.so').write_bytes(b'frozen app')
        (self.bundle/'libflutter_engine.so').write_bytes(b'frozen engine')
        self.runtime = self.root/'runtime'
        self.runtime.write_bytes(b'frozen runtime')
        self.runtime.chmod(0o700)
        (self.benchmark/'run.sh').write_text('# unused host fixture\n')
        (self.tools/'libnative_pipeline.so').write_bytes(b'host mock library')
        (self.tools/'runtime-wrapper.sh').write_text('# unused host fixture\n')
        (self.tools/'runtime-wrapper.sh').chmod(0o700)
        self.log = self.root/'events.jsonl'
        _script(self.benchmark/'run-managed.sh', r'''
import json,os,sys
from pathlib import Path
with Path(os.environ['MOCK_LOG']).open('a') as stream:
    stream.write(json.dumps(['managed',sys.argv[1:]])+'\n')
output=Path(sys.argv[sys.argv.index('--output')+1])
for index in range(int(os.environ['MOCK_CAPTURES'])):
    attempt=output/f'new-{index}'/'opengl'/'attempt-001'
    attempt.mkdir(parents=True)
    (attempt/'native-pipeline.bin').write_bytes(b'new raw capture')
raise SystemExit(int(os.environ['MOCK_MANAGED_EXIT']))
''')
        _script(self.tools/'trace_instance.py', r'''
import json,os,sys
from pathlib import Path
action,name,output=sys.argv[1:]
if action=='init':
    Path(output).mkdir()
with Path(os.environ['MOCK_LOG']).open('a') as stream:
    stream.write(json.dumps(['trace',action,name,output])+'\n')
''')
        _script(self.tools/'finalize_capture.py', r'''
import json,os,sys
from pathlib import Path
with Path(os.environ['MOCK_LOG']).open('a') as stream:
    stream.write(json.dumps(['finalize',sys.argv[1]])+'\n')
if int(os.environ['MOCK_FINALIZER_EXIT'])==0:
    (Path(sys.argv[1])/'native-pipeline-finalization.json').write_text('{}')
raise SystemExit(int(os.environ['MOCK_FINALIZER_EXIT']))
''')
        binaries = self.root/'bin'
        binaries.mkdir()
        _script(binaries/'sudo', '''
import os,sys
assert sys.argv[1]=='-n'
os.execvp(sys.argv[2],sys.argv[2:])
''')
        self.env = dict(os.environ,
            PATH=str(binaries)+os.pathsep+os.environ['PATH'],
            BENCH_NATIVE_PIPELINE_RUNTIME=str(self.runtime),
            BENCH_NATIVE_PIPELINE_RUNTIME_SHA256=hashlib.sha256(self.runtime.read_bytes()).hexdigest(),
            BENCH_NATIVE_PIPELINE_ENGINE_SHA256=hashlib.sha256((self.bundle/'libflutter_engine.so').read_bytes()).hexdigest(),
            MOCK_LOG=str(self.log),MOCK_CAPTURES='1',MOCK_MANAGED_EXIT='0',MOCK_FINALIZER_EXIT='0',
            PYTHONDONTWRITEBYTECODE='1')

    def run_device(self,mode='diagnostic',**environment):
        result = subprocess.run(['bash',str(self.runner),mode,str(self.benchmark),
            str(self.experiment),str(self.bundle),'host-job'],
            env=dict(self.env,**environment),capture_output=True,text=True,timeout=10)
        events = [json.loads(line) for line in self.log.read_text().splitlines()] if self.log.exists() else []
        return result,events

    def test_success_finalizes_only_new_capture_after_managed_then_closes_trace(self):
        old = self.experiment/'reports/old/opengl/attempt-001'
        old.mkdir(parents=True)
        (old/'native-pipeline.bin').write_bytes(b'previous raw capture')
        result,events = self.run_device()
        self.assertEqual(result.returncode,0,result.stderr)
        self.assertEqual([(event[0],event[1] if event[0]=='trace' else None) for event in events],
                         [('trace','init'),('trace','start'),('managed',None),
                          ('finalize',None),('trace','stop'),('trace','close')])
        arguments = next(event[1] for event in events if event[0]=='managed')
        self.assertEqual(arguments[arguments.index('--flutter-pi')+1],
                         str(self.tools/'runtime-wrapper.sh'))
        finalized = Path(next(event[1] for event in events if event[0]=='finalize'))
        self.assertEqual(finalized,self.experiment/'reports/new-0/opengl/attempt-001')
        self.assertTrue((finalized/'native-pipeline-finalization.json').exists())
        self.assertFalse((old/'native-pipeline-finalization.json').exists())
        self.assertEqual((self.experiment/'host-job-exit-code').read_text(),'0\n')

    def test_managed_failure_preserves_exit_and_skips_finalizer_but_closes_trace(self):
        result,events = self.run_device(MOCK_MANAGED_EXIT='7')
        self.assertEqual(result.returncode,7,result.stderr)
        self.assertFalse(any(event[0]=='finalize' for event in events))
        self.assertEqual([event[1] for event in events if event[0]=='trace'],['init','start','stop','close'])
        self.assertEqual((self.experiment/'host-job-exit-code').read_text(),'7\n')

    def test_finalizer_failure_remains_failure_and_trace_is_closed(self):
        result,events = self.run_device(MOCK_FINALIZER_EXIT='5')
        self.assertNotEqual(result.returncode,0)
        self.assertTrue(any(event[0]=='finalize' for event in events))
        self.assertEqual([event[1] for event in events if event[0]=='trace'],['init','start','stop','close'])
        self.assertNotEqual((self.experiment/'host-job-exit-code').read_text(),'0\n')

    def test_missing_or_ambiguous_capture_does_not_choose_an_arbitrary_attempt(self):
        for count in ('0','2'):
            with self.subTest(count=count):
                # Each run owns a new experiment/job, just as on the device.
                with tempfile.TemporaryDirectory(dir=self.root) as directory:
                    experiment=Path(directory)
                    (experiment/'config').mkdir()
                    (experiment/'config/native-pipeline-photo.json').write_text('{}')
                    saved=self.experiment
                    self.experiment=experiment
                    self.log.unlink(missing_ok=True)
                    try:
                        result,events=self.run_device(MOCK_CAPTURES=count)
                    finally:
                        self.experiment=saved
                    self.assertNotEqual(result.returncode,0)
                    self.assertIn('Expected exactly one new native capture',result.stderr)
                    self.assertFalse(any(event[0]=='finalize' for event in events))
                    self.assertEqual(len(list(experiment.glob('reports/*/opengl/attempt-001/native-pipeline.bin'))),int(count))
                    self.assertEqual([event[1] for event in events if event[0]=='trace'],['init','start','stop','close'])

    def test_control_does_not_start_trace_or_finalize(self):
        result,events = self.run_device(mode='control',MOCK_CAPTURES='0')
        self.assertEqual(result.returncode,0,result.stderr)
        self.assertEqual([event[0] for event in events],['managed'])
        arguments = events[0][1]
        self.assertEqual(arguments[arguments.index('--flutter-pi')+1],str(self.runtime))
        self.assertFalse(list(self.experiment.glob('trace-*')))

    def test_wrong_frozen_runtime_is_rejected_before_managed_or_trace(self):
        result,events = self.run_device(BENCH_NATIVE_PIPELINE_RUNTIME_SHA256='0'*64)
        self.assertNotEqual(result.returncode,0)
        self.assertIn('Actual runtime differs from pinned runtime',result.stderr)
        self.assertEqual(events,[])


if __name__ == '__main__':
    unittest.main()
