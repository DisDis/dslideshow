#!/usr/bin/env python3
"""Capture only an owned tracefs instance; never configure the global tracer.

Usage (normally under the existing device supervisor):
  trace_instance.py init dslideshow_native_RUN /absolute/new/output
  trace_instance.py start dslideshow_native_RUN /absolute/new/output
  trace_instance.py stop dslideshow_native_RUN /absolute/new/output
  trace_instance.py close dslideshow_native_RUN /absolute/new/output

`init` exclusively creates the output directory and instance. DRM queued and
delivered events and at least one CL submission spelling are required. Other
V3D events are optional, with availability and kernel formats recorded explicitly.
No GPU is opened and no global tracefs control is written. This is diagnostic
instrumentation; its timings must not replace an uninstrumented performance run.
"""

import argparse
import contextlib
import fcntl
import json
import os
from pathlib import Path
import re
import signal
import shutil
import sys
import time
import uuid


_NAME = re.compile(r"dslideshow_native_[a-zA-Z0-9_]+")
_STAT = re.compile(r"^([^:]+):\s*(\d+)\s*$")
_DRM = ("drm/drm_vblank_event_queued", "drm/drm_vblank_event_delivered")
_CL = ("v3d/v3d_submit_cl", "v3d/v3d_submit_cl_ioctl")
_OPTIONAL = (
    "v3d/v3d_bcl_irq", "v3d/v3d_rcl_irq",
    "v3d/v3d_submit_csd", "v3d/v3d_submit_csd_ioctl", "v3d/v3d_csd_irq",
    "v3d/v3d_submit_tfu", "v3d/v3d_submit_tfu_ioctl", "v3d/v3d_tfu_irq",
)
_PROVENANCE = "trace-provenance.json"
_LOSS_COUNTERS = ("overrun", "commit_overrun", "dropped_events")


class TraceError(RuntimeError):
    pass


def _clock():
    return {"monotonic_ns": time.monotonic_ns(), "realtime_ns": time.time_ns()}


def _interrupted(signum, _frame):
    raise TraceError(f"Interrupted by {signal.Signals(signum).name}")


def _active_clock(text):
    tokens = text.split()
    selected = [token[1:-1] for token in tokens if token.startswith("[") and token.endswith("]")]
    return selected[0] if len(selected) == 1 else (tokens[0] if len(tokens) == 1 else None)


def _safe_path(path):
    path = Path(path)
    if not path.is_absolute():
        raise TraceError(f"Use an absolute path: {path}")
    if path != path.resolve() or path == Path(path.anchor):
        raise TraceError(f"Use an absolute, non-symlink path: {path}")
    return path


def _output_owner():
    if os.geteuid() != 0:
        return None
    values = (os.environ.get("SUDO_UID"), os.environ.get("SUDO_GID"))
    if values == (None, None):
        return None
    owner = []
    for value in values:
        if (not value or any(char < "0" or char > "9" for char in value)
                or int(value) > 4294967294):
            raise TraceError("SUDO_UID and SUDO_GID must both be valid numeric IDs")
        owner.append(int(value))
    return tuple(owner)


def _write_json(path, value, *, exclusive=False):
    if exclusive:
        with path.open("x", encoding="utf-8") as stream:
            json.dump(value, stream, indent=2)
            stream.write("\n")
        return
    temporary = path.with_name(f".{path.name}.{uuid.uuid4().hex}.tmp")
    try:
        with temporary.open("x", encoding="utf-8") as stream:
            json.dump(value, stream, indent=2)
            stream.write("\n")
        temporary.replace(path)
    finally:
        temporary.unlink(missing_ok=True)


def _create_instance(instance):
    # tracefs populates the controls and event directories automatically.
    instance.mkdir()


def _remove_instance(instance):
    # Virtual tracefs children must not be unlinked recursively.
    instance.rmdir()


@contextlib.contextmanager
def _lock(output):
    flags = os.O_CREAT | os.O_RDWR | os.O_NOFOLLOW
    descriptor = os.open(output / ".session.lock", flags, 0o600)
    try:
        fcntl.flock(descriptor, fcntl.LOCK_EX | fcntl.LOCK_NB)
        yield
    finally:
        os.close(descriptor)


def _event_inventory(tracefs):
    events = {}
    for event in (*_DRM, *_CL, *_OPTIONAL):
        path = tracefs / "events" / event / "format"
        available = path.is_file()
        events[event] = {
            "available": available,
            "required": event in _DRM,
            "required_group": "cl_submission" if event in _CL else None,
            "selected": available,
            "format": path.read_text() if available else None,
        }
    return events


def _assert_owned(state, instance, name, tracefs, *, allow_removed=False):
    if (state.get("schema_version") != 1 or state.get("instance_name") != name
            or state.get("tracefs") != str(tracefs)
            or state.get("instance") != str(instance)):
        raise TraceError("Output provenance does not identify this instance")
    if allow_removed and state.get("status") in ("closed", "failed") and not instance.exists():
        return
    if (instance.is_symlink() or not instance.is_dir()
            or instance.stat().st_ino != state.get("instance_inode")):
        raise TraceError("Instance identity changed; refusing to operate on it")


def _cleanup(instance, state):
    errors = []
    if instance.is_dir() and not instance.is_symlink():
        if instance.stat().st_ino != state.get("instance_inode"):
            return ["Instance identity changed; not removed"]
        try:
            (instance / "tracing_on").write_text("0")
        except OSError as error:
            errors.append(f"disable: {error}")
        try:
            _remove_instance(instance)
        except OSError as error:
            errors.append(f"remove: {error}")
    return errors


def _init(name, output, tracefs, instance, buffer_size_kb, owner):
    output.mkdir(mode=0o700)  # Refuse reuse, including a previous partial run.
    if owner is not None:
        # Only the directory created by the successful exclusive mkdir is ours.
        # Preserve access to preflight failure evidence without touching a
        # colliding output directory or any tracefs instance.
        os.chown(output, *owner)
    with _lock(output):
        state = {
            "schema_version": 1, "instance_name": name,
            "tracefs": str(tracefs), "instance": str(instance),
            "instance_inode": None, "status": "initializing",
            "created": _clock(),
            "kernel": dict(zip(("sysname", "nodename", "release", "version", "machine"), os.uname())),
            "buffer_size_kb_per_cpu_requested": buffer_size_kb,
            "output_owner": None if owner is None else {"uid": owner[0], "gid": owner[1]},
            "required_event_groups": {"drm": list(_DRM), "cl_submission_any": list(_CL)},
        }
        _write_json(output / _PROVENANCE, state, exclusive=True)
        owned = False
        try:
            state["events"] = _event_inventory(tracefs)
            available = tracefs / "available_events"
            state["available_events"] = available.read_text() if available.is_file() else None
            missing = [event for event in _DRM if not state["events"][event]["available"]]
            if not any(state["events"][event]["available"] for event in _CL):
                missing.append("cl_submission_any:" + "|".join(_CL))
            state["missing_required"] = missing
            if missing:
                raise TraceError("Missing required trace events: " + ", ".join(missing))
            _create_instance(instance)  # Atomic collision check; never adopt an existing instance.
            owned = True
            state["instance_inode"] = instance.stat().st_ino
            # Leave ownership evidence for supervisor cleanup even if preparation
            # is interrupted before event enablement finishes.
            _write_json(output / _PROVENANCE, state)
            (instance / "tracing_on").write_text("0")
            clocks = (instance / "trace_clock").read_text()
            state["trace_clock_available"] = clocks
            if "mono" not in [clock.strip("[]") for clock in clocks.split()]:
                raise TraceError("The private trace instance has no mono clock")
            (instance / "trace_clock").write_text("mono")
            (instance / "current_tracer").write_text("nop")
            (instance / "buffer_size_kb").write_text(str(buffer_size_kb))
            state["trace_clock_readback"] = (instance / "trace_clock").read_text().strip()
            state["trace_clock"] = _active_clock(state["trace_clock_readback"])
            if state["trace_clock"] != "mono":
                raise TraceError("The private trace instance did not select the mono clock")
            state["buffer_size_kb_per_cpu_actual"] = (instance / "buffer_size_kb").read_text().strip()
            state["initial_cpus"] = sorted(path.name for path in (instance / "per_cpu").glob("cpu*"))
            for event, information in state["events"].items():
                if information["selected"]:
                    control = instance / "events" / event
                    # Keep the actual enabled format, not an inferred field layout.
                    information["format"] = (control / "format").read_text()
                    (control / "enable").write_text("1")
            state["status"] = "initialized"
            _write_json(output / _PROVENANCE, state)
        except Exception as error:
            state.update(status="failed", error=str(error), failed=_clock())
            state["cleanup_errors"] = _cleanup(instance, state) if owned else []
            _write_json(output / _PROVENANCE, state)
            raise


def _save_stats(instance, output, state):
    per_cpu = {}
    for path in sorted((instance / "per_cpu").glob("cpu*/stats")):
        raw = path.read_text()
        counters = {}
        for line in raw.splitlines():
            match = _STAT.fullmatch(line.strip())
            if match:
                counters[match[1].strip().lower().replace(" ", "_")] = int(match[2])
        per_cpu[path.parent.name] = {"raw": raw, "counters": counters}
    missing = sorted(set(state["initial_cpus"]) - per_cpu.keys())
    loss_values = [cpu["counters"][key] for cpu in per_cpu.values()
                   for key in _LOSS_COUNTERS if key in cpu["counters"]]
    complete = (bool(per_cpu) and not missing
                and all("overrun" in cpu["counters"] for cpu in per_cpu.values()))
    result = {
        "schema_version": 1, "collected": _clock(), "per_cpu": per_cpu,
        "missing_cpus": missing, "stats_complete": complete,
        "loss_detected": any(value > 0 for value in loss_values) if complete else None,
    }
    _write_json(output / "trace-stats.json", result, exclusive=True)
    state["stats_complete"] = result["stats_complete"]
    state["loss_detected"] = result["loss_detected"]


def run(action, name, output, *, tracefs=Path("/sys/kernel/tracing"), buffer_size_kb=8192):
    if not _NAME.fullmatch(name):
        raise TraceError("Invalid instance name; expected dslideshow_native_[a-zA-Z0-9_]+")
    if type(buffer_size_kb) is not int or not 8192 <= buffer_size_kb <= 16384:
        raise TraceError("Per-CPU buffer must be between 8192 and 16384 KiB")
    tracefs, output = _safe_path(tracefs), _safe_path(output)
    if output.is_relative_to(tracefs):
        raise TraceError("Output must be outside tracefs")
    instance = tracefs / "instances" / name
    if action == "init":
        return _init(name, output, tracefs, instance, buffer_size_kb, _output_owner())
    if action not in ("start", "stop", "close"):
        raise TraceError(f"Unknown action: {action}")
    with _lock(output):
        state = json.loads((output / _PROVENANCE).read_text())
        _assert_owned(state, instance, name, tracefs, allow_removed=action == "close")
        try:
            if action == "start":
                if state["status"] != "initialized":
                    raise TraceError("Start requires a new initialized capture")
                (instance / "trace").write_text("")
                state["started"] = _clock()
                (instance / "tracing_on").write_text("1")
                state["status"] = "running"
            elif action == "stop":
                if state["status"] != "running":
                    raise TraceError("Stop requires a running capture")
                (instance / "tracing_on").write_text("0")
                state["stopped"] = _clock()
                with (instance / "trace").open("rb") as source:
                    with (output / "trace.txt").open("xb") as destination:
                        shutil.copyfileobj(source, destination)
                _save_stats(instance, output, state)
                state["status"] = "stopped"
            else:
                errors = _cleanup(instance, state)
                if errors:
                    raise TraceError("; ".join(errors))
                state.update(status="closed", closed=_clock())
            _write_json(output / _PROVENANCE, state)
        except Exception as error:
            state.update(status="failed", error=str(error), failed=_clock())
            state["cleanup_errors"] = _cleanup(instance, state)
            _write_json(output / _PROVENANCE, state)
            raise


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("action", choices=("init", "start", "stop", "close"))
    parser.add_argument("name")
    parser.add_argument("output", type=Path)
    parser.add_argument("--tracefs", type=Path, default=Path("/sys/kernel/tracing"))
    parser.add_argument("--buffer-size-kb", type=int, default=8192)
    args = parser.parse_args(argv)
    previous = {value: signal.signal(value, _interrupted) for value in (signal.SIGTERM, signal.SIGINT)}
    try:
        run(args.action, args.name, args.output, tracefs=args.tracefs, buffer_size_kb=args.buffer_size_kb)
    except (OSError, ValueError, TraceError) as error:
        print(f"trace_instance: {error}", file=sys.stderr)
        return 1
    finally:
        for value, handler in previous.items():
            signal.signal(value, handler)
    return 0


if __name__ == "__main__":
    sys.exit(main())
