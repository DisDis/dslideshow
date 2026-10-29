# Автоматические бенчмарки DSlideShow на Raspberry Pi

История стенда и его инструментов — в [собственном changelog](changelog.md).
Изменения приложений описываются в [корневом changelog](../changelog.md).
Сохранённые результаты и состав архивов — в [индексе отчётов](reports/README.md).
[Правила сопровождения](../doc/benchmarks-maintenance.md) задают обновление
документации, хранение доказательств, удаление устаревшего и ежемесячный аудит.
[Очистка стенда 29.10.2026](reports/maintenance-2026-10-29/report.md) описывает
удалённые материалы, освобождённое место и границы локальной проверки.

[Локальная диагностика Louver 29.10.2026](reports/louver-clipping-2026-10-29/report.md)
сохраняет воспроизведение утечки изображения за поворотными планками,
Linux release-кадры до/после и границы проверки. Временный probe архивирован;
регрессионный тест находится в production suite. Web, RaPi5 и скорость
отрисовки в этом исследовании не проверялись.

[Стенд экрана OTA](ota-harness.md) монтирует production-страницу с локальным
потоком установщика: QR/код, полноширинный журнал, просмотр истории, возврат
к последней строке и cleanup. Реальная установка и перезагрузка не выполняются.

[Новый формат эффектов и локальные проверки](../doc/effect-settings.md):
37 типов и 82 пресета в приложении; standard сохраняет 684 сценария за счёт явных вариантов
в `lib/src/effect_variants.dart`. ID включает параметры; отчёт — `effect_config`.
`effect_configs` — карта типов со списком вариантов настроек под каждым
ключом; в значениях нет поля `type`. Значение `options.durationMs=0`
наследует `transition_ms`. Неизвестные поля и имена сценариев отклоняются.

Модели `BenchmarkConfig` и `BenchmarkCase` используют Freezed и json_serializable;
после изменения полей запустите в `benchmarks/` команду `dart run build_runner build`.
Отчётная проекция сценария генерируется с прежними ID и JSON-ключами.

Отдельное Flutter-приложение с path-зависимостью от `../dslideshow_flutter`.
В основном приложении нет точки входа, телеметрии или переключателей для бенчмарков.
Мышь, клавиатура и действия пользователя для прогона не нужны.
Аппаратные прогоны используют подключённый дисплей 2560×1600.
При запуске тесты начинаются автоматически, отчёты записываются на диск,
приложение завершает процесс. SSH-скрипт по умолчанию запускает **только OpenGL**
и упаковывает результат, включая нативные логи и результаты аварийного запуска.
Аппаратные проверки Vulkan отложены до поддержки видео в native runtime.

Для изменений владения ресурсами в `SlideShowPage` используйте отдельный
[стенд настоящего renderer](renderer-harness.md): он монтирует production-страницу,
Bloc, фото, плееры и специальные экраны. Обычный `BenchmarkViewport` создаёт
ресурсы самостоятельно и не проверяет такой рефакторинг.
Аппаратный [A/B и визуальная проверка SlideSession 28.10.2026](reports/slide-session-2026-10-28/report.md)
сохраняют frozen release/source, исходные ошибки калибровки и границы приёмки.

Пошаговое [руководство для RaPi5](../doc/raspberry-pi-benchmarks.md) содержит
актуальные пути к flutter-pi, установку, запуск через нестабильный SSH в фоне
с восстановлением службы фоторамки, точечные тесты и получение отчётов.

Отдельный короткий A/B flutter-pi сравнивает
`integration_dpms_and_video` и `remove-page-flip` на одинаковом frozen release-bundle внутри каждой пары,
с ABBA, тяжёлыми эффектами, видео и независимыми DRM completion-событиями.
Результаты 27.10.2026: [отчёт по всем эффектам](reports/flutter-pi-pageflip-2026-10-27/report.md)
и [English report for the MR](reports/flutter-pi-pageflip-2026-10-27/mr-report.md).

[Раздельная диагностика native pipeline](tool/native_pipeline/README.md)
сопоставляет время EGL/GBM/KMS, GPU-задания V3D и DRM completion на одном frozen
release bundle. Инструментированные данные предназначены для поиска узкого места;
результаты и ограничения — в [разборе flutter-pi](reports/flutter-pi-native-pipeline-2026-10-28/report.md).

## Пресеты и расширенные настройки

[Таблица соответствия](../doc/effect-settings.md#соответствие-пресетов) описывает 82 пресета;
результат принятого визуального сравнения сохранён в [отчёте](reports/effect-presets-2026-10-28/report.md).
Пользователь подтвердил замену
прежних эффектов 28.10.2026; временные эталонные рендеры, их шейдеры,
тест сравнения и локальный HTML/PNG-отчёт удалены после проверки.

Прежние имена сохраняются в ID исторической матрицы; `effect_config` отчёта
содержит фактические канонические тип и options. `config/effect-options-visual.json`
и `effect-options-performance.json` остаются для необязательной последующей
диагностики, без Vulkan/24h и без изменения runtime. В текущей задаче аппаратный
прогон не требуется по решению пользователя.

Для отдельного исследования производительности после обновления каталога
используйте [двухэтапный фото-прогон](reports/effect-performance-2026-10-28/report.md).
`flutter test --no-pub tool/prepare_effect_screening_test.dart` создаёт
`build/effect-screening/screening.json` и `catalog.json` непосредственно из
production-каталога: все 37 defaults и 82 пресета, одинаковые настройки
измеряются один раз. Первый проход — только фото→фото, без прогрева,
один повтор, Mosaic 100×100/Canvas, без захвата кадров и намеренных stall.
Отбор для повторного измерения — `sampled_fps < 25`; ошибки и отсутствующие
измерения требуют отдельного разбора. Это предварительный отбор, не A/B.

### Входные фото как в основном приложении

Viewport создаёт два неизменяемых `EffectSlideInput` при подготовке сценария и
передаёт те же экземпляры в каждый кадр `createTransformWidget`. `view` сохраняет
исходное дерево слоёв; `photo` заимствует подготовленный bitmap у `ImageWidget`
и содержит `PhotoCamera` без изменяемой матрицы. У GIF/видео `photo == null`.
Отдельного `bindPhotos` и выбора конкретного класса для передачи фото больше нет;
`supportsInputs` проверяется до запуска анимации. Callback `onEffectPrepared`
получает те же входы и может заимствовать их ресурсы только до `release()`.
`PhotoMotionProbe` сам применяет камеру к `view`, поэтому его входная камера
остаётся единичной. Проба запускается явно через `config/photo-motion.json`
на обычных/48-Мп фото. Отказ для неподдерживаемых медиа проверяется отдельно в VM.

Локальные shader-regression targets явно передают подготовленные фото;
галерея и общие visual audits сохраняют живые входы, где эффект их поддерживает.
В галерее и общем pixel audit фото добавляются только при отказе
`supportsInputs` от live-входов. Frozen shader fixtures, плотность Mosaic,
размеры, фазы и допуски сравнения сохраняются. Для миграции этого API аппаратный
прогон исключён пользователем: исторические release/source-отчёты подтверждают
только зафиксированные в них сборки, а не текущий интерфейс.

Для измерения обычных переходов фото→фото включите в JSON
`"production_photo_inputs": true`. Подготовленное фото передаётся эффекту в
`SizedBox` размера viewport, как в основном слайдшоу, без добавочных чёрной
подложки и `RepaintBoundary` на каждом входе. Общая граница захвата стенда
сохраняется; качество, размер подготовки и освобождение
изображений не меняются. По умолчанию поле выключено для воспроизводимости
прежних отчётов. GIF/видео, Ken Burns и случаи с намеренным stall сохраняют
прежние входные слои даже при opt-in.
Включайте одинаковое значение в baseline и candidate; результаты с разными
входными слоями требуют нового baseline и не являются A/B оптимизации эффекта.

Обычные входы не имеют `GlobalKey`: эффекты Glass, Radial Blur и Phosphor
монтируют несколько представлений одного медиа. Прежний общий ключ переносил
исходящий виджет между ветками даже в release и искажал многослойную нагрузку; для таких эффектов
нужны новые baseline/candidate с исправленным стендом. Общие подготовленные
bitmap и видеосессии по-прежнему принадлежат одному владельцу на медиа.

После ручного визуального принятия оптимизированных эффектов временные копии
original/reference, их shader и одноразовый pixel-comparison target удалены из
рабочих исходников. Завершённый audit, его release-bundle и source archive
сохранены в `reports/effect-performance-2026-10-28/corrected-harness/egl-pixels-painted-bootstrap/`;
сырые результаты и строгие статусы проверок остаются прежними. Ручное принятие
визуальных отличий не превращает несовпавшие пиксельные проверки в passed.

Универсальные [EGL backbuffer capture](tool/egl_capture/README.md), Dart IPC helper
и его тесты сохранены: wrapper с `LD_PRELOAD`, native swap-barrier и RGBA8
readback проверяют реально закешированные OpenGL-текстуры. Для повторения
завершённого audit используйте сохранённые архивы; измерения производительности
с interposer недействительны. Перенос Stretch/CrossZoom/Radial и последующих
фото-шейдеров Glass/Film в production описан ниже.

### Принятые оптимизации и независимые эталоны

Stretch/CrossZoom/Radial, фото-шейдеры Glass/Film Dissolve и общий kernel Glass
перенесены в production. Условия A/B, визуальные различия и release/source архивы
описаны в [исследовании эффектов](reports/effect-performance-2026-10-28/report.md).
Закрытые экспериментальные классы и одноразовые entrypoints удалены.

`config/photo-shader-focus.json` проверяет Baseline/Fade/Glass/Film на фото.
`shaders/glass_reconstruction_reference.frag` сохраняет shader до общего kernel;
`test/glass_reconstruction_test.dart` сравнивает production Glass с независимым
эталоном на контрастных/прозрачных фото, разных панелях, размерах и камерах
(max delta≤2), проверяет переиспользование и освобождение shader.

`tool/build_info.py` включает shader assets, Dart-код и конфигурацию в fingerprint;
генерируемые build outputs исключены. Сохранённые архивы подтверждают только
свои frozen сборки, а не текущий исходный код.

## Radial / VHS после обновления flutter-pi и частот

[Продолжение GPU-оптимизации](reports/gpu-effects-2026-10-28/report.md) содержит
отдельные ABBA на runtime `30669…ea4b`, CPU max 2600 / GPU max 900 МГц.
Принятые реализации перенесены в production: общий UV Radial и кешируемый tint VHS.
Наборы `config/gpu-radial-focus.json` и `config/gpu-vhs-cache-focus.json` теперь
измеряют обычные фабрики; стенд передаёт VHS два входа с существующими bitmap.
GIF/видео передают `photo == null` и сохраняют исходный живой путь.

`test/radial_shared_uv_test.dart` сравнивает production shader с замороженным
`shaders/radial_shared_uv_reference.frag`, включая все origins, камеры и разные
аспекты. `test/cached_vhs_test.dart` проверяет фабрику, сброс к живым входам и
цвет/полосы/noise на контрастных полупрозрачных фото. Локальные тесты не заменяют
реальный EGL-аудит raster cache; его исходный failed-статус VHS сохранён в отчёте.
Временные shader/painter-кандидаты и entrypoints удалены после сохранения
release/source архивов. Более медленные варианты Kaleidoscope не перенесены.

```sh
flutter test --no-pub test/cached_vhs_test.dart test/radial_shared_uv_test.dart
```

## Завершённые исследования

BlurProbe, MosaicProbe и CompositionProbe вместе с историческими конфигами
удалены после завершения исследований. Их исходники доступны в истории Git,
сохранённые измерения и ограничения — через [индекс отчётов](reports/README.md).
Для новых проверок используйте production-эффекты и актуальные конфиги ниже.
Регрессии эффектов находятся в `dslideshow_flutter/test/`; стенд сохраняет
проверки входов/ресурсов и full-frame visual audit всех сеток 100/150/200.

| Конфиг | Назначение |
| --- | --- |
| `smoke.json`, `standard.json` | Общая матрица фото/GIF/видео, ошибки и ресурсы |
| `visual.json` | 21 контрольная фаза штатных эффектов |
| `effect-options-visual.json`, `effect-options-performance.json` | Полный текущий каталог и варианты настроек |
| `photo-motion.json` | Ken Burns и подготовка обычных/48-Мп фото |
| `photo-shader-focus.json` | Baseline/Fade/Glass/Film |
| `gpu-radial-focus.json`, `gpu-vhs-cache-focus.json` | Короткие production-сценарии Radial/VHS |
| `native-pipeline-photo.json` | Фото для отдельной native-диагностики |
| `soak.json` | Отложенный длительный набор; не запускается автоматически |

Все конфиги находятся в `config/`. Плотность, разрешение и качество штатных
эффектов при очистке не изменяются.

## Локальные проверки backend без Flutter и устройства

`flutter analyze --no-pub` проверяет живые исходники стенда. Каталоги `build/`
и `reports/` исключены: они содержат сгенерированные targets и замороженные
копии чужих пакетов. Автоматическая Chrome-проба галереи удалена; браузерные
проверки пишутся и запускаются только с согласия
пользователя, см. [правила тестирования](../doc/testing.md#браузерные-проверки).

Исследовательские `tool/camera_rpc_probe.dart` и `tool/rpc_timeout_probe.dart`
проверяют настоящий HTTP при отказах камер и удержание межизолятных RPC-слотов.
`tool/camera_device_probe.dart` и `tool/camera_socket_probe.py` сопоставляют
читающие RPC со снимками TCP/FD работающей рамки. `tool/camera_http_probe.py`
сравнивает публичный `/info` через сеть и loopback. Действующие команды —
в [диагностике страницы устройства](../doc/config-app-device.md#диагностика-задержек-управления),
результаты и границы наблюдений — в [исследовании timeout камер](reports/camera-rpc-2026-10-26/report.md).

### Миниатюры и управляемый HTTP галереи

[Один FFmpeg и JPEG](reports/thumbnail-jpeg-local-2026-10-27/report.md) сохраняет
актуальное сравнение с предыдущим probe/RGBA/encode, сырые HTTP-результаты,
медиахеши и ограничения проверки.
`gallery_http.py --bucket 256|512|1024` берёт policy из каталога;
`--cold-concurrency 4` задаёт параллельный холодный проход. Инструмент измеряет
дерево процессов: sampled sum RSS/FD/threads и CPU с reaped children.
Сумма RSS может дважды учитывать shared pages; дискретный максимум не является
точным peak RSS. `/info` остаётся HTTP-proxy отзывчивости, не измерением RPC.
[Совместимость FFmpeg 5.1 и диагностика](reports/gallery-ffmpeg51-diagnostics-2026-10-27/report.md):
`tool/ffmpeg_thumbnail_compat.dart` запускает настоящий production worker, создаёт
alpha/EXIF/GIF/tiny fixtures, проверяет JPEG, MD5 и неизменность источников.
Необязательный аргумент — каталог с photo_a/photo_b/photo_large/video_a.
Файл исключён из Flutter-анализатора benchmarks: он
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

Прежняя автоматическая Chrome-проба BrowserClient/CORS удалена 29.10.2026.
Её локальные исходные данные и выводы сохранены в
[итоговом HTTP/Chrome-отчёте](reports/gallery-implementation-2026-10-26/report.md).
Его итоговые Markdown/JSON и одноразовый генератор сохранены с отчётом;
генератор работает только с архивными результатами и не является общим runner.
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
[Завершённый Linux release A/B](reports/gallery-native-cache-cold-2026-10-26/linux-release-report.md)
сохраняет frozen исходники и release-архивы. Его генераторы, привязанные к одному
эксперименту, удалены из `tool/`. Для новых сравнений используйте универсальный
`gallery_native_cache_probe.py`; границы его VM-проверки перечислены выше.

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

* `smoke`: один повтор без прогрева; все эффекты общего реестра на фото, представители
  Fade/Cube/Blinds/MosaicFade и baseline на остальных сочетаниях, включая видео и 48 Мп.
* `standard`: **684 случая**, один прогрев + три измерения каждого.
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
Например для явной настройки мозаики (штатные сетки 100/150/200):

```json
{"effect_configs":{"mosaic":[{"enabled":true,"options":{"durationMs":0,"gridSize":100,"fadeFraction":0.3,"direction":"topLeft"}}]},"media_cases":["photo-photo","video-video"],"grids":[100,150,200],"backends":["canvas","shader"],"capture_frames":false}
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

`tool/compare_effect_performance.py` сравнивает raw-коллекции с проверкой условий
и полноты измерений. Прогрев в `runs.jsonl`/`frames.jsonl` имеет `phase=warmup`,
`cycle=0`, отрицательные `repeat` от `-config.warmups` до `-1`; измеряемые повторы
начинаются с нуля. Прогрев не входит в FPS и хвосты FrameTiming, но его валидные
`warmup:<case>:-N` telemetry samples входят в память/SwapFree. Некорректные номера,
ошибки прогрева и дубликаты не превращаются в успешные измерения.

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

Короткий набор проверяет все эффекты общего реестра на фото, включая Canvas/shader мозаики
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

Агрегация использует сырые `runs.jsonl`, включая повторы после последнего checkpoint.
`error_counts` отдельно показывает runtime/cleanup/capture/telemetry ошибки;
`failed_runs` не подменяет эти счётчики. `successful` требует отсутствия всех ошибок.

## Локальные проверки

```bash
flutter analyze --no-pub
flutter test --no-pub
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest discover -s tool -p 'test_*.py'
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest discover -s tool/native_pipeline -p 'test_*.py'
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest discover -s tool/egl_capture -p 'test_*.py'
bash -n run.sh run_renderer.sh run_ota.sh build_aot_pi5.sh build_renderer_pi5.sh build_ota_pi5.sh
flutter test --no-pub tool/render_effect_gallery_test.dart
```

Эти команды запускают VM/native локальные тесты. Устройство и браузер не
используются; реальный GPU/scanout и DOM/interop ими не проверяются.

Галереи появятся в `build/effects/gallery-*.png`; количество файлов зависит
от размера реестра эффектов, по 12 переходов на страницу.
Для пересоздания встроенных медиа: `python3 tool/generate_media.py`
(только на рабочей машине: Pillow и ffmpeg с libx264).

Методика: [FrameTiming Flutter](https://api.flutter.dev/flutter/scheduler/SchedulerBinding/addTimingsCallback.html),
[/proc Linux](https://docs.kernel.org/filesystems/proc.html),
[flutter-pi: build/run/--vulkan](https://github.com/ardera/flutter-pi).

[Новые эффекты и Ken Burns](../doc/effects.md): настройка, совместимость,
предпросмотр, тесты и измерения на RaPi5.
