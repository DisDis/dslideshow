import unittest

from screen_effects import analyze


class ScreenEffectsTest(unittest.TestCase):
    def test_explicit_error_requires_followup_even_when_status_and_fps_pass(self):
        cases = [dict(id='glow', effect='Glow', presets=['glow'], family_default=True,
                      effect_config={'glow': {'options': {'radius': .045}}}),
                 dict(id='fade', effect='Fade', presets=['fade'], family_default=True,
                      effect_config={'fade': {}})]
        samples = [dict(case_id='glow', phase='measured', status='passed', sampled_fps=60,
                        error='late engine failure'),
                   dict(case_id='fade', phase='measured', status='passed', sampled_fps=60)]
        rows, followup = analyze({'cases': cases}, samples)
        row = next(row for row in rows if row['case_id'] == 'glow')
        self.assertTrue(row['selected'])
        self.assertEqual(row['fps'], 60)
        self.assertEqual(row['reasons'], ['late engine failure'])
        self.assertEqual(followup['effect_configs']['glow'], [{'options': {'radius': .045}}])
        self.assertFalse(next(row for row in rows if row['case_id'] == 'fade')['selected'])

    def test_invalid_thresholds_cannot_silently_disable_selection(self):
        for threshold in [True, 0, -1, float('nan'), float('inf'), '25']:
            with self.subTest(threshold=threshold), self.assertRaises(ValueError):
                analyze({}, [], threshold)

    def test_boolean_fps_and_duplicate_measurements_require_followup(self):
        cases = [dict(id='fade', effect='Fade', presets=['fade'], family_default=True,
                      effect_config={'fade': {}})]
        sample = dict(case_id='fade', phase='measured', status='passed', sampled_fps=True)
        rows, _ = analyze({'cases': cases}, [sample])
        self.assertTrue(rows[0]['selected'])
        self.assertIsNone(rows[0]['fps'])
        sample['sampled_fps'] = 60
        rows, _ = analyze({'cases': cases}, [sample, sample])
        self.assertTrue(rows[0]['selected'])
        self.assertIn('expected one measurement, found 2', rows[0]['reasons'])

    def test_threshold_errors_and_missing_data_keep_exact_settings(self):
        cases = [dict(id=name, effect=name, presets=[name], family_default=False,
                      effect_config={'glow': {'options': {'radius': radius}}})
                 for name, radius in [('slow', .01), ('boundary', .02), ('failed', .03),
                                      ('missing', .04), ('invalid', .05)]]
        cases.append(dict(id='fade', effect='Fade', presets=['fade'], family_default=True,
                          effect_config={'fade': {'options': {}}}))
        samples = [dict(case_id=name, phase='measured', status='passed', sampled_fps=fps)
                   for name, fps in [('slow', 24.9), ('boundary', 25), ('failed', 60),
                                     ('invalid', float('nan')), ('fade', 60)]]
        samples[2].update(status='failed', error='cleanup failed')
        # Warmup data must never fill in an absent measured result.
        samples.append(dict(case_id='missing', phase='warmup', status='passed', sampled_fps=60))
        rows, config = analyze({'cases': cases}, samples)
        self.assertEqual({row['case_id'] for row in rows if row['selected']},
                         {'slow', 'failed', 'missing', 'invalid'})
        self.assertEqual([item['options']['radius'] for item in config['effect_configs']['glow']],
                         [.01, .03, .04, .05])
        self.assertEqual(config['effect_configs']['fade'], [{'options': {}}])
        self.assertEqual(config['media_cases'], ['photo-photo'])
        self.assertEqual(config['grids'], [100, 150, 200])
        self.assertEqual(config['warmups'], 1)
        self.assertTrue(config['production_photo_inputs'])
        self.assertEqual(config['repeats'], 3)
        self.assertEqual(config['transition_timeout_seconds'], 180)


if __name__ == '__main__':
    unittest.main()
