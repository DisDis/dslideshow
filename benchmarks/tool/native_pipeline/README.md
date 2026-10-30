# Диагностика native OpenGL pipeline

Этот стенд разделяет CPU-время вызовов EGL/GBM/KMS, интервалы GPU-заданий V3D
и DRM completion. Методика и результаты — в
[разборе flutter-pi](../../reports/flutter-pi-native-pipeline-2026-10-28/report.md).
Он не меняет рабочий runtime, engine, ОС, драйверы или параметры качества.

`FrameTiming.raster` включает синхронный embedder present. Встроенные `TRACER_*`
flutter-pi и timeline engine отключены в используемой release-сборке. Поэтому
для диагноза используются независимые часы `CLOCK_MONOTONIC` и kernel tracefs.

## Что записывается

* `pipeline_probe.c`: семь вызовов EGL/GBM/DRM с wall/thread-CPU интервалами,
  tid, вложенностью, аргументами, результатом и `errno`. Буфер mmap ограничен;
  overflow, незавершённые записи, ошибки часов и lifecycle сохраняются явно.
  Нет дополнительных GL-вызовов, readback или принудительного завершения GPU.
* `dslideshow_tools native trace`: только собственная tracefs instance, `mono`, доступные
  V3D submission/IRQ и DRM queued/delivered. Сохраняются исходные форматы событий,
  данные, статистика потерь и отсутствующие возможности. Глобальный tracer не
  меняется; существующие instance/output не переиспользуются.
* `dslideshow_tools native capture`: фактически загруженный engine проверяется по
  `/proc/PID/maps`, device/inode и SHA-256. PID связывается с mmap-логом сборщика.
  Однократная проверка выполняется при старте, до измеренных повторов.

`runtime-wrapper.sh` включает interposer только для нужного ELF. `--help` и
дочерние программы не создают повторный лог. При обычном завершении mmap-данные
синхронизируются; завершённые записи доступны и после `_exit`, но неполное
завершение остаётся отмеченным. Отсутствующий лог не означает нулевые задержки.

В используемом Dart `Process.exit` намеренно вызывает
[`_Exit`](https://github.com/dart-lang/sdk/blob/04bcd1036cdc799ac6564988f159ee454d42c822/runtime/bin/process.cc#L247-L256),
а на Linux — [`_exit`](https://github.com/dart-lang/sdk/blob/04bcd1036cdc799ac6564988f159ee454d42c822/runtime/bin/platform_linux.cc#L192-L196).
При таком завершении C-деструктор не вызывается. После успешного supervisor
`dslideshow_tools native finalize` создаёт отдельное подтверждение: процесс отсутствует,
launcher завершился с 0, записи полны, SHA исходного mmap, launcher status и
engine proof неизменны. Сырой header остаётся `lifecycle=1/closed=0`, а внешний
конец capture хранится отдельно. Проверку выполняйте на том же Pi и в том же
boot сразу после процесса; создавать такое доказательство offline нельзя.
Неполные записи, потери и неуспешный exit не подтверждаются.

**Все результаты инструментированного запуска диагностические.** Их FPS и
ресурсы не заменяют A/B оптимизации: mmap-буфер, tracing и измерение часов имеют
собственную стоимость. RCL submit→IRQ включает обработку IRQ и не равен времени
только fragment shader. Перекрывающиеся задания объединяются, а не суммируются.

## Запуск на фоторамке

Используйте существующие SSH/rsync и supervisor из
[аппаратного руководства](../../../doc/raspberry-pi-benchmarks.md).
Нужны уже установленные GCC, pkg-config и development headers EGL/GBM/libdrm;
эта работа не устанавливает пакеты. На устройстве соберите только interposer:

```sh
bash tools/native_pipeline/build.sh tools/native_pipeline/libnative_pipeline.so
```

Перед запуском закрепите один immutable release bundle, engine и настоящий
runtime. Архивируйте source/release, config, SHA-256 и инструменты. Поле
`production_photo_inputs` должно совпадать во всех запусках. Конфиг
[`native-pipeline-photo.json`](../../config/native-pipeline-photo.json) содержит
шесть медленных фотоэффектов, Baseline/Fade, один прогрев и два измерения;
без GIF/видео/48-Мп/capture/24h и только OpenGL.

`run-device.sh` принимает пять аргументов: mode, benchmark root, experiment root,
frozen bundle и уникальный job. В experiment root заранее создайте `config/`
с `native-pipeline-photo.json`, скопируйте этот каталог инструментов. Запускайте
через `nohup` с теми же timeout/keepalive, что и прочие аппаратные проверки.
Пример для каталога эксперимента 28.10.2026:

```sh
export BENCH_NATIVE_PIPELINE_RUNTIME_SHA256=9e60974e3bdb9e0bb8e3c77061e83f55b7c9cad53b45360f01281e825c498d67
export BENCH_NATIVE_PIPELINE_ENGINE_SHA256=c466d00c4a274e78bb31589ae6cf261ac6a3c447cc980f879d49c94c48537523
experiment=/home/pi/workspace/benchmarks/experiments/native-pipeline-20261028
bundle=/home/pi/workspace/benchmarks/variants/effect-performance-20261028-common-kernel-candidate/bundle
bash "$experiment/tools/native_pipeline/run-device.sh" control \
  /home/pi/workspace/benchmarks "$experiment" "$bundle" UNIQUE_CONTROL
# После завершения control и восстановления службы:
bash "$experiment/tools/native_pipeline/run-device.sh" diagnostic \
  /home/pi/workspace/benchmarks "$experiment" "$bundle" UNIQUE_DIAGNOSTIC
```

`run-device.sh` использует ARM64 CLI из `BENCHMARK_TOOLS_EXECUTABLE` либо
`BENCHMARK_ROOT/tools/dslideshow_tools`. Этот executable создаёт штатный
`benchmarks/tool/build_tools.sh` на машине сборки; Dart SDK и pub на Pi не нужны.
CLI закрепляется в bundle вместе с SHA-256. Для ручного переноса interposer
сохраняйте также `tool/cli.sh` рядом с каталогом `native_pipeline`, как в исходном
дереве инструментов. `sudo` получает абсолютный путь к ARM64 CLI.

`run-device.sh` делегирует остановку/восстановление службы существующему
`run-managed.sh`, сохраняет input hashes, останавливает и удаляет только свою
trace instance при выходе. Job и output должны быть новыми. При sudo новый
trace output передаётся вызывающему пользователю; чужие каталоги не меняются.
Закрытая instance удаляется, её trace/provenance остаются в experiment root.
После ошибки сохраните launcher/exit-code, проверьте службу и остатки именно
этой instance. Не запускайте следующую GPU-проверку до завершения предыдущей.

## Анализ и локальные проверки

Скопируйте raw collection и private trace на рабочую машину. Передавайте ровно
одну попытку при одном native mmap-логе. `run.sh` создаёт исходный collection
archive до внешней финализации: сохраните также добавленный
`native-pipeline-finalization.json` или упакуйте завершённый каталог collection.

```sh
dart --suppress-analytics tools/bin/dslideshow_tools.dart native analyze COLLECTION_OR_ATTEMPT OUTPUT \
  --native ATTEMPT/native-pipeline.bin --trace-dir PRIVATE_TRACE \
  --engine-sha256 c466d00c4a274e78bb31589ae6cf261ac6a3c447cc980f879d49c94c48537523
(cd tools && dart test test/benchmarks/native_pipeline)
bash -n benchmarks/tool/native_pipeline/build.sh \
  benchmarks/tool/native_pipeline/runtime-wrapper.sh \
  benchmarks/tool/native_pipeline/run-device.sh
(cd benchmarks && flutter test --no-pub test/native_pipeline_config_test.dart)
```

Окна переходов выводятся из исходных FrameTiming, это не точные GPU-маркеры.
Прогревы по умолчанию исключены из метрик и проверяются отдельно. Ошибки,
пропуски, потери, неподтверждённый engine и неполные пары событий сохраняются,
снимают заявления о полноте и не заменяются нулями. Наблюдённые интервалы остаются
доступны даже при неполной корреляции; интерпретировать их нужно с ограничениями
в сформированном отчёте.

Рабочий код находится в `tools/lib/src/benchmarks/native_pipeline/`, а точки входа
доступны через `dslideshow_tools native --help`. Тесты используют временные
proc/tracefs, настоящий C-interposer с fake ABI и 61 независимый вектор прежнего
анализатора; они не открывают GPU и не проверяют службу на Pi. Системные
CLOCK_MONOTONIC и getrusage используют сгенерированные libc bindings из
`tools/tool/ffigen.dart`; stat/uid/chown берутся у штатных POSIX-команд.
Перегенерация bindings: `(cd tools && dart run tool/ffigen.dart)` на Linux LP64.

CLI поддерживает standalone x64 и штатную cross-compilation AArch64.
ARM64 executable требует системные libc/libm/libpthread/libdl и Linux dynamic
loader. Локальная сборка и просмотр ELF не подтверждают работу tracefs/launcher на фоторамке:
такая проверка выполняется отдельным согласованным аппаратным сценарием.
