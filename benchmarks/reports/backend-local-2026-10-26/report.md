# Local backend measurements

Pure Dart Linux host measurements, no RaPi5/GPU/Flutter run. Metadata-only files are never decoded. Nearest-rank quantiles; small sample counts do not establish stable p99. Whole-process RSS/HWM includes both isolates. Raw cpu_ms and summary self_cpu_ms cover only the Dart process utime/stime, exclude subprocess CPU, and have host CLK_TCK resolution. They do not measure the full cost of system commands.

Harness/mode/SDK compatibility: matched.

| Variant | Layout/count | Index + first, p50 ms | Remaining N-1, p50 ms | Whole cycle, p50 ms | Peak HWM bytes |
|---|---|---:|---:|---:|---:|
| baseline | flat/1 | 0.115 | 0.000 | 0.115 | 8830976 |
| baseline | flat/1000 | 15.643 | 2.171 | 17.501 | 11722752 |
| baseline | flat/10000 | 133.867 | 201.933 | 357.272 | 42733568 |
| baseline | flat/50000 | 650.683 | 4279.152 | 4929.835 | 84627456 |
| baseline | nested/1 | 0.640 | 0.000 | 0.640 | 8835072 |
| baseline | nested/1000 | 16.009 | 1.846 | 17.850 | 12791808 |
| baseline | nested/10000 | 145.015 | 194.472 | 361.388 | 51515392 |
| baseline | nested/50000 | 724.901 | 4552.844 | 5277.745 | 87523328 |
| candidate-approved | flat/1 | 0.203 | 0.000 | 0.203 | 8982528 |
| candidate-approved | flat/1000 | 9.428 | 1.450 | 10.976 | 12382208 |
| candidate-approved | flat/10000 | 72.087 | 15.461 | 89.507 | 49102848 |
| candidate-approved | flat/50000 | 344.184 | 64.870 | 411.945 | 70291456 |
| candidate-approved | nested/1 | 0.241 | 0.000 | 0.241 | 9011200 |
| candidate-approved | nested/1000 | 8.405 | 1.098 | 9.494 | 13352960 |
| candidate-approved | nested/10000 | 89.166 | 13.460 | 101.750 | 49823744 |
| candidate-approved | nested/50000 | 425.722 | 57.454 | 483.176 | 71942144 |

| Variant | Layout/count | RPC p95/max ms | Loop lag p95/max ms | Skipped probes / loop intervals |
|---|---|---:|---:|---:|
| baseline | flat/1 | 0.196 / 0.426 | 1.093 / 2.933 | 0 / 0 |
| baseline | flat/1000 | 16.594 / 21.796 | 7.839 / 17.711 | 4 / 10 |
| baseline | flat/10000 | 130.157 / 140.135 | 1.123 / 136.222 | 71 / 77 |
| baseline | flat/50000 | 676.275 / 696.139 | 1.144 / 692.213 | 386 / 391 |
| baseline | nested/1 | 0.428 / 0.929 | 0.611 / 0.696 | 0 / 0 |
| baseline | nested/1000 | 16.233 / 26.192 | 1.621 / 21.807 | 2 / 8 |
| baseline | nested/10000 | 144.095 / 158.857 | 0.935 / 154.279 | 79 / 85 |
| baseline | nested/50000 | 726.750 / 736.707 | 1.301 / 732.442 | 426 / 431 |
| candidate-approved | flat/1 | 0.139 / 0.200 | 0.332 / 0.334 | 0 / 0 |
| candidate-approved | flat/1000 | 0.230 / 3.272 | 1.011 / 3.630 | 0 / 0 |
| candidate-approved | flat/10000 | 0.861 / 1.442 | 1.124 / 1.948 | 0 / 0 |
| candidate-approved | flat/50000 | 1.042 / 4.754 | 2.027 / 5.254 | 0 / 1 |
| candidate-approved | nested/1 | 0.132 / 0.172 | 1.137 / 1.150 | 0 / 0 |
| candidate-approved | nested/1000 | 0.447 / 0.860 | 1.004 / 2.069 | 0 / 0 |
| candidate-approved | nested/10000 | 0.999 / 1.322 | 1.637 / 2.535 | 0 / 0 |
| candidate-approved | nested/50000 | 1.304 / 4.861 | 2.922 / 12.796 | 2 / 3 |

RPC samples include 60 ms before and after indexing. Saturated probes are explicitly skipped and counted, not converted to successful/zero latency measurements. Full scheduled latencies and event-loop gaps remain in raw JSONL.

| Variant | Metric phase/concurrency | p50 / max elapsed ms | Samples |
|---|---|---:|---:|
| baseline | cold/1 | 29.576 / 29.576 | 1 |
| baseline | immediate/1 | 20.139 / 20.139 | 1 |
| baseline | expired_refresh/1 | 11.489 / 30.400 | 3 |
| baseline | expired_burst/2 | 49.109 / 49.109 | 1 |
| baseline | cached_burst/2 | 25.241 / 25.241 | 1 |
| baseline | expired_burst/5 | 58.245 / 58.245 | 1 |
| baseline | cached_burst/5 | 35.727 / 35.727 | 1 |
| candidate-approved | cold/1 | 11.945 / 11.945 | 1 |
| candidate-approved | immediate/1 | 0.012 / 0.012 | 1 |
| candidate-approved | expired_refresh/1 | 11.222 / 35.085 | 3 |
| candidate-approved | expired_burst/2 | 36.364 / 36.364 | 1 |
| candidate-approved | cached_burst/2 | 0.011 / 0.011 | 1 |
| candidate-approved | expired_burst/5 | 34.760 / 34.760 | 1 |
| candidate-approved | cached_burst/5 | 0.032 / 0.032 | 1 |

baseline separate diagnostic direct command invocations: `{"cat": 17, "df": 17, "free": 17, "sensorsScript": 17, "uptime": 17}`.


candidate-approved separate diagnostic direct command invocations: `{"df": 4, "sensorsScript": 4, "uptime": 4}`.


Index and cycle observations use independent fresh processes. Throughput includes URI result collection; it excludes decoding, fixtures, validation and RPC. The first selection includes index construction. No boundary rescan is included: exactly N selections are made.

Metrics use real host /proc data and applicable df/uptime/free commands from each production implementation, plus a configured constant sensor script. Expired refreshes use 1100 ms spacing; the production frontend normally requests once per minute. Diagnostic direct-command counts come from forwarding wrappers in a separate pass, not process polling. They do not count all child processes or shell internals. Raw latency, missed probes, metrics values, process data, errors, provenance, binary and source archive are retained per variant.

Baseline then candidate order is not a randomized A/B trial. Host contention, filesystem cache and runtime conditions limit conclusions; this report establishes local behavior and scaling only.

A separate ABBA confirmation reuses the frozen AOT binaries: `confirm-approved-raw.jsonl`, `confirm-approved-summary.json`, `confirm-approved-provenance.json`. CPU there includes the reaped Dart process and its reaped descendants via Python RUSAGE_CHILDREN, unlike self CPU above. It does not measure an empirical one-minute interval.

| ABBA variant | Entire metrics scenario CPU incl. children, range ms | Observations |
|---|---:|---:|
| baseline | 287.171–403.935 | 2 |
| candidate-approved | 82.298–117.980 | 2 |

| ABBA variant | Individual expired refresh, range ms | Immediate cached call, range ms |
|---|---:|---:|
| baseline | 11.545–13.416 | 14.316–14.886 |
| candidate-approved | 24.847–38.357 | 0.008–0.014 |

The entire metrics scenario includes cold + immediate, one expired refresh, expired/cached bursts of 2 and 5. The observations do not establish a consistent speedup of an individual expired refresh; read its actual range above separately from cache-hit latency and aggregate burst CPU. In the final approved ABBA observations, expired refresh was slower.

All-child-process tracing was unavailable in this environment (see `process-diagnostic.json` for the exact strace failure). Forwarding-wrapper counts above remain direct-command invocations only; total child-process counts are unverified.

This report compares baseline with candidate-approved. The intermediate candidates and their confirmations are retained unchanged for audit, along with a superseded GPhoto review supplement. candidate-approved includes the final GPhoto release guard and ErrorResult serializers and was measured again with the same frozen baseline Dart harness.

Final production-source verification: `3ce0a559d799ae993741e14f4cb7e4985e0901504ea81767c3ba86ed9a1510c5`; differences from candidate-approved snapshot: `[]`. See `final-source-verification.json` for scope and algorithm.


## Локальное сравнение 26 октября 2026 года

Baseline снят с `597ffa098a66bd1424c09888733c7b5d03be973e` до production-правок.
Обе версии используют один замороженный pure Dart harness, Dart 3.13.5,
локальные Linux AOT executables и те же файловые fixtures. На каждый случай
в основной серии приходятся три свежих процесса. Это измерения прогретой
файловой системы после подготовки fixtures, без принудительной очистки кеша ОС.

| Сценарий 50k файлов | Baseline | Принятый кандидат |
| --- | ---: | ---: |
| Полный проход, flat, медиана | 4929,8 мс | 411,9 мс |
| Полный проход, nested, медиана | 5277,7 мс | 483,2 мс |
| RPC p95 / max во время flat-индексации | 676,3 / 696,1 мс | 1,04 / 4,75 мс |
| RPC p95 / max во время nested-индексации | 726,8 / 736,7 мс | 1,30 / 4,86 мс |
| Максимум VmHWM, flat | 84,6 МБ | 70,3 МБ |
| Максимум VmHWM, nested | 87,5 МБ | 71,9 МБ |

Значения VmHWM относятся ко всему процессу и не являются памятью только индекса.
На 10k файлов максимум памяти кандидата выше baseline; уменьшение памяти на 50k
нельзя обобщать на все размеры. У однократного выбора единственного файла
в flat-сценарии накладные расходы выросли с 0,115 до 0,203 мс.

В отдельной диагностике 17 запросов динамических метрик потребовали 85 прямых
запусков команд в baseline и 12 в кандидате за счёт чтения `/proc`, объединения
запросов и кеша. Это число непосредственных вызовов, а не всех дочерних процессов.
Трассировка `strace` в данном окружении получила `EPERM`; отсутствие полного
process count явно сохранено в отчёте.

Подтверждающий порядок ABBA для того же сценария метрик дал 287–404 мс CPU
в baseline и 82–118 мс в кандидате, включая завершившиеся дочерние процессы
через `RUSAGE_CHILDREN` (по два наблюдения на вариант). При этом отдельный
просроченный refresh в этой серии был **медленнее**: 11,5–13,4 против
24,8–38,4 мс. Выигрыш объединения/кеша не означает ускорения одиночного сбора.
Штатный минутный интервал frontend в этой ускоренной серии не измерялся.

Полные локальные данные, исходники, бинарники и параметры сохранены в
`benchmarks/reports/backend-local-2026-10-26/`; итоговая пара — `baseline` и
`candidate-approved`. Промежуточные попытки сохранены отдельно. SHA-256 итогового
дерева `backend/lib` + `common/lib`:
`3ce0a559d799ae993741e14f4cb7e4985e0901504ea81767c3ba86ed9a1510c5`.
Проверка совпадения с измеренным кандидатом не нашла различий. Небольшое число
повторов и обычная нагрузка рабочей машины ограничивают точность сравнения;
сырые задержки, пропуски запросов и ошибки сохранены без подстановки нулей.
