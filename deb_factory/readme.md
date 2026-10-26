# Сборка финального DEB

Точка входа — `./build.sh` из этого каталога. Синхронизация frontend/backend,
автоматическое увеличение build-номера и оформление `changelog.md` описаны в
[руководстве выпуска](../doc/releasing.md).

Штатный `scripts/sensorsScript.sh` передаёт температуру и, при наличии тахометра
Raspberry Pi 5, фактический RPM вентилятора. Формат, отсутствие показаний,
диагностика и проверки описаны в [руководстве датчиков](../doc/sensors.md).

* install md5deep, dpkg-deb
* Create 'source_arm64'
* Create 'source_arm64/flutter-pi/'
* Put special 'flutter-pi' in 'source_arm64/flutter-pi/'
    with dpms support
* Run build.sh

## Обязательные тесты перед сборкой

`build.sh` сначала запускает `run_tests.sh`. Он последовательно выполняет
`dart test` в `common` и `backend` (для backend — `--concurrency=1`, поскольку
тесты используют общие loopback-порты), затем `flutter test --no-pub` в `i18n`,
`system_metrics_widget`, `dslideshow_flutter` и `config_app`. После этого
запускаются Python-тесты из `dslideshow_flutter/tool` и `deb_factory`.
При ошибке любого тестового набора сборка завершается с ненулевым кодом **до**
удаления прежнего staging-каталога, увеличения версий и компиляции.
Пропуск тестов не предусмотрен.

Нужны согласованные Flutter/Dart SDK, Python 3 и заранее полученные зависимости
пакетов (`dart pub get` / `flutter pub get` из соответствующего каталога).
Требования SDK и локальных path-зависимостей приведены в
[README приложения](../dslideshow_flutter/README.md). Скрипты определяют корень
репозитория по своему пути, поэтому их можно вызывать из любого каталога.
Отдельный прогон из корня репозитория без сборки и изменения версии:

```bash
./deb_factory/run_tests.sh
```

Этот прогон проверяет локальные unit/widget-тесты и инструменты упаковки.
Анализатор, Chrome/integration-тесты и аппаратные бенчмарки выполняются отдельно
по документации затронутых пакетов и не заменяются этим шагом.

## Проверка упаковки

Из корня репозитория:

```bash
python3 -m unittest discover -s deb_factory -p 'test_*.py' -v
sh -n deb_factory/build.sh
sh -n deb_factory/run_tests.sh
sh -n deb_factory/template_build_arm64/opt/dslideshow/scripts/sensorsScript.sh
```

Тесты проверяют охват production-пакетов, остановку при ошибке и сохранность
версий и staging-каталога при провале preflight. Проверка упаковки использует
небольшие готовые assets и заглушки тестов/Flutter-компиляции, вызывает
настоящие `build.sh`, `md5deep` и `dpkg-deb`. После распаковки проверяются полнота
и значения контрольных сумм, относительные пути в `DEBIAN/md5sums`, сохранность
native runtime и файла версии. Пути в `md5sums` должны быть относительными:
список используется для проверки файлов на устройстве, где каталога машины
сборки нет.
