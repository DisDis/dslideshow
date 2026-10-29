# DEB 15.1.0+1 — 29 октября 2026

Минорный выпуск после `15.0.0+4`. Исходный commit перед подготовкой —
`aa6728efa298d7539155f82955f5ae876ca0c3ad`.
[Продуктовые изменения](../../../changelog.md),
[порядок выпуска](../../releasing.md).

## Состав

Экран OTA показывает крупные значки получения, установки и перезапуска,
трёхэтапную последовательность и пояснение при пустом журнале. Карточка
и журнал сохраняют положение, в том числе при 100% передачи. Успех установки
отделён от перезапуска; при ошибке показан способ возврата к слайдшоу.
Обновлены английские и русские подписи.
[Поведение и снимки](../../ota-update-stages.md).
Формат конфигурации и совместимость сохраняются относительно 15.0.0.

## Проверки и ограничения

Сборка выполняется штатным `deb_factory/build.sh`: release arm64/CPU pi4,
панель Wasm/skwasm с JavaScript/CanvasKit fallback.
Использованы Flutter 3.47.7 / Dart 3.13.5.
Версии изменены через `autover -v minor`, затем build-номер увеличен сборкой.
Логи и сверка артефакта: `deb_factory/.buildlog/15.1.0/` (локально, ignored).

Новые браузерные, desktop integration и аппаратные прогоны не выполнялись.
Локальные widget-тесты не подтверждают плавность анимации, шрифты и читаемость
на физическом дисплее. Сохранённый
[OTA A/B](../../../benchmarks/reports/ota-ux-2026-10-29/report.md) относится
к предыдущему экрану и не является аппаратной приёмкой этого выпуска.
Реальная загрузка OTA, установка, перезапуск и отключение питания не проверены.
Команды следующего OpenGL A/B с одинаковым runtime и восстановлением службы:
[OTA harness](../../../benchmarks/ota-harness.md) и
[RaPi5](../../raspberry-pi-benchmarks.md).

Runtime взят из `deb_factory/source_arm64/flutter-pi/flutter-pi`;
его SHA-256 совпадает с runtime предыдущего DEB 15.0.0+1.
Подключение к устройству и изменение его ПО не выполнялись.

Пакет подготовлен локально; установка на рамку, Git-тег и публикация
в OTA-канал в эту подготовку не входят.

## Результаты и артефакт

Анализ всех десяти Dart/Flutter-пакетов: `No issues found`, включая `info`.
Обязательные локальные тесты: 1158 Dart/Flutter и 39 Python, все прошли.

| Набор | Пройдено |
| --- | ---: |
| common | 28 |
| rpc_serializers_generator | 23 |
| backend | 486 |
| i18n | 3 |
| system_metrics_widget | 10 |
| dslideshow_flutter | 274 |
| config_app | 334 |
| Python: Linux tools / упаковка | 6 / 33 |

* Файл: `deb_factory/dslideshow-15.1.0+1-arm64-pi4.deb`.
* Размер: 23930532 байта.
* SHA-256: `57cc6681464e7b43a411b9eea60753614e5e38cbc973945f8968ec26ef1416e2`.
* app.so SHA-256: `6f121c200aac836f0fd01b85372b4eb6f81df87b0d917775529d1505f64a429f`.
* libflutter_engine.so SHA-256: `71803501234a54ee4d5b4b998dd201b2cf1dd537187d69c60d598a4aaf12b426`.
* flutter-pi SHA-256: `30669efa6ad054744b4c63275cafaf7738d1489b5702c17de666ac73edcbea4b`.

После распаковки проверены все 142 MD5, полнота манифеста и относительные
пути. Все 84 файла web bundle совпали с результатом сборки; Wasm, JavaScript
и локальные renderer-ресурсы присутствуют. AOT, engine и runtime — AArch64,
с исполняемыми правами. Runtime совпал с подготовленным source_arm64.
Оба pubspec, ApplicationInfo, DEB control, файл version и Flutter version.json
согласованы на 15.1.0+1; версия присутствует в AOT.

```sh
dpkg-deb -f deb_factory/dslideshow-15.1.0+1-arm64-pi4.deb Package Version Architecture Description
sha256sum deb_factory/dslideshow-15.1.0+1-arm64-pi4.deb
```
