# Аппаратная проверка экрана OTA

`lib/ota_main.dart` монтирует обычную `OTAPage`, её Bloc, владельца терминала
и xterm. Подменяется только внешний `FrontendService`: локальные потоки дают
адрес, код, этапы и текст установщика. Стенд не соединяется с backend, не
запускает установщик и не вызывает перезагрузку. Все его виджеты — StatelessWidget;
жизненный цикл стенда находится в отдельном владельце.

Из `benchmarks/`:

```sh
flutter analyze --no-pub lib/ota_main.dart
flutter test --no-pub test/ota_harness_test.dart
(cd ../tools && dart test test/benchmarks/launcher_test.dart)
bash -n build_ota_pi5.sh run_ota.sh
./build_ota_pi5.sh
```

Скрипт печатает `OTA_PACKAGE` и `OTA_ARCHIVE`. Он сохраняет исходный lock-файл.
Для baseline сохраните исходники production до изменения и добавьте **тот же**
стенд. В обеих сборках сохраняйте одинаковые версии пакетов, SDK/engine,
конфигурацию и native runtime. Архивируйте оба release bundle и исходники;
не сравнивайте со старым архивом, если условия не совпадают.

Разворачивайте пакет в отдельном каталоге по
[инструкции RaPi5](../doc/raspberry-pi-benchmarks.md#2-проверка-связи-и-установка-пакета).
Запускайте только через описанный там `run-managed.sh`: он останавливает
фоторамку и восстанавливает службу после завершения или ошибки. В отдельном
каталоге пакета скопируйте supervisor и свяжите `managed-supervisor.lock`
с общей `/home/pi/workspace/benchmarks/managed-supervisor.lock`.

```sh
cd /home/pi/workspace/benchmarks/ota-candidate
mkdir -p managed/ota-candidate-timing-001
nohup ./run-managed.sh ota-candidate-timing-001 \
  > managed/ota-candidate-timing-001/launcher.log 2>&1 < /dev/null &
```

Launcher использует установленный `/opt/dslideshow/flutter-pi`, release,
OpenGL, 2560×1600, один запуск без повторов и предел 120s. Непустой output
отклоняется; ошибки и native-логи сохраняются. ОС, драйверы и runtime не меняются.

Матрица: готовность с QR/кодом, передача файла на 42%, установка,
поток 60 строк/s в течение 5s, burst 200 строк, жест просмотра истории,
ещё 50 строк, возврат к концу, ещё 25 строк, ошибка, успех и удаление страницы.
История листается через публичный `ScrollableState.position.drag` из subtree
самого `TerminalView`; scrollable статуса не участвует в пробе.
кнопка возврата вызывается как обычное UI-действие. У baseline, где кнопки нет,
стенд возвращается вниз прокруткой. Наблюдения baseline могут показывать
нарушения новых UX требований: это не причина скрывать исходные данные.

`events.jsonl` сохраняет ширину/высоту терминала, размер шрифта, scroll offset,
сохранение истории и возврат к концу. Проба требует фактического ухода от конца,
сохранения offset после новых строк и возобновления слежения; нарушения делают
запуск failed. `ota-report.json` содержит полные
FrameTiming потока и p50/p95/p99/max; `telemetry.jsonl` — RSS, FD, потоки,
температуру и частоты. Граница окна FrameTiming задаётся timestamp начала
и конца, поздние callbacks фильтруются по этому окну; последующие маркерные
кадры дожидаются доставки callback. Пустой FrameTiming не доказывает успех.
`launch.json` фиксирует runtime/AOT hashes, metadata — build provenance.

Для визуальной проверки сделайте **отдельный запуск** с `OTA_CAPTURE=true`
перед `nohup`. Он сохраняет PNG каждого этапа через `RepaintBoundary.toImage`;
эти результаты не используйте для сравнения производительности. PNG подтверждает
композицию Flutter; физический вывод и читаемость на расстоянии требуют просмотра
дисплея. Короткий поток и cleanup не заменяют длительную проверку утечек;
реальная установка, загрузка по сети и перезагрузка сюда не входят.

Результаты текущего A/B: [OTA UX 29.10.2026](reports/ota-ux-2026-10-29/report.md).
