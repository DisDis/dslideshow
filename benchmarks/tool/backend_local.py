#!/usr/bin/env python3
"""Local pure-Dart backend A/B runner; no Flutter, devices or dependency changes."""
import argparse
from collections import Counter
import hashlib
import json
import math
import os
from pathlib import Path
import platform
import shlex
import shutil
import signal
import subprocess
import tarfile
import time
from urllib.parse import unquote, urljoin, urlparse

TOOL = Path(__file__).resolve().parent
ROOT = TOOL.parents[1]


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def descendant_identities(parent):
    """Find process descendants across setsid, recording start ticks against PID reuse."""
    processes = {}
    for stat in Path("/proc").glob("[0-9]*/stat"):
        try:
            fields = stat.read_text().rsplit(")", 1)[1].split()
            processes[int(stat.parent.name)] = (int(fields[1]), fields[19])
        except (OSError, ValueError, IndexError):
            continue
    descendants = {}
    parents = {parent}
    while parents:
        children = {pid for pid, (ppid, _) in processes.items() if ppid in parents and pid not in descendants}
        for pid in children:
            descendants[pid] = processes[pid][1]
        parents = children
    return descendants


def signal_descendants(identities, signum):
    for pid, started in identities.items():
        try:
            fields = Path(f"/proc/{pid}/stat").read_text().rsplit(")", 1)[1].split()
            if fields[19] == started:
                os.kill(pid, signum)
        except (ProcessLookupError, FileNotFoundError):
            pass


def run_process(argv, *, env=None, timeout=120):
    """Kill the complete local process group on deadline, then reap and drain."""
    process = subprocess.Popen(argv, env=env, text=True, stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE, start_new_session=True)
    try:
        stdout, stderr = process.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        # Production command runners may use setsid themselves. Such children
        # are outside this launcher's group, but remain owned descendants.
        descendants = descendant_identities(process.pid)
        signal_descendants(descendants, signal.SIGTERM)
        try:
            os.killpg(process.pid, signal.SIGTERM)
        except ProcessLookupError:
            pass
        try:
            stdout, stderr = process.communicate(timeout=2)
        except subprocess.TimeoutExpired:
            signal_descendants(descendants, signal.SIGKILL)
            try:
                os.killpg(process.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
            stdout, stderr = process.communicate()
        signal_descendants(descendants, signal.SIGKILL)
        raise RuntimeError(f"Deadline: {argv!r}\n{stdout}\n{stderr}")
    if process.returncode:
        raise RuntimeError(f"Exit {process.returncode}: {argv!r}\n{stdout}\n{stderr}")
    return stdout, stderr


def fixture(directory, count, layout):
    """Distinct tiny metadata-only regular files; never passed to an image decoder."""
    directory = Path(directory)
    manifest_file = directory / "manifest.json"
    expected = {"count": count, "layout": layout, "content": "metadata-only-v1\n"}
    if manifest_file.exists():
        manifest = json.loads(manifest_file.read_text())
        if any(manifest.get(key) != value for key, value in expected.items()):
            raise ValueError(f"Fixture manifest mismatch: {directory}")
        actual = sorted((directory / "images").rglob("*.jpg"))
        path_hash = hashlib.sha256()
        for path in actual:
            if path.read_text() != expected["content"]:
                raise ValueError(f"Fixture content mismatch: {path}")
            path_hash.update((str(path.relative_to(directory)) + "\n").encode())
        if len(actual) != count or path_hash.hexdigest() != manifest["paths_sha256"]:
            raise ValueError(f"Fixture paths mismatch: {directory}")
        return manifest
    if directory.exists() and any(directory.iterdir()):
        raise ValueError(f"Refusing to overwrite an incomplete fixture: {directory}")
    directory.mkdir(parents=True, exist_ok=True)
    paths = []
    for index in range(count):
        folder = directory / "images"
        if layout == "nested":
            folder /= f"group-{index // 1000:03d}/album-{index // 100:04d}"
        folder.mkdir(parents=True, exist_ok=True)
        target = folder / f"photo-{index:06d}.jpg"
        target.write_text(expected["content"])
        paths.append(str(target.relative_to(directory)))
    manifest = {**expected, "decoded": False, "file_bytes": len(expected["content"]),
                "paths_sha256": hashlib.sha256("".join(path + "\n" for path in sorted(paths)).encode()).hexdigest()}
    manifest_file.write_text(json.dumps(manifest, indent=2) + "\n")
    return manifest


def snapshot(packages, destination, harness=None):
    packages = Path(packages).resolve()
    config = json.loads(packages.read_text())
    sources = destination / "sources"
    sources.mkdir()
    hashes = {}
    for item in config["packages"]:
        source = Path(unquote(urlparse(urljoin(packages.as_uri(), item["rootUri"])).path))
        if item["name"] in ("dslideshow_backend", "dslideshow_common"):
            target = sources / ("backend" if item["name"] == "dslideshow_backend" else "common")
            target.mkdir()
            shutil.copytree(source / "lib", target / "lib")
            for name in ("pubspec.yaml", "pubspec.lock"):
                if (source / name).exists():
                    shutil.copy2(source / name, target / name)
            source = target
        item["rootUri"] = source.as_uri() + "/"
    shutil.copy2(harness or TOOL / "backend_local.dart", sources / "backend_local.dart")
    shutil.copy2(__file__, sources / "backend_local.py")
    for path in sorted(sources.rglob("*")):
        if path.is_file():
            hashes[str(path.relative_to(sources))] = digest(path)
    (destination / "source-hashes.json").write_text(json.dumps(hashes, indent=2) + "\n")
    frozen_packages = destination / "package_config.json"
    frozen_packages.write_text(json.dumps(config, indent=2) + "\n")
    archive = destination / "source.tar.gz"
    with tarfile.open(archive, "w:gz") as out:
        out.add(sources, arcname="sources")
        out.add(frozen_packages, arcname="package_config.json")
    return frozen_packages, sources / "backend_local.dart", {
        "source_archive_sha256": digest(archive), "source_hashes_sha256": digest(destination / "source-hashes.json"),
        "harness_sha256": digest(sources / "backend_local.dart"),
    }


def sensor_fixture(directory):
    sensor = directory / "sensors.sh"
    sensor.write_text("#!/bin/sh\n"
                      'if [ -n "${BENCHMARK_EXEC_LOG:-}" ]; then printf "%s\\n" sensorsScript >> "$BENCHMARK_EXEC_LOG"; fi\n'
                      "printf 'temp=42.0\\047C\\nfan=1200 RPM\\n'\n")
    sensor.chmod(0o755)
    return sensor


def wrappers(directory):
    directory.mkdir()
    for name in ("df", "uptime", "free", "cat"):
        executable = shutil.which(name)
        if executable is None:
            raise FileNotFoundError(name)
        target = directory / name
        target.write_text('#!/bin/sh\nprintf "%s\\n" ' + shlex.quote(name) +
                          ' >> "$BENCHMARK_EXEC_LOG"\nexec ' + shlex.quote(executable) + ' "$@"\n')
        target.chmod(0o755)


def percentile(values, fraction):
    values = sorted(values)
    if not values:
        return None
    # Nearest-rank quantile, explicitly shared by all variants.
    return values[max(0, math.ceil(fraction * len(values)) - 1)]


def distribution(values):
    return {"n": len(values), "p50": percentile(values, .5), "p95": percentile(values, .95),
            "p99": percentile(values, .99), "max": max(values) if values else None}


def summarize(rows):
    result = {}
    for row in rows:
        if row["scenario"] == "storage":
            key = f"storage/{row['layout']}/{row['count']}"
            result.setdefault(key, []).append(row)
    summary = {}
    for key, values in result.items():
        summary[key] = {name: distribution([value[name] for value in values]) for name in
                        ("index_first_selection_ms", "remaining_selection_ms", "whole_cycle_ms")}
        summary[key]["hwm_bytes"] = distribution([value["after"]["hwm_bytes"] for value in values])
        summary[key]["self_cpu_ms"] = distribution([value["after"]["cpu_ms"] - value["before"]["cpu_ms"] for value in values])
    for row in rows:
        if row["scenario"] == "responsiveness":
            key = f"responsiveness/{row['layout']}/{row['count']}"
            probes = [probe for probe in row["rpc_probes"] if probe.get("status") == "ok"]
            values = summary.setdefault(key, {"rpc_ms": [], "scheduled_rpc_ms": [], "loop_ms": [], "dropped": 0, "loop_skipped": 0})
            values["rpc_ms"].extend(probe["latency_ms"] for probe in probes)
            values["scheduled_rpc_ms"].extend(probe["scheduled_latency_ms"] for probe in probes)
            values["loop_ms"].extend(probe["lag_ms"] for probe in row["event_loop_samples"])
            values["dropped"] += row["dropped_probe_intervals"]
            values["loop_skipped"] += sum(probe["skipped_intervals"] for probe in row["event_loop_samples"])
    for key, value in summary.items():
        if key.startswith("responsiveness/"):
            for name in ("rpc_ms", "scheduled_rpc_ms", "loop_ms"):
                value[name] = distribution(value[name])
    for row in rows:
        if row["scenario"] == "metrics":
            values = summary.setdefault("metrics", {})
            for metric in row["rows"]:
                key = f"{metric['phase']}/{metric['concurrency']}"
                values.setdefault(key, {"elapsed_ms": [], "self_cpu_ms": []})
                values[key]["elapsed_ms"].append(metric["elapsed_ms"])
                values[key]["self_cpu_ms"].append(metric["after"]["cpu_ms"] - metric["before"]["cpu_ms"])
    for value in summary.get("metrics", {}).values():
        for name in ("elapsed_ms", "self_cpu_ms"):
            value[name] = distribution(value[name])
    for row in rows:
        if row["scenario"] == "metrics_command_diagnostic":
            summary["direct_commands"] = dict(Counter(row["direct_command_invocations"]))
    return summary


def write_report(report_root):
    variants = {}
    provenance = {}
    for raw in sorted(report_root.glob("*/raw.jsonl")):
        variants[raw.parent.name] = summarize([json.loads(line) for line in raw.read_text().splitlines()])
        provenance[raw.parent.name] = json.loads((raw.parent / "provenance.json").read_text())
    compatible = len({(value["harness_sha256"], value["mode"], value["dart_version"]) for value in provenance.values()}) <= 1
    (report_root / "comparison.json").write_text(json.dumps(variants, indent=2) + "\n")
    accepted = next((name for name in ("candidate-approved", "candidate-final", "candidate") if name in variants), None)
    visible_variants = {name: value for name, value in variants.items()
                        if name == "baseline" or name == accepted}
    text = ["# Local backend measurements", "", "Pure Dart Linux host measurements, no RaPi5/GPU/Flutter run. "
            "Metadata-only files are never decoded. Nearest-rank quantiles; small sample counts do not establish stable p99. "
            "Whole-process RSS/HWM includes both isolates. Raw cpu_ms and summary self_cpu_ms cover only the Dart process "
            "utime/stime, exclude subprocess CPU, and have host CLK_TCK resolution. They do not measure the full cost of system commands.", "",
            "Harness/mode/SDK compatibility: " + ("matched" if compatible else "MISMATCH; do not compare variants") + ".", "",
            "| Variant | Layout/count | Index + first, p50 ms | Remaining N-1, p50 ms | Whole cycle, p50 ms | Peak HWM bytes |", "|---|---|---:|---:|---:|---:|"]
    for variant, summary in visible_variants.items():
        for key, value in summary.items():
            if key.startswith("storage/"):
                text.append(f"| {variant} | {key[8:]} | {value['index_first_selection_ms']['p50']:.3f} | "
                            f"{value['remaining_selection_ms']['p50']:.3f} | {value['whole_cycle_ms']['p50']:.3f} | {value['hwm_bytes']['max']} |")
    text += ["", "| Variant | Layout/count | RPC p95/max ms | Loop lag p95/max ms | Skipped probes / loop intervals |",
             "|---|---|---:|---:|---:|"]
    for variant, summary in visible_variants.items():
        for key, value in summary.items():
            if key.startswith("responsiveness/"):
                text.append(f"| {variant} | {key[15:]} | {value['rpc_ms']['p95']:.3f} / {value['rpc_ms']['max']:.3f} | "
                            f"{value['loop_ms']['p95']:.3f} / {value['loop_ms']['max']:.3f} | {value['dropped']} / {value['loop_skipped']} |")
    text += ["", "RPC samples include 60 ms before and after indexing. Saturated probes are explicitly skipped and counted, "
             "not converted to successful/zero latency measurements. Full scheduled latencies and event-loop gaps remain in raw JSONL.", "",
             "| Variant | Metric phase/concurrency | p50 / max elapsed ms | Samples |", "|---|---|---:|---:|"]
    for variant, summary in visible_variants.items():
        for key, value in summary.get("metrics", {}).items():
            metric = value["elapsed_ms"]
            text.append(f"| {variant} | {key} | {metric['p50']:.3f} / {metric['max']:.3f} | {metric['n']} |")
    for variant, summary in visible_variants.items():
        text += ["", f"{variant} separate diagnostic direct command invocations: `{json.dumps(summary.get('direct_commands', {}), sort_keys=True)}`.", ""]
    text += ["", "Index and cycle observations use independent fresh processes. Throughput includes URI result collection; "
             "it excludes decoding, fixtures, validation and RPC. The first selection includes index construction. "
             "No boundary rescan is included: exactly N selections are made.", "",
             "Metrics use real host /proc data and applicable df/uptime/free commands from each production implementation, plus a configured constant sensor script. "
             "Expired refreshes use 1100 ms spacing; the production frontend normally requests once per minute. "
             "Diagnostic direct-command counts come from forwarding wrappers in a separate pass, not process polling. "
             "They do not count all child processes or shell internals. Raw latency, missed probes, metrics values, process data, "
             "errors, provenance, binary and source archive are retained per variant.", "",
             "Baseline then candidate order is not a randomized A/B trial. Host contention, filesystem cache and runtime conditions "
             "limit conclusions; this report establishes local behavior and scaling only."]
    confirm_stem = next((name for name in ("confirm-approved", "confirm-final", "confirm")
                         if (report_root / f"{name}-summary.json").exists()), "confirm")
    if (report_root / f"{confirm_stem}-summary.json").exists():
        text += ["", f"A separate ABBA confirmation reuses the frozen AOT binaries: `{confirm_stem}-raw.jsonl`, "
                 f"`{confirm_stem}-summary.json`, `{confirm_stem}-provenance.json`. CPU there includes the reaped Dart process and its reaped "
                 "descendants via Python RUSAGE_CHILDREN, unlike self CPU above. It does not measure an empirical one-minute interval."]
        confirm = json.loads((report_root / f"{confirm_stem}-summary.json").read_text())
        confirm_rows = [json.loads(line) for line in (report_root / f"{confirm_stem}-raw.jsonl").read_text().splitlines()]
        if any(row["scenario"] == "storage" for row in confirm_rows):
            text += ["", "| ABBA variant | Layout/count | Whole cycle range ms | Remaining N-1 range ms | Observations |",
                     "|---|---|---:|---:|---:|"]
        for variant in confirm:
            for layout in ("flat", "nested"):
                measured = [row for row in confirm_rows if row["variant"] == variant and
                            row["scenario"] == "storage" and row["layout"] == layout]
                if not measured:
                    continue
                whole = [row["whole_cycle_ms"] for row in measured]
                remaining = [row["remaining_selection_ms"] for row in measured]
                text.append(f"| {variant} | {layout}/50000 | {min(whole):.3f}–{max(whole):.3f} | "
                            f"{min(remaining):.3f}–{max(remaining):.3f} | {len(measured)} |")
        text += ["", "| ABBA variant | Entire metrics scenario CPU incl. children, range ms | Observations |",
                 "|---|---:|---:|"]
        for variant in confirm:
            values = [row["process_and_reaped_children_cpu_ms"] for row in confirm_rows
                      if row["variant"] == variant and row["scenario"] == "metrics"]
            text.append(f"| {variant} | {min(values):.3f}–{max(values):.3f} | {len(values)} |")
        text += ["", "| ABBA variant | Individual expired refresh, range ms | Immediate cached call, range ms |",
                 "|---|---:|---:|"]
        for variant in confirm:
            measured = [row for row in confirm_rows if row["variant"] == variant and row["scenario"] == "metrics"]
            expired = [metric["elapsed_ms"] for row in measured for metric in row["rows"] if metric["phase"] == "expired_refresh"]
            immediate = [metric["elapsed_ms"] for row in measured for metric in row["rows"] if metric["phase"] == "immediate"]
            text.append(f"| {variant} | {min(expired):.3f}–{max(expired):.3f} | {min(immediate):.3f}–{max(immediate):.3f} |")
        text += ["", "The entire metrics scenario includes cold + immediate, one expired refresh, expired/cached bursts of 2 and 5. "
                 "The observations do not establish a consistent speedup of an individual expired refresh; read its actual range above separately "
                 "from cache-hit latency and aggregate burst CPU. In the final approved ABBA observations, expired refresh was slower."]
    if (report_root / "process-diagnostic.json").exists():
        diagnostic = json.loads((report_root / "process-diagnostic.json").read_text())
        if "unavailable" in diagnostic or any("unavailable" in item for item in diagnostic.get("variants", {}).values()):
            text += ["", "All-child-process tracing was unavailable in this environment (see `process-diagnostic.json` for the exact "
                     "strace failure). Forwarding-wrapper counts above remain direct-command invocations only; total child-process counts are unverified."]
    if accepted in ("candidate-final", "candidate-approved"):
        text += ["", f"This report compares baseline with {accepted}. The intermediate candidates and their confirmations are "
                 f"retained unchanged for audit, along with a superseded GPhoto review supplement. {accepted} includes the final GPhoto "
                 "release guard and ErrorResult serializers and was measured again with the same frozen baseline Dart harness."]
    if (report_root / "final-source-verification.json").exists():
        verification = json.loads((report_root / "final-source-verification.json").read_text())
        text += ["", f"Final production-source verification: `{verification['final_production_tree_sha256']}`; "
                 f"differences from {verification['measured_variant']} snapshot: `{verification['differences']}`. See `final-source-verification.json` for scope and algorithm."]
    (report_root / "report.md").write_text("\n".join(text) + "\n")


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dart", default="/home/dis/bin/flutter/bin/cache/dart-sdk/bin/dart")
    parser.add_argument("--packages", type=Path, required=True)
    parser.add_argument("--variant", required=True, choices=("baseline", "candidate", "candidate-final", "candidate-approved", "selftest"))
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--sizes", default="1,1000,10000,50000")
    parser.add_argument("--layouts", default="flat,nested")
    parser.add_argument("--repeats", type=int, default=3)
    parser.add_argument("--metrics-repeats", type=int, default=3)
    parser.add_argument("--mode", choices=("aot", "jit"), default="aot")
    parser.add_argument("--provenance", type=Path)
    parser.add_argument("--harness", type=Path, help="Reuse an earlier immutable Dart harness for a comparable candidate")
    args = parser.parse_args(argv)
    sizes = [int(size) for size in args.sizes.split(",")]
    layouts = args.layouts.split(",")
    if min(sizes) < 1 or args.repeats < 1 or args.metrics_repeats < 0 or any(layout not in ("flat", "nested") for layout in layouts):
        parser.error("Positive sizes/repeats and flat,nested layouts required")
    report_root = args.output.resolve()
    report_root.mkdir(parents=True, exist_ok=True)
    destination = report_root / args.variant
    destination.mkdir()  # Never replace an existing experiment or binary.
    frozen_packages, harness, provenance = snapshot(args.packages, destination, args.harness)
    if args.provenance:
        provenance["original_snapshot"] = json.loads(args.provenance.read_text())
    provenance.update({"mode": args.mode, "host": platform.uname()._asdict(),
                       "dart_version": run_process([args.dart, "--suppress-analytics", "--version"])[0].strip(),
                       "argv": vars(args) | {"packages": str(args.packages), "output": str(args.output), "provenance": str(args.provenance)},
                       "started_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())})
    if args.mode == "aot":
        binary = destination / "backend-local"
        compile_argv = [args.dart, "--suppress-analytics", "compile", "exe", f"--packages={frozen_packages}", str(harness), "-o", str(binary)]
        start = time.monotonic()
        stdout, stderr = run_process(compile_argv, timeout=180)
        (destination / "compile.log").write_text(stdout + stderr)
        provenance.update({"compile_seconds": time.monotonic() - start, "binary_sha256": digest(binary), "compile_argv": compile_argv})
        command = [str(binary)]
    else:
        command = [args.dart, f"--packages={frozen_packages}", str(harness)]
    (destination / "provenance.json").write_text(json.dumps(provenance, indent=2, default=str) + "\n")
    env = os.environ | {"BENCHMARK_CLK_TCK": str(os.sysconf("SC_CLK_TCK"))}
    rows = []
    raw = destination / "raw.jsonl"
    def record(row):
        rows.append(row)
        with raw.open("a") as output:
            output.write(json.dumps(row) + "\n")
    def execute(scenario, root, **values):
        start = time.monotonic()
        argv = command + [f"--scenario={scenario}"] + [f"--{key.replace('_', '-')}={value}" for key, value in values.items()]
        stdout, stderr = run_process(argv, env=env | {"DSLIDESHOW_ROOT": str(root)}, timeout=120)
        row = json.loads(stdout.strip().splitlines()[-1])
        if row["status"] != "ok":
            raise RuntimeError(row)
        row.update({"scenario": scenario, "process_wall_seconds": time.monotonic() - start, "stderr": stderr})
        return row
    try:
        for layout in layouts:
            for count in sizes:
                root = report_root / "fixtures" / f"{layout}-{count}"
                manifest = fixture(root, count, layout)
                for repeat in range(args.repeats):
                    for scenario in ("storage", "responsiveness"):
                        print(f"{args.variant} {scenario} {layout} {count} repeat {repeat}", flush=True)
                        row = execute(scenario, root, **({"count": count} if scenario == "storage" else {}))
                        row.update({"count": count, "layout": layout, "repeat": repeat, "fixture": manifest})
                        record(row)
        sensor = sensor_fixture(destination)
        disk = run_process(["df", "-P", str(destination)])[0].splitlines()[1].split()[0]
        env.update({"BENCHMARK_SENSOR_SCRIPT": str(sensor), "BENCHMARK_DISK_SOURCE": disk})
        record(execute("metrics", destination, repeats=args.metrics_repeats, interval_ms=1100))
        wrapper_dir = destination / "exec-wrappers"
        wrappers(wrapper_dir)
        env.update({"PATH": str(wrapper_dir) + os.pathsep + env["PATH"], "BENCHMARK_EXEC_LOG": str(destination / "direct-exec.log")})
        diagnostic = execute("metrics", destination, repeats=1, interval_ms=1100)
        diagnostic["scenario"] = "metrics_command_diagnostic"
        diagnostic["direct_command_invocations"] = (destination / "direct-exec.log").read_text().splitlines()
        record(diagnostic)
    except Exception as error:
        (destination / "failure.json").write_text(json.dumps({"error": str(error)}, indent=2) + "\n")
        raise
    finally:
        write_report(report_root)
    print(f"Report: {report_root / 'report.md'}", flush=True)


if __name__ == "__main__":
    main()
