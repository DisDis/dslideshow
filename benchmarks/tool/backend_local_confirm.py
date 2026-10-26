#!/usr/bin/env python3
"""ABBA confirmation with previously frozen AOT binaries, including child CPU."""
import argparse
import json
import os
from pathlib import Path
import resource
import time

import backend_local as bench


def execute(command, env):
    before = resource.getrusage(resource.RUSAGE_CHILDREN)
    start = time.monotonic()
    stdout, stderr = bench.run_process(command, env=env, timeout=120)
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    row = json.loads(stdout.strip().splitlines()[-1])
    if row.get("status") != "ok":
        raise RuntimeError(row)
    row.update({"process_wall_seconds": time.monotonic() - start, "stderr": stderr,
                "process_and_reaped_children_cpu_ms": 1000 * (
                    after.ru_utime + after.ru_stime - before.ru_utime - before.ru_stime)})
    return row


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--rounds", type=int, default=1)
    parser.add_argument("--candidate", choices=("candidate", "candidate-final", "candidate-approved"), default="candidate")
    parser.add_argument("--metrics-only", action="store_true", help="Confirm metric costs without repeating the storage workload")
    args = parser.parse_args()
    if args.rounds < 1:
        parser.error("Positive --rounds required")
    root = args.output.resolve()
    stem = {"candidate": "confirm", "candidate-final": "confirm-final", "candidate-approved": "confirm-approved"}[args.candidate]
    raw = root / f"{stem}-raw.jsonl"
    if raw.exists():
        raise FileExistsError(raw)
    provenance = {name: json.loads((root / name / "provenance.json").read_text())
                  for name in ("baseline", args.candidate)}
    if any(value["mode"] != "aot" for value in provenance.values()):
        raise ValueError("Confirmation requires frozen AOT binaries")
    if len({value["harness_sha256"] for value in provenance.values()}) != 1:
        raise ValueError("Different harnesses; cannot compare")
    rows = []
    for round_index in range(args.rounds):
        for order_index, variant in enumerate(("baseline", args.candidate, args.candidate, "baseline")):
            binary = root / variant / "backend-local"
            if bench.digest(binary) != provenance[variant]["binary_sha256"]:
                raise ValueError(f"Changed frozen binary: {variant}")
            env = os.environ | {"BENCHMARK_CLK_TCK": str(os.sysconf("SC_CLK_TCK"))}
            for layout in (() if args.metrics_only else ("flat", "nested")):
                fixture = root / "fixtures" / f"{layout}-50000"
                bench.fixture(fixture, 50000, layout)
                print(f"confirm {round_index}/{order_index} {variant} {layout}/50000", flush=True)
                row = execute([str(binary), "--scenario=storage", "--count=50000"],
                              env | {"DSLIDESHOW_ROOT": str(fixture)})
                row.update({"variant": variant, "scenario": "storage", "layout": layout,
                            "round": round_index, "order": order_index})
                rows.append(row)
                with raw.open("a") as output:
                    output.write(json.dumps(row) + "\n")
            disk = bench.run_process(["df", "-P", str(root)])[0].splitlines()[1].split()[0]
            row = execute([str(binary), "--scenario=metrics", "--repeats=1", "--interval-ms=1100"], env | {
                "DSLIDESHOW_ROOT": str(root), "BENCHMARK_SENSOR_SCRIPT": str(root / variant / "sensors.sh"),
                "BENCHMARK_DISK_SOURCE": disk,
            })
            row.update({"variant": variant, "scenario": "metrics", "round": round_index, "order": order_index})
            rows.append(row)
            with raw.open("a") as output:
                output.write(json.dumps(row) + "\n")
    summary = {}
    for variant in ("baseline", args.candidate):
        selected = [row for row in rows if row["variant"] == variant]
        summary[variant] = bench.summarize(selected)
        summary[variant]["metrics_process_and_reaped_children_cpu_ms"] = bench.distribution([
            row["process_and_reaped_children_cpu_ms"] for row in selected if row["scenario"] == "metrics"])
    (root / f"{stem}-summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    (root / f"{stem}-provenance.json").write_text(json.dumps({"argv": vars(args), "binaries": provenance,
        "order": "ABBA", "cpu": "Python RUSAGE_CHILDREN deltas after each reaped Dart process; includes its reaped descendants"}, indent=2, default=str) + "\n")


if __name__ == "__main__":
    main()
