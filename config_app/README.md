# config_app

Панель настройки фоторамки. Для сборки нужен Flutter 3.47+ / Dart 3.13+.

## Linux desktop

Из папки `config_app`:

```sh
./build_linux.sh --debug
flutter run -d linux
```

Для release-сборки используйте `./build_linux.sh --release`.
Скрипт проверяет инструменты и GTK, очищает нативный CMake-кэш,
выполняет `flutter pub get` и сборку. Обновление путей GTK также работает
при обычном `flutter build linux` и запуске из VS Code.

Зависимости, причины ошибок `PkgConfig::GTK` и GSettings, способы диагностики
и порядок переноса исправления в другие приложения описаны в
[инструкции по Linux-сборке](../doc/linux-build-troubleshooting.md).
