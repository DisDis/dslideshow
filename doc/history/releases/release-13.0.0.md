# DEB 13.0.0+1 — 27 октября 2026

Новый мажорный выпуск после `12.0.0+2`; исходный коммит — `0becc77`.
Полный перечень накопленных изменений — в [changelog](../../../changelog.md).
Пакет собран локально; изменения перенесены из `Unreleased` в `13.0.0+1`.

## Изменения

* [Галерея](../../gallery.md): один процесс FFmpeg на JPEG-миниатюру без ffprobe
  и отдельных Dart-isolates; EXIF, квадратные размеры, фон прозрачности,
  представительный кадр анимации/видео, постеры в сетке. Настройки качества,
  размеров, четырёх workers, очереди, кеша и лимитов потоков; MD5 ETag.
  Policy 4 инвалидирует старые производные; оригиналы сохраняются.
* Исправлено падение FFmpeg 5.1 при наложении прозрачности: непрозрачный фон
  рисуется в RGB. Добавлена ограниченная диагностика процессов, кеша,
  запросов и каталога; консольный лог сохраняет переданные stack traces.
  FFmpeg обязателен в Depends пакета.
* [RPC](../../../rpc_serializers_generator/README.md): генерируемый реестр
  `@RpcSerializers` сохраняет 57 wire tags. Выделены FrameStateReader,
  WebSocketUser и DeviceEventBindings с проверками гонок и освобождения ресурсов.
* Регулярные выражения переиспользуются во всех пакетах и инструментах.
* [Локальный Ambient API probe](../../../tools/README.md): OAuth, выбор альбома,
  пагинация, скачивание и возобновляемое приватное состояние. Автоматизация
  Google Photos в production остаётся в [плане](../../plans/google-photos-plan.md).

## Границы аппаратной приёмки

[Исправление FFmpeg 5.1.9](../../../benchmarks/reports/gallery-ffmpeg51-diagnostics-2026-10-27/report.md)
проверено отдельным CLI-конвейером на RaPi; это не запуск нового DEB и не полная
приёмка UI. [Локальное A/B миниатюр](../../../benchmarks/reports/thumbnail-jpeg-local-2026-10-27/report.md)
не подтверждает общее ускорение: память выросла, качество JPEG и subsampling
изменились. Полный A/B четырёх workers, FrameTiming и визуальная проверка RaPi5
остаются открытыми. Команды последующего OpenGL-прогона с supervisor и
восстановлением службы сохранены в [аппаратном руководстве](../../raspberry-pi-benchmarks.md);
сценарии галереи и ограничения — в [руководстве галереи](../../gallery.md).

В этой подготовке нового аппаратного A/B не было. ОС, драйверы, прошивка и
runtime устройства не изменялись; Vulkan и 24-часовой прогон не запускались.
Установка на рамку и публикация OTA не выполнялись.

## Артефакт и проверки

Сборка выполнена через `deb_factory/build.sh`: release, arm64/CPU pi4,
Flutter 3.47.7 / Dart 3.13.5; веб-панель собрана в release.

* Файл: `deb_factory/dslideshow-13.0.0+1-arm64-pi4.deb`.
* Размер: 19 172 240 байт.
* SHA-256: `06bd0fb14b4fa7550ca1635359d1c513f1eafa8939e23acc465d441619128424`.
* AOT SHA-256: `a9a01ad4739c153b914f56960fa7e412e1d6f2c1ae5aed48eaf4df26b111fb85`.
* Engine SHA-256: `71803501234a54ee4d5b4b998dd201b2cf1dd537187d69c60d598a4aaf12b426`.
* Flutter-pi SHA-256: `54db8f673cdc365b0227efb5ae43be019fef0d52a6316d71caa9c43cac8152be`.

Оба pubspec, generated ApplicationInfo, DEB control, установленный файл version
и Flutter version.json согласованы на `13.0.0+1`; строка версии найдена в AOT.
После распаковки проверены контрольные суммы всех 131 файла opt/, полнота
манифеста и относительные пути. AOT, engine и runtime — AArch64; web bundle
присутствует. Runtime побайтово совпадает с подготовленным source_arm64,
его SHA-256 также сверен по SSH с `/opt/dslideshow/flutter-pi` на рамке.
Lock-файлы обновлены через pub get: изменены только версии path-зависимостей.

| Набор | Результат |
| --- | --- |
| common | 13 тестов |
| rpc_serializers_generator | 23 теста |
| backend | 426 тестов, последовательно |
| i18n | 3 теста |
| system_metrics_widget | 10 тестов |
| dslideshow_flutter | 106 тестов |
| config_app | 304 теста |
| benchmarks | 26 тестов |
| Python: Linux tools / упаковка | 6 / 26 тестов |

Всего 911 Dart/Flutter-тестов и 32 Python-теста. Из них штатная сборка
автоматически выполнила 885 production-тестов и все 32 Python-теста.
Анализаторы common, rpc_serializers_generator, backend, i18n и benchmarks
чистые; приложение, панель и метрики сохранили 7/5/2 прежних info, без ошибок
и предупреждений. Chrome/integration-проверки в этой подготовке не повторялись.
Логи сборки, анализаторов, тестов стенда и распаковки:
`deb_factory/.buildlog/13.0.0/` (локальный игнорируемый каталог).

Для проверки артефакта из корня репозитория:

```sh
dpkg-deb -f deb_factory/dslideshow-13.0.0+1-arm64-pi4.deb Package Version Architecture Description
sha256sum deb_factory/dslideshow-13.0.0+1-arm64-pi4.deb
```
