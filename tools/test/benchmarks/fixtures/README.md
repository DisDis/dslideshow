# Independent benchmark migration fixtures

`comparison_parity.json.gz` contains the inputs and expected results captured
from the complete former Python comparator suite before its removal on
30 October 2026: 40 original tests exercised 87 comparison inputs. The original
suite passed during capture. `reports_parity.json.gz` preserves 11 collect/resume
states from its original report tests (the 9-test suite passed during capture).

Both files are ordinary gzip-compressed UTF-8 JSON, with no executable code and
no external data. Each input file is stored as base64 so corrupt UTF-8 and
truncated JSONL remain reproducible. The fixtures contain tiny synthetic
collections and no real media, credentials or device output.

The comparator assertions preserve metrics, completeness, error details,
conditions and eligibility. They normalize temporary paths, condition scope
prefixes, diagnostic message text and per-case issue wording; diagnostic and
issue counts remain exact. Notes/HTML wording is covered separately where
relevant. New expected values must not be derived from the Dart implementation.

Launcher tests run the actual shell scripts against controlled Dart processes.
They separately cover renderer selection, Vulkan policy, native failure,
archive contents and signal teardown; they do not start an engine or hardware.
