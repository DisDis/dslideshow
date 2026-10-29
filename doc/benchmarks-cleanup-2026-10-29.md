# Очистка benchmarks — 29 октября 2026

Выполнена по согласованному плану. Проверки ограничены локальным окружением:
устройство и браузер не используются. Производственный код приложений, версии,
lock-файлы, shader-эталоны, оригиналы медиа и FixedAnimationController сохранены.

[Индекс отчётов](../benchmarks/reports/README.md) описывает оставшиеся результаты.
[README стенда](../benchmarks/README.md) содержит актуальные команды и конфиги.

## Удалённые материалы

Полностью удалены 13 заменённых групп отчётов:

* `initial-device-check`, `recovery-device-check`, `visual-initial`,
  `policy-verification`, `visual-device-check`.
* `full-standard-RaPi5`, `RaPi5-standard-2026-10-25-analysis`,
  `new-visuals-2026-10-25`.
* `backend-extraction-2026-10-27`, `gallery-local-2026-10-26`,
  `gallery-thumbnail-local-2026-10-26`, `thumbnail-ffmpeg-local-2026-10-27`,
  `rpc-capacity-2026-10-26`.

`native-opengl-investigation` объединён с видеоисследованием. Уникальные старые
native/error/active-operation логи, исходные сводки и небольшие диагностические
исходники сохранены в `flutter-pi-video-2026-10-25/legacy-failure-evidence.tar.gz`.
Исторические ограничения остаются в [документе эффектов](effects-work.md),
[исследовании галереи](gallery-performance.md) и [материалах RPC](camera-rpc-investigation-2026-10.md).

В оставшихся группах удалены проверенные распакованные дубли, воспроизводимые
metadata-only fixtures, непринятые executable bundles и неиспользованные
промежуточные сборки. Отдельно удалены старый агентский dump, одноразовый queue
script и orphan checksums. Рабочий кеш `.dart_tool` сохранён.

Из исходников стенда удалены:

| Материалы | Количество и состав |
| --- | --- |
| Конфиги закрытых исследований | 28: blur — 5, composition — 9, mosaic — 6, zoom-blur — 4, new-visuals — 4 |
| Экспериментальные реализации | 4: `blur_probes.dart`, `mosaic_probes.dart`, `composition_probes.dart`, `composition_reference.dart` |
| Только экспериментальные test/audit targets | 6; действующий dense-grid capture contract перенесён в `config_metrics_test.dart` |
| Одноразовые инструменты галереи | 6: list/contract/thumbnail probes, исторический HTTP reporter, Linux release runner и его Dart-template |
| Сборки и локальные остатки | Устаревший `build/`, Python `__pycache__`, остатки `pageflip_ab`, `flutter_01.log` и пустые experimental/native каталоги |

Сняты регистрация и metadata удалённых проб, их специальные ветки и bitmap-клоны
во viewport. Оставлен отдельный `photo-motion.json` для Ken Burns. Актуальные
инструменты и 11 конфигов перечислены в [README стенда](../benchmarks/README.md).

## Что сохранено

Основной стенд и production harness renderer/OTA, 684 standard-сценария,
11 актуальных конфигов, оригиналы фото/GIF/видео, независимые shader-эталоны,
полноразмерные pixel-регрессии, сетки Mosaic 100/150/200 и диагностика камеры/RPC.
Принятые source/release A/B, raw/provenance, исходные failed-проверки и уникальные
ошибки остаются в отчётах; ручная приёмка не меняет автоматические failed-статусы.

Восемь единственных release-пакетов ранних принятых A/B перенесены из `build/`
в `release-archives/` соответствующих ZoomOver/BlurFade/Mosaic/Accordion отчётов.
Проверены gzip/tar и SHA256; AOT/source fingerprints записаны в transfer
manifests рядом с архивами. Генератор исторического gallery HTTP/Chrome отчёта сохранён вместе
с импортируемым helper в `archive-support/gallery-http-report-tools.tar.gz`.
Браузер при этом не запускался.

Правила дальнейшей актуализации, удаления и ежемесячного аудита закреплены в
[руководстве сопровождения](benchmarks-maintenance.md) и `AGENTS.md`.

## Проверки и объём

Объём измерен по выделенным блокам файловой системы (`st_blocks × 512`),
в одном рабочем каталоге до очистки и после проверок. Суммарная экономия учитывает
перенос восьми архивов из `build/` в отчёты и небольшой рост кеша генератора.

| Каталог | До, ГиБ | После, ГиБ | Освобождено, ГиБ |
| --- | ---: | ---: | ---: |
| reports | 11,82 | 4,69 | 7,12 |
| build | 3,85 | 0,00 | 3,85 |
| Весь benchmarks | 15,90 | 4,93 | 10,97 |

Всего освобождено **11,779,076,096 байт** (разделители — запятые).
Число файлов в `benchmarks/`: 145,172 → 6,919;
каталогов отчётов: 43 → 29 (13 удалены, ещё один объединён с видеоисследованием).

[Машинная сводка](benchmarks-cleanup-2026-10-29.json) содержит точные размеры,
список 45 удалённых tracked-файлов и результаты по каждой группе отчётов.

Выполнены локально:

* `flutter analyze --no-pub` в benchmarks: `No issues found`.
* `flutter test --no-pub` в benchmarks: 76 тестов прошли после окончательной генерации модели.
* Production-регрессии `zoom_blur_effect`, `composition_effect`, `mosaic_optimization`: 12 тестов прошли.
* Python: 109 тестов `tool/`, 97 `native_pipeline/`, 9 `egl_capture/` — прошли. После генерации отдельно повторены 4 build-info теста.
* `bash -n` всех сохраняемых launch/build shell scripts, проверка локальных ссылок, manifest путей/размеров и отсутствия битых symlinks; `git diff --check`.

Модель `BenchmarkCase` переведена на Freezed/json_serializable штатным
`dart run build_runner build`; независимые ожидаемые JSON payloads проверяют
сохранение ID, ключей и null/omit. Зависимости, lock-файлы и чужие изменения
версий не изменены. Итоговые изменения повторно просмотрены.

Устройство и браузер не запускались. Результат не является новой аппаратной
приёмкой текущего кода, измерением ускорения или проверкой DOM/interop.
