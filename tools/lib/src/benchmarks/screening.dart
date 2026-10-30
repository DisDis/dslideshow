import 'json_io.dart';

(List<Map<String, dynamic>>, Map<String, dynamic>) screenEffects(
  Map<String, dynamic> catalog,
  List<Map<String, dynamic>> samples, {
  num threshold = 25,
}) {
  if (!numeric(threshold, positive: true)) {
    throw ArgumentError.value(threshold, 'threshold', 'FPS threshold must be finite and positive');
  }
  final measured = <String, List<Map<String, dynamic>>>{};
  for (final sample in samples) {
    if (sample['phase'] == 'measured') (measured[sample['case_id'] as String] ??= []).add(sample);
  }
  final rows = <Map<String, dynamic>>[], variants = <String, List<dynamic>>{};
  for (final value in asList(catalog['cases'])) {
    final row = asMap(value),
        runs = measured[row['id']] ?? [],
        run = runs.length == 1 ? runs.single : <String, dynamic>{},
        fps = run['sampled_fps'];
    final valid = numeric(fps, positive: true), reasons = <dynamic>[];
    if (runs.length != 1) reasons.add('expected one measurement, found ${runs.length}');
    if (!valid) {
      reasons.add('missing/invalid FPS');
    } else if ((fps as num) < threshold) {
      reasons.add('FPS below ${threshold.toString().replaceFirst('.0', '')}');
    }
    if (truth(run['error'])) {
      reasons.add(run['error']);
    } else if (run['status'] != 'passed') {
      reasons.add('measurement did not pass');
    }
    if (reasons.isNotEmpty) {
      for (final entry in asMap(row['effect_config']).entries) {
        final list = variants[entry.key] ??= [];
        if (!list.any((e) => canonical(e) == canonical(entry.value))) list.add(entry.value);
      }
    }
    rows.add({
      'case_id': row['id'],
      'effect': row['effect'],
      'presets': row['presets'],
      'family_default': row['family_default'],
      'fps': valid ? fps : null,
      'selected': reasons.isNotEmpty,
      'reasons': reasons,
      'actual_ms': run['actual_ms'],
      'frames': run['frames'],
      'ui_p95_ms': asMap(run['ui_ms'])['p95'],
      'raster_p95_ms': asMap(run['raster_ms'])['p95'],
      'raster_p99_ms': asMap(run['raster_ms'])['p99'],
    });
  }
  final fade = asList(catalog['cases'])
      .firstWhere((e) => e['family_default'] == true && asMap(e['effect_config']).containsKey('fade'));
  final control = fade['effect_config']['fade'], list = variants['fade'] ??= [];
  if (!list.any((e) => canonical(e) == canonical(control))) list.add(control);
  rows.sort((a, b) {
    if (a['fps'] == null) return b['fps'] == null ? 0 : -1;
    if (b['fps'] == null) return 1;
    return (a['fps'] as num).compareTo(b['fps'] as num);
  });
  return (
    rows,
    {
      'suite': 'smoke',
      'effects': ['Baseline'],
      'effect_configs': variants,
      'media_cases': ['photo-photo'],
      'warmups': 1,
      'repeats': 3,
      'grids': [100, 150, 200],
      'backends': ['canvas'],
      'capture_frames': false,
      'visual_audit': false,
      'transition_ms': 1000,
      'transition_timeout_seconds': 180,
      'seed': 42,
      'production_photo_inputs': true,
    },
  );
}
