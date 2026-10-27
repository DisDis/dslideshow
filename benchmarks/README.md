# Автоматические бенчмарки DSlideShow на Raspberry Pi

Отдельное Flutter-приложение с path-зависимостью от `../dslideshow_flutter`.
В основном приложении нет точки входа, телеметрии или переключателей для бенчмарков.
Мышь, клавиатура и действия пользователя для прогона не нужны.
Аппаратные прогоны используют подключённый дисплей 2560×1600.
При запуске тесты начинаются автоматически, отчёты записываются на диск,
приложение завершает процесс. SSH-скрипт по умолчанию запускает **только OpenGL**
и упаковывает результат, включая нативные логи и результаты аварийного запуска.
Аппаратные проверки Vulkan отложены до поддержки видео в native runtime.

Пошаговое [руководство для RaPi5](../doc/raspberry-pi-benchmarks.md) содержит
актуальные пути к flutter-pi, установку, запуск через нестабильный SSH в фоне
с восстановлением службы фоторамки, точечные тесты и получение отчётов.

## Диагностика Accordion / LiquidMorph

Наборы `composition-confirm.json`, `composition-visual.json`,
`composition-media.json`, `composition-video.json` сравнивают штатные эффекты
с замороженными `CompositionProbe-accordionReference` / `liquidReference`.
`CompositionProbe-accordionGrouped` сохраняет отклонённый эксперимент с общими
трансформациями; production Accordion оставлен исходным после обратного A/B.
Пробы включаются только явно через `effects`. В `composition-diagnostics.json`
компонентные `accordionNoShadow`, `liquidNoScale`, `liquidNoClip` намеренно меняют
картинку и нужны только для локализации затрат. `liquidBounded` / `liquidRectTail`
проходят отдельный пиксельный контроль; их наличие в стенде не означает приёмку
оптимизации. Все наборы выполняются в OpenGL; видео→видео сюда не входит.
Методика и выводы — в [разборе RaPi5](../doc/accordion-liquid-optimization-2026-10.md).
`composition-acceptance.json` задаёт пять повторов на обычных/48 Мп фото;
`composition-final.json` и `composition-final-visual.json` проверяют окончательный
код после исключения неподтверждённого изменения Accordion.

## Диагностика Mosaic / MosaicFade

[Исследование Canvas-маски на RaPi5](../doc/mosaic-optimization-2026-10.md)
описывает `mosaic-diagnostics.json`, `mosaic-confirm.json`, `mosaic-visual.json`,
`mosaic-media.json`, `mosaic-video.json` и `mosaic-video-confirm.json`. Пробы `MosaicProbe-points-*` и
`MosaicProbe-vertices-*` включаются только явно; обычные smoke/standard их
не запускают. Сетки 100/150/200 сохраняются. В visual audit проверяются
**все выбранные сетки**, с SHA-256 полного кадра 2560×1600 в каждой позиции.
Обычные captures 0/50/100% сохраняют только первую сетку.

## Диагностика BlurFade

Точечные сценарии `blur-diagnostics.json`, `blur-confirm.json`,
`blur-confirm-photos.json`, `blur-visual.json` и `blur-video.json` описаны
в [исследовании BlurFade на RaPi5](../doc/blur-fade-optimization-2026-10.md).
Диагностические `BlurProbe-*` включаются только явно через `effects`;
обычные матрицы их не запускают. `fadeOnly` / `blurOnly` намеренно меняют
картинку, bitmap-пробы доступны только для статического исходящего слайда.
Это инструменты исследования, а не дополнительные пользовательские эффекты.

Визуальный аудит дополнительно сохраняет `full_frames` в `audit/*.json`:
размеры и SHA-256 raw RGBA полного кадра до уменьшения до PNG-превью.
Сравнивайте эти хеши между эталоном и кандидатом; успешная эвристическая
проверка движения сама по себе не подтверждает точное совпадение пикселей.

## Локальные проверки backend без Flutter и устройства

`flutter analyze --no-pub` проверяет живые исходники стенда. Каталоги `build/`
и `reports/` исключены: они содержат сгенерированные targets и замороженные
копии чужих пакетов. Отдельная `tool/gallery_browser_probe.dart` также исключена
из контекста пакета benchmarks: её зависимости принадлежат config_app.
Проверка этой пробы — компиляция с замороженным package config панели и запуск
настоящего Chrome через `gallery_browser_probe.py`, как описано ниже.

Исследовательские `tool/camera_rpc_probe.dart` и `tool/rpc_timeout_probe.dart`
проверяют настоящий HTTP при отказах камер и удержание межизолятных RPC-слотов.
`tool/camera_device_probe.dart` и `tool/camera_socket_probe.py` сопоставляют
читающие RPC со снимками TCP/FD работающей рамки. `tool/camera_http_probe.py`
сравнивает публичный `/info` через сеть и loopback. Команды, результаты и границы
проверок — в [исследовании timeout камер](../doc/camera-rpc-investigation-2026-10.md).

Отдельные диагностические пробы галереи `tool/gallery_list_probe.dart` и
`tool/gallery_contract_probe.dart` описаны в
[исследовании галереи](../doc/gallery-performance.md) и
[локальном отчёте](reports/gallery-local-2026-10-26/report.md).
Они проверяют текущий HTTP-контракт, блокировку списка и локальную отмену
потока; не запускают устройство и не заменяют A/B интерфейса на RaPi5.

### Миниатюры и управляемый HTTP галереи

[Один FFmpeg и JPEG](reports/thumbnail-jpeg-local-2026-10-27/report.md) сравнивает
новый конвейер с предыдущим probe/RGBA/encode. [Первый переход на FFmpeg](reports/thumbnail-ffmpeg-local-2026-10-27/report.md)
сохраняет baseline/candidate, сырые HTTP-результаты, медиахеши и команды повтора.
`gallery_http.py --bucket 256|512|1024` берёт policy из каталога;
`--cold-concurrency 4` задаёт параллельный холодный проход. Инструмент измеряет
дерево процессов: sampled sum RSS/FD/threads и CPU с reaped children.
Сумма RSS может дважды учитывать shared pages; дискретный максимум не является
точным peak RSS. `/info` остаётся HTTP-proxy отзывчивости, не измерением RPC.
[Совместимость FFmpeg 5.1 и диагностика](reports/gallery-ffmpeg51-diagnostics-2026-10-27/report.md):
`tool/ffmpeg_thumbnail_compat.dart` запускает настоящий production worker, создаёт
alpha/EXIF/GIF/tiny fixtures, проверяет JPEG, MD5 и неизменность источников.
Необязательный аргумент — каталог с photo_a/photo_b/photo_large/video_a.
Как и browser probe, файл исключён из Flutter-анализатора benchmarks: он
компилируется с package config backend, где доступен dev-пакет image:

```sh
# Из корня; пакет image нужен только существующей dev-конфигурации backend.
dart compile exe --packages=backend/.dart_tool/package_config.json \
  benchmarks/tool/ffmpeg_thumbnail_compat.dart -o /tmp/ffmpeg-thumbnail-compat
/tmp/ffmpeg-thumbnail-compat benchmarks/assets/media
```

Используется `ffmpeg` из PATH: один и тот же AOT probe можно запустить в отдельном
Debian 12 для 5.1 и на host для 8. Проверка не устанавливает пакеты и не запускает
hardware service. Ошибки не превращаются в нулевые измерения или skipped.

`gallery_thumbnail_probe.dart source size output-file` проверяет текущий worker;
прежние Dart decoder-пробы сохранены в исторических frozen-отчётах.

Production-поведение, API и лимиты описаны в [руководстве галереи](../doc/gallery.md).
`gallery_http.py` компилирует frozen backend/common с одним и тем же
`gallery_http_server.dart` в AOT, запускает локальный HTTP-сервер и сравнивает
каталоги 1k/10k, оригиналы, холодные/тёплые миниатюры, validators, отмену и
ресурсы процесса. Чтение тел замедляется управляемым клиентом; число активных
запросов включает всё тело. `/info` — proxy отзывчивости web-isolate, не RPC.
Freeze сохраняет исходники, manifest и package config; зависимости остаются
в существующем pub cache. Нужны разрешённый loopback и уже установленные SDK.

Из корня репозитория, с новым каталогом результата для каждого измерения:

```sh
# Baseline нужно заморозить ДО изменения production-кода:
python3 benchmarks/tool/gallery_http.py \
  --freeze-current --variant baseline \
  --output benchmarks/reports/gallery-http-EXPERIMENT
# После изменения production-кода, с тем же harness/SDK/media:
python3 benchmarks/tool/gallery_http.py \
  --freeze-current --variant candidate \
  --output benchmarks/reports/gallery-http-EXPERIMENT
python3 -m unittest discover -s benchmarks/tool -p test_gallery_http.py
```

По умолчанию выполняются три свежих процесса на каждый размер коллекции,
12 image requests при concurrency 1/4/10 и неизменённые `photo_a.jpg`,
`photo_b.jpg`, `photo_large.jpg` из `assets/media/`. Другие медиа задаются
повторяемым `--media PATH`; для обеих сторон они должны совпадать по SHA-256.
`--harness PATH` фиксирует исходный harness. `--reuse-binary --run-name NAME`
повторяет уже собранную версию в новом подкаталоге без перезаписи предыдущих данных.

`gallery_browser_probe.py` компилирует копию production `MediaImageLoader` в JS
и запускает уже установленный Chrome/Chromium с отдельным временным профилем.
Два локальных origin проверяют настоящий BrowserClient: abort до headers и
во время body, общий cap, single-flight, cache/revision и CORS/OPTIONS/validators.
Новый браузер не устанавливается:

```sh
python3 benchmarks/tool/gallery_browser_probe.py \
  --output benchmarks/reports/gallery-browser-EXPERIMENT
```

Это сетевой тест, а не Flutter UI/scroll/FPS. Локальные исходные данные и выводы
сохранены в [итоговом HTTP/Chrome-отчёте](reports/gallery-implementation-2026-10-26/report.md).
Отдельный [прототип scaled JPEG decode](reports/gallery-thumbnail-local-2026-10-26/report.md)
описывает `gallery_thumbnail_probe.dart`, время, RSS и неизменность оригиналов.
Для повторного показа в Linux отдельно сохранён
[before/after native warm cache](reports/gallery-native-cache-warm-2026-10-26/report.md):
`tool/gallery_native_cache_probe.py` запускает одинаковые 63 попадания через
настоящий кеш в Flutter VM против замороженных исходников. Он проверяет время
пути hit и отсутствие перезаписи metadata; сеть, декодирование и UI FPS в этот
probe не входят. Наблюдения работающей панели и LAN отделены в отчёте.
Тот же инструмент с `--scenario cold` проверяет первые записи JPEG в native-кеш:

```sh
python3 benchmarks/tool/gallery_native_cache_probe.py \
  --freeze-current --snapshot benchmarks/reports/gallery-cold-EXPERIMENT/baseline \
  --scenario cold --fixture-parent /path/on/client/cache/filesystem \
  --payload /path/to/thumbnail.jpg --concurrency 4
# После production-правки — та же команда с новым snapshot candidate,
# теми же payload, filesystem и concurrency.
```

`fixture-parent` должен существовать; инструмент создаёт и удаляет только свои
свежие `gallery-cold-probe-*` каталоги, не открывая действующий кеш панели.
Пять серий по 63 записи проверяют полные байты до возврата, отсутствие `.part`
и попадания после close/reopen. Хранятся frozen sources, хеши harness/payload,
сырые времена и provenance. `--run-name NAME` повторяет frozen вариант в новом
каталоге. [Сравнение cold native cache](reports/gallery-native-cache-cold-2026-10-26/report.md)
отделено от [cold/warm LAN](reports/gallery-live-2026-10-26/lan-cold.json):
запись клиента не измеряет создание производной на сервере.
Отдельный [Linux release A/B](reports/gallery-native-cache-cold-2026-10-26/linux-release-report.md)
использует `tool/gallery_native_cache_release.py` и Dart-template из `tool/`:
runner генерирует entry point внутри ignored report и собирает frozen snapshots,
сохраняя bundles и manifests. Нужны исходные baseline/production snapshots из
этого эксперимента и уже установленные Linux build dependencies/Xvfb. Это
вспомогательные сборки: после них production bundle следует восстановить обычной
`flutter build linux --release --no-pub --target lib/main.dart` из `config_app`.
Wi-Fi, Flutter FrameTiming, визуальная проверка устройства и аппаратный A/B
не выполняются этими командами; для них требуется отдельное окно по
[руководству RaPi5](../doc/raspberry-pi-benchmarks.md).

`tool/backend_local.dart` и `tool/backend_local.py` образуют отдельный pure Dart
стенд для `DiskStorage`, транспорта RPC и `SystemInfoService`. Он не запускает
Flutter, hardware service, GPIO, MQTT, фоторамку или команды настройки сети.
Используются существующие зависимости `backend/.dart_tool/package_config.json`;
стенд ничего не устанавливает и не меняет SDK, версии или lock-файлы.

Перед production-правками сохраните baseline. Runner копирует `backend/lib`,
`common/lib`, pubspec/lock и собственный harness, превращает package roots
в абсолютные пути и компилирует эту копию. Если исходники уже меняются в другом
чате, baseline обязан использовать заранее замороженный package config.
Одинаковый Dart harness применяется к обеим версиям через прежний публичный API.
Если сам инструмент уже получил изменения, `--harness ПУТЬ/baseline/sources/backend_local.dart`
закрепляет прежний исходник; его SHA256 и режим сравниваются при построении отчёта.

Из корня репозитория:

```bash
python3 benchmarks/tool/backend_local.py \
  --packages backend/.dart_tool/package_config.json \
  --variant baseline --output benchmarks/reports/backend-local-EXPERIMENT
# После изменения production-кода:
python3 benchmarks/tool/backend_local.py \
  --packages backend/.dart_tool/package_config.json \
  --variant candidate --output benchmarks/reports/backend-local-EXPERIMENT
python3 benchmarks/tool/backend_local_confirm.py \
  --output benchmarks/reports/backend-local-EXPERIMENT --rounds 1
# Необязательный отдельный process-count diagnostic, если strace уже установлен:
python3 benchmarks/tool/backend_local_trace.py \
  --output benchmarks/reports/backend-local-EXPERIMENT
```

По умолчанию используется существующий SDK
`/home/dis/bin/flutter/bin/cache/dart-sdk/bin/dart`; другой путь задаётся `--dart`.
Это прямой бинарник Dart SDK, а не Flutter wrapper. Режим по умолчанию — локальный
Linux AOT executable (`dart compile exe --packages=...`); `--mode jit` доступен
для диагностики. JIT и AOT напрямую не сравниваются. Существующий каталог варианта
не перезаписывается: для повторения нужен новый experiment. Подтверждение ABBA
использует уже сохранённые AOT binaries, а не текущие production-исходники.
Если после review появились production-исправления, дополнительный вариант
`--variant candidate-final` сохраняет прежний candidate; для него повторите
confirm с `--candidate candidate-final`. Старые результаты остаются в архиве,
основной отчёт показывает окончательный измеренный вариант.
Для отдельного пользовательского уточнения поддержан `candidate-approved`;
его подтверждение выбирается `--candidate candidate-approved`. `--metrics-only`
у confirm повторяет только метрики, если код Storage между вариантами не менялся.

Сценарии по умолчанию: 1/1k/10k/50k файлов, flat/nested, три свежих процесса
на случай. `--sizes 1,1000 --layouts nested --repeats 1 --metrics-repeats 1`
сокращает локальную проверку. Metadata-only fixtures содержат маленькие текстовые
обычные файлы с расширением `.jpg` и отдельными inode; декодер их никогда не читает.
Они проверяют метаданные, не качество фото или воспроизведение. Данные и manifest
переиспользуются с проверкой содержимого/хешей; неполные каталоги не затираются.
Полный набор занимает около 500 MiB при блоке 4 KiB плюс метаданные.

Измеряются первый `next()` (индекс + первый выбор) и ровно N−1 следующих вызовов,
поэтому повторное сканирование на границе цикла не попадает в цифры. Проверка
полноты/уникальности и пары current/next выполняется вне timed window. `init()`
и watcher здесь не используются; их корректность покрывают backend unit-тесты.
Отзывчивость измеряется отдельно: настоящий RPC transport вызывает backend worker
в другом isolate, клиент планирует Echo каждые 5 ms. При занятии четырёх probe ports
интервалы явно отмечаются пропущенными. Сырые scheduled/send/receive timestamps,
event-loop lag и пропуски сохраняются; пропущенные запросы не становятся нулями.

Системные метрики используют данные хоста через production implementation
(`/proc`, `df`, `uptime`, `free` по конкретной версии) и явно подписанный
постоянный fixture script двух сенсоров. Проверяются cold, immediate,
истёкший refresh с интервалом 1100 ms и bursts 2/5. Это ускоренная локальная нагрузка;
штатный frontend запрашивает данные при запуске и раз в минуту. Отдельный diagnostic
pass считает непосредственные вызовы команд forwarding wrappers; shell internals
и все дочерние процессы этим не подсчитываются. Эти wrappers не используются в timed pass.
Штатный hardware service и запись production-логов на диск в этот стенд не входят.
Необязательный `backend_local_trace.py` использует только уже установленный
`strace` и считает успешные fork/vfork/clone без `CLONE_THREAD`, включая split
records. Если окружение запрещает ptrace, причина сохраняется в
`process-diagnostic.json`, а полный счётчик процессов остаётся непроверенным.

`report.md` и `comparison.json` содержат сводку, `raw.jsonl` — исходные наблюдения,
а каталоги вариантов сохраняют provenance, исходный архив, SHA256, package config,
binary, compile log и diagnostic exec log. RSS/HWM относятся ко всему Linux-процессу,
включая оба isolate. `cpu_ms` в raw / `self_cpu_ms` в summary — только Dart
utime/stime, без системных subprocess. Подтверждение `confirm-raw.jsonl` отдельно
собирает CPU процесса вместе с reaped descendants через Python `RUSAGE_CHILDREN`.
Малое число повторов не подтверждает устойчивый p99. Это локальные результаты;
они не подтверждают ускорение на RaPi5 и не заменяют отдельно согласованную
аппаратную проверку. Локальный стенд её не запускает и не планирует.

Регрессии самого инструмента (без Flutter/устройства):

```bash
python3 -m unittest discover -s benchmarks/tool -p 'test_backend_local.py' -v
```

Проверяются полные циклы/один файл, RPC process exit, ошибки обхода, неизменность
source snapshot, повреждённые fixtures и реальное завершение группы процессов
при timeout. `DART_EXECUTABLE` переопределяет Dart для integration tests; если SDK
или backend package config отсутствует, эта часть тестов явно пропускается.

## Сборка на рабочей машине

Используется установленный Flutter SDK и `flutterpi_tool`, как в
`dslideshow_flutter/build_aot_pi4.sh`. Установленная версия `flutterpi_tool`
должна поддерживать `--cpu=pi5`.

```bash
cd benchmarks
./build_aot_pi5.sh
```

Результат: `build/benchmarks-pi5-release-XXXXXXXX.tar.gz` (точное имя скрипт выводит).
В архиве bundle с AOT/engine/assets, `run.sh`, конфигурации и обработчик отчётов.
Тестовые медиа уже включены; Pillow/ffmpeg на устройстве не нужны.
В сборку записываются версия SDK, git commit/dirty status и хеш исходников.

При необходимости engine под Pi 4 на Pi 5: `BENCHMARK_CPU=pi4 ./build_aot_pi5.sh`.
Для диагностики: `BENCHMARK_BUILD_MODE=profile ./build_aot_pi5.sh`.
Итоговую производительность сравнивать в **release** при одинаковых SDK и engine.

## Перенос и запуск через SSH

Устройство: `pi@192.168.50.143`, каталог `/home/pi/workspace/benchmarks`.
Ниже переносится распакованный пакет с рабочей машины; `XXXXXXXX` замените
на суффикс конкретной сборки. Предыдущий benchmark должен быть завершён.

```bash
rsync -a --checksum --partial --timeout=600 \
  -e 'ssh -o BatchMode=yes -o ConnectTimeout=120 -o ServerAliveInterval=30 -o ServerAliveCountMax=10' \
  build/package/benchmarks-pi5-release-XXXXXXXX/ \
  pi@192.168.50.143:/home/pi/workspace/benchmarks/
```

Перед запуском освободите DRM-вывод: `sudo -n service dslideshow stop`.
После завершения или ошибки восстановите `sudo -n service dslideshow start`.
Для запуска используйте supervisor и команды из
[руководства](../doc/raspberry-pi-benchmarks.md#3-запуск-независимый-от-ssh-с-восстановлением-фоторамки):
они продолжают работу после обрыва SSH и восстанавливают службу.
Скрипт не меняет сервисы, прошивку, частоты, governor или настройки системы.
По умолчанию используется `/opt/dslideshow/flutter-pi`; путь можно передать:

```bash
./run.sh --flutter-pi /path/to/flutter-pi --suite standard
```

Используется engine из bundle и доступные библиотеки рядом с выбранным flutter-pi.
Нативный flutter-pi должен поддерживать API engine; Vulkan нужен для тестов
фото/GIF в этом режиме, GStreamer-видеоплагин — для видео в OpenGL.
Если runtime с ними несовместим, ошибка останется в `native.log`, а архив всё равно создастся.
Версия/хеш runtime, аргументы и его `--help` сохраняются в результатах.
OpenGL запускается без `--vulkan`, Vulkan — с этим флагом; launcher не меняет
запрошенный renderer. Внутренние fallback native runtime отдельно не проверяются.

24-часовой `soak` сейчас **отложен пользователем, не запускается**.
При будущей отдельной приёмке один renderer по умолчанию работает 24 часа,
два последовательно — около 48 часов. Для обычных проверок выбирайте smoke,
визуальный набор или standard. Обычный запуск использует OpenGL:

```bash
./run.sh --suite standard --renderers opengl
```

`BENCHMARK_RENDERERS` и `--renderers` позволяют явно выбрать renderer;
CLI имеет приоритет. `vulkan` и `both` сохранены только для будущей отдельной
проверки совместимого runtime. Видео Vulkan по умолчанию выключено.
Пример для будущего runtime с реализованной поддержкой видео:

```bash
./run.sh --suite smoke --renderers vulkan --vulkan-video
./run.sh --suite standard --no-vulkan-video
```

Также доступны `vulkan_video: true` в JSON и `BENCHMARK_VULKAN_VIDEO=true|false`.
CLI/переменная окружения переопределяют JSON; без них default — false.

`--timeout SECONDS` задаёт аварийный предел **для каждого renderer** (по умолчанию 48 часов).
TERM/INT позволяют завершить текущий тест и сохранить частичный отчёт;
зависший engine после timeout получает TERM, затем KILL через 30 секунд.
Одновременный запуск второго benchmark блокируется через `flock`.

## Что запускается

* `smoke`: один повтор без прогрева; все 48 эффектов на фото, представители
  Fade/Cube/Blinds/MosaicFade и baseline на остальных сочетаниях, включая видео и 48 Мп.
* `standard`: **486 случаев**, один прогрев + три измерения каждого.
  Все эффекты на фото→фото, фото→видео, видео→фото, видео→видео, GIF→фото, фото→GIF.
  Мозаики: 100×100, 150×150, 200×200, Canvas и shader.
  Дополнительно фото 48 Мп и три случая с намеренной блокировкой UI на 80 ms.
* `soak`: полная матрица, затем повторение без повторного прогрева до заданного времени.

Сетка не уменьшается, blur и качество изображения не упрощаются.
Используется настоящий `FixedAnimationController`: длительность может растягиваться
под нагрузкой, **это не ошибка**. Проверяются монотонность и ограничение шага прогресса.
Медиа готовятся настоящими `ImageWidget`/`VideoSession` из библиотеки.
В Blinds все полосы используют одну видеосессию на исходник.
Сессии/изображения пересоздаются между случаями и освобождаются после отсоединения виджетов.

Число случаев и время зависят от конфигурации и скорости устройства.
Полный проход может длиться несколько часов: Fixed-контроллер
замедляется, подготовка исходников измеряется заново, после каждого перехода
ожидается доставка пакета FrameTiming. Прогресс виден в stdout/native.log.
Ошибка отдельного теста не останавливает остальные. В smoke/standard после
нативного падения launcher запускает новый процесс с оставшейся частью матрицы;
последний активный случай отмечается как нативный сбой. Замеры сохраняются до
освобождения плееров, поэтому падение при cleanup не уничтожает уже полученные данные.
Каждая попытка хранится в `opengl/attempt-001/`, `vulkan/attempt-001/` и т. д.
Поле `all_supported_cases_attempted` показывает охват поддерживаемых случаев,
`all_cases_accounted_for` учитывает также допустимые `unsupported`;
`all_cases_attempted` может быть false при пропуске видео Vulkan.
`native_crashes` — число падений; нативные ошибки сохраняют `complete=false`,
даже если оставшиеся случаи проверены.
При ошибке до начала первого случая повтор прекращается, чтобы не зациклить старт.
В soak нативное падение прерывает длительный прогон данного renderer и не маскируется перезапуском.

## Экран и оригиналы

Целевой физический вывод — **2560×1600**; launcher передаёт `--videomode 2560x1600`.
Фактические physical/logical размеры, DPR и частота дисплея записываются в metadata.
Совпадение с целью проверяется; нагрузка не подгоняется уменьшением размера окна.
Чтобы использовать режим ОС без запроса videomode: `BENCHMARK_VIDEO_MODE=none ./run.sh`.

В bundle включены JPEG **4032×3024**, **6000×4000**, **8000×6000**, анимированный GIF,
два движущихся H.264/30 fps ролика 1920×1080. JPEG — детерминированные изображения
для повторяемой нагрузки, не коллекция настоящих фотографий. Они декодируются
в полном исходном размере; готовый слайд создаётся в физическом разрешении экрана,
как в основном приложении. Время подготовки включает чтение, decode, фон/blur и создание слайда.
HWM/RSS помогают увидеть цену больших оригиналов.
До прогона вычисляются хеши файлов; дисковый кеш ОС не очищается.
Измерение подготовки не является тестом холодного чтения с SD-карты.

Рекомендуется также прогнать **свои необработанные фото и видео**. В отдельном каталоге
разместите файлы с такими именами (перекодировать/уменьшать их не нужно):

```text
photo_a.jpg       # оригинал с телефона
photo_b.jpg       # оригинал с камеры
photo_large.jpg   # самый большой оригинал
animation.gif
video_a.mp4
video_b.mp4
```

```bash
BENCHMARK_MEDIA_DIR=/home/pi/benchmark-originals ./run.sh --suite standard
```

Хеши, размер файлов и фактические размеры изображений сохраняются; размеры и
длительность внешних видео считываются после инициализации декодера.
Исходники не включаются в отчётный архив. Портреты/EXIF, HEVC/4K и особенности
реальной фототеки исследуются таким прогоном; встроенные файлы этого не заменяют.
При необходимости изменить настройки без сборки: `--config /path/custom.json`.
Все поля перечислены в `lib/src/config.dart`; неизвестные поля/имена вызывают ошибку.
`BENCHMARK_SUITE`, `BENCHMARK_SOAK_SECONDS`, `BENCHMARK_MEDIA_DIR` имеют приоритет над JSON.
Например для исследования сетки 250×250:

```json
{"effects":["MosaicFade"],"media_cases":["photo-photo","video-video"],"grids":[100,200,250],"backends":["canvas","shader"],"capture_frames":false}
```

## Метрики и отчёты

В конце launcher выводит `BENCHMARK_ARCHIVE=...tar.gz`. Передайте **весь архив**.
Он содержит общий `report.html` выбранных renderer, их сводки
и подробные данные каждой попытки в `renderer/attempt-NNN/`:

* `report.html`, `report.md`, `summary.json`, `summary.csv` — сводка, графики и checkpoint;
* `runs.jsonl` — подготовка, каждый повтор, длительность/stretch, шаги прогресса,
  UI/raster/total span p50/p95/p99/max, интервалы vsync, оценка пропущенных vsync, декодеры;
* `frames.jsonl` — сырые FrameTiming с метками случая/повтора/фазы;
* `telemetry.jsonl` — RSS/HWM, CPU процесса/системы, память/swap, потоки/FD,
  температура CPU, частоты CPU/GPU, `vcgencmd get_throttled` при доступности;
* `captures/` — полные PNG 0/50/100% для фото→фото, первый размер сетки,
  вне измерений; в smoke/soak по умолчанию отключены;
* `video-probes/` — два контрольных захвата каждого видео, один раз перед прогревом;
* `native.log`, `errors.jsonl`, `launch.json`, `launcher-status.json` — ошибки и параметры запуска.

Скопировать архив обратно:

```bash
rsync -a --partial --append-verify --timeout=600 \
  -e 'ssh -o BatchMode=yes -o ConnectTimeout=120 -o ServerAliveInterval=30 -o ServerAliveCountMax=10' \
  pi@192.168.50.143:/home/pi/workspace/benchmarks/reports/ИМЯ.tar.gz ./
```

Необходим Python 3 стандартной поставки Raspberry Pi OS, Bash, coreutils, `flock`, `tar`.
Частоты/температуры/`vcgencmd` могут быть недоступны — записывается `null`, а не ноль.
Процессный CPU может превышать 100% на нескольких ядрах. HWM — максимум процесса с запуска;
периодический RSS может не поймать короткий пик. RSS сам по себе не доказывает утечку.
Приоритет имеют тенденции после прогрева, HWM, FD/потоки и ошибки в длительном прогоне.

В release FrameTiming доставляется пакетами примерно раз в секунду, поэтому
сбор хвоста ожидается отдельно (`timing_drain_ms>=1000`, по умолчанию 1200).
Отсутствие кадровых данных считается ошибкой; FPS не подменяется числом тиков анимации.
Среднее/максимум p95 отдельных прогонов не называются общим p95. Сырые кадры сохранены.
FPS/пропущенные vsync — оценки по Flutter submissions, не аппаратные счётчики дисплея.

**Видео в текущем Vulkan flutter-pi:** историческое
[ограничение внешних видеотекстур](https://github.com/ardera/flutter-pi/issues/477#issuecomment-2837937981)
относится к используемому embedder. Flutter добавил новый API в
[PR #188855](https://github.com/flutter/flutter/pull/188855) (создан 1 июля,
слит 2 октября 2026); flutter-pi должен отдельно реализовать Vulkan texture callback.
В исходниках runtime на устройстве он не подключён, доступный embedder header
этого API не содержит. Поддержка в движке сама по себе не включает её в flutter-pi.
Исторический прогон 25.10.2026 пытался запустить все 237 видеосценариев Vulkan
и получил native crash. Новый стенд пропускает их до подготовки медиа со статусом
`unsupported`: они не считаются ошибками или измерениями. Все 249 сценариев
Vulkan без видео в историческом прогоне завершены.

**Проверка видео в OpenGL:** автоматически проверяются инициализация, ошибки, пауза/запуск и
движение позиции. Дополнительно один раз для каждого источника вне измерений снимаются
два кадра композиции видео с интервалом 700 ms. `captured_motion` в
`metadata.video_texture_probes` означает, что захват содержит меняющиеся пиксели
видеотекстуры. Чёрный/неподвижный/недоступный захват даёт `unverified`: некоторые
embedder не поддерживают снимки Texture, а внешнее видео может иметь неподвижный фрагмент.
Физический вывод дисплея этим не проверяется. Контрольные PNG и native.log остаются
в архиве. Пользователь также подтвердил видимое видео на физическом экране
во время прогона 25.10.2026; режим и конкретный сценарий этого наблюдения неизвестны.

Для повторной генерации общего отчёта: `python3 tool/collect_reports.py reports/КАТАЛОГ`.
Потребление диска зависит от длительности и PNG; для soak предусмотрите несколько GB.
Отчёты дописываются во время работы, checkpoint сохраняется после каждого случая.

### Визуальная проверка

```bash
./run.sh --config config/visual.json --renderers opengl --timeout 3600
```

Короткий набор проверяет все 48 эффектов на фото, включая Canvas/shader мозаики
100×100. Для каждого снимается 21 кадр (0, 5, …, 100%) и отдельные эталоны A/B.
Захват выполняется в разрешении экрана; превью отчёта уменьшаются до 320×200.
Фото и реальный рендер сохраняют исходное качество. Проверяются начальный и
конечный кадры, число разных кадров и длинные статичные участки. Чёрный/прозрачный
readback даёт `unverified_capture`, а не ложный успех. Откройте `visual-report.html`:
там есть полосы кадров и пошаговый просмотр/воспроизведение.

Контрольные кадры намеренно неподвижны и снимаются вне измерения времени.
На дисплее эта фаза подписана «КОНТРОЛЬНЫЙ КАДР … анимация остановлена».
Ранее три неподписанных кадра Diagonal на 0/50/100% могли выглядеть как
дискретное появление двух треугольников. Это не запись реальной анимации.

Локальная плотная проверка: `flutter test --no-pub tool/audit_effects_test.dart`.
Она проверяет 21 кадр при размерах 160×100 и 2560×1600, включая положительную
глубину углов 3D-преобразований. Результат — `build/effects/visual-audit.json`.
24-часовой прогон сейчас отложен; визуальный набор его не запускает.

### Точечный A/B ZoomOver и BlurFade

Вызовы launcher ниже передавайте supervisor из аппаратного руководства:

```bash
./run.sh --config config/zoom-blur.json --renderers opengl --timeout 2400
./run.sh --config config/zoom-blur-confirm.json --renderers opengl --timeout 2400
./run.sh --config config/zoom-blur-visual.json --renderers opengl --timeout 1800
./run.sh --config config/zoom-blur-video.json --renderers opengl --timeout 2400
```

Первый набор: Baseline/Fade/ZoomOver/BlurFade × фото, фото 48 Мп и оба направления
GIF — 16 сценариев, один прогрев и три измерения. Второй снимает 21 контрольный
кадр ZoomOver/BlurFade и Baseline. Третий проверяет Baseline/ZoomOver/BlurFade
на фото→видео и видео→фото с одним декодером — шесть сценариев. Известный native
сбой video→video остаётся отдельным дефектом, этот набор его не проверяет.
Для A/B используйте одинаковые конфиги/оригиналы, исходную и новую release-сборки;
переходить на Vulkan для этого сравнения не нужно.
`zoom-blur-confirm.json` оставляет восемь случаев на обычных/48 Мп фото для
повторной пары в обратном порядке. Результаты и принятая оптимизация описаны
в [аппаратном разборе ZoomOver/BlurFade](../doc/zoom-blur-optimization-2026-10.md).

Агрегация использует сырые `runs.jsonl`, включая повторы после последнего checkpoint.
`error_counts` отдельно показывает runtime/cleanup/capture/telemetry ошибки;
`failed_runs` не подменяет эти счётчики. `successful` требует отсутствия всех ошибок.

## Локальные проверки

```bash
flutter analyze --no-pub
flutter test --no-pub
python3 -m unittest discover -s tool -p 'test_*.py'
bash -n run.sh build_aot_pi5.sh
flutter test --no-pub tool/render_effect_gallery_test.dart
```

Галереи появятся в `build/effects/gallery-1.png` … `gallery-4.png`.
Для пересоздания встроенных медиа: `python3 tool/generate_media.py`
(только на рабочей машине: Pillow и ffmpeg с libx264).

Методика: [FrameTiming Flutter](https://api.flutter.dev/flutter/scheduler/SchedulerBinding/addTimingsCallback.html),
[/proc Linux](https://docs.kernel.org/filesystems/proc.html),
[flutter-pi: build/run/--vulkan](https://github.com/ardera/flutter-pi).

[Новые эффекты и Ken Burns](../doc/new-visuals-2026-10.md): настройка, совместимость,
предпросмотр, тесты и измерения на RaPi5.
