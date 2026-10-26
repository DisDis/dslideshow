#!/usr/bin/env python3
"""Optional local process-count diagnostic; never use tracing for elapsed A/B."""
import argparse
import json
import os
from pathlib import Path
import re
import shutil

import backend_local as bench


def process_creations(text):
    """Count successful fork/vfork/non-thread clone results, including split lines."""
    pending = {}
    children = set()
    for line in text.splitlines():
        match = re.match(r"^(\d+)\s+(.*)$", line)
        if not match:
            continue
        tid, event = match.groups()
        resumed = re.match(r"<\.\.\. (clone3?|fork|vfork) resumed>(.*)$", event)
        if resumed:
            method, tail = resumed.groups()
            event = pending.pop((tid, method), "") + tail
        initial = re.match(r"(clone3?|fork|vfork)\(", event)
        if not initial:
            continue
        if "<unfinished ...>" in event:
            pending[(tid, initial[1])] = event.split("<unfinished ...>")[0]
            continue
        result = re.search(r"=\s+(\d+)\s*$", event)
        if result and "CLONE_THREAD" not in event:
            children.add(int(result[1]))
    return sorted(children)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    root = args.output.resolve()
    result_file = root / "process-diagnostic.json"
    if result_file.exists():
        raise FileExistsError(result_file)
    results = {"method": "strace -f -e trace=process; successful non-thread process creation events, excluding the harness itself",
               "timing": "diagnostic only; no elapsed-time comparison", "variants": {}}
    executable = shutil.which("strace")
    if executable is None:
        results["unavailable"] = "strace is not installed; no installation attempted"
    else:
        for variant in ("baseline", "candidate"):
            folder = root / variant
            binary = folder / "backend-local"
            provenance = json.loads((folder / "provenance.json").read_text())
            if bench.digest(binary) != provenance["binary_sha256"]:
                raise ValueError(f"Changed frozen binary: {variant}")
            trace = folder / "process-trace.log"
            disk = bench.run_process(["df", "-P", str(root)])[0].splitlines()[1].split()[0]
            command = [executable, "-f", "-e", "trace=process", "-o", str(trace), str(binary),
                       "--scenario=metrics", "--repeats=0", "--interval-ms=1100"]
            env = os.environ | {"BENCHMARK_SENSOR_SCRIPT": str(folder / "sensors.sh"),
                                "BENCHMARK_DISK_SOURCE": disk, "DSLIDESHOW_ROOT": str(root)}
            try:
                stdout, stderr = bench.run_process(command, env=env, timeout=30)
                children = process_creations(trace.read_text())
                results["variants"][variant] = {"child_process_count": len(children), "child_pids": children,
                                               "command": command, "stderr": stderr, "raw": json.loads(stdout.strip().splitlines()[-1])}
            except RuntimeError as error:
                results["variants"][variant] = {"unavailable": str(error), "command": command}
    result_file.write_text(json.dumps(results, indent=2) + "\n")
    print(result_file)


if __name__ == "__main__":
    main()
