# DSlideShow: сборка

[Настройки эффектов](../doc/effect-settings.md) описывают `slideshow.effects`,
длительность переходов, каталог и предпросмотр. Старые `allowedEffects`/
`transitionTimeMs` не поддерживаются. [Обзор пресетов](../doc/effect-settings.md#соответствие-пресетов)
содержит варианты объединённых семейств, а [устройство renderer](../doc/slideshow-renderer.md) —
общий контракт входов и владение фото, видео и специальными экранами.

Аппаратные результаты сохранены в отчётах
[каталога эффектов](../benchmarks/reports/effect-performance-2026-10-28/report.md)
и [Radial Blur/VHS](../benchmarks/reports/gpu-effects-2026-10-28/report.md).
Они относятся к указанным в отчётах сборкам и условиям; последующие изменения
API не превращают их в измерения текущего checkout.

Проверенная конфигурация сборки: Flutter 3.47.7 stable, Dart 3.13.5.
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
`ffmpeg`); проверены версии 5.1.9 и 8.0.1. Он также нужен машине сборки для обязательных
backend codec-тестов. [Подробности](../backend/README.md#локальные-зависимости-миниатюр).

## Linux desktop

Установите инструменты и development-пакеты по общей
[инструкции Linux](../doc/linux-build-troubleshooting.md). Из `dslideshow_flutter/`:

```sh
./build_linux.sh --release
```

Скрипт проверяет инструменты и GTK, обновляет нативный CMake-кэш, выполняет
`flutter pub get` и `flutter build linux`. Версия приложения не увеличивается.
Результат x64 — `build/linux/x64/release/bundle/`; переносить нужно весь bundle.
Обычные `flutter build linux --release` и `flutter run -d linux` также поддерживаются.

Основная фоторамка в обычном Linux desktop запускается без видео. Видео
в [desktop-панели config_app](../config_app/README.md#linux-desktop) использует
отдельный libmpv backend. Embedded runner `flutter-pi` не требует GTK.
Диагностика GTK/GSettings, toolchain и Snap VS Code, а также регрессионные
проверки runner собраны в [общем руководстве](../doc/linux-build-troubleshooting.md).

## Raspberry Pi

Существующий `./build_aot_pi4.sh` собирает arm64/CPU pi4 через `flutterpi_tool`.
`../deb_factory/build.sh` собирает также веб-панель и DEB. Flutter SDK,
`flutterpi_tool` и engine binaries должны быть согласованы по версии.
При сборке DEB AOT и web собираются параллельно анализатору и локальным тестам;
упаковка начинается после успеха всех задач. Зависимости должны быть получены
заранее, build-номер увеличивается до запуска параллельных задач; детали отказов
и повторных попыток — в [руководстве выпуска](../doc/releasing.md).
После добавления зависимости backend выполните `flutter pub get` также в
`dslideshow_flutter/`: AOT использует граф зависимостей основного приложения,
а не `backend/.dart_tool/package_config.json`.
После обновления видеоплагина требуется проверка на устройстве: видео/GIF,
пауза, сон и пробуждение по датчику, DPMS и GPIO. Desktop-сборка этого не проверяет.

[Аппаратное руководство](../doc/raspberry-pi-benchmarks.md) описывает установку
и автоматический запуск отдельного бенчмарка на RaPi5, тесты эффектов/видео,
получение отчётов и расположение исходников flutter-pi на устройстве.
Порядок синхронизации версий, ведения changelog и финальной сборки через
`deb_factory/build.sh` приведён в [инструкции выпуска](../doc/releasing.md).

## Подключение к настройкам

Экран рамки показывает QR, код и ручной адрес панели; объясняет подготовку,
отсутствие сети, ошибки и timeout, обновляет адрес и поддерживает повтор/выход.
[Все состояния, снимки и локальные проверки](../doc/config-page-states.md).
Поведение принадлежит `ConfigBloc`, страница и новые виджеты stateless.
Подсказки `ButtonsHintWidget` располагаются у физических кнопок по настройкам
`hintOffsetX/Y`; значки соответствуют доступным экранным действиям.
При отсутствии сети используется Wi-Fi-значок.

## Терминал OTA

[Этапы обновления на экране рамки](../doc/ota-update-stages.md):
13 скриншотов на 2560×1600 с описанием состояний и командой повторного захвата.

Экран показывает QR-код, код доступа, текущую версию и этапы передачи, установки
и перезапуска. Статусы, размеры, адаптивность и сохранение истории описаны в
[руководстве со скриншотами](../doc/ota-update-stages.md). Язык рамки настраивается
независимо от языка панели; [формат и defaults](../doc/language.md).

Журнал установки на экране рамки начинает каждую строку вывода `apt` с первого
столбца. `TerminalBackend` включает режим перевода строки xterm: Linux `LF`
переходит на следующую строку и возвращает курсор в её начало. `CRLF` не создаёт
лишних строк, а отдельный `CR` сохраняет обновление прогресса в текущей строке.
ANSI-последовательности и потоковые фрагменты обрабатывает терминал без замены
переносов в исходном выводе.

Локальная регрессионная проверка сравнивает ячейки настоящего буфера терминала
для `LF`, разделённого между сообщениями `CRLF`, прогресса через `CR` и ANSI:

```sh
flutter test --no-pub test/terminal_backend_test.dart
DSLIDESHOW_EMBEDDED=true flutter test --no-pub test/ota_bloc_test.dart \
  test/ota_view_test.dart test/ota_terminal_panel_test.dart \
  test/ota_ready_paint_test.dart
```

Команды выполняются из `dslideshow_flutter/`. VM-тесты проверяют буфер,
состояния и гонки инициализации, стартовую компоновку на 2560×1600 и небольшом
экране, фактически нарисованные QR/код/красную версию в границах дисплея,
прокрутку настоящего TerminalView и освобождение ресурсов. Они не
устанавливают пакет и не заменяют проверку читаемости на дисплее.
Изолированный [аппаратный стенд OTA](../benchmarks/ota-harness.md) подаёт
тестовые события и логи без установки через `apt` и перезапуска рамки.
Маршруты и контракт установки описаны в [руководстве OTA](../doc/uploads.md#терминал-на-экране-рамки).

## Проверки

Зависимости frontend собираются через сервис-локатор `injector` (GetIt)
в `lib/main.dart`. `RouteBloc`, `SlideshowStatusBloc`, `FrameFrontendController`,
`FrameDisplayInfoReader`, `FrontendService` и `FrontendRpcService` регистрируются как singleton
до обработки входящих RPC. Геометрия дисплея читается зарегистрированной
функцией при каждом запросе, поэтому resize отражается в ответе.

`FrontendService` владеет минутным опросом SystemInfo и локальными ожиданиями
RPC. SystemInfo запрашивается при создании сервиса и затем на каждом минутном
тике через надёжный межизолятный RPC к backend. Отдельного флага выполняющегося
опроса нет. Ошибка backend диагностируется без сырого исключения,
следующий тик запрашивает данные заново. `dispose()`
отменяет таймер, локальные ожидания и потоки событий; поздний ответ не обновляет
закрытый сервис. Общий RemoteService принадлежит уровню запуска и этим методом
не закрывается. GetIt-регистрация подключает `dispose` к своему lifecycle
и вызывает его один раз при завершении владельца. Результат `dispose`
не кешируется для повторных вызовов.

FrontendService публикует `onSystemInfoUpdate` без зависимости от Bloc.
В `main.dart` этот поток подключён к `FrameFrontendController`, который
обновляет `hasInternet` в `SlideshowStatusBloc`. Зависимости классов передаются
через конструкторы; `injector` используется в точке сборки приложения.
FrontendService не зависит от контроллера состояния рамки. Сначала создаётся
FrontendService, затем StatusBloc с этим сервисом, затем FrameFrontendController
с готовыми StatusBloc, маршрутом и функцией чтения дисплея. Последним создаётся
FrontendRpcService: он обрабатывает RPC чтения состояния и управления через
контроллер, а команды кнопок, действий и OTA передаёт FrontendService.
Оба межизолятных входа подключены к этому RPC-обработчику. Цикла и отложенного
provider StatusBloc нет; после завершения FrontendService обработчик отклоняет команды.
Unit-тесты создают рабочие объекты через те же конструкторы с fake внешнего RPC.

`MainMenuBloc` ждёт подтверждения power/restart и закрывает меню после успеха.
Отказ оставляет меню доступным, повторное выполнение до окончания текущего
игнорируется. Закрытие отменяет локальное ожидание и ждёт отмены подписки
кнопок. Логи `FrontendService` используют `requestId` для RPC и название действия
для refresh; `FrontendRpcService` пишет начало/итог команд состояния рамки на FINE
и безопасный тип ошибки на WARNING с исходным `requestId`.
`MainMenuBloc` записывает действие и итог.
Ошибки/отмена не раскрывают текст исключения или содержимое RPC.

```sh
# Из dslideshow_flutter/
flutter test --no-pub test/frontend_service_test.dart test/frame_frontend_controller_test.dart test/main_menu_bloc_test.dart
```

Тесты используют рабочие сервис/Bloc с fake внешнего RemoteService, виртуальное
время и управляемые ответы. Они не выключают устройство и не перезапускают
службу. Содержимое callback выбора страницы и команды проверяется отдельно
от layout меню.

[Распределение покрытия и быстрые локальные команды](../doc/testing.md).

[Специальные экраны](../doc/special-screens.md): часы, снимки камер по HTTP/HTTPS,
расписание вставок и локальные проверки.

[Сон экрана и присутствие](../doc/screen-presence.md): правила отмены затухания,
приоритет ручной блокировки, Linux-регрессии и сценарии аппаратной проверки.

[Сессии renderer слайд-шоу](../doc/slideshow-renderer.md): владение фото, видео
и специальными экранами, подготовка, отмена и освобождение ресурсов перехода.

Из корня репозитория:

```sh
(cd tools && dart test test/system/linux_test.dart)
(cd common && dart test)
(cd rpc_serializers_generator && dart test)
(cd backend && dart test)
(cd config_app && flutter test --no-pub)
(cd system_metrics_widget && flutter test --no-pub)
(cd dslideshow_flutter && flutter test --no-pub)
(cd config_app && ./build_web.sh --no-pub)
```

Генерация моделей: `dart run build_runner build` в `common/`, `backend/`,
`dslideshow_flutter/` и `config_app/`. Для watch-режима доступны скрипты
`generate_models.sh`. Используется штатный запуск build_runner без дополнительных
ограничений генератора; история обновления SDK сохранена [отдельно](../doc/history/sdk-update-2026-10.md).
Для форматированного вывода события OTA после общей генерации выполните из
`dslideshow_flutter/`:

```sh
dart run build_runner build --define freezed:freezed=format=true \
  --build-filter lib/features/ota/presentation/bloc/ota_event.freezed.dart
```

Freezed 4 задаёт форматирование builder-опцией; сгенерированный файл вручную
не редактируется. Остальные модели этой командой не перезаписываются.
В backend обычный `dart run build_runner build` генерирует также RPC-реестр из `@RpcSerializers`:
[подключение builder и правила регистрации](../rpc_serializers_generator/README.md).

Device Preview 3 подключается до инициализации WidgetsBinding. В desktop debug/profile
доступен профиль PhotoFrame 2560×1600; управление устройствами теперь находится
в расширении Flutter DevTools. Embedded- и release-запуск используют обычный binding.

Lock-файлы приложений, backend, rpc_serializers_generator и autover сохраняются
в Git для воспроизводимости.
При нехватке квоты `/tmp` можно задать `TMPDIR` на диске с достаточным местом.

[Эффекты и Ken Burns](../doc/effects.md): визуальные варианты, совместимость
с живыми медиа, настройки движения фото, предпросмотр и границы проверок.
