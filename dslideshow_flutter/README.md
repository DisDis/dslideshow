# DSlideShow: сборка

Проверяемая конфигурация обновления: Flutter 3.47.7 stable, Dart 3.13.5.
Основные пакеты требуют Dart >=3.13, Flutter-приложения — Flutter >=3.47.
`flutter.config.enable-native-assets` включён в pubspec приложений и пакета
метрик: он нужен новым зависимостям `path_provider`, в том числе при сборке Linux.
Глобальные настройки Flutter менять не требуется.

## Локальные зависимости

Backend использует локальные версии библиотек из соседних репозиториев:

* `../../googleapis/discoveryapis_generator/googleapis`;
* `../../flutter_packages/packages/flutter_gpiod`;
* `../../flutter_packages/packages/dpms`.

Пути считаются относительно `backend/`. Для сборки эти checkout должны
существовать. `googleapis` содержит используемый здесь клиент Photos Library;
заменять его обычным пакетом с pub.dev без миграции интеграции нельзя.

Для backend-миниатюр нужен `ffmpeg` в PATH (Debian/Ubuntu: пакет
`ffmpeg`); проверена версия 8.0.1. Они также нужны машине сборки для обязательных
backend codec-тестов. [Подробности](../backend/README.md#локальные-зависимости-миниатюр).

## Linux desktop

Общая [инструкция по диагностике Linux-сборки](../doc/linux-build-troubleshooting.md)
содержит способы исправления GTK/GSettings и переноса решения в другое приложение.

На Debian/Ubuntu установите инструменты и development-пакеты:

```sh
sudo apt-get update
sudo apt-get install clang lld cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```

В каталоге `dslideshow_flutter/`:

```sh
./build_linux.sh --release
```

Скрипт проверяет инструменты и GTK, удаляет старый нативный CMake-кэш,
выполняет `flutter pub get` и `flutter build linux`. Версия приложения при этом
не увеличивается. Результат для x64: `build/linux/x64/release/bundle/`.
Весь bundle нужно сохранять вместе с исполняемым файлом.

`flutter build linux --release` также поддерживается: CMake сам повторно
запрашивает пути GTK/GLib/GIO через pkg-config перед созданием Flutter targets.

### Ошибка `Imported target "PkgConfig::GTK" includes non-existent path`

В проверенном окружении GTK development-пакеты отсутствовали, но CMakeCache
сохранил пути от предыдущей установки GTK 3.24.50. Это приводит к ссылкам на
удалённые include-каталоги.

1. Установите development-пакеты командой выше.
2. Проверьте `pkg-config --modversion gtk+-3.0` и `pkg-config --cflags gtk+-3.0`.
3. Если pkg-config сообщает отсутствующий каталог, восстановите владеющий им
   пакет и его зависимости. Например, для `sysprof-6` на данном Ubuntu нужен
   `libsysprof-capture-4-dev`, для `libmount` — `libmount-dev`, для `blkid` —
   `libblkid-dev`. Не создавайте пустые каталоги для подавления ошибки.
4. Повторите `./build_linux.sh --release`.

При использовании своего SDK/sysroot проверьте `PKG_CONFIG_PATH`,
`PKG_CONFIG_LIBDIR`, `PKG_CONFIG_SYSROOT_DIR`. Пакеты и библиотеки должны
соответствовать целевой архитектуре.

Если Flutter сообщает, что рядом с Clang отсутствуют `ld.lld` или `ld`,
установите `lld` той же версии, что и Clang. Flutter native assets
ищут инструменты рядом с реальным исполняемым файлом `clang++`.

Linux desktop runner использует GTK. Raspberry Pi с `flutter-pi` использует
другой способ запуска; GTK не нужен этому embedded runner. В текущем коде
видеовоспроизведение на обычном Linux desktop отключено.

### Падение при запуске из Snap-версии VS Code

Ошибка `Settings schema 'org.gnome.settings-daemon.plugins.xsettings' does not
contain a key named 'antialiasing'` возникает, когда системный GTK получает
несовместимые GSettings-схемы из окружения Snap VS Code. Сообщение Flutter
`Error waiting for a debug connection` появляется следом из-за завершения
нативного процесса до подключения отладчика.

Linux runner восстанавливает исходный `XDG_DATA_DIRS` из
`XDG_DATA_DIRS_VSCODE_SNAP_ORIG` и удаляет унаследованные Snap-пути GTK до
инициализации приложения. Исправление работает при обычном F5 и `flutter run`;
принудительно переключать Wayland на X11 или менять системные схемы не нужно.
Обычный запуск вне Snap VS Code сохраняет пользовательские GTK-переменные.

После изменения runner остановите предыдущую отладку и запустите F5 заново,
чтобы пересобрался нативный исполняемый файл. Hot reload для этого недостаточно.

## Raspberry Pi

Существующий `./build_aot_pi4.sh` собирает arm64/CPU pi4 через `flutterpi_tool`.
`../deb_factory/build.sh` собирает также веб-панель и DEB. Flutter SDK,
`flutterpi_tool` и engine binaries должны быть согласованы по версии.
После обновления видеоплагина требуется проверка на устройстве: видео/GIF,
пауза, сон и пробуждение по датчику, DPMS и GPIO. Desktop-сборка этого не проверяет.

[Аппаратное руководство](../doc/raspberry-pi-benchmarks.md) описывает установку
и автоматический запуск отдельного бенчмарка на RaPi5, тесты эффектов/видео,
получение отчётов и расположение исходников flutter-pi на устройстве.
Порядок синхронизации версий, ведения changelog и финальной сборки через
`deb_factory/build.sh` приведён в [инструкции выпуска](../doc/releasing.md).

## Проверки

[Специальные экраны](../doc/special-screens.md): часы, снимки камер по HTTP/HTTPS,
расписание вставок и локальные проверки.

[Сон экрана и присутствие](../doc/screen-presence.md): правила отмены затухания,
приоритет ручной блокировки, Linux-регрессии и оставшаяся аппаратная приёмка.

Из корня репозитория:

```sh
python3 dslideshow_flutter/tool/test_linux_dependencies.py -v
python3 dslideshow_flutter/tool/test_linux_host_environment.py -v
(cd common && dart test)
(cd rpc_serializers_generator && dart test)
(cd backend && dart test)
(cd config_app && flutter test)
(cd system_metrics_widget && flutter test)
(cd dslideshow_flutter && flutter test)
(cd config_app && flutter build web --release)
```

Генерация моделей: `dart run build_runner build` в `common/`, `backend/`,
`dslideshow_flutter/` и `config_app/`. Для watch-режима доступны скрипты
`generate_models.sh`. На Flutter 3.47.7/Dart 3.13.5 проверена обычная AOT-генерация:
прежний `--force-jit` и ограничение `source_helper <1.4.0` больше не нужны.
В backend эта же команда генерирует RPC-реестр из `@RpcSerializers`:
[подключение builder и правила регистрации](../rpc_serializers_generator/README.md).

Device Preview 3 подключается до инициализации WidgetsBinding. В desktop debug/profile
доступен профиль PhotoFrame 2560×1600; управление устройствами теперь находится
в расширении Flutter DevTools. Embedded- и release-запуск используют обычный binding.

Lock-файлы приложений, backend, rpc_serializers_generator и autover сохраняются
в Git для воспроизводимости.
При нехватке квоты `/tmp` можно задать `TMPDIR` на диске с достаточным местом.

[Новые эффекты и Ken Burns](../doc/new-visuals-2026-10.md): настройка, совместимость,
предпросмотр, тесты и измерения на RaPi5.

[Десять дополнительных переходов в стиле видеоредакторов](../doc/premiere-style-transitions.md):
поведение, совместимость с живыми медиа, настройка и локальные проверки.
