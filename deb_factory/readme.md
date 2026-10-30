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

## Установка Czkawka CLI на фоторамке

При `postinst configure` (первой установке и обновлении DEB) скрипт
`/opt/dslideshow/scripts/install_czkawka.sh` скачивает официальный
[Czkawka CLI 12.0.2 ARM64](https://github.com/qarmin/czkawka/releases/download/12.0.2/linux_czkawka_cli_arm64)
в `/opt/dslideshow/bin/czkawka_cli`. Загрузка происходит **на фоторамке при
установке**, бинарник не включается в DEB. Нужен доступ к GitHub по HTTPS;
`curl` и `ca-certificates` входят в Depends. По ELF-зависимостям этого asset
также заданы `libc6 (>= 2.34)` и `libgcc-s1`; скрипт не обновляет ОС и не
подключает дополнительные репозитории.

Перед выполнением скачанного файла проверяется фиксированный SHA-256
`3a65408ca30036cf1cd993112bde6288e13c870842d12131dee8b4e435325c38`,
сверенный с [digest asset в GitHub API](https://api.github.com/repos/qarmin/czkawka/releases/tags/12.0.2).
Затем проверяется `--version` с таймаутом 10 секунд. Только после успеха
файл атомарно заменяет прежнюю версию и получает права `0755`.
Сетевая операция ограничена таймаутами и двумя повторными попытками.
Ошибки сети, SHA-256 или запуска оставляют прежний бинарник, удаляют временные
файлы и завершают настройку DEB с ошибкой. После устранения причины повторите
`sudo dpkg --configure dslideshow`. Уже установленный executable с тем же
SHA-256 повторно проверяется и используется без скачивания, в том числе офлайн.

Ссылка `/usr/local/bin/czkawka_cli` делает команду доступной в обычном PATH.
Если этот путь занят чужим файлом или ссылкой, установка завершается с
диагностикой `action=link-conflict`, сохраняя чужую команду. Администратор должен
сам освободить путь перед повтором. Пакет из репозитория `czkawka-cli` больше
не рекомендуется и не требуется; его `/usr/bin/czkawka_cli` не изменяется.
В unit `dslideshow.service` явно задан PATH с `/opt/dslideshow/bin` первым:
backend получает закреплённую версию без shell-профиля пользователя `pi`.
Новое окружение применяется при следующем запуске службы; `postinst` включает
автозапуск, но сам не запускает и не перезапускает фоторамку.
При удалении/purge DEB удаляются загруженный бинарник и только собственная
ссылка; `postrm upgrade` сохраняет их для новой версии.

Проверки после установки на целевой системе:

```bash
command -v czkawka_cli
czkawka_cli --version
systemctl show dslideshow --property=Environment
sudo -u pi env PATH=/opt/dslideshow/bin:/usr/local/bin:/usr/bin:/bin czkawka_cli --version
journalctl -t dslideshow.deb -n 50 --no-pager
```

Диагностика установки имеет `component=czkawka-install`, `operation` (PID),
версию, действие, результат и длительность. Начало, повторное использование
и успех записываются на INFO, отказ — ERR с этапом и exit code, отмена — INFO.
Это проверки поставки и запуска CLI; поиск настоящих дубликатов на ARM64
и совместная работа со слайдшоу требуют отдельной проверки на фоторамке.

## Обязательные тесты перед сборкой

`build.sh` подготавливает staging и один раз увеличивает build-номер через
`autover`, затем параллельно запускает три задачи: `run_tests.sh`, сборку AOT
`dslideshow_flutter` и web-сборку `config_app`. Так все задачи читают одну
сгенерированную версию. Упаковка DEB, копирование результатов и вычисление
контрольных сумм начинаются только после успешного завершения всех трёх задач.

В задаче проверок первым шагом `run_analysis.sh`
проверяет все Dart/Flutter-пакеты: `common`, `rpc_serializers_generator`,
`backend`, `autover`, `autover/example`, `i18n`, `system_metrics_widget`,
`dslideshow_flutter`, `config_app` и `benchmarks`. Ошибки и предупреждения
анализатора блокируют сборку; `info` выводятся, но не останавливают её
(`dart analyze --fatal-warnings`, для Flutter также `--no-fatal-infos`).
Перед любым релизом всё равно необходимо
исправить **все** замечания, включая `info`, до `No issues found`, согласно
[правилу выпуска](../doc/releasing.md#анализатор-перед-любым-релизом).

После анализатора скрипт последовательно выполняет
`dart test` в `common`, `rpc_serializers_generator` и `backend`
(для backend — `--concurrency=1`, поскольку
тесты используют общие loopback-порты), затем `flutter test --no-pub` в `i18n`,
`system_metrics_widget`, `dslideshow_flutter` и `config_app`. После этого
запускаются Python-тесты из `dslideshow_flutter/tool` и `deb_factory`.
При ошибке анализатора, предупреждении, отказе тестов или одной из сборок
оставшиеся задачи останавливаются вместе с их дочерними процессами, DEB не
упаковывается, скрипт завершается с ненулевым кодом. SIGINT/SIGTERM также
останавливают фоновые задачи. Build-номер и staging к этому моменту уже изменены;
они не откатываются. Перед повторной попыткой проверьте diff: повторный запуск
снова увеличит build-номер.
Пропуск проверок не предусмотрен.

Для настоящих backend codec/CLI-тестов нужны `ffmpeg`, `ffprobe`, `jpegtran`,
`chmod` и `czkawka_cli` в PATH. Команды, проверенные варианты и границы проверки
описаны в [README backend](../backend/README.md#инструменты-управления-медиатекой).
Проверяются Czkawka CLI 8.x/12.x JSON, Dart EXIF/PNG и оба допустимых
`jpegtran`: IJG 9f (`libjpeg-progs`) и libjpeg-turbo 3.1.3
(`libjpeg-turbo-progs`). IJG не обязан поддерживать `-version`; его не нужно
заменять только ради названия варианта. Эти инструменты не устанавливаются
скриптами сборки автоматически.

`control.template` задаёт Depends на `ffmpeg`,
`libjpeg-progs | libjpeg-turbo-progs`. EXIF и поворот PNG выполняются в Dart;
ExifTool не требуется.
`chmod`, `sha256sum` и `timeout` входят в базовый Essential-пакет `coreutils`.
Czkawka 12.0.2 устанавливается через `postinst`, как описано
[выше](#установка-czkawka-cli-на-фоторамке). Адаптер backend явно принимает
проверенные ветки 8.x/12.x и отклоняет неизвестные версии. Если executable
позднее удалён или недоступен, поиск отмечается `failed` с типизированным
`unavailable`; синхронные API отсутствующих инструментов возвращают HTTP 503.

Имена пакетов jpegtran сверены с
[Debian](https://packages.debian.org/trixie/libjpeg-turbo-progs).

Нужны согласованные Flutter/Dart SDK, Python 3 и заранее полученные зависимости
пакетов (`dart pub get` / `flutter pub get` из соответствующего каталога).
В параллельной фазе web-сборка запускается с `--no-pub`, чтобы не менять
package config и lock-файлы во время анализа и тестов. `config_app/build_web.sh`
по умолчанию собирает Wasm и JavaScript fallback; в DEB переносится весь
`config_app/build/web`, включая Wasm-модули и локальные renderer-ресурсы.
Границы проверки web-панели описаны в [README панели](../config_app/README.md).
Не запускайте второй экземпляр `build.sh`, `pub get`, генерацию моделей или
очистку build-каталогов в этом же checkout до завершения текущего запуска.
Flutter SDK может сам
сериализовать некоторые этапы своим startup lock; ускорение зависит от ресурсов
машины. Для одновременных компиляторов и тестов нужен запас RAM и места на диске
и во временном каталоге.
Требования SDK и локальных path-зависимостей приведены в
[README приложения](../dslideshow_flutter/README.md). Скрипты определяют корень
репозитория по своему пути, поэтому их можно вызывать из любого каталога.
Отдельный прогон из корня репозитория без сборки и изменения версии:

```bash
./deb_factory/run_tests.sh
```

Только анализатор без тестов, сборки и изменения версии:

```bash
./deb_factory/run_analysis.sh
```

Общий прогон проверяет анализатор, локальные unit/widget-тесты и инструменты упаковки.
Integration-тесты и аппаратные бенчмарки выполняются отдельно
по документации затронутых пакетов и не заменяются этим шагом. Автоматические
браузерные тесты удалены; написание и запуск таких тестов требуют согласия
пользователя, см. [правила тестирования](../doc/testing.md#браузерные-проверки).

## Проверка упаковки

Из корня репозитория:

```bash
python3 -m unittest discover -s deb_factory -p 'test_*.py' -v
sh -n deb_factory/build.sh
sh -n deb_factory/run_tests.sh
sh -n deb_factory/run_analysis.sh
sh -n config_app/build_web.sh
sh -n deb_factory/template_build_arm64/opt/dslideshow/scripts/sensorsScript.sh
bash -n deb_factory/template_build_arm64/DEBIAN/postinst
bash -n deb_factory/template_build_arm64/DEBIAN/postrm
bash -n deb_factory/template_build_arm64/opt/dslideshow/scripts/install_czkawka.sh
```

Тесты проверяют охват production-пакетов, фактическое перекрытие трёх задач,
ожидание всех результатов перед упаковкой, отказ каждой задачи и остановку
дочерних процессов при прерывании. Управляемые процессы используют локальные
Unix-сокеты; в sandbox для тестов требуется разрешение локальных сокетов.
Проверка упаковки использует
небольшие готовые assets и заглушки тестов/Flutter-компиляции, вызывает
настоящие `build.sh`, `md5deep` и `dpkg-deb`. После распаковки проверяются полнота
и значения контрольных сумм, относительные пути в `DEBIAN/md5sums`, сохранность
native runtime и файла версии. Пути в `md5sums` должны быть относительными:
список используется для проверки файлов на устройстве, где каталога машины
сборки нет.

`test_czkawka_install.py` запускает настоящие `postinst`, установщик и `postrm`
во временном `DPKG_ROOT`: загрузчик, logger и системные команды подменены,
SHA-256, таймаут и файловые операции настоящие. Проверяются PATH из unit и
обычный PATH, права, офлайн-повтор, восстановление повреждённого файла,
отказ сети/контрольной суммы/запуска, отмена и очистка, чужая команда и
жизненный цикл upgrade/remove/purge. Тесты проверяют уровни и результаты
диагностики, не скачивают релиз и не выполняют ARM64-код на машине сборки.
