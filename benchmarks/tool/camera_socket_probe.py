#!/usr/bin/env python3
"""Passive /proc observation; run on the frame, optionally through SSH stdin.

python3 - CONFIG_PATH PID [SECONDS]
Reads camera hosts but emits only camera indices, never URLs or credentials.
Does not open camera/MQTT connections or change the service/configuration.
"""
import collections
import datetime
import ipaddress
import json
from pathlib import Path
import sys
import time
from urllib.parse import urlsplit


def camera_endpoints(config):
    """Map IPv4 HTTP(S) endpoints to stable indices, including skipped sources."""
    cameras = {}
    camera_index = 0
    for screen in config.get('slideshow', {}).get('specialScreens', []):
        if screen.get('type') != 'cameras':
            continue
        for camera in screen.get('options', {}).get('cameras', []):
            try:
                url = urlsplit(camera['url'])
                if url.scheme not in ('http', 'https'):
                    continue
                address = ipaddress.IPv4Address(url.hostname)
                port = url.port if url.port is not None else (443 if url.scheme == 'https' else 80)
                endpoint = (address.packed[::-1].hex().upper(), port)
                cameras.setdefault(endpoint, []).append(camera_index)
            except (ValueError, KeyError):
                pass
            finally:
                camera_index += 1
    return cameras


def tcp_states(text, owned, endpoints):
    """Count only process-owned TCP sockets, separating camera and MQTT states."""
    states = collections.Counter()
    mqtt = collections.Counter()
    for row in text.splitlines()[1:]:
        fields = row.split()
        if f'socket:[{fields[9]}]' not in owned:
            continue
        address, port = fields[2].split(':')
        indices = endpoints.get((address, int(port, 16)))
        if indices is not None:
            # TCP cannot distinguish snapshot paths on the same endpoint.
            group = ','.join(str(index) for index in indices)
            states[f'{group}:{fields[3]}'] += 1
        if int(port, 16) == 1883:
            mqtt[fields[3]] += 1
    return states, mqtt


def main():
    config_path, process_id = sys.argv[1:3]
    duration = int(sys.argv[3]) if len(sys.argv) > 3 else 240
    if not 1 <= duration <= 1800:
        raise ValueError('Invalid duration')
    config = json.loads(Path(config_path).read_text())
    cameras = camera_endpoints(config)
    started = time.monotonic()
    while time.monotonic() - started < duration:
        proc = Path('/proc') / process_id
        owned = set()
        for descriptor in (proc / 'fd').iterdir():
            try:
                owned.add(descriptor.readlink().name)
            except FileNotFoundError:
                # A request may close between listing and reading a descriptor.
                pass
        states, mqtt = tcp_states(Path('/proc/net/tcp').read_text(), owned, cameras)
        print(json.dumps({
            'utc': datetime.datetime.now(datetime.timezone.utc).isoformat(),
            'elapsed_s': round(time.monotonic() - started, 3),
            'camera_tcp_states': dict(states), 'mqtt_tcp_states': dict(mqtt),
            'fds': len(list((proc / 'fd').iterdir())),
            'threads': len(list((proc / 'task').iterdir())),
        }), flush=True)
        time.sleep(1)


if __name__ == '__main__':
    main()
