import contextlib
import hashlib
import io
import json
from pathlib import Path
import struct
import tempfile
import unittest

import analyze as tool


HEADER = struct.Struct('<8s8I6Q2I4Q')
RECORD = struct.Struct('<IHH5QIiq6QIIQ')
NS = 1000000000


def write_json(path, value):
    path.write_text(json.dumps(value)+'\n')


def write_jsonl(path, rows):
    path.write_text(''.join(json.dumps(row)+'\n' for row in rows))


def native_file(path, calls=None, **changes):
    calls = calls if calls is not None else [dict(start=2100000000,end=2300000000,cpu=1000000)]
    values = dict(magic=b'NPIPV001',version=1,endian=0x01020304,header_size=128,
                  record_size=128,capacity=max(4,len(calls)),pid=123,flags=3,init_errno=0,
                  reserved=len(calls),committed=sum(call.get('committed',1)==1 for call in calls),
                  dropped=0,started=NS,realtime=1700000000*NS,closed=10*NS,
                  lifecycle=2,clock_errors=0)
    values.update(changes)
    data = HEADER.pack(*[values[k] for k in ('magic','version','endian','header_size',
        'record_size','capacity','pid','flags','init_errno','reserved','committed',
        'dropped','started','realtime','closed','lifecycle','clock_errors')],0,0,0,0)
    for index, call in enumerate(calls):
        start,end=call.get('start',2100000000),call.get('end',2300000000)
        data += RECORD.pack(call.get('committed',1),call.get('function',1),call.get('depth',0),
            call.get('sequence',index+1),start,end,100000,100000+call.get('cpu',1000),
            call.get('tid',123),call.get('errno',0),call.get('result',1),
            *call.get('args',[0,0,0,0,0,0]),call.get('entry_errno',0),0,0)
    data += bytes(max(0,values['capacity']-len(calls))*128)
    path.write_bytes(data)
    return path


def line(timestamp,event,data):
    return f'worker-123 [001] .... {timestamp/NS:.9f}: {event}: {data}\n'


def trace(directory, jobs=None, extra=None):
    directory.mkdir()
    events={name:dict(available=True,selected=True,format='field: dev; field: seqno;') for name in [
      'v3d/v3d_submit_cl','v3d/v3d_rcl_irq','drm/drm_vblank_event_queued','drm/drm_vblank_event_delivered']}
    write_json(directory/'trace-provenance.json',dict(schema_version=1,status='closed',
        trace_clock='mono',started=dict(monotonic_ns=NS),stopped=dict(monotonic_ns=10*NS),
        events=events,missing_required=[],initial_cpus=['cpu0']))
    write_json(directory/'trace-stats.json',dict(schema_version=1,stats_complete=True,
        loss_detected=False,missing_cpus=[],per_cpu={'cpu0':{'raw':'saved stats',
        'counters':dict(overrun=0,commit_overrun=0,dropped_events=0)}}))
    rows=[]
    for seq,start,end in jobs if jobs is not None else [(1,2100000000,2700000000),(2,2500000000,3200000000)]:
        rows += [line(start,'v3d_submit_cl',f'dev=0, seqno={seq}, type=RCL'),
                 line(end,'v3d_rcl_irq',f'dev=0, seqno={seq}')]
    for index,timestamp in enumerate([2200000000,2400000000,2800000000]):
        rows.append(line(timestamp,'drm_vblank_event_delivered',f'file=0x123, crtc=0, seq={index}'))
    rows += extra or []
    (directory/'trace.txt').write_text(''.join(rows))
    return directory


def attempt(directory, extra_cases=None, warmup=False):
    directory.mkdir()
    cases=[('Glass',tool.Phase.MEASURED.value,0,2000000,2900000)]
    if warmup: cases.insert(0,('Glass',tool.Phase.WARMUP.value,-1,1200000,1700000))
    cases += extra_cases or []
    frames,runs=[],[]
    for name,phase,repeat,start,last in cases:
        common=dict(case_id=name,phase=phase,cycle=0,repeat=repeat)
        frames += [dict(common,vsync_us=start,total_us=100000,build_us=100,raster_us=500),
                   dict(common,vsync_us=last,total_us=100000,build_us=300,raster_us=900)]
        runs.append(dict(common,status='passed',error=None,frames=2,actual_ms=(last+100000-start)/1000))
    write_jsonl(directory/'frames.jsonl',frames)
    write_jsonl(directory/'runs.jsonl',runs)
    write_jsonl(directory/'errors.jsonl',[])
    (directory/'native.log').write_text('BENCHMARK_CASE Glass\n')
    plan=[dict(id=name) for name in sorted({case[0] for case in cases})]
    write_json(directory/'summary.json',dict(status='completed',metadata=dict(
        config=dict(repeats=1,warmups=1 if warmup else 0),cycles=1,plan=plan)))
    return directory


class AnalysisTest(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root=Path(self.tmp.name)
        self.native=native_file(self.root/'calls.bin')
        self.trace=trace(self.root/'trace')
        self.attempt=attempt(self.root/'attempt')

    def result(self,include=False):
        return tool.analyze(self.attempt,self.native,self.trace,include)

    def edit(self,path,callback):
        data=json.loads(path.read_text());callback(data);write_json(path,data)

    def external_proof(self):
        native_file(self.native,lifecycle=1,closed=0)
        write_json(self.attempt/'native-pipeline-provenance.json',dict(schema_version=1,
            kind='native_pipeline_loaded_engine',status='verified',pid=123,
            process_start_ticks=42,engine=dict(path='/bundle/libflutter_engine.so',sha256='c'*64),
            captured_monotonic_ns=1500000000,timing_results_valid=False))
        write_json(self.attempt/'launcher-status.json',dict(exit_code=0,finished_utc='2026-10-28T10:00:00Z'))
        proof=dict(schema_version=1,kind='native_pipeline_external_finalization',status='verified',
            pid=123,process_start_ticks=42,process_absent=True,hash_stable=True,
            validated_at_monotonic_ns=9*NS,timing_results_valid=False,
            native_capture=dict(sha256=hashlib.sha256(self.native.read_bytes()).hexdigest(),
                                size_bytes=self.native.stat().st_size),
            engine_provenance_sha256=hashlib.sha256((self.attempt/'native-pipeline-provenance.json').read_bytes()).hexdigest(),
            launcher_status=dict(file='launcher-status.json',exit_code=0,
                sha256=hashlib.sha256((self.attempt/'launcher-status.json').read_bytes()).hexdigest()))
        write_json(self.attempt/'native-pipeline-finalization.json',proof)
        return self.attempt/'native-pipeline-finalization.json'

    def finalized_result(self):
        return tool.analyze(self.attempt,self.native,self.trace,expected_engine='c'*64)

    def test_union_clips_overlap_and_never_sums_parallel_gpu_intervals(self):
        result=self.result()
        self.assertTrue(result['correlation_complete'])
        row=result['cases'][0]
        self.assertEqual(row['start_ns'],2*NS)
        self.assertEqual(row['end_ns'],3*NS)
        self.assertEqual(row['gpu']['observed_elapsed_union_ms'],900)
        self.assertEqual(row['gpu']['coverage_percent'],90)
        self.assertEqual(row['gpu']['boundary_partial_jobs'],1)
        self.assertEqual(row['gpu']['full_job_elapsed_ms']['count'],1)
        self.assertEqual(row['native']['eglSwapBuffers']['wall_ms']['p95'],200)
        self.assertEqual(row['native']['eglSwapBuffers']['thread_cpu_ms']['p95'],1)
        self.assertIn('not exclusive GPU shader time',' '.join(result['notes']))

    def test_out_of_order_events_pair_by_full_device_sequence_type(self):
        original=self.result()['cases'][0]['gpu']
        path=self.trace/'trace.txt'; path.write_text(''.join(reversed(path.read_text().splitlines(keepends=True))))
        result=self.result()
        self.assertTrue(result['correlation_complete'])
        self.assertEqual(result['cases'][0]['gpu'],original)

    def test_actual_kernel_bare_rcl_format_is_parsed_without_inventing_type_field(self):
        path=self.trace/'trace.txt'
        path.write_text(path.read_text().replace('type=RCL','RCL, 0x00000001..0x00000002'))
        result=self.result()
        self.assertTrue(result['correlation_complete'])
        self.assertEqual(result['cases'][0]['gpu']['coverage_percent'],90)

    def test_optional_ioctl_event_is_not_counted_as_a_second_scheduler_submission(self):
        self.edit(self.trace/'trace-provenance.json',lambda d:d['events'].update({
            'v3d/v3d_submit_cl_ioctl':dict(available=True,selected=True,format='ioctl fields')}))
        with (self.trace/'trace.txt').open('a') as f:
            f.write(line(2050000000,'v3d_submit_cl_ioctl','dev=0, bo_count=2'))
        result=self.result()
        self.assertTrue(result['correlation_complete'])
        self.assertEqual(result['kernel_trace']['event_counts']['v3d_submit_cl_ioctl'],1)
        self.assertEqual(len(result['kernel_trace']['jobs']),2)

    def test_missing_irq_retains_known_lower_bound_but_prevents_coverage_claim(self):
        path=self.trace/'trace.txt'
        path.write_text(''.join(l for l in path.read_text().splitlines(keepends=True) if not('v3d_rcl_irq' in l and 'seqno=2' in l)))
        result=self.result();row=result['cases'][0]
        self.assertFalse(result['correlation_complete'])
        self.assertEqual(row['gpu']['observed_elapsed_union_ms'],600)
        self.assertIsNone(row['gpu']['coverage_percent'])
        self.assertIsNone(row['gpu']['by_device']['0']['coverage_percent'])
        self.assertEqual(result['kernel_trace']['unmatched'][0]['seqno'],2)

    def test_duplicate_submit_does_not_choose_an_arbitrary_irq_pair(self):
        with (self.trace/'trace.txt').open('a') as f:
            f.write(line(2150000000,'v3d_submit_cl','dev=0, seqno=1, type=RCL'))
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertEqual(len(result['kernel_trace']['jobs']),1)
        self.assertEqual(len(result['kernel_trace']['unmatched'][0]['submits']),2)

    def test_irq_without_identity_is_not_assigned_fifo(self):
        path=self.trace/'trace.txt';path.write_text(path.read_text().replace('v3d_rcl_irq: dev=0, seqno=1','v3d_rcl_irq: dev=0'))
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertTrue(any('lacks dev/seqno' in d for d in result['kernel_trace']['diagnostics']))

    def test_single_pre_window_orphan_irq_preserves_raw_incompleteness_but_bounds_window(self):
        self.attempt=attempt(self.root/'pre-window',warmup=True)
        with (self.trace/'trace.txt').open('a') as f:
            f.write(line(1100000000,'v3d_rcl_irq','dev=0, seqno=99'))
        result=self.result()
        self.assertTrue(result['correlation_complete'])
        self.assertFalse(result['raw_kernel_trace_complete'])
        self.assertFalse(result['kernel_trace']['complete'])
        self.assertTrue(result['kernel_trace']['selected_windows_complete'])
        orphan=result['kernel_trace']['unmatched'][0]
        self.assertEqual(orphan['seqno'],99)
        self.assertTrue(orphan['outside_all_windows'])
        self.assertTrue(result['kernel_trace']['diagnostics'])
        self.assertTrue(result['kernel_trace']['warnings'])
        self.assertIn('Raw kernel trace complete: False',tool.render(result))

    def test_orphan_irq_during_omitted_warmup_cannot_be_declared_outside_scope(self):
        self.attempt=attempt(self.root/'warm-orphan',warmup=True)
        with (self.trace/'trace.txt').open('a') as f:
            f.write(line(1500000000,'v3d_rcl_irq','dev=0, seqno=99'))
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertFalse(result['kernel_trace']['selected_windows_complete'])
        self.assertIsNone(result['cases'][0]['gpu']['coverage_percent'])

    def test_orphan_at_window_boundary_or_inside_measurement_is_not_safely_bounded(self):
        original=(self.trace/'trace.txt').read_text()
        for timestamp in (2*NS,2200000000,9*NS):
            with self.subTest(timestamp=timestamp):
                (self.trace/'trace.txt').write_text(original+line(timestamp,'v3d_rcl_irq','dev=0, seqno=99'))
                result=self.result()
                self.assertFalse(result['correlation_complete'])
                self.assertIsNone(result['cases'][0]['gpu']['coverage_percent'])

    def test_pre_window_submit_with_unknown_end_cannot_be_bounded(self):
        with (self.trace/'trace.txt').open('a') as f:
            f.write(line(1100000000,'v3d_submit_cl','dev=0, seqno=99, type=RCL'))
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertFalse(result['kernel_trace']['unmatched'][0]['outside_all_windows'])

    def test_outside_orphan_does_not_hide_other_trace_errors_or_unknown_windows(self):
        with (self.trace/'trace.txt').open('a') as f:
            f.write(line(1100000000,'v3d_rcl_irq','dev=0, seqno=99'))
        self.edit(self.trace/'trace-stats.json',lambda d:d.update(loss_detected=True))
        self.assertFalse(self.result()['correlation_complete'])
        self.edit(self.trace/'trace-stats.json',lambda d:d.update(loss_detected=False))
        self.edit(self.attempt/'summary.json',lambda d:d['metadata']['config'].update(repeats=2))
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertFalse(result['kernel_trace']['unmatched'][0]['outside_all_windows'])

    def test_same_seqno_on_another_device_cannot_complete_this_job(self):
        path=self.trace/'trace.txt';path.write_text(path.read_text().replace('v3d_rcl_irq: dev=0, seqno=1','v3d_rcl_irq: dev=1, seqno=1'))
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertEqual(len(result['kernel_trace']['unmatched']),2)

    def test_trace_overrun_and_contradictory_loss_summary_are_invalid(self):
        self.edit(self.trace/'trace-stats.json',lambda d:d['per_cpu']['cpu0']['counters'].update(overrun=1))
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertTrue(any('nonzero' in d for d in result['kernel_trace']['diagnostics']))

    def test_missing_statistics_and_failed_then_closed_provenance_are_invalid(self):
        self.edit(self.trace/'trace-stats.json',lambda d:d.update(stats_complete=False,loss_detected=None))
        self.edit(self.trace/'trace-provenance.json',lambda d:d.update(error='capture failed',cleanup_errors=['cleanup failed']))
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertTrue(any('cleanup reports errors' in d for d in result['kernel_trace']['diagnostics']))

    def test_missing_cpu_cannot_be_hidden_by_complete_summary_flag(self):
        self.edit(self.trace/'trace-provenance.json',lambda d:d.update(initial_cpus=['cpu0','cpu1']))
        self.assertFalse(self.result()['correlation_complete'])

    def test_unknown_clock_never_falls_back_to_utc(self):
        self.edit(self.trace/'trace-provenance.json',lambda d:d.update(trace_clock='global'))
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertIsNone(result['cases'][0]['gpu']['coverage_percent'])

    def test_misaligned_native_clock_invalidates_correlation(self):
        native_file(self.native,started=4*NS,calls=[dict(start=5*NS,end=6*NS)])
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertTrue(any('outside native' in d for d in result['cases'][0]['issues']))

    def test_warmups_excluded_and_missing_expected_measurement_stays_explicit(self):
        self.attempt=attempt(self.root/'warm-attempt',warmup=True)
        result=self.result()
        self.assertEqual(len(result['cases']),1)
        self.assertEqual(result['omitted_warmup_windows'],1)
        self.assertEqual(len(self.result(True)['cases']),2)
        path=self.attempt/'runs.jsonl'
        rows=[json.loads(l) for l in path.read_text().splitlines()]
        write_jsonl(path,[r for r in rows if r['phase']=='warmup'])
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertIsNone(result['cases'][0]['run_status'])

    def test_failed_omitted_warmup_remains_an_explicit_error(self):
        self.attempt=attempt(self.root/'failed-warmup',warmup=True)
        path=self.attempt/'runs.jsonl'; rows=[json.loads(l) for l in path.read_text().splitlines()]
        rows[0]['error']='late warmup failure'
        write_jsonl(path,rows)
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertEqual(result['omitted_warmup_windows'],1)
        self.assertTrue(result['omitted_warmups'][0]['issues'])
        self.assertEqual(result['errors'][0]['phase'],'warmup')

    def test_missing_declared_repeat_does_not_turn_absence_into_zero(self):
        self.edit(self.attempt/'summary.json',lambda d:d['metadata']['config'].update(repeats=2))
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        missing=result['cases'][1]
        self.assertEqual(missing['repeat'],1)
        self.assertIsNone(missing['start_ns'])
        self.assertIsNone(missing['gpu'])

    def test_case_percentiles_pool_calls_not_percentiles_of_runs(self):
        self.attempt=attempt(self.root/'pooled',extra_cases=[('Glass','measured',1,4000000,4900000)])
        self.edit(self.attempt/'summary.json',lambda d:d['metadata']['config'].update(repeats=2))
        native_file(self.native,calls=[dict(start=2100000000,end=2101000000),
            dict(start=2200000000,end=2201000000),dict(start=4100000000,end=4200000000)])
        result=self.result()
        phase=result['case_summaries'][0]['native']['eglSwapBuffers']
        self.assertEqual(phase['wall_ms']['count'],3)
        self.assertAlmostEqual(phase['wall_ms']['p95'],90.1)
        self.assertNotEqual(phase['wall_ms']['p95'],50.5)

    def test_case_boundary_calls_clipped_without_inventing_partial_cpu_time(self):
        self.attempt=attempt(self.root/'two-cases',extra_cases=[('Fade','measured',0,3000000,3900000)])
        native_file(self.native,calls=[dict(start=2950000000,end=3050000000,cpu=1000)])
        result=self.result()
        self.assertTrue(result['correlation_complete'])
        for row in result['cases']:
            call=row['native']['eglSwapBuffers']
            self.assertEqual(call['boundary_partial_calls'],1)
            self.assertEqual(call['observed_clipped_wall_union_ms'],50)
            self.assertIsNone(call['thread_cpu_ms']['p95'])
            self.assertIsNone(call['wall_ms']['p95'])

    def test_nested_calls_are_not_aggregated_as_serial_wall_time(self):
        native_file(self.native,calls=[dict(start=2100000000,end=2400000000),
            dict(function=3,start=2200000000,end=2300000000,depth=1,result=0x1234)])
        row=self.result()['cases'][0]
        self.assertEqual(row['native']['eglSwapBuffers']['observed_clipped_wall_union_ms'],300)
        self.assertEqual(row['native']['gbm_surface_lock_front_buffer']['observed_clipped_wall_union_ms'],100)

    def test_successful_call_with_stale_errno_remains_successful_but_real_failure_preserved(self):
        native_file(self.native,calls=[dict(errno=22,result=1),dict(function=5,result=-1,errno=16)])
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertFalse(result['native_capture']['calls'][0]['failed'])
        self.assertEqual(result['errors'][0]['call']['result_errno'],16)

    def test_native_overflow_pending_and_clock_errors_do_not_disappear(self):
        native_file(self.native,calls=[dict(committed=0)],reserved=5,committed=0,dropped=1,clock_errors=1)
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        report=result['native_capture']
        self.assertEqual(report['header']['pending_count'],4)
        self.assertEqual(report['header']['dropped_count'],1)
        self.assertTrue(any('overflow' in d for d in report['diagnostics']))

    def test_abrupt_exit_keeps_committed_records_and_warning(self):
        native_file(self.native,lifecycle=1,closed=0)
        result=self.result()
        self.assertEqual(len(result['native_capture']['calls']),1)
        self.assertTrue(result['native_capture']['warnings'])
        self.assertFalse(result['native_capture']['complete'])
        self.assertFalse(result['correlation_complete'])

    def test_external_postexit_proof_restores_complete_span_without_rewriting_raw_header(self):
        self.external_proof()
        before=self.native.read_bytes()
        result=self.finalized_result()
        self.assertTrue(result['correlation_complete'])
        capture=result['native_capture']
        self.assertEqual(capture['closure'],'external_finalization')
        self.assertEqual(capture['effective_end_ns'],9*NS)
        self.assertEqual(capture['header']['lifecycle'],1)
        self.assertEqual(capture['header']['closed_monotonic_ns'],0)
        self.assertEqual(self.native.read_bytes(),before)
        self.assertTrue(any('no C destructor' in warning for warning in capture['warnings']))

    def test_external_proof_requires_expected_engine_and_exact_process_identity(self):
        proof=self.external_proof()
        self.assertFalse(self.result()['correlation_complete'])
        self.edit(proof,lambda d:d.update(process_start_ticks=43))
        result=self.finalized_result()
        self.assertFalse(result['correlation_complete'])
        self.assertIsNone(result['cases'][0]['gpu']['coverage_percent'])

    def test_external_proof_rejects_wrong_native_hash_or_size(self):
        for mutation in [dict(sha256='0'*64),dict(size_bytes=0)]:
            with self.subTest(mutation=mutation):
                proof=self.external_proof()
                self.edit(proof,lambda d:d['native_capture'].update(mutation))
                result=self.finalized_result()
                self.assertFalse(result['correlation_complete'])
                self.assertTrue(any('native capture SHA/size' in d for d in result['diagnostics']))

    def test_external_proof_rejects_launcher_hash_and_nonzero_actual_exit(self):
        proof=self.external_proof()
        self.edit(proof,lambda d:d['launcher_status'].update(sha256='0'*64))
        self.assertFalse(self.finalized_result()['correlation_complete'])
        proof=self.external_proof()
        self.edit(self.attempt/'launcher-status.json',lambda d:d.update(exit_code=139))
        self.edit(proof,lambda d:d['launcher_status'].update(sha256=hashlib.sha256(
            (self.attempt/'launcher-status.json').read_bytes()).hexdigest()))
        self.assertFalse(self.finalized_result()['correlation_complete'])

    def test_external_proof_rejects_alive_pid_and_missing_attestation(self):
        proof=self.external_proof()
        self.edit(proof,lambda d:d.update(process_absent=False))
        self.assertFalse(self.finalized_result()['correlation_complete'])
        proof.unlink()
        self.assertFalse(self.finalized_result()['correlation_complete'])

    def test_external_proof_rejects_changed_engine_proof_and_early_finalization(self):
        proof=self.external_proof()
        self.edit(proof,lambda d:d.update(engine_provenance_sha256='0'*64))
        self.assertFalse(self.finalized_result()['correlation_complete'])
        proof=self.external_proof()
        self.edit(proof,lambda d:d.update(validated_at_monotonic_ns=2200000000))
        self.assertFalse(self.finalized_result()['correlation_complete'])

    def test_external_proof_cannot_hide_pending_records_overflow_or_clock_errors(self):
        for changes in [dict(calls=[dict(committed=0)],committed=0),
                        dict(dropped=1),dict(clock_errors=1)]:
            with self.subTest(changes=changes):
                proof=self.external_proof()
                native_file(self.native,lifecycle=1,closed=0,**changes)
                self.edit(proof,lambda d:d['native_capture'].update(
                    sha256=hashlib.sha256(self.native.read_bytes()).hexdigest(),
                    size_bytes=self.native.stat().st_size))
                self.assertFalse(self.finalized_result()['correlation_complete'])

    def test_invalid_binary_endian_and_truncation_produce_diagnostics(self):
        for mutation in [lambda: native_file(self.native,endian=0x04030201),
                         lambda: self.native.write_bytes(b'NPIPV001')]:
            mutation()
            result=self.result()
            self.assertFalse(result['correlation_complete'])
            self.assertTrue(result['native_capture']['diagnostics'])

    def test_jsonl_corruption_preserves_later_records_and_is_not_ignored(self):
        path=self.attempt/'frames.jsonl';path.write_bytes(b'{bad\n'+path.read_bytes())
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertEqual(result['cases'][0]['frame_count'],2)
        self.assertTrue(any('frames.jsonl:1' in d for d in result['diagnostics']))

    def test_oversized_or_inconsistent_frame_times_are_diagnostics_not_crashes(self):
        path=self.attempt/'frames.jsonl';rows=[json.loads(l) for l in path.read_text().splitlines()]
        rows[0]['vsync_us']=10**500
        rows[1]['total_us']=1
        write_jsonl(path,rows)
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        self.assertIsNone(result['cases'][0]['start_ns'])

    def test_loaded_engine_requires_expected_sha_and_native_pid_when_requested(self):
        sha='c'*64
        provenance=dict(schema_version=1,kind='native_pipeline_loaded_engine',status='verified',pid=123,
            engine=dict(path='/bundle/libflutter_engine.so',sha256=sha,inode=42),
            captured_monotonic_ns=1500000000,timing_results_valid=False)
        write_json(self.attempt/'native-pipeline-provenance.json',provenance)
        result=tool.analyze(self.attempt,self.native,self.trace,expected_engine=sha)
        self.assertTrue(result['correlation_complete'])
        self.edit(self.attempt/'native-pipeline-provenance.json',lambda d:d.update(pid=124))
        result=tool.analyze(self.attempt,self.native,self.trace,expected_engine=sha)
        self.assertFalse(result['correlation_complete'])
        self.assertTrue(any('loaded engine' in d for d in result['diagnostics']))

    def test_unknown_loaded_engine_proof_schema_cannot_be_claimed_verified(self):
        self.external_proof()
        self.edit(self.attempt/'native-pipeline-provenance.json',lambda d:d.update(schema_version=2))
        result=self.finalized_result()
        self.assertFalse(result['loaded_engine']['validation_complete'])
        self.assertFalse(result['correlation_complete'])

    def test_missing_expected_engine_provenance_cannot_silently_pass(self):
        result=tool.analyze(self.attempt,self.native,self.trace,expected_engine='c'*64)
        self.assertFalse(result['correlation_complete'])

    def test_global_errors_disable_every_per_case_coverage_and_complete_flag(self):
        write_jsonl(self.attempt/'errors.jsonl',[dict(kind='runtime',error='decoder error')])
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        row=result['cases'][0]
        self.assertFalse(row['correlation_valid'])
        self.assertFalse(row['gpu']['complete'])
        self.assertIsNone(row['gpu']['coverage_percent'])
        self.assertEqual(row['gpu']['observed_elapsed_union_ms'],900)
        summary=result['case_summaries'][0]
        self.assertFalse(summary['correlation_complete'])
        self.assertIsNone(summary['rcl_coverage_percent'])

    def test_overlapping_case_windows_remain_observable_but_not_complete(self):
        self.attempt=attempt(self.root/'overlapping',extra_cases=[('Fade','measured',0,2500000,3400000)])
        result=self.result()
        self.assertFalse(result['correlation_complete'])
        for row in result['cases']:
            self.assertFalse(row['correlation_valid'])
            self.assertIsNone(row['gpu']['coverage_percent'])

    def test_bad_engine_identity_disables_per_case_coverage(self):
        result=tool.analyze(self.attempt,self.native,self.trace,expected_engine='c'*64)
        self.assertFalse(result['cases'][0]['correlation_valid'])
        self.assertIsNone(result['cases'][0]['gpu']['coverage_percent'])

    def test_no_trace_data_is_unknown_not_zero_gpu_coverage(self):
        (self.trace/'trace.txt').write_text('')
        row=self.result()['cases'][0]
        self.assertIsNone(row['gpu']['observed_elapsed_union_ms'])
        self.assertIsNone(row['gpu']['coverage_percent'])

    def test_drm_streams_do_not_mix_devices_or_case_boundaries(self):
        with (self.trace/'trace.txt').open('a') as f:
            f.write(line(2600000000,'drm_vblank_event_delivered','file=0x999, crtc=2, seq=1'))
        streams=self.result()['cases'][0]['drm']
        self.assertEqual(len(streams),2)
        self.assertEqual(streams[0]['gaps_ms']['p95'],390)
        self.assertIsNone(streams[1]['gaps_ms']['p95'])

    def test_cli_writes_reviewable_report_and_diagnostic_only_json(self):
        output=self.root/'output'
        with contextlib.redirect_stdout(io.StringIO()):
            code=tool.main([str(self.attempt),str(output),'--native',str(self.native),'--trace-dir',str(self.trace)])
        self.assertEqual(code,0)
        result=json.loads((output/'analysis.json').read_text())
        self.assertTrue(result['diagnostic_only'])
        self.assertEqual(result['performance_acceptance'],'not_assessed')
        self.assertIn('not exclusive GPU shader time',(output/'report.md').read_text())


if __name__ == '__main__':
    unittest.main()
