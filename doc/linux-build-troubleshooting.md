# Ошибки сборки и запуска Flutter-приложений на Linux

Инструкция для Linux desktop-сборок `config_app` и `dslideshow_flutter`.
Для текущих зависимостей проекта нужны Flutter 3.47+ и Dart 3.13+.
Запуск фоторамки через `flutter-pi` использует другой runner; изменения GTK
из этой инструкции относятся к desktop-приложениям.

## Быстрое восстановление сборки

1. Проверьте инструменты и библиотеки:

   ```sh
   flutter doctor -v
   pkg-config --modversion gtk+-3.0 glib-2.0 gio-2.0
   ```

   Если development-пакетов нет, для Debian/Ubuntu установите их:

   ```sh
   sudo apt-get install clang lld cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
   ```

   Также нужны development-заголовки libstdc++, подходящие компилятору и
   дистрибутиву. Конкретную проблему с toolchain показывает `flutter doctor -v`.

   Для видео в `config_app` дополнительно нужны libmpv и libepoxy:

   ```sh
   sudo apt-get install libmpv-dev libepoxy-dev
   pkg-config --modversion mpv epoxy
   ```

   Linux-плеер и [его функциональная проверка](../config_app/README.md#проверки-видео)
   относятся к desktop-панели. Они не меняют video backend фоторамки.

2. Из корня репозитория перейдите в приложение и пересоберите его:

   ```sh
   cd config_app
   ./build_linux.sh --debug
   flutter run -d linux
   ```

   Для второго приложения вместо `config_app` выберите `dslideshow_flutter`.
   Для release-сборки используйте `./build_linux.sh --release`.

Скрипт удаляет только `CMakeCache.txt` и каталоги `CMakeFiles` внутри
`build/linux`, затем выполняет `flutter pub get` и `flutter build linux`.
Пакеты и остальные Dart-артефакты сохраняются. После успешной сборки можно
снова запускать приложение из VS Code.

## `Imported target "PkgConfig::GTK" includes non-existent path`

Это ошибка конфигурации нативной сборки. CMake создал target GTK с каталогом
заголовков, которого уже нет на диске.

Если путь сохранился только в старом `CMakeCache.txt`, а текущий
`pkg-config --cflags-only-I gtk+-3.0` его уже не возвращает, нужно обновить
результаты поиска зависимостей. Создание пустого include-каталога скрывает
ошибку конфигурации и не восстанавливает заголовки.

### Как отличить старый кэш от сломанной установки

Из папки приложения выполните:

```sh
pkg-config --cflags-only-I gtk+-3.0 glib-2.0 gio-2.0
rg --no-ignore -n -g CMakeCache.txt '^(GTK|GLIB|GIO)_INCLUDE_DIRS:' build/linux
printenv PKG_CONFIG_PATH PKG_CONFIG_LIBDIR PKG_CONFIG_SYSROOT_DIR
```

Последняя команда может ничего не вывести, если эти переменные не заданы.

- Путь есть только в кэше: запустите `./build_linux.sh --debug`.
- `pkg-config` тоже выдаёт несуществующий путь: проверьте установку
  development-пакетов и выбранные `.pc`-файлы. Команда
  `pkg-config --variable=pcfiledir gtk+-3.0` показывает каталог метаданных GTK;
  проблемный путь может приходить и от её зависимостей. В Debian/Ubuntu
  владельца конкретного `.pc`-файла можно найти через `dpkg-query -S`, затем
  переустановить соответствующий пакет.
- Настроен сторонний SDK или cross-build: проверьте `PKG_CONFIG_PATH`,
  `PKG_CONFIG_LIBDIR`, `PKG_CONFIG_SYSROOT_DIR` и sysroot. Они должны указывать
  на библиотеки для выбранной целевой платформы. Не удаляйте их настройки
  без проверки назначения.

### Как устроено постоянное исправление

В каждом приложении есть `linux/cmake/LinuxDependencies.cmake`. Он сбрасывает
маркер кэширования `FindPkgConfig` для GTK/GLib/GIO, повторно запускает поиск,
создаёт `IMPORTED_TARGET GLOBAL` и проверяет существование include-каталогов.
Если сломана сама установка пакетов, сборка останавливается с понятным
сообщением о модуле и пути.

Модуль подключается в `linux/CMakeLists.txt` **до** Flutter-подкаталога:

```cmake
include(cmake/LinuxDependencies.cmake)

set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/flutter")
add_subdirectory(${FLUTTER_MANAGED_DIR})
```

Порядок важен: первое создание `PkgConfig::GTK` должно использовать свежие
пути. Поэтому исправление работает и при обычном `flutter build linux`,
`flutter run -d linux` и отладке из VS Code. Скрипт сборки дополнительно
очищает весь нативный CMake-кэш.

Не исправляйте пути вручную в `build/linux`, `linux/flutter/ephemeral` или
Flutter SDK: это производные файлы, и следующая сборка их создаст заново.

## Native assets: отсутствует `ld.lld` или `ld`

Если Flutter сообщает об отсутствии linker рядом с Clang, установите `lld`
той же версии, что и Clang, и проверьте реальный путь `clang++`. Native assets
ищут инструменты рядом с исполняемым файлом компилятора; корректного `PATH`
может быть недостаточно при смешении разных toolchain.

## GSettings: отсутствует ключ `antialiasing`

Другой сбой происходит уже при запуске собранного приложения:

```text
Settings schema 'org.gnome.settings-daemon.plugins.xsettings' does not contain a key named 'antialiasing'
Error waiting for a debug connection: The log reader stopped unexpectedly, or never started.
```

В ранее проверенном окружении причиной была Snap-версия VS Code: дочернее
приложение использовало системный GTK вместе с унаследованными путями к
несовместимым схемам и модулям Snap. Сообщение про debug connection было
следствием падения нативного процесса до запуска Dart.

Сравните запуск из VS Code с `flutter run -d linux` в обычном системном
терминале. Для диагностики из терминала VS Code достаточно:

```sh
printenv XDG_DATA_DIRS_VSCODE_SNAP_ORIG XDG_DATA_DIRS GSETTINGS_SCHEMA_DIR GTK_PATH
```

В обоих приложениях `linux/runner/host_environment.cc` восстанавливает
`XDG_DATA_DIRS` из непустого `XDG_DATA_DIRS_VSCODE_SNAP_ORIG` и удаляет
унаследованные пути `GSETTINGS_SCHEMA_DIR`, `GTK_PATH`, `GTK_EXE_PREFIX`,
`GTK_IM_MODULE_FILE`, `GDK_PIXBUF_MODULE_FILE`, `GDK_PIXBUF_MODULEDIR`.
Без этого маркера пользовательское окружение не меняется. Выбор Wayland/X11
также сохраняется.

Функция вызывается в `linux/runner/main.cc` **до** создания `MyApplication`:

```cpp
configure_host_gtk_environment();
g_autoptr(MyApplication) app = my_application_new();
```

Файл `host_environment.cc` должен входить в `add_executable` в
`linux/runner/CMakeLists.txt`. После изменения runner нужна пересборка;
hot reload не обновляет нативный код. Если маркера Snap нет, причину следует
искать отдельно по фактическому окружению и первой ошибке процесса.

## Перенос исправления в новое Flutter-приложение

1. Возьмите из `config_app` файлы `build_linux.sh`,
   `linux/cmake/LinuxDependencies.cmake` и
   `linux/runner/host_environment.{h,cc}`. Поправьте название приложения
   в диагностических сообщениях CMake-модуля.
2. Подключите модуль CMake перед `add_subdirectory(flutter)`, как показано выше.
   Удалите дублирующий поиск GTK из верхнего `linux/CMakeLists.txt` после
   этого подключения. Flutter-managed CMake-файл менять не требуется.
3. Подключите заголовок `host_environment.h` в `main.cc`, вызовите функцию
   до создания приложения и добавьте `.cc` в `add_executable` runner.
4. Сохраните право исполнения: `chmod +x build_linux.sh`.
5. Убедитесь, что каталог `linux/` не исключён из Git. Его исходники должны
   сохраняться в репозитории; `linux/flutter/ephemeral` и `build/` остаются
   игнорируемыми. Иначе исправление потеряется в новом checkout.
6. Выполните проверки ниже, соберите приложение и проверьте запуск из VS Code.
   После регенерации платформенных файлов Flutter сверяйте изменения runner,
   чтобы эти подключения не потерялись.

## Регрессионные проверки

Из корня репозитория:

```sh
python3 -m unittest discover -s dslideshow_flutter/tool -p 'test_linux_*.py' -v
DS_LINUX_PROJECT_ROOT="$PWD/config_app" python3 -m unittest discover -s dslideshow_flutter/tool -p 'test_linux_*.py' -v
```

Для CMake-проверок не нужен системный GTK; тест окружения требует `clang++`,
`pkg-config` и GLib development-файлы. Для каждого приложения проверяются:

- понятная ошибка при отсутствии пакета;
- диагностика реально отсутствующего include-каталога;
- обновление пути после удаления старого каталога без очистки CMake-кэша;
- сохранение обычного пользовательского окружения;
- отсутствие изменений при пустом маркере Snap;
- восстановление системных путей Snap VS Code, повторный безопасный вызов
  функции и сохранение выбранного backend отображения.

Эти проверки не заменяют реальную сборку и запуск приложения.

## Справочные материалы

- [Настройка Linux toolchain для Flutter](https://docs.flutter.dev/platform-integration/linux/setup).
- [CMake FindPkgConfig: импортированные targets и параметры поиска](https://cmake.org/cmake/help/latest/module/FindPkgConfig.html).
