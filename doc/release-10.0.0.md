# DEB 10.0.0+2 — 25 октября 2026

Мажорный выпуск со специальными экранами часов и камер, обновлёнными эффектами,
исправлениями сна/присутствия и обновлением Flutter/Dart. Полный перечень —
в [changelog](../changelog.md). Исходная ревизия перед подготовкой выпуска:
`e7e78cf`; изменения подготовки — версии, lock-файлы, документация и исправление
контрольных сумм упаковки.

## Артефакт и версии

Собран через `deb_factory/build.sh`: AOT release, arm64, CPU pi4,
Flutter 3.47.7 / Dart 3.13.5. Веб-панель также собрана в release.

* Файл: `deb_factory/dslideshow-10.0.0+2-arm64-pi4.deb`.
* Размер: 18 985 420 байт.
* SHA-256: `93055ae94fcd6f58f099db2cee31310ae0932b62ee801e0442f96dd83d6f988b`.
* Backend/frontend, `ApplicationInfo`, DEB control и файл `opt/dslideshow/version`
  внутри пакета: `10.0.0+2`. Метаданные локальных path-зависимостей обновлены через `pub get`;
  внешние версии зависимостей при подготовке выпуска не менялись.
* AOT `app.so` SHA-256:
  `3b869f756df627affc7ebb24ea177d5d067abddd6d904665b12a6ecc9d148dee`.
* Engine SHA-256:
  `71803501234a54ee4d5b4b998dd201b2cf1dd537187d69c60d598a4aaf12b426`.
* Flutter-pi SHA-256:
  `e1b6b7d263b4cd4962770542a40f430ea3b2f4bd0fe4ed552ecf1ddcccb418b7`.
  Это тот же бинарник, что в `/opt/dslideshow/flutter-pi` на RaPi5.

Первая сборка `10.0.0+1` выявила абсолютные пути машины сборки в
`DEBIAN/md5sums` и не принята как финальный пакет. `md5deep -l` исправляет пути;
регрессионный тест сначала воспроизвёл ошибку, затем прошёл после исправления.
Повторный штатный запуск сборки увеличил build-номер до `+2`.

После распаковки финального DEB проверены все 125 сумм файлов `opt/`, полнота
манифеста и относительность путей. `md5sum --check` завершился успешно.
Проверены наличие веб-панели, архитектура AArch64 у AOT/engine/runtime и
номер выпуска в скомпилированном AOT и Flutter `version.json`.

Повторить проверку пакета из корня репозитория:

```bash
dpkg-deb -f deb_factory/dslideshow-10.0.0+2-arm64-pi4.deb Package Version Architecture Description
sha256sum deb_factory/dslideshow-10.0.0+2-arm64-pi4.deb
release_dir=$(mktemp -d)
dpkg-deb --raw-extract deb_factory/dslideshow-10.0.0+2-arm64-pi4.deb "$release_dir"
(cd "$release_dir" && md5sum --check DEBIAN/md5sums)
```

## Локальные проверки

| Пакет | Успешные Dart/Flutter-тесты |
| --- | ---: |
| common | 4 |
| backend | 72 |
| dslideshow_flutter | 54 |
| config_app | 8 |
| system_metrics_widget | 6 |
| benchmarks | 20 |
| Всего | 164 |

Прошли также 20 Python-тестов: шесть проверок Linux-инструментов, 13 проверок
стенда и один интеграционный тест упаковки. Синтаксис скриптов сборки DEB/AOT/web
и запуска стенда проверен через `sh -n`/`bash -n`.

Полные анализаторы common, backend и benchmarks чистые. В основном приложении
остаются семь прежних info, в config_app — шесть, в system_metrics_widget — два;
ошибок и предупреждений нет. Команды `flutter analyze` этих трёх пакетов
возвращают код 1 из-за info при стандартном `fatal-infos`.
Команды проверок приведены в [README приложения](../dslideshow_flutter/README.md#проверки),
[README стенда](../benchmarks/README.md) и [README упаковки](../deb_factory/readme.md).

## Аппаратные отчёты и пределы приёмки

Сохранены предыдущие release-прогоны на RaPi5, OpenGL, 2560×1600:

* [ZoomOver A/B](zoom-blur-optimization-2026-10.md): ускорение на фото/GIF,
  контрольная серия и визуальное сравнение. Текущий исходник ZoomOver совпадает
  со snapshot финального кандидата.
* [BlurFade A/B](blur-fade-optimization-2026-10.md): отдельные baseline/candidate
  сборки, полные RGBA-хеши, фото/GIF/видео и ресурсные метрики. Отпечатки BlurFade,
  FixedAnimationController и затронутого кода стенда сверены с текущими файлами.
* [Визуальная проверка всех эффектов](effects-work.md#обновлённая-очередь-работ):
  в сохранённом OpenGL-прогоне нет ошибок или native crash.

Архивы baseline/candidate и полные отчёты остаются в `benchmarks/reports/`;
они не хранятся в Git. Прошлые отчёты и build-info не изменялись при выпуске.

Эти результаты относятся к указанным в них Pi5-сборкам стенда. Новый DEB с CPU
pi4 отдельно на устройстве не запускался. Новая аппаратная приёмка сна/GPIO/DPMS
не выполнена; воспроизводимые шаги остаются в
[руководстве сна и присутствия](screen-presence.md).

Native-сбои OpenGL video→video и ошибки позднего cancel/cleanup сохраняются.
Видеопрогоны с такими ошибками не считаются успешной приёмкой. Исправления
flutter-pi, обновления ОС/драйверов/прошивки, Vulkan и 24-часовой прогон отложены.
Для специальных экранов действуют описанные
[ограничения камер и локальной проверки](special-screens.md).

Публикация на GitHub/в OTA и установка пакета на рамку не выполнялись.
При проверке состояния устройства служба `dslideshow` работала с `9.6.0+2`;
служба, её runtime и настройки не изменялись.
