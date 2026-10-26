#!/usr/bin/env python3
"""Measure GET /info headers using only the standard library; no auth/body.

Run locally as camera_http_probe.py HOST:PORT [SECONDS], or send this file to
python3 - HOST:PORT [SECONDS] over SSH. Each request opens a fresh connection.
Linux/POSIX SIGALRM bounds each complete request and the remaining run time.
"""
import datetime
import http.client
import json
import signal
import sys
import time
from urllib.parse import urlsplit


def _expired(_signum, _frame):
    raise TimeoutError('HTTP request deadline exceeded')


def probe(authority, duration=120):
    target = urlsplit('//' + authority)
    if (not target.hostname or target.port is None or target.username is not None
            or target.password is not None or target.path or target.query
            or target.fragment):
        raise ValueError('Expected HOST:PORT without URL, auth, or path')
    if not 1 <= duration <= 1800:
        raise ValueError('Duration must be between 1 and 1800 seconds')
    started = time.monotonic()
    deadline = started + duration
    next_sample = started
    samples = []
    previous_handler = signal.signal(signal.SIGALRM, _expired)
    try:
        while time.monotonic() < deadline:
            now = time.monotonic()
            if now < next_sample:
                time.sleep(min(next_sample - now, max(0, deadline - now)))
            sent = time.monotonic()
            remaining = deadline - sent
            if remaining <= 0:
                break
            sample = {
                'utc': datetime.datetime.now(datetime.timezone.utc).isoformat(),
                'elapsed_s': round(sent - started, 3),
            }
            connection = http.client.HTTPConnection(
                target.hostname, target.port, timeout=min(6, remaining))
            try:
                signal.setitimer(signal.ITIMER_REAL, min(6, remaining))
                connection.request('GET', '/info', headers={'Connection': 'close'})
                response = connection.getresponse()
                sample['status'] = response.status
                response.close()
            except Exception as error:
                sample['exception_type'] = type(error).__name__
            finally:
                signal.setitimer(signal.ITIMER_REAL, 0)
                connection.close()
            sample['rtt_ms'] = round((time.monotonic() - sent) * 1000, 3)
            samples.append(sample)
            next_sample += 1
            # Skip missed intervals instead of creating a catch-up request burst.
            now = time.monotonic()
            if next_sample < now:
                next_sample += int(now - next_sample) + 1
    finally:
        signal.setitimer(signal.ITIMER_REAL, 0)
        signal.signal(signal.SIGALRM, previous_handler)
    return {
        'probe': 'camera_http_info_headers',
        'duration_s': duration,
        'actual_duration_s': round(time.monotonic() - started, 3),
        'samples': samples,
    }


def main():
    if not 2 <= len(sys.argv) <= 3:
        raise SystemExit('Usage: camera_http_probe.py HOST:PORT [SECONDS=120]')
    result = probe(sys.argv[1], int(sys.argv[2]) if len(sys.argv) == 3 else 120)
    print(json.dumps(result), flush=True)


if __name__ == '__main__':
    main()
