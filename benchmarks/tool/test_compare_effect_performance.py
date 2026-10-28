import contextlib
import copy
import io
import json
from pathlib import Path
import tempfile
import unittest

from compare_effect_performance import compare, main, read_jsonl, render


CASE = 'Glow--photo-photo'


def _json(path, value):
    path.write_text(json.dumps(value), encoding='utf-8')


def _jsonl(path, rows):
    path.write_text(''.join(json.dumps(row) + '\n' for row in rows), encoding='utf-8')


def collection(root, fps=(10, 100, 30), times=((1, 1), (1, 1), (100,)), warmups=1):
    attempt = root / 'opengl' / 'attempt-001'
    attempt.mkdir(parents=True)
    descriptor = dict(id=CASE, effect='Glow', media='photo-photo',
                      effect_config={'glow': {'options': {'radius': .045}}},
                      **{'from': 'photo_a.jpg', 'to': 'photo_b.jpg'})
    metadata = dict(config=dict(repeats=3, warmups=warmups, seed=42), cycles=1, build_mode='release',
                    requested_renderer='opengl', target_display_matches=True,
                    display=dict(physical_width=2560, physical_height=1600,
                                 logical_width=2560, logical_height=1600,
                                 pixel_ratio=1, refresh_hz=50),
                    build=dict(git_commit='baseline-commit', source_sha256='baseline-source', cpu='pi5', mode='release',
                               flutter=dict(frameworkVersion='3.47.7', frameworkRevision='framework',
                                            engineRevision='engine', dartSdkVersion='3.13.5')),
                    hardware=dict(model='Raspberry Pi 5 Model B Rev 1.0', kernel='Linux aarch64',
                                  os='Debian GNU/Linux 12', processors=4, clock_ticks_per_second=100,
                                  cpu_governors={'/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq': 'ondemand'},
                                  initial_throttle_bits=0, temperature_paths=['/sys/class/thermal/thermal_zone0/temp']),
                    media=[dict(name='photo_a.jpg', sha256='photo-a', width=4032, height=3024),
                           dict(name='photo_b.jpg', sha256='photo-b', width=6000, height=4000)],
                    plan=[descriptor], runtime_errors=0, cleanup_errors=0)
    _json(attempt / 'summary.json', dict(status='completed', metadata=metadata,
                                        failed_runs=0, error_events=0, error_counts={}))
    _json(attempt / 'launch.json', dict(flutter_pi_sha256='runtime', app_sha256='baseline-app'))
    _json(attempt / 'launcher-status.json', dict(exit_code=0))
    (attempt / 'native.log').write_text('', encoding='utf-8')
    runs, frames = [], []
    for repeat, (rate, values) in enumerate(zip(fps, times)):
        identity = dict(case_id=CASE, cycle=0, phase='measured', repeat=repeat)
        runs.append(dict(identity, case=descriptor, status='passed', sampled_fps=rate,
                         frames=len(values), raster_ms=dict(p95=999)))
        for index, time in enumerate(values):
            frames.append(dict(identity, vsync_us=100000 * repeat + index * 20000,
                               build_us=time * 1000, raster_us=time * 2000))
    # A very fast warmup must never affect the measured median or pooled tails.
    for repeat in range(-warmups, 0):
        identity = dict(case_id=CASE, cycle=0, phase='warmup', repeat=repeat)
        runs.append(dict(identity, case=descriptor, status='passed', sampled_fps=999, frames=1))
        frames.append(dict(identity, vsync_us=1, build_us=999999, raster_us=999999))
    _jsonl(attempt / 'runs.jsonl', runs)
    _jsonl(attempt / 'frames.jsonl', frames)
    _jsonl(attempt / 'errors.jsonl', [])
    _jsonl(attempt / 'telemetry.jsonl', [
        dict(stage='preflight', rss_bytes=9999, available_memory_bytes=1, swap_free_bytes=9999),
        dict(stage=f'prepare:{CASE}', rss_bytes=100, available_memory_bytes=900, swap_free_bytes=500),
        *[dict(stage=f'warmup:{CASE}:{repeat}', rss_bytes=350,
               available_memory_bytes=650, swap_free_bytes=475) for repeat in range(-warmups, 0)],
        dict(stage=f'measured:{CASE}:0', rss_bytes=400, available_memory_bytes=600, swap_free_bytes=450),
        dict(stage=f'measured:{CASE}:1', rss_bytes=300, available_memory_bytes=700, swap_free_bytes=420),
        dict(stage=f'cleanup:{CASE}', rss_bytes=200, available_memory_bytes=800, swap_free_bytes=400),
    ])
    return attempt


def edit_json(path, update):
    value = json.loads(path.read_text())
    update(value)
    _json(path, value)


def edit_jsonl(path, update):
    rows = [json.loads(line) for line in path.read_text().splitlines()]
    update(rows)
    _jsonl(path, rows)


class EffectPerformanceComparisonTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.baseline = self.root / 'baseline'
        self.candidate = self.root / 'candidate'
        self.a = collection(self.baseline)
        self.b = collection(self.candidate, fps=(20, 40, 60))

    def compare(self):
        return compare(self.baseline, self.candidate)

    def test_negative_warmup_ids_one_and_two_are_valid_but_not_measured(self):
        for count in (1, 2):
            with self.subTest(warmups=count):
                a, b = self.root / f'a-{count}', self.root / f'b-{count}'
                collection(a, warmups=count)
                collection(b, fps=(20, 40, 60), warmups=count)
                result = compare(a, b)
                self.assertTrue(result['comparison_ready'])
                candidate = result['cases'][0]['candidate']
                self.assertEqual(candidate['passed_runs'], 3)
                self.assertEqual(candidate['fps_median'], 40)
                self.assertEqual(candidate['ui_ms']['count'], 5)
                self.assertEqual(candidate['memory']['samples'], 4 + count)

    def test_malformed_warmup_ids_are_rejected_in_both_runs_and_frames(self):
        for filename in ('runs.jsonl', 'frames.jsonl'):
            path = self.b / filename
            original = path.read_bytes()
            for field, value in [('repeat', 0), ('repeat', -2), ('repeat', True),
                                 ('repeat', -1.0), ('repeat', '-1'), ('cycle', True), ('cycle', 1)]:
                with self.subTest(file=filename, field=field, value=value):
                    path.write_bytes(original)
                    def update(rows):
                        next(row for row in rows if row['phase'] == 'warmup')[field] = value
                    edit_jsonl(path, update)
                    result = self.compare()
                    self.assertFalse(result['comparison_ready'])
                    self.assertTrue(result['candidate']['diagnostics'])
                    self.assertEqual(result['cases'][0]['candidate']['passed_runs'], 3)
            path.write_bytes(original)

    def test_absent_expected_warmups_cannot_compare_as_complete_on_both_sides(self):
        for attempt in (self.a, self.b):
            for name in ('runs.jsonl', 'frames.jsonl'):
                edit_jsonl(attempt / name, lambda rows: rows.__setitem__(
                    slice(None), [row for row in rows if row['phase'] != 'warmup']))
        result = self.compare()
        self.assertTrue(result['performance_comparable'])
        self.assertFalse(result['comparison_ready'])
        for side in ('baseline', 'candidate'):
            case = result['cases'][0][side]
            self.assertEqual(case['expected_warmup_runs'], 1)
            self.assertEqual(case['observed_warmup_runs'], 0)
            self.assertEqual(case['passed_warmup_runs'], 0)
            self.assertEqual(case['missing_warmup_repetitions'], [(0, -1)])
            self.assertEqual(case['passed_runs'], 3)
            self.assertEqual(case['ui_ms']['count'], 5)
            self.assertTrue(any('missing warmup' in issue for issue in case['issues']))
        self.assertEqual(result['cases'][0]['changes'], {})

    def test_each_declared_negative_warmup_must_exist(self):
        a, b = self.root / 'two-warmups-a', self.root / 'two-warmups-b'
        collection(a, warmups=2)
        attempt = collection(b, warmups=2)
        for name in ('runs.jsonl', 'frames.jsonl'):
            edit_jsonl(attempt / name, lambda rows: rows.__setitem__(
                slice(None), [row for row in rows if row['phase'] != 'warmup' or row['repeat'] != -2]))
        result = compare(a, b)
        self.assertFalse(result['comparison_ready'])
        case = result['cases'][0]['candidate']
        self.assertEqual(case['missing_warmup_repetitions'], [(0, -2)])
        self.assertEqual(case['observed_warmup_runs'], 1)

    def test_zero_declared_warmups_accepts_no_warmup_records(self):
        a, b = self.root / 'cold-a', self.root / 'cold-b'
        collection(a, warmups=0)
        collection(b, warmups=0)
        result = compare(a, b)
        self.assertTrue(result['comparison_ready'])
        for side in ('baseline', 'candidate'):
            case = result['cases'][0][side]
            self.assertEqual(case['expected_warmup_runs'], 0)
            self.assertEqual(case['observed_warmup_runs'], 0)
            self.assertEqual(case['missing_warmup_repetitions'], [])

    def test_missing_warmup_frames_block_without_entering_measured_tails(self):
        edit_jsonl(self.b / 'frames.jsonl', lambda rows: rows.__setitem__(
            slice(None), [row for row in rows if row['phase'] != 'warmup']))
        result = self.compare()
        self.assertFalse(result['comparison_ready'])
        case = result['cases'][0]['candidate']
        self.assertEqual(case['warmups'][0]['reported_frames'], 1)
        self.assertEqual(case['warmups'][0]['raw_frames'], 0)
        self.assertEqual(case['missing_warmup_repetitions'], [])
        self.assertEqual(case['ui_ms']['count'], 5)
        self.assertEqual(case['fps_median'], 40)
        self.assertTrue(any('warmup frame count' in issue for issue in case['issues']))

    def test_duplicate_warmup_across_attempts_is_not_extra_preconditioning(self):
        second = self.candidate / 'opengl' / 'attempt-002'
        second.mkdir()
        for path in self.b.iterdir():
            if path.is_file():
                (second / path.name).write_bytes(path.read_bytes())
        for name in ('runs.jsonl', 'frames.jsonl'):
            edit_jsonl(second / name, lambda rows: rows.__setitem__(
                slice(None), [row for row in rows if row['phase'] == 'warmup']))
        result = self.compare()
        self.assertFalse(result['comparison_ready'])
        case = result['cases'][0]['candidate']
        self.assertEqual(case['passed_runs'], 3)
        self.assertEqual(case['observed_warmup_runs'], 2)
        self.assertEqual(case['duplicate_warmup_repetitions'], [[0, -1]])

    def test_failed_or_error_bearing_warmup_and_duplicate_remain_explicit(self):
        path = self.b / 'runs.jsonl'
        original = path.read_bytes()
        for status in ('failed', 'passed'):
            with self.subTest(status=status):
                path.write_bytes(original)
                def update(rows):
                    next(row for row in rows if row['phase'] == 'warmup').update(
                        status=status, error='warmup decoder failure')
                edit_jsonl(path, update)
                result = self.compare()
                self.assertFalse(result['comparison_ready'])
                errors = result['candidate']['errors']
                self.assertTrue(any(event.get('run', {}).get('error') == 'warmup decoder failure'
                                    for event in errors))
                self.assertEqual(result['cases'][0]['candidate']['passed_runs'], 3)
        path.write_bytes(original)
        edit_jsonl(path, lambda rows: rows.append(copy.deepcopy(rows[-1])))
        result = self.compare()
        self.assertFalse(result['comparison_ready'])
        self.assertTrue(any('duplicate warmup' in text for text in result['candidate']['diagnostics']))

    def test_invalid_warmup_config_never_authorizes_negative_ids(self):
        path = self.b / 'summary.json'
        original = path.read_bytes()
        for count in (0, True, -1, '1', 1.0, None):
            with self.subTest(warmups=count):
                path.write_bytes(original)
                edit_json(path, lambda value: value['metadata']['config'].update(warmups=count))
                result = self.compare()
                self.assertFalse(result['comparison_ready'])
                self.assertTrue(result['candidate']['diagnostics'])

    def test_negative_and_boolean_measured_ids_cannot_become_warmups(self):
        for filename in ('runs.jsonl', 'frames.jsonl'):
            path = self.b / filename
            original = path.read_bytes()
            for value in (-1, True):
                with self.subTest(file=filename, repeat=value):
                    path.write_bytes(original)
                    edit_jsonl(path, lambda rows: rows[0].update(repeat=value))
                    result = self.compare()
                    self.assertFalse(result['comparison_ready'])
                    self.assertTrue(result['candidate']['diagnostics'])
            path.write_bytes(original)

    def test_telemetry_includes_only_declared_negative_warmups(self):
        _jsonl(self.b / 'telemetry.jsonl', [
            dict(stage=f'prepare:{CASE}', rss_bytes=100),
            dict(stage=f'warmup:{CASE}:-1', rss_bytes=700),
            dict(stage=f'warmup:{CASE}:-2', rss_bytes=9999),
            dict(stage=f'warmup:{CASE}:0', rss_bytes=9999),
            dict(stage=f'measured:{CASE}:-1', rss_bytes=9999),
            dict(stage=f'measured:{CASE}:0', rss_bytes=400),
        ])
        result = self.compare()
        self.assertTrue(result['comparison_ready'])
        memory = result['cases'][0]['candidate']['memory']
        self.assertEqual(memory['samples'], 3)
        self.assertEqual(memory['rss_peak_sampled_bytes'], 700)

    def test_fps_median_pooled_raw_tails_and_system_memory(self):
        result = self.compare()
        self.assertTrue(result['performance_comparable'])
        self.assertTrue(result['comparison_ready'])
        self.assertEqual(result['acceptance'], 'not_assessed')
        row = result['cases'][0]
        a, b = row['baseline'], row['candidate']
        self.assertEqual(a['fps_median'], 30)
        self.assertEqual(b['fps_median'], 40)
        self.assertAlmostEqual(row['changes']['fps_percent'], 100 / 3)
        self.assertEqual(a['ui_ms']['count'], 5)
        self.assertEqual(a['ui_ms']['p50'], 1)
        self.assertAlmostEqual(a['ui_ms']['p95'], 80.2)
        self.assertAlmostEqual(a['ui_ms']['p99'], 96.04)
        self.assertEqual(a['ui_ms']['max'], 100)
        self.assertAlmostEqual(a['raster_ms']['p95'], 160.4)
        self.assertNotEqual(a['raster_ms']['p95'], 999)
        self.assertEqual(a['memory']['rss_peak_sampled_bytes'], 400)
        self.assertEqual(a['memory']['available_memory_min_bytes'], 600)
        self.assertEqual(a['memory']['swap_free_delta_bytes'], -100)
        self.assertEqual(a['descriptor'], result['baseline']['metadata']['plan'][0])

    def test_source_identity_may_change_and_media_order_is_irrelevant(self):
        def update(summary):
            metadata = summary['metadata']
            metadata['build'].update(git_commit='new-commit', source_sha256='new-source', built_utc='new-date')
            metadata['media'].reverse()
            metadata['display']['refresh_hz'] += .009
        edit_json(self.b / 'summary.json', update)
        edit_json(self.b / 'launch.json', lambda launch: launch.update(app_sha256='new-app'))
        self.assertTrue(self.compare()['comparison_ready'])

    def test_each_required_condition_blocks_incompatible_comparison(self):
        original = json.loads((self.b / 'summary.json').read_text())
        mutations = [
            ('config', lambda metadata: metadata['config'].update(seed=99)),
            ('display', lambda metadata: metadata['display'].update(physical_width=1280)),
            ('display', lambda metadata: metadata['display'].update(pixel_ratio=2)),
            ('refresh_hz', lambda metadata: metadata['display'].update(refresh_hz=50.011)),
            ('flutter_sdk_engine', lambda metadata: metadata['build']['flutter'].update(engineRevision='different')),
            ('media', lambda metadata: metadata['media'][0].update(sha256='different')),
            ('media', lambda metadata: metadata['media'][0].update(width=999)),
        ]
        for condition, update in mutations:
            with self.subTest(condition=condition):
                summary = copy.deepcopy(original)
                update(summary['metadata'])
                _json(self.b / 'summary.json', summary)
                result = self.compare()
                self.assertFalse(result['performance_comparable'])
                self.assertFalse(result['comparison_ready'])
                self.assertTrue(any(check['condition'] == condition and not check['passed'] for check in result['conditions']))
                self.assertEqual(result['cases'][0]['changes'], {})
        _json(self.b / 'summary.json', original)
        edit_json(self.b / 'launch.json', lambda launch: launch.update(flutter_pi_sha256='different'))
        self.assertFalse(self.compare()['performance_comparable'])

    def test_missing_conditions_on_both_sides_do_not_compare_as_equal(self):
        for attempt in (self.a, self.b):
            edit_json(attempt / 'summary.json', lambda summary: summary['metadata'].update(display={}, media=[]))
        result = self.compare()
        self.assertFalse(result['performance_comparable'])
        self.assertTrue(any(check['reason'] == 'missing/invalid condition' for check in result['conditions']))

    def test_target_display_requires_literal_true_even_if_both_sides_agree(self):
        for value in (False, None, 1, 'true'):
            with self.subTest(value=value):
                for attempt in (self.a, self.b):
                    edit_json(attempt / 'summary.json', lambda summary: summary['metadata'].update(
                        target_display_matches=value))
                result = self.compare()
                self.assertFalse(result['performance_comparable'])
                self.assertFalse(result['comparison_ready'])
                self.assertTrue(any(check['condition'] == 'target_display_matches' and not check['passed']
                                    for check in result['conditions']))
                self.assertEqual(result['cases'][0]['changes'], {})

    def test_missing_target_display_status_is_not_inferred_from_dimensions(self):
        edit_json(self.b / 'summary.json', lambda summary: summary['metadata'].pop('target_display_matches'))
        self.assertFalse(self.compare()['comparison_ready'])

    def test_requested_renderer_must_match_selected_renderer_on_both_sides(self):
        for value in ('vulkan', None, 'OpenGL', True):
            with self.subTest(value=value):
                for attempt in (self.a, self.b):
                    edit_json(attempt / 'summary.json', lambda summary: summary['metadata'].update(
                        requested_renderer=value))
                result = self.compare()
                self.assertFalse(result['performance_comparable'])
                self.assertFalse(result['comparison_ready'])
                self.assertTrue(any(check['condition'] == 'requested_renderer' and not check['passed']
                                    for check in result['conditions']))

    def test_explicit_vulkan_renderer_accepts_matching_photo_collections(self):
        for root in (self.baseline, self.candidate):
            (root / 'opengl').rename(root / 'vulkan')
            edit_json(root / 'vulkan' / 'attempt-001' / 'summary.json',
                      lambda summary: summary['metadata'].update(requested_renderer='vulkan'))
        self.assertTrue(compare(self.baseline, self.candidate, 'vulkan')['comparison_ready'])

    def test_missing_native_log_blocks_eligibility_without_erasing_measurements(self):
        (self.b / 'native.log').unlink()
        result = self.compare()
        self.assertFalse(result['comparison_ready'])
        self.assertFalse(result['cases'][0]['comparison_eligible'])
        self.assertEqual(result['cases'][0]['changes'], {})
        self.assertEqual(result['cases'][0]['candidate']['fps_median'], 40)
        self.assertEqual(result['cases'][0]['candidate']['ui_ms']['count'], 5)
        self.assertTrue(any('native.log' in message and 'required native log unavailable' in message
                            for message in result['candidate']['diagnostics']))

    def test_unreadable_native_log_is_not_treated_as_an_empty_clean_log(self):
        native = self.b / 'native.log'
        native.unlink()
        native.mkdir()
        result = self.compare()
        self.assertFalse(result['comparison_ready'])
        self.assertTrue(any('required native log unavailable' in message
                            for message in result['candidate']['diagnostics']))

    def test_both_runtime_and_artifact_must_explicitly_be_release(self):
        original = json.loads((self.b / 'summary.json').read_text())
        for runtime, artifact in [('release', 'profile'), ('debug', 'release'),
                                  ('profile', 'profile'), (None, 'release'), ('release', None), (None, None)]:
            with self.subTest(runtime=runtime, artifact=artifact):
                summary = copy.deepcopy(original)
                summary['metadata']['build_mode'] = runtime
                summary['metadata']['build']['mode'] = artifact
                _json(self.b / 'summary.json', summary)
                result = self.compare()
                self.assertFalse(result['comparison_ready'])
                self.assertTrue(any(check['condition'] == 'release_mode' and not check['passed']
                                    for check in result['conditions']))

    def test_identical_non_release_archives_still_fail_the_release_requirement(self):
        for attempt in (self.a, self.b):
            def update(summary):
                summary['metadata']['build_mode'] = 'profile'
                summary['metadata']['build']['mode'] = 'profile'
            edit_json(attempt / 'summary.json', update)
        self.assertFalse(self.compare()['performance_comparable'])

    def test_static_hardware_identity_and_governor_policy_must_match(self):
        original = json.loads((self.b / 'summary.json').read_text())
        mutations = [
            lambda metadata: metadata['build'].update(cpu='pi4'),
            lambda metadata: metadata['hardware'].update(model='Raspberry Pi 4'),
            lambda metadata: metadata['hardware'].update(kernel='different kernel'),
            lambda metadata: metadata['hardware'].update(os='different OS'),
            lambda metadata: metadata['hardware'].update(processors=8),
            lambda metadata: metadata['hardware'].update(clock_ticks_per_second=1000),
            lambda metadata: metadata['hardware']['cpu_governors'].update(
                {'/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq': 'performance'}),
            lambda metadata: metadata.update(hardware={}),
        ]
        for index, update in enumerate(mutations):
            with self.subTest(mutation=index):
                summary = copy.deepcopy(original)
                update(summary['metadata'])
                _json(self.b / 'summary.json', summary)
                result = self.compare()
                self.assertFalse(result['comparison_ready'])
                self.assertTrue(any(check['condition'] == 'hardware_identity' and not check['passed']
                                    for check in result['conditions']))

    def test_dynamic_hardware_readings_do_not_change_static_identity(self):
        def update(summary):
            summary['metadata']['hardware'].update(initial_throttle_bits=65536,
                                                   temperature_paths=['another temperature path'],
                                                   cpu_frequency_khz=[1800000], cpu_temperature_c=70)
        edit_json(self.b / 'summary.json', update)
        result = self.compare()
        self.assertTrue(result['comparison_ready'])
        self.assertEqual(result['candidate']['metadata']['hardware']['initial_throttle_bits'], 65536)
        self.assertEqual(result['acceptance'], 'not_assessed')

    def test_failed_missing_duplicate_repeats_and_orphan_frames_are_explicit(self):
        def update(rows):
            rows[0].update(status='failed', error='transition timeout', sampled_fps=10000)
            del rows[2]
            rows.append(copy.deepcopy(rows[1]))
        edit_jsonl(self.b / 'runs.jsonl', update)
        result = self.compare()
        row = result['cases'][0]
        candidate = row['candidate']
        self.assertFalse(result['comparison_ready'])
        self.assertEqual(candidate['failed_runs'], 1)
        self.assertEqual(candidate['missing_repetitions'], [(0, 2)])
        self.assertEqual(candidate['duplicate_repetitions'], [[0, 1]])
        self.assertEqual(candidate['fps_median'], 40)
        self.assertTrue(any('no measured run' in issue for issue in candidate['issues']))
        self.assertEqual(row['changes'], {})

    def test_missing_case_is_retained_with_null_candidate(self):
        edit_json(self.b / 'summary.json', lambda summary: summary['metadata'].update(plan=[]))
        _jsonl(self.b / 'runs.jsonl', [])
        _jsonl(self.b / 'frames.jsonl', [])
        result = self.compare()
        self.assertFalse(result['comparison_ready'])
        self.assertIsNone(result['cases'][0]['candidate'])
        self.assertIn('Missing case', render(result))

    def test_observed_descriptors_cannot_replace_missing_expected_plan(self):
        edit_json(self.b / 'summary.json', lambda summary: summary['metadata'].pop('plan'))
        result = self.compare()
        self.assertEqual(result['cases'][0]['candidate']['passed_runs'], 3)
        self.assertFalse(result['comparison_ready'])
        self.assertTrue(any('expected case plan' in text for text in result['candidate']['diagnostics']))

    def test_passed_runs_do_not_hide_cleanup_or_native_errors(self):
        _jsonl(self.b / 'errors.jsonl', [dict(kind='cleanup', case_id=CASE, error='release failed')])
        edit_json(self.b / 'launcher-status.json', lambda status: status.update(exit_code=139))
        (self.b / 'native.log').write_text('[ERROR:flutter/shell] EGL import failed\nSegmentation fault\n')
        _json(self.candidate / 'opengl' / 'renderer-status.json', dict(attempts=[
            dict(path='attempt-001', exit_code=139, native_failure=True, last_case_id=CASE)]))
        result = self.compare()
        self.assertEqual(result['cases'][0]['candidate']['passed_runs'], 3)
        self.assertFalse(result['comparison_ready'])
        kinds = {event['kind'] for event in result['candidate']['errors']}
        self.assertTrue({'cleanup', 'launcher_exit', 'native_log', 'native_failure'} <= kinds)
        self.assertIn('release failed', render(result))

    def test_raw_frame_count_and_invalid_fps_never_become_zero(self):
        edit_jsonl(self.b / 'runs.jsonl', lambda rows: rows[0].update(frames=999, sampled_fps=True))
        result = self.compare()
        candidate = result['cases'][0]['candidate']
        self.assertFalse(result['comparison_ready'])
        self.assertEqual(candidate['fps_median'], 50)
        self.assertTrue(any('FPS' in issue for issue in candidate['issues']))
        self.assertTrue(any('frame count' in issue for issue in candidate['issues']))

    def test_duplicate_frame_timestamp_and_passed_error_are_not_accepted(self):
        edit_jsonl(self.b / 'frames.jsonl', lambda rows: rows[1].update(vsync_us=rows[0]['vsync_us']))
        edit_jsonl(self.b / 'runs.jsonl', lambda rows: rows[1].update(error='late runtime error'))
        result = self.compare()
        issues = result['cases'][0]['candidate']['issues']
        self.assertFalse(result['comparison_ready'])
        self.assertTrue(any('duplicate frame timestamp' in issue for issue in issues))
        self.assertTrue(any('late runtime error' in issue for issue in issues))

    def test_all_failed_repetitions_leave_fps_and_frame_metrics_absent(self):
        def fail(rows):
            for row in rows:
                if row['phase'] == 'measured':
                    row.update(status='failed', error='timeout')
        edit_jsonl(self.b / 'runs.jsonl', fail)
        result = self.compare()
        candidate = result['cases'][0]['candidate']
        self.assertIsNone(candidate['fps_median'])
        self.assertIsNone(candidate['ui_ms']['p95'])
        self.assertIsNone(candidate['raster_ms']['max'])
        self.assertEqual(candidate['ui_ms']['count'], 0)
        self.assertFalse(result['comparison_ready'])

    def test_corrupt_jsonl_is_diagnosed_and_valid_later_records_survive(self):
        path = self.b / 'frames.jsonl'
        original = path.read_bytes()
        path.write_bytes(b'{"truncated":\n[]\n{"x":NaN}\n{"x":1e999}\n{"x":1,"x":2}\n\xff\n' + original)
        result = self.compare()
        diagnostics = result['candidate']['diagnostics']
        self.assertEqual(len(diagnostics), 6)
        self.assertTrue(all('invalid JSONL' in message for message in diagnostics))
        self.assertEqual(result['cases'][0]['candidate']['ui_ms']['count'], 5)
        self.assertFalse(result['comparison_ready'])

    def test_schema_mismatch_is_diagnosed_without_crashing(self):
        edit_json(self.b / 'summary.json', lambda summary: summary['metadata'].update(
            display='bad', build='bad', config=['bad'], media=['bad'], plan='bad'))
        result = self.compare()
        self.assertFalse(result['comparison_ready'])
        self.assertTrue(result['candidate']['diagnostics'])

    def test_same_case_id_with_changed_descriptor_is_not_comparable(self):
        def update(summary):
            summary['metadata']['plan'][0]['from'] = 'other.jpg'
        edit_json(self.b / 'summary.json', update)
        result = self.compare()
        self.assertFalse(result['cases'][0]['descriptors_match'])
        self.assertFalse(result['comparison_ready'])
        self.assertTrue(any('inconsistent descriptor' in text for text in result['candidate']['diagnostics']))

    def test_attempt_conditions_cannot_silently_change_after_resume(self):
        second = self.candidate / 'opengl' / 'attempt-002'
        second.mkdir()
        for path in self.b.iterdir():
            if path.is_file():
                (second / path.name).write_bytes(path.read_bytes())
        edit_json(second / 'summary.json', lambda summary: summary['metadata']['display'].update(refresh_hz=60))
        result = self.compare()
        self.assertFalse(result['performance_comparable'])
        self.assertFalse(result['comparison_ready'])
        self.assertEqual(len(result['candidate']['attempts']), 2)

    def test_missing_telemetry_metrics_stay_null_and_one_sample_has_no_delta(self):
        _jsonl(self.b / 'telemetry.jsonl', [dict(stage=f'measured:{CASE}:0', swap_free_bytes=500)])
        memory = self.compare()['cases'][0]['candidate']['memory']
        self.assertIsNone(memory['rss_peak_sampled_bytes'])
        self.assertIsNone(memory['available_memory_min_bytes'])
        self.assertIsNone(memory['swap_free_delta_bytes'])

    def test_unknown_swap_in_one_attempt_does_not_become_partial_total(self):
        second = self.candidate / 'opengl' / 'attempt-002'
        second.mkdir()
        for path in self.b.iterdir():
            if path.is_file():
                (second / path.name).write_bytes(path.read_bytes())
        _jsonl(second / 'telemetry.jsonl', [dict(stage=f'measured:{CASE}:0', rss_bytes=500)])
        memory = self.compare()['cases'][0]['candidate']['memory']
        self.assertEqual(memory['rss_peak_sampled_bytes'], 500)
        self.assertIsNone(memory['swap_free_delta_bytes'])
        self.assertEqual(len(memory['swap_spans']), 2)

    def test_cli_writes_reviewable_reports_and_returns_failure_for_invalid_data(self):
        output = self.root / 'comparison'
        with contextlib.redirect_stdout(io.StringIO()):
            code = main([str(self.baseline), str(self.candidate), str(output)])
        self.assertEqual(code, 0)
        self.assertTrue(json.loads((output / 'comparison.json').read_text())['comparison_ready'])
        self.assertIn('Acceptance: not assessed', (output / 'report.md').read_text())
        self.assertIn('not GPU memory', (output / 'report.md').read_text())
        self.assertIn('manual validation of the benchmark harness', (output / 'report.md').read_text())
        self.assertIn('shared-GlobalKey harness are invalid', (output / 'report.md').read_text())
        (self.b / 'runs.jsonl').unlink()
        with contextlib.redirect_stdout(io.StringIO()):
            code = main([str(self.baseline), str(self.candidate), str(output)])
        self.assertEqual(code, 2)
        self.assertFalse(json.loads((output / 'comparison.json').read_text())['comparison_ready'])

    def test_jsonl_missing_file_has_a_diagnostic(self):
        diagnostics = []
        self.assertEqual(read_jsonl(self.root / 'missing.jsonl', diagnostics), [])
        self.assertEqual(len(diagnostics), 1)


if __name__ == '__main__':
    unittest.main()
