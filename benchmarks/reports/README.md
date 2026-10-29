# Сохранённые результаты бенчмарков

Последний полный аудит: **29.10.2026**.
[Состав очистки и проверок](../../doc/benchmarks-cleanup-2026-10-29.md).
Здесь остаются
доказательства принятых изменений, диагностика незакрытых вопросов и компактные
данные отклонённых экспериментов. Отчёты описывают **сохранённые сборки**:
последующие изменения каталога эффектов, API входов и версий не становятся
аппаратно проверенными только потому, что рядом есть исторический отчёт.

## Основные материалы

| Материалы | Что сохраняют и как читать результат |
| --- | --- |
| [OTA UX, 29.10](ota-ux-2026-10-29/report.md) | Итоговая release/source A/B, timing, PNG и provenance. Исходные отказы instrumentation и пустого ready-экрана сохранены. Стенд проверяет настоящую страницу с искусственным потоком; установка пакета и перезагрузка не выполнялись. |
| [SlideSession, 28.10](slide-session-2026-10-28/report.md) | A/B настоящего renderer, lifecycle, память и визуальные endpoints. Сохраняются исходные отказы калибровки и обратный повтор памяти; ускорение и отсутствие утечек не заявляются. |
| [GPU Radial / VHS](../../doc/gpu-effect-performance-2026-10.md) | Принятые `gpu-radial-uv-2026-10-28/`, `gpu-vhs-cache-2026-10-28/`, общий quality audit `gpu-visual-2026-10-28/`, итоговая интеграция `gpu-production-2026-10-28/` и сводки `gpu-effects-2026-10-28/`. Сохранены source/release, исходные A/B и provenance. **Strict max2 для VHS не пройден**; ручное принятие не меняет failed-статус. |
| [Новый каталог и фото-шейдеры](../../doc/effect-performance-2026-10.md) | `effect-performance-2026-10-28/corrected-harness/`: принятые сравнения, raw и frozen source/release, включая экспериментальные Stretch/CrossZoom/Radial, Glass/Film и общий Mitchell kernel. Итоговый EGL-аудит — `egl-pixels-painted-bootstrap/`; исходные несовпадения сохранены. Предыдущие некорректные входы остаются только диагностическими данными и исходниками. |
| [OpenGL video](flutter-pi-video-2026-10-25/README.md) | Baseline SIGSEGV, исходные native/error/active-operation логи, исправления upload/lifecycle/EOS, source/runtime и общий bundle. Короткие успешные проверки не заменяют длительную приёмку. `legacy-failure-evidence.tar.gz` дополнительно сохраняет старые ошибки standard/smoke/native-исследования и их исходные сводки. |
| [Page-flip A/B](flutter-pi-pageflip-2026-10-27/report.md) | Полный архив сравнения native runtime и независимые DRM completion-события, provenance и итоговые сравнения. Sampled Flutter FPS и физическая частота завершений различаются. |
| [Native pipeline](../../doc/flutter-pi-native-pipeline-2026-10.md) | `flutter-pi-native-pipeline-2026-10-28/`: raw evidence, финальный анализ, инструментированные источники и доказательства завершения. Диагностические timings не являются обычным FPS A/B; исходные ограничения trace/lifecycle сохранены. |
| [Текущие JPEG-миниатюры](thumbnail-jpeg-local-2026-10-27/report.md) | Локальное AOT A/B нынешнего конвейера с одним FFmpeg; source, итоговые raw и provenance. Это не аппаратная приёмка RaPi. Копия большого JPEG в fixtures воспроизводится из `../assets/media/photo_large.jpg`. |
| [Совместимость FFmpeg 5.1](gallery-ffmpeg51-diagnostics-2026-10-27/report.md) | Воспроизведение native SIGSEGV прежнего RGBA-фильтра и исправление для установленного FFmpeg 5.1.9; короткие исходные логи и результаты. |
| [Backend](../../doc/backend-performance.md) и [галерея](../../doc/gallery.md) | `backend-local-2026-10-26/`, `gallery-implementation-2026-10-26/`, `gallery-native-cache-cold-2026-10-26/`, `gallery-native-cache-warm-2026-10-26/`, `gallery-live-2026-10-26/`: принятые сравнения, snapshots и наблюдения. В галерейном `archive-support/` сохранён генератор исторического HTTP/Chrome-отчёта; браузерные проверки при очистке не выполнялись. |
| [Камера и RPC](../../doc/camera-rpc-investigation-2026-10.md) | `camera-rpc-2026-10-26/`, `rpc-telemetry-live-2026-10-26/`, `rpc-telemetry-2026-10-26/`: исходные задержки/timeout, состояния очередей, локальное сравнение инструментации и границы наблюдений. Отсутствие прежней задержки в одном коротком запуске не доказывает исправления. |

## Ранние принятые оптимизации

Числа, условия и ограничения находятся в отдельных документах:
[ZoomOver](../../doc/zoom-blur-optimization-2026-10.md),
[BlurFade](../../doc/blur-fade-optimization-2026-10.md),
[Mosaic/MosaicFade](../../doc/mosaic-optimization-2026-10.md),
[Accordion/LiquidMorph](../../doc/accordion-liquid-optimization-2026-10.md).
В одноимённых каталогах `*-2026-10-25/` сохранены raw-архивы, source snapshots,
конфигурации, JSON/CSV и `release-archives/` с принятыми baseline/candidate.
Старые распакованные галереи и производные HTML удалены. Для пересчёта отчёта
используются сохранённые raw и `analyze.py`; исходные ошибочные видео-прогоны
не превращаются в успешные измерения.

## Отклонённые GPU-эксперименты

`gpu-creative-2026-10-28/`, `gpu-creative-mitchell-2026-10-28/`,
`gpu-radial-2026-10-28/` и `gpu-kaleidoscope-canvas-2026-10-28/`
содержат source snapshots, компактные experiment/test archives, исходные
ABBA raw, сравнения, provenance и строгие failed-проверки. Тяжёлые executable
bundles этих непринятых вариантов удалены. Причины отказа — отсутствие выигрыша
либо нарушение численных границ, см. [разбор GPU](../../doc/gpu-effect-performance-2026-10.md#отклонённые-варианты).
Наличие исходника не означает, что вариант используется в production.

## Что заменено и удалено

* Начальные `initial-device-check`, `recovery-device-check`, `visual-initial`,
  `policy-verification`, `visual-device-check`, `full-standard-RaPi5` и
  `RaPi5-standard-2026-10-25-analysis` относятся к старому стенду/каталогу.
  Их ограничения записи и агрегации, частичные measured-повторы, native ошибки
  и различие Flutter vsync/физического дисплея описаны в
  [истории эффектов](../../doc/effects-work.md). Исходные диагностические логи
  и `full-standard-summary.json` находятся в `legacy-failure-evidence.tar.gz`.
  Эти прогоны не являются baseline текущего каталога.
* `new-visuals-2026-10-25` заменён принятым каталогом и пресетами;
  [итог сравнения](../../doc/effect-presets-review.md) описывает актуальное решение.
  Старые контрольные рендеры не требуются для новой аппаратной приёмки.
* `gallery-local-2026-10-26` был исследованием прежнего контракта до реализации;
  актуальные результаты находятся в HTTP/cache-отчётах выше.
  `gallery-thumbnail-local-2026-10-26` исследовал pure Dart scaled JPEG;
  `thumbnail-ffmpeg-local-2026-10-27` — промежуточный probe/RGBA/encode.
  Оба пути вытеснены нынешним одним FFmpeg с JPEG; их выводы и ограничения
  сохранены в [руководстве галереи](../../doc/gallery.md).
* `backend-extraction-2026-10-27` проверял локальное выделение классов без
  изменения протокола/lifecycle. Arm64-пробы не запускались; аппаратных
  результатов у этого завершённого рефакторинга нет.
* `rpc-capacity-2026-10-26` содержал local smoke и неисполненные arm64-пробы.
  Передача по SSH прервалась до AOT-запуска; аппаратного A/B нет. Диагностика
  очередей и дальнейшие ограничения остаются в материалах камеры/RPC выше.
* Старый `native-opengl-investigation` объединён с видеоисследованием:
  backtrace, native/error логи и небольшие исходники сохранены в
  `flutter-pi-video-2026-10-25/legacy-failure-evidence.tar.gz`.
  Одноразовые queue scripts, агентская рабочая заметка и orphan checksums
  без соответствующих архивов удалены.

## Архивы и воспроизведение

[`retained-archives.json`](retained-archives.json) перечисляет SHA256 и результаты
чтения сохранённых архивов. До удаления распакованной копии проверены полный
поток tar/gzip, контроль gzip CRC и побайтовый SHA256 соответствующего member.
Одинаковые архивы используют один экземпляр через относительную ссылку.
JSON/provenance и уникальные ошибки не переписаны ради успешного статуса.
Исторические `SHA256SUMS` и `bundle.sha256` описывают полный исходный freeze,
включая удалённые executable отклонённых вариантов; текущий состав архивов
перечислен в `retained-archives.json`.

Raw, release и source archives остаются локальными и игнорируются Git;
`git restore` их не восстановит. В Git сохраняются индекс, manifest и выбранные
текстовые отчёты. После очистки некоторые прежние команды чтения распакованных
каталогов требуют сначала извлечь соответствующий raw archive в **отдельный
временный каталог** с рабочей копией соответствующего отчёта. Перед запуском
исторического `analyze.py` восстановите в этой копии все raw-архивы целиком,
включая JSONL и медиа: часть scripts считает существующий каталог уже
распакованным и не восстанавливает отдельно удалённые файлы. Пересчёт выполняется
в рабочей копии, поскольку scripts перезаписывают производные JSON/CSV/HTML.
Не распаковывайте архивы поверх сохранённого evidence.
Медиа и executable внутри проверенного архива не хранятся второй распакованной
копией. Генерируемые metadata-only fixtures и byte-copy JPEG создаются заново
при необходимости; они не являются уникальными исходными фотографиями.

Очистка не запускала устройство, браузерные тесты или новый аппаратный A/B.
Правила актуализации, удаления и периодического аудита — в
[руководстве сопровождения](../../doc/benchmarks-maintenance.md).
Правила будущих запусков — в [README стенда](../README.md) и
[руководстве RaPi5](../../doc/raspberry-pi-benchmarks.md).
