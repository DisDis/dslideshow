#!/usr/bin/env python3
"""Checkpoint a native exit and find unattempted cases without concealing crashes."""
import json
from pathlib import Path
import re
import sys

from collect_reports import read_json


def checkpoint(renderer, attempt, exit_code):
    summary = read_json(attempt / 'summary.json') or {}
    metadata = summary.get('metadata', {})
    state = read_json(renderer / 'renderer-status.json') or dict(attempts=[], skipped_case_ids=[])
    full_plan = metadata.get('plan') or state.get('plan', [])
    ids = [row['id'] for row in full_plan]
    skipped = set(state['skipped_case_ids'])
    remaining = [name for name in ids if name not in skipped]
    last = None
    try:
        with (attempt / 'native.log').open(errors='replace') as log:
            for line in log:
                match = re.match(r'^BENCHMARK_CASE (.+?) cycle=', line)
                if match:
                    last = match[1]
    except OSError:
        pass
    active = read_json(attempt / 'active-case.json') or {}
    last = active.get('id', last)
    completed = summary.get('status') in ('completed', 'completed_with_failures')
    native_failure = exit_code not in (0, 2, 130)
    if completed:
        skipped.update(metadata.get('executed_case_ids', remaining))
    elif last in remaining:
        skipped.update(remaining[:remaining.index(last) + 1])
    progressed = len(skipped) > len(state['skipped_case_ids'])
    state.update(plan=full_plan, skipped_case_ids=[name for name in ids if name in skipped],
                 all_cases_attempted=bool(ids) and len(skipped) == len(ids))
    state['attempts'].append(dict(path=attempt.name, exit_code=exit_code,
        last_case_id=last, native_failure=native_failure, completed=completed,
        resume_progress=progressed))
    (renderer / 'renderer-status.json').write_text(json.dumps(state, indent=2))
    (renderer / 'skip.json').write_text(json.dumps(state['skipped_case_ids']))
    # An error before BENCHMARK_CASE cannot be repaired by skipping a test.
    return native_failure and progressed and len(skipped) < len(ids)


def main():
    renderer, attempt = map(Path, sys.argv[1:3])
    print('resume' if checkpoint(renderer, attempt, int(sys.argv[3])) else 'done')


if __name__ == '__main__':
    main()
