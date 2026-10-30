# Independent native-analysis regression vectors

`analysis_vectors.json` records the input files and structured results produced
by the original Python analyzer before its removal on 30 October 2026. The
original 46 tests passed; their analyzer calls produced 61 vectors. Source and
test SHA-256 are recorded in the corpus. Inputs use base64 to preserve malformed
UTF-8 and the exact native ABI bytes. These are tiny synthetic captures and do
not constitute hardware measurements or performance acceptance.

The Dart tests replay each vector against the working analyzer, compare complete
structured numerical/status/provenance results, preserve issue/warning reasons, and compare top-level diagnostic counts
without freezing language-specific exception wording. The expected values are
independent of the Dart implementation and must not be regenerated from it.
