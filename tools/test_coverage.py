#!/usr/bin/env python3
"""Collect local VM coverage and inventory sources missing from LCOV.

No dependencies are installed, source files are never instrumented/rewritten,
and only test/ is accepted (no browser/device/integration test execution).
"""

import argparse
import csv
from datetime import datetime, timezone
import hashlib
import html
import itertools
import json
import os
from pathlib import Path
import re
import shutil
import signal
import subprocess
import sys
import time
from urllib.parse import unquote, urljoin, urlparse


ROOT = Path(__file__).resolve().parents[1]
PACKAGES = {
    "backend": "dslideshow_backend",
    "config_app": "config_app",
    "dslideshow_flutter": "dslideshow_flutter",
}
GENERATED = (".g.dart", ".freezed.dart")
IMPORT = re.compile(r"(?:import|export)\s+['\"]([^'\"]+)['\"]")
TEST_FLAGS = {
    "real_delay": re.compile(r"Future(?:<[^>]+>)?\.delayed\s*\(|\bsleep\s*\("),
    "pump_and_settle": re.compile(r"\bpumpAndSettle\s*\("),
    "widget_count": re.compile(r"\bfindsNWidgets\s*\("),
    "skip": re.compile(r"\bskip\s*:"),
}


def write_json(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def source_snapshot(root):
    """Hash inputs including tests, shaders, shared packages and lock files."""
    files = {}
    for package in (*PACKAGES, "common", "i18n", "system_metrics_widget"):
        base = root / package
        for directory in ("lib", "bin", "test", "integration_test", "assets"):
            for path in sorted((base / directory).rglob("*")):
                if path.is_file() and not path.is_symlink():
                    files[path.relative_to(root).as_posix()] = hashlib.sha256(path.read_bytes()).hexdigest()
        for name in ("pubspec.yaml", "pubspec.lock", "analysis_options.yaml"):
            path = base / name
            if path.is_file():
                files[path.relative_to(root).as_posix()] = hashlib.sha256(path.read_bytes()).hexdigest()
    digest = hashlib.sha256(json.dumps(files, sort_keys=True).encode()).hexdigest()
    return {"sha256": digest, "files": files}


def inventory(root):
    result, excluded = {}, []
    for package in PACKAGES:
        for directory in ("lib", "bin"):
            for path in sorted((root / package / directory).rglob("*.dart")):
                key = path.relative_to(root).as_posix()
                content = path.read_text()
                if path.name.endswith(GENERATED) or "GENERATED CODE" in content[:500] or path.name == "generated_plugin_registrant.dart":
                    excluded.append(key)
                else:
                    result[key] = {"package": package, "source_lines": len(content.splitlines())}
    return result, excluded


def resolve_source(value, root, package):
    if value.startswith("package:"):
        name, _, relative = value[8:].partition("/")
        directory = next((key for key, val in PACKAGES.items() if val == name), None)
        return f"{directory}/lib/{relative}" if directory else None
    path = Path(unquote(urlparse(value).path)) if value.startswith("file:") else Path(value)
    if not path.is_absolute():
        path = root / package / path
    try:
        return path.resolve().relative_to(root.resolve()).as_posix()
    except ValueError:
        return None


def empty_record():
    return {"lines": {}, "branches": {}, "functions": {}}


def read_lcov(path, root, package):
    """Merge duplicate records by line/branch identity; don't trust LF/LH."""
    records = {}
    current = None
    function_keys = {}
    for raw in path.read_text().splitlines():
        if raw.startswith("SF:"):
            key = resolve_source(raw[3:], root, package)
            current = records.setdefault(key, empty_record()) if key else None
            function_keys = {}
        elif raw == "end_of_record":
            current = None
        elif current is not None and raw.startswith("DA:"):
            line, count, *_ = raw[3:].split(",")
            line = int(line)
            current["lines"][line] = current["lines"].get(line, 0) + int(count)
        elif current is not None and raw.startswith("BRDA:"):
            line, block, branch, count = raw[5:].split(",")
            key = f"{line},{block},{branch}"
            current["branches"][key] = current["branches"].get(key, 0) + (0 if count == "-" else int(count))
        elif current is not None and raw.startswith("FN:"):
            line, name = raw[3:].split(",", 1)
            key = f"{line},{name}"
            function_keys[name] = key
            current["functions"].setdefault(key, 0)
        elif current is not None and raw.startswith("FNDA:"):
            count, name = raw[5:].split(",", 1)
            if name not in function_keys:
                raise ValueError(f"FNDA has no FN declaration: {name}")
            key = function_keys[name]
            current["functions"][key] = current["functions"].get(key, 0) + int(count)
    return records


def merge_records(groups):
    merged = {}
    for records in groups:
        for path, values in records.items():
            target = merged.setdefault(path, empty_record())
            for kind in target:
                for key, count in values[kind].items():
                    target[kind][key] = target[kind].get(key, 0) + count
    return merged


def metrics(record):
    lines, branches = record["lines"], record["branches"]
    return {"lines_found": len(lines), "lines_hit": sum(n > 0 for n in lines.values()),
            "branches_found": len(branches), "branches_hit": sum(n > 0 for n in branches.values()),
            "functions_found": len(record["functions"]), "functions_hit": sum(n > 0 for n in record["functions"].values())}


def totals(records):
    result = dict.fromkeys(("lines_found", "lines_hit", "branches_found", "branches_hit", "functions_found", "functions_hit"), 0)
    for record in records.values():
        for key, value in metrics(record).items():
            result[key] += value
    result["line_percent"] = round(100 * result["lines_hit"] / result["lines_found"], 2) if result["lines_found"] else None
    result["branch_percent"] = round(100 * result["branches_hit"] / result["branches_found"], 2) if result["branches_found"] else None
    result["function_percent"] = round(100 * result["functions_hit"] / result["functions_found"], 2) if result["functions_found"] else None
    return result


def write_lcov(path, records):
    output = []
    for name, record in sorted(records.items()):
        output.append(f"SF:{name}")
        output.extend(f"FN:{key}" for key in sorted(record["functions"]))
        output.extend(f"FNDA:{count},{key.split(',', 1)[1]}" for key, count in sorted(record["functions"].items()))
        output.extend(f"DA:{line},{count}" for line, count in sorted(record["lines"].items()))
        output.extend(f"BRDA:{key},{count}" for key, count in sorted(record["branches"].items()))
        m = metrics(record)
        output.extend((f"FNF:{m['functions_found']}", f"FNH:{m['functions_hit']}", f"LF:{m['lines_found']}", f"LH:{m['lines_hit']}", f"BRF:{m['branches_found']}", f"BRH:{m['branches_hit']}", "end_of_record"))
    path.write_text("\n".join(output) + "\n")


def test_index(root):
    result = []
    for package in PACKAGES:
        for path in sorted((root / package / "test").rglob("*_test.dart")):
            source = path.read_text()
            result.append({"path": path.relative_to(root).as_posix(),
                           "lines": len(source.splitlines()), "imports": IMPORT.findall(source),
                           "review_hints": {key: len(pattern.findall(source)) for key, pattern in TEST_FLAGS.items() if pattern.search(source)}})
    return result


def hit_set(records):
    return {(path, line) for path, record in records.items() for line, count in record["lines"].items() if count > 0}


def overlap(groups):
    result = []
    for left, right in itertools.combinations(groups, 2):
        a, b = hit_set(groups[left]), hit_set(groups[right])
        result.append({"left": left, "right": right, "shared_hit_lines": len(a & b),
                       "left_only": len(a - b), "right_only": len(b - a),
                       "jaccard_percent": round(100 * len(a & b) / len(a | b), 2) if a | b else None})
    return result


def test_results(path):
    """Read test runner JSON events, ignoring CLI preambles and log lines."""
    started, done, suites, start_times = {}, {}, {}, {}
    for line in path.read_text().splitlines() if path.exists() else []:
        try:
            event = json.loads(line)
        except ValueError:
            continue
        if not isinstance(event, dict):
            continue
        if event.get("type") == "testStart":
            started[event["test"]["id"]] = event["test"]
            start_times[event["test"]["id"]] = event.get("time")
        elif event.get("type") == "suite":
            suites[event["suite"]["id"]] = event["suite"].get("path")
        elif event.get("type") == "testDone":
            done[event["testID"]] = event
    counts = dict.fromkeys(("passed", "failed", "skipped", "hidden", "unfinished"), 0)
    failures, timings = [], []
    for key, test in started.items():
        event = done.get(key)
        if event is None:
            counts["unfinished"] += 1
        elif event.get("hidden"):
            counts["hidden"] += 1
        elif event.get("skipped"):
            counts["skipped"] += 1
        elif event.get("result") == "success":
            counts["passed"] += 1
        else:
            counts["failed"] += 1
            failures.append({"name": test["name"], "suite": suites.get(test.get("suiteID"))})
        if event is not None and not event.get("hidden") and start_times[key] is not None and event.get("time") is not None:
            timings.append({"name": test["name"], "suite": suites.get(test.get("suiteID")),
                            "milliseconds": event["time"] - start_times[key]})
    return {**counts, "failures": failures, "slowest_instrumented_tests": sorted(timings, key=lambda row: row["milliseconds"], reverse=True)[:10]}


def summarize(run, root):
    manifest = json.loads((run / "manifest.json").read_text())
    sources, excluded = (manifest["inventory"], manifest["excluded_generated"]) if "inventory" in manifest else inventory(root)
    groups = {}
    for package in manifest["packages"]:
        path = run / package / "lcov.info"
        if path.exists():
            groups[package] = {k: v for k, v in read_lcov(path, root, package).items() if k in sources}
    merged = merge_records(groups.values())
    files = []
    for name, info in sources.items():
        record = merged.get(name, empty_record())
        files.append({"path": name, **info, **metrics(record),
                      "status": "measured" if record["lines"] else "not_measured",
                      "uncovered_lines": [line for line, count in sorted(record["lines"].items()) if count == 0],
                      "hit_by": [group for group, records in groups.items() if name in records and any(records[name]["lines"].values())]})
    current = source_snapshot(root)
    changed = sorted(k for k in manifest["snapshot"]["files"].keys() | current["files"].keys()
                     if manifest["snapshot"]["files"].get(k) != current["files"].get(k))
    complete = manifest["status"] == "finished" and len(groups) == len(manifest["packages"])
    passed = complete and not changed and all(result["exit_code"] == 0 for results in manifest.get("results", {}).values() for result in results.values())
    summary = {"schema_version": 1, "reporter_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
               "manifest": "manifest.json", "run_status": manifest["status"], "checks_passed": passed, "source_changed": changed,
               "excluded_generated": excluded, "files": files, "packages": {},
               "suite_matrix": {}, "suite_overlap": overlap(groups),
               "tests": {p: test_results(run / p / "tests.jsonl") for p in manifest["packages"]},
               "limits": ["Percentages describe only executable lines reported by the VM, not every source file.",
                          "Missing files have unknown executable-line denominators; see not_measured.",
                          "Line hits and overlap do not measure assertion quality or prove redundancy.",
                          "No browser, device, native integration or shader coverage is claimed.",
                          "Flutter LCOV is original collector output; Flutter does not retain raw coverage JSON here."]}
    for package in PACKAGES:
        belongs = lambda name: sources[name]["package"] == package
        own = {k: v for k, v in groups.get(package, {}).items() if belongs(k)}
        union = {k: v for k, v in merged.items() if belongs(k)}
        summary["packages"][package] = {"own_suite": totals(own), "all_suites": totals(union),
                                           "source_files": sum(info["package"] == package for info in sources.values()),
                                           "not_measured": [f["path"] for f in files if f["package"] == package and f["status"] == "not_measured"]}
    for suite, records in groups.items():
        summary["suite_matrix"][suite] = {package: totals({k: v for k, v in records.items() if sources[k]["package"] == package}) for package in PACKAGES}
    write_json(run / "summary.json", summary)
    write_json(run / "test-index.json", manifest.get("test_index") or test_index(root))
    write_lcov(run / "union.lcov.info", merged)
    with (run / "files.csv").open("w", newline="") as stream:
        fields = ("path", "status", "source_lines", "lines_found", "lines_hit", "branches_found", "branches_hit", "functions_found", "functions_hit", "uncovered_lines", "hit_by")
        writer = csv.DictWriter(stream, fields, extrasaction="ignore")
        writer.writeheader()
        writer.writerows({**f, "uncovered_lines": " ".join(map(str, f["uncovered_lines"])), "hit_by": " ".join(f["hit_by"])} for f in files)
    rows = []
    for f in files:
        missed = ", ".join(map(str, f["uncovered_lines"]))
        rows.append(f"<tr><td>{html.escape(f['path'])}</td><td>{f['status']}</td><td>{f['lines_hit']}/{f['lines_found']}</td><td>{f['branches_hit']}/{f['branches_found']}</td><td>{missed}</td></tr>")
    (run / "index.html").write_text("<!doctype html><meta charset=utf-8><title>Local VM coverage</title>"
        "<style>body{font:14px sans-serif;margin:24px}table{border-collapse:collapse}td,th{border:1px solid #ccc;padding:8px;vertical-align:top}td:last-child{max-width:500px;overflow-wrap:anywhere}</style>"
        "<h1>Local VM coverage</h1><p>Measured executable lines only. Missing files are listed separately. "
        "Line hits do not prove assertions. See summary.json and manifest.json for provenance and limits.</p>"
        + ("<p>WARNING: source inputs changed; do not treat this run as a consistent baseline.</p>" if changed else "")
        + ("<p>WARNING: this run is incomplete or has failed checks. See manifest.json.</p>" if not passed else "")
        + "<table><tr><th>Source</th><th>Status</th><th>Lines</th><th>Branches</th><th>Uncovered lines</th></tr>" + "".join(rows) + "</table>")
    return summary


def execute(command, cwd, log, env):
    start = time.monotonic()
    with log.open("w") as stream:
        process = subprocess.Popen(command, cwd=cwd, stdout=stream, stderr=subprocess.STDOUT, env=env, start_new_session=True)
        try:
            code = process.wait()
        except KeyboardInterrupt:
            os.killpg(process.pid, signal.SIGTERM)
            try:
                process.wait(timeout=10)
            except subprocess.TimeoutExpired:
                os.killpg(process.pid, signal.SIGKILL)
                process.wait()
            raise
    return {"command": command, "cwd": str(cwd), "exit_code": code, "seconds": round(time.monotonic() - start, 3), "log": str(log)}


def require_package_configs(root, packages):
    for package in packages:
        path = root / package / ".dart_tool/package_config.json"
        config = json.loads(path.read_text())
        if package == "backend":
            entry = next((p for p in config["packages"] if p["name"] == "coverage"), None)
            if entry is None:
                raise RuntimeError("coverage must already be resolved in backend; no dependency installation is performed")
            uri = urljoin(path.as_uri(), entry["rootUri"].rstrip("/") + "/")
            binary = Path(unquote(urlparse(uri).path)) / "bin/test_with_coverage.dart"
            if not binary.is_file():
                raise RuntimeError("resolved coverage package is unavailable; prepare dependencies separately")


def collect(args):
    root = args.root.resolve()
    require_package_configs(root, args.packages)
    run = args.out.resolve() if args.out else root / ".local/test-coverage" / datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S%fZ")
    # Never overwrite an old run or silently consume stale LCOV.
    run.mkdir(parents=True, exist_ok=False)
    manifest = {"schema_version": 1, "started_utc": datetime.now(timezone.utc).isoformat(),
                "root": str(root), "packages": args.packages, "tests": args.tests or ["test"],
                "snapshot": source_snapshot(root), "results": {}, "status": "running"}
    manifest["inventory"], manifest["excluded_generated"] = inventory(root)
    manifest["test_index"] = test_index(root)
    manifest["collector_sha256"] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    for key, command in (("commit", ["git", "rev-parse", "HEAD"]), ("git_status", ["git", "status", "--short"])):
        manifest[key] = subprocess.check_output(command, cwd=root, text=True).strip()
    dart, flutter = shutil.which("dart"), shutil.which("flutter")
    if not dart or not flutter:
        raise RuntimeError("dart and flutter must already be on PATH")
    env = dict(os.environ, FLUTTER_SUPPRESS_ANALYTICS="true", DART_SUPPRESS_ANALYTICS="true", FLUTTER_SKIP_UPDATE_CHECK="true")
    env.pop("DSLIDESHOW_EMBEDDED", None)
    manifest["environment"] = {"DSLIDESHOW_EMBEDDED": "unset", "platform": sys.platform}
    manifest["sdk"] = subprocess.check_output([dart, "--version"], stderr=subprocess.STDOUT, text=True, env=env).strip()
    write_json(run / "manifest.json", manifest)
    try:
        for package in args.packages:
            cwd, output = root / package, run / package
            output.mkdir()
            tests = args.tests or ["test"]
            for test in tests:
                target = (cwd / test).resolve()
                if not target.is_relative_to(cwd / "test") or not target.exists():
                    raise ValueError(f"Only existing test/ paths are accepted: {test}")
            result = {}
            manifest["results"][package] = result
            if args.analyze:
                cmd = [dart, "analyze"] if package == "backend" else [flutter, "analyze", "--no-pub"]
                result["analysis"] = execute(cmd, cwd, output / "analysis.log", env)
                print(f"{package}: analysis exit={result['analysis']['exit_code']}", flush=True)
            if package == "backend":
                cmd = [dart, "run", "coverage:test_with_coverage", "--function-coverage", "--branch-coverage", "--out", str(output)]
                cmd += [f"--scope-output={name}" for name in PACKAGES.values()]
                cmd += ["--", "--concurrency=1", "--reporter=json", *tests]
            else:
                cmd = [flutter, "test", "--no-pub", "--coverage", "--branch-coverage", "--coverage-path", str(output / "lcov.info"),
                       "--coverage-package=^(dslideshow_backend|config_app|dslideshow_flutter)$", "--reporter=json", *tests]
            print(f"{package}: collecting VM coverage", flush=True)
            result["tests"] = execute(cmd, cwd, output / "tests.jsonl", env)
            result["coverage_present"] = {"exit_code": 0 if (output / "lcov.info").is_file() and (output / "lcov.info").stat().st_size else 1}
            print(f"{package}: tests exit={result['tests']['exit_code']} ({result['tests']['seconds']}s)", flush=True)
            write_json(run / "manifest.json", manifest)
        manifest["status"] = "finished"
    except BaseException as error:
        manifest["status"] = "interrupted" if isinstance(error, KeyboardInterrupt) else "failed"
        manifest["error_type"] = type(error).__name__
        raise
    finally:
        manifest["finished_utc"] = datetime.now(timezone.utc).isoformat()
        write_json(run / "manifest.json", manifest)
        summarize(run, root)
        print(f"Report: {run}", flush=True)
    return int(any(item["exit_code"] != 0 for result in manifest["results"].values() for item in result.values()))


def merge_runs(runs, output, root):
    """Combine artifacts only. Later runs replace a suite, never sum reruns."""
    manifests = [json.loads((run / "manifest.json").read_text()) for run in runs]
    if len({m["snapshot"]["sha256"] for m in manifests}) != 1:
        raise ValueError("Cannot merge different source snapshots")
    if any(m["status"] != "finished" for m in manifests):
        raise ValueError("Cannot merge incomplete runs")
    if any(m.get("tests", ["test"]) != ["test"] for m in manifests):
        raise ValueError("merge accepts full-suite reruns only; use compare for selected tests")
    if any(output.resolve().is_relative_to(run.resolve()) for run in runs):
        raise ValueError("Output must be outside every input run")
    output.mkdir(parents=True, exist_ok=False)
    manifest = {**manifests[-1], "packages": [], "results": {}, "input_runs": [str(r.resolve()) for r in runs]}
    for run, original in zip(runs, manifests):
        for package in original["packages"]:
            target = output / package
            if target.exists():
                shutil.rmtree(target)
            shutil.copytree(run / package, target)
            if package not in manifest["packages"]:
                manifest["packages"].append(package)
            manifest["results"][package] = original["results"][package]
    if "inventory" not in manifest:
        manifest["inventory"], manifest["excluded_generated"] = inventory(root)
        manifest["test_index"] = test_index(root)
    write_json(output / "manifest.json", manifest)
    return summarize(output, root)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="action", required=True)
    collector = commands.add_parser("collect")
    collector.add_argument("--root", type=Path, default=ROOT)
    collector.add_argument("--out", type=Path)
    collector.add_argument("--packages", nargs="+", choices=PACKAGES, default=list(PACKAGES))
    collector.add_argument("--tests", nargs="+", help="Paths below the selected package's test/ (single package only)")
    collector.add_argument("--analyze", action="store_true")
    report = commands.add_parser("summarize")
    report.add_argument("run", type=Path)
    report.add_argument("--root", type=Path, default=ROOT)
    comparison = commands.add_parser("compare")
    comparison.add_argument("runs", type=Path, nargs="+")
    merger = commands.add_parser("merge")
    merger.add_argument("runs", type=Path, nargs="+")
    merger.add_argument("--out", type=Path, required=True)
    merger.add_argument("--root", type=Path, default=ROOT)
    args = parser.parse_args()
    if args.action == "collect":
        if args.tests and len(args.packages) != 1:
            parser.error("--tests requires exactly one --packages entry")
        return collect(args)
    if args.action == "summarize":
        summarize(args.run.resolve(), args.root.resolve())
        return 0
    if args.action == "merge":
        summary = merge_runs(args.runs, args.out, args.root.resolve())
        return int(not summary["checks_passed"])
    groups, snapshots = {}, set()
    for run in args.runs:
        manifest = json.loads((run / "manifest.json").read_text())
        summary = json.loads((run / "summary.json").read_text())
        if summary["source_changed"]:
            parser.error(f"Inputs changed during run: {run}")
        if not summary["checks_passed"]:
            parser.error(f"Run has incomplete or failed checks: {run}")
        snapshots.add(manifest["snapshot"]["sha256"])
        groups[str(run)] = read_lcov(run / "union.lcov.info", Path(manifest["root"]), "")
    if len(snapshots) != 1:
        parser.error("Cannot compare overlap across different source snapshots")
    print(json.dumps(overlap(groups), indent=2))
    return 0


if __name__ == "__main__":
    sys.exit(main())
