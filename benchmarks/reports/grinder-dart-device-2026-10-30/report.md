# Аппаратная проверка стенда после переноса инструментов на Dart

Статус: завершено 30.10.2026. Новый release-bundle проверен на настоящей RaPi5:
штатный OpenGL smoke выполнил **147/147 сценариев**, записал **14 888 кадров**,
ошибок и native-падений нет. Сборка, доставка ARM64 Dart CLI, запуск,
агрегация и восстановление службы работают для этого набора.

## Условия и происхождение

* Устройство `pi@192.168.50.143`, OpenGL, 2560×1600, DPR 1;
  фактическая частота из API дисплея — 49,9993 Hz.
* Flutter 3.47.7, Dart 3.13.5, benchmark `pi5/release`,
  `build/benchmarks-pi5-release-L0Lfwuba.tar.gz`.
* Штатный `config/smoke.json`: один повтор, без прогрева, переход 1000 ms,
  Mosaic 100×100 и 200×200, Canvas и shader; `capture_frames=false`.
  Встроенные оригиналы и плотность не уменьшались.
* Приложение выполнялось **19:04:22–19:16:23 Europe/Moscow**, около 12 минут.
  Подготовка/доставка пакета в этот интервал не входят.
* Код `benchmarks/lib`, конфиги и production-эффекты в этой проверке не менялись.
  `assets/build-info.json` сгенерирован штатной сборкой.

| Вход | SHA256 |
| --- | --- |
| `app.so` | `953890256fba9f5f06c68cbd63d53e0e5dff52d5c0d041e472c99da2b8651850` |
| Engine | `c466d00c4a274e78bb31589ae6cf261ac6a3c447cc980f879d49c94c48537523` |
| ARM64 Dart CLI | `590241a2ec5a6056313063cef0c5756f23a74c9712eac1f494fbc90fc956ada2` |
| Установленный flutter-pi | `30669efa6ad054744b4c63275cafaf7738d1489b5702c17de666ac73edcbea4b` |
| Fingerprint исходников/harness | `584b42b788fc9dd48931cc51f90b7cab9b6dbbc982979c9000914cc0b3f1f29b` |

Хеши app/engine/helper после rsync совпали с локальной сборкой. Установленный
runtime не заменялся; его SHA до/после совпал. ОС, драйверы и прошивка не менялись.
Новый пакет развёрнут отдельно:
`/home/pi/workspace/benchmarks/checks/grinder-dart-20261030T160403299248Z`.
Прежний bundle, отчёты и пользовательские конфиги стенда сохранены.
В [снимке после прогона](device-provenance-after.json) сохранены Linux
`6.12.109+rpt-rpi-2712`, HEAD checkout flutter-pi
`cfbc44a556931e7ccf647d46f7165062450e9a95` и его status (`?? build.sh`).
Runtime в этой работе не пересобирался; checkout сам по себе не доказывает
происхождение установленного бинарника.

## Результат

| Медиа | Сценариев |
| --- | ---: |
| Фото → фото | 100 |
| Фото → видео | 8 |
| Видео → фото | 8 |
| Видео → видео | 8 |
| GIF → фото | 8 |
| Фото → GIF | 8 |
| Большое фото | 7 |
| Всего | **147** |

Все сценарии поддержаны и выполнены за одну попытку: 147 measured runs,
`complete=true`, `successful=true`, unsupported/failed/native crashes/error events — 0.
Для всех 147 измерений есть ненулевое число кадров и числовой raster p95;
сумма `frames` совпадает со всеми 14 888 строками `frames.jsonl`.
Записаны 1440 telemetry samples; sampled RSS peak — 895 467 520 байт,
пиковая температура CPU — 62,25 °C. `get_throttled` до/после — `0x0`.

Метрики различают дорогие эффекты; например, в этой единственной попытке:

| Сценарий фото → фото | Raster p95 | Wall time перехода |
| --- | ---: | ---: |
| Kaleidoscope | 132,036 ms | 12 733,331 ms |
| Radial Blur | 108,099 ms | 10 666,686 ms |
| Cross Zoom, mode cross / scale 1,6 / blur 0,012 | 92,140 ms | 6 133,359 ms |
| VHS Damage | 72,104 ms | 6 883,301 ms |
| Glow | 68,981 ms | 6 133,336 ms |

Статус `passed` подтверждает контракт сценария; отдельные эффекты превышают
бюджет дисплея около 20 ms. FixedAnimationController намеренно растягивает
переход под нагрузкой, его логика сохранена.

## Запуск и восстановление

Использован уже существовавший на устройстве `run-managed.sh`, без изменения
его логики. Его копия находится рядом с новым пакетом. Supervisor запущен
от `pi` через transient systemd unit
`dslideshow-bench-grinder-dart-20261030T160403299248Z.service`, независимо от SSH.
Аргументы: `--suite smoke --config config/smoke.json --renderers opengl --timeout 1800`.

До прогона служба `dslideshow` была активна, перед GPU-запуском остановлена.
Supervisor и benchmark завершились с кодом 0; служба автоматически восстановлена:
`active/running`, `ExecMainStatus=0`, `NRestarts=0`. Состояние и контрольные хеши
сохранены в [device-check.json](device-check.json); журнал — в [launcher.log](launcher.log).

## Архивы и повторная агрегация

| Архив | SHA256 |
| --- | --- |
| [Release](release.tar.gz) | `308bfa214a00a7727b4feea5d3505f4a14a7862a9b04197b18c8fe24067bf633` |
| [Исходники](source.tar.gz), 495 файлов | `74a858faddaa821bdd2ca5afb9e43a65ac4030be4c83a804b6de4025e50e7fb2` |
| [Raw](raw.tar.gz) | `0bf01206008c6c734e5b42c500e6815fadaaf316bc7fc0931f7db482b200e9dc` |

Архивы проверены чтением полного tar/gzip-потока и SHA256; хеш скачанного raw
совпадает с устройством. Они включены в [manifest](../retained-archives.json)
с датой точечной проверки; дата полного аудита исторических архивов не изменена.
Исходный raw-архив не переписан. В рабочей распакованной копии повторно выполнен
`benchmark collect-reports --fail-on-errors` локальным Dart CLI.
Числа сценариев, результаты, measured runs и ошибки совпали с агрегацией на RaPi5.
Fingerprint рабочих исходников на момент проверки совпал с provenance
проверенного приложения; соответствующий снимок сохранён в `source.tar.gz`.
Последующее изменение версий или кода checkout не распространяет эту приёмку
на новую сборку.

Итоговые данные: [verification.json](verification.json),
[HTML-отчёт](raw-extracted/20261030T160421Z-smoke-H4eG9LvY/report.html),
[JSON-сводка](raw-extracted/20261030T160421Z-smoke-H4eG9LvY/collection-summary.json),
[build log](build.log), [frozen inputs](frozen-inputs.json).
Рабочая распакованная копия оставлена для просмотра и пересчёта отчёта;
неизменяемое доказательство — `raw.tar.gz`.

## Границы вывода

Подтверждён штатный путь нового Dart harness на устройстве для smoke.
Один повтор без прогрева не подтверждает устойчивый процент ускорения, p95
между запусками или отсутствие долговременной утечки. Это не A/B со старым
Python harness. Полный standard/soak, Vulkan, PhotoMotion и визуальный audit
эффектов не выполнялись; скорость по software FrameTiming не равна физическому
scanout. Настоящий renderer и OTA имеют отдельные стенды.
DEB `16.0.0+12` на устройство не устанавливался.
