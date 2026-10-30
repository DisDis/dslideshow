import 'package:dslideshow_tools/src/benchmarks/screening.dart';
import 'package:test/test.dart';

void main() {
  final catalog = <String, dynamic>{
    'cases': [
      for (final entry in {'slow': .01, 'boundary': .02, 'failed': .03, 'missing': .04, 'invalid': .05}.entries)
        {
          'id': entry.key,
          'effect': entry.key,
          'presets': [entry.key],
          'family_default': false,
          'effect_config': {
            'glow': {
              'options': {'radius': entry.value},
            },
          },
        },
      {
        'id': 'fade',
        'effect': 'Fade',
        'presets': ['fade'],
        'family_default': true,
        'effect_config': {
          'fade': {'options': <String, dynamic>{}},
        },
      },
    ],
  };
  test('followup preserves exact settings and excludes warmup stand-ins', () {
    final samples = <Map<String, dynamic>>[
      for (final entry in {'slow': 24.9, 'boundary': 25, 'failed': 60, 'invalid': double.nan, 'fade': 60}.entries)
        {
          'case_id': entry.key,
          'phase': 'measured',
          'status': entry.key == 'failed' ? 'failed' : 'passed',
          'sampled_fps': entry.value,
          if (entry.key == 'failed') 'error': 'cleanup failed',
        },
      {'case_id': 'missing', 'phase': 'warmup', 'status': 'passed', 'sampled_fps': 60},
    ];
    final (rows, followup) = screenEffects(catalog, samples);
    expect(rows.where((r) => r['selected'] == true).map((r) => r['case_id']).toSet(), {
      'slow',
      'failed',
      'missing',
      'invalid',
    });
    expect((followup['effect_configs'] as Map)['glow'], [
      for (final radius in [.01, .03, .04, .05])
        {
          'options': {'radius': radius},
        },
    ]);
    expect(followup['media_cases'], ['photo-photo']);
    expect(followup['grids'], [100, 150, 200]);
    expect(followup['warmups'], 1);
    expect(followup['repeats'], 3);
    expect(followup['production_photo_inputs'], true);
  });
  test('boolean FPS and duplicate runs cannot pass', () {
    final sample = <String, dynamic>{'case_id': 'fade', 'phase': 'measured', 'status': 'passed', 'sampled_fps': true};
    final (rows, _) = screenEffects(catalog, [sample, sample]);
    final fade = rows.singleWhere((r) => r['case_id'] == 'fade');
    expect(fade['selected'], true);
    expect(fade['fps'], isNull);
    expect(fade['reasons'], contains('expected one measurement, found 2'));
  });
  test('explicit error requires followup even at passed 60 FPS', () {
    final (rows, _) = screenEffects(catalog, [
      {'case_id': 'fade', 'phase': 'measured', 'status': 'passed', 'sampled_fps': 60, 'error': 'late engine failure'},
    ]);
    expect(rows.singleWhere((r) => r['case_id'] == 'fade')['reasons'], ['late engine failure']);
  });
  test('nonpositive and non-finite thresholds fail', () {
    for (final value in [0, -1, double.nan, double.infinity]) {
      expect(() => screenEffects({}, [], threshold: value), throwsArgumentError);
    }
  });
}
