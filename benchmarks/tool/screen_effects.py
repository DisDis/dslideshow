#!/usr/bin/env python3
"""Rank a photo screening collection and prepare its focused repeat config."""
import argparse
from collections import defaultdict
import json
import math
from pathlib import Path


def analyze(catalog, samples, threshold=25):
    if (isinstance(threshold, bool) or not isinstance(threshold, (int, float))
            or not math.isfinite(threshold) or threshold <= 0):
        raise ValueError('FPS threshold must be finite and positive')
    measured = defaultdict(list)
    for sample in samples:
        if sample.get('phase') == 'measured':
            measured[sample['case_id']].append(sample)
    rows, variants = [], defaultdict(list)
    for case in catalog['cases']:
        runs = measured[case['id']]
        run = runs[0] if len(runs) == 1 else {}
        fps = run.get('sampled_fps')
        valid_fps = (not isinstance(fps, bool) and isinstance(fps, (int, float))
                     and math.isfinite(fps) and fps > 0)
        reasons = []
        if len(runs) != 1:
            reasons.append(f'expected one measurement, found {len(runs)}')
        if not valid_fps:
            reasons.append('missing/invalid FPS')
        elif fps < threshold:
            reasons.append(f'FPS below {threshold:g}')
        if run.get('error'):
            reasons.append(run['error'])
        elif run.get('status') != 'passed':
            reasons.append('measurement did not pass')
        effect_config = case.get('effect_config') or {}
        if reasons:
            for family, config in effect_config.items():
                if config not in variants[family]:
                    variants[family].append(config)
        rows.append(dict(
            case_id=case['id'], effect=case['effect'],
            presets=case['presets'], family_default=case['family_default'],
            fps=fps if valid_fps else None, selected=bool(reasons), reasons=reasons,
            actual_ms=run.get('actual_ms'), frames=run.get('frames'),
            ui_p95_ms=(run.get('ui_ms') or {}).get('p95'),
            raster_p95_ms=(run.get('raster_ms') or {}).get('p95'),
            raster_p99_ms=(run.get('raster_ms') or {}).get('p99'),
        ))
    # Keep the ordinary Fade as a control alongside Baseline.
    fade = next(case for case in catalog['cases']
                if case['family_default'] and 'fade' in (case.get('effect_config') or {}))
    control = fade['effect_config']['fade']
    if control not in variants['fade']:
        variants['fade'].append(control)
    followup = dict(
        suite='smoke', effects=['Baseline'], effect_configs=dict(variants),
        media_cases=['photo-photo'], warmups=1, repeats=3,
        grids=[100, 150, 200], backends=['canvas'], capture_frames=False,
        visual_audit=False, transition_ms=1000, transition_timeout_seconds=180, seed=42,
        production_photo_inputs=True,
    )
    return sorted(rows, key=lambda row: (row['fps'] is not None, row['fps'] or 0)), followup


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('collection', type=Path)
    parser.add_argument('catalog', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--threshold', type=float, default=25)
    args = parser.parse_args()
    if not math.isfinite(args.threshold) or args.threshold <= 0:
        parser.error('--threshold must be finite and positive')
    samples = []
    for file in sorted(args.collection.rglob('runs.jsonl')):
        samples.extend(json.loads(line) for line in file.read_text().splitlines() if line)
    rows, followup = analyze(json.loads(args.catalog.read_text()), samples, args.threshold)
    args.output.mkdir(parents=True, exist_ok=True)
    for name, value in [('screening-results.json', rows), ('focused.json', followup)]:
        (args.output / name).write_text(json.dumps(value, indent=2) + '\n')
    lines = ['| Preset / family default | FPS | Raster p95, ms | Follow up |',
             '| --- | ---: | ---: | --- |']
    for row in rows:
        label = ', '.join(row['presets']) or row['effect']
        fps = 'missing' if row['fps'] is None else f"{row['fps']:.2f}"
        raster = row['raster_p95_ms']
        raster = 'missing' if raster is None else f'{raster:.2f}'
        lines.append(f"| {label} | {fps} | {raster} | {'; '.join(row['reasons'])} |")
    (args.output / 'screening-results.md').write_text('\n'.join(lines) + '\n')
    print(json.dumps(dict(cases=len(rows), selected=sum(row['selected'] for row in rows),
                          output=str(args.output))))


if __name__ == '__main__':
    main()
