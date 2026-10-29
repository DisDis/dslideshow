# Локальные тесты: покрытие и время прогона

Общие правила качества и стоимости тестов находятся в
[AGENTS.md](../AGENTS.md#стоимость-и-качество-тестов).
Команды выполняются из соответствующего пакета, с заранее установленными
зависимостями. Обычная проверка не должна менять версии и lock-файлы.

## Кто проверяет контракт

| Набор | Ответственность |
| --- | --- |
| `common/test/encode_decode_test.dart` | Настоящий JSON payload модели ErrorResult, включая отклонение неверного типа поля. |
| `backend/test/serializers_test.dart` | Рабочий RPC-реестр, теги, envelope, декодирование и неизвестные типы. |
| `backend/test/ota_test.dart`, `ota_upload_test.dart` | Выбор DEB из ответа релиза, повреждённые ответы, отказ от скачивания установленной/старой версии, загрузка и установка; HTTP-страницы OTA, произвольный текстовый код, возврат к слайдшоу, устойчивость запуска и ранний отказ через настоящий локальный HTTP без установки. |
| `backend/test/ota_config_transfer_test.dart` | Выдача исходных байтов `config.json`, включая повреждённый JSON; авторизация, проверка `AppConfig`, пределы, атомарная замена и очистка при ошибках импорта. |
| `backend/test/streaming_upload_test.dart` | Потоковый приём multipart, ограничения и cleanup; ограниченное отбрасывание тела после отказа, включая предел байтов, таймауты и отмену. |
| `dslideshow_flutter/test/terminal_backend_test.dart` | Ячейки настоящего буфера OTA-терминала: начало строки после `LF`, разделённый по сообщениям `CRLF`, обновление прогресса через `CR` и ANSI-последовательности во фрагментах. |
| `dslideshow_flutter/test/ota_bloc_test.dart` | Стадии OTA, ранний код и поздний адрес, ошибки сети/RPC, конкуренция инициализации с live-событиями и выходом, отмена подписок и поздние ответы после закрытия. |
| `dslideshow_flutter/test/ota_view_test.dart`, `ota_terminal_panel_test.dart` | Крупные QR/код/версия, иконки и три этапа, 100% в одной строке без сдвига заголовка/полосы, стабильная геометрия и сохранение лога; подсказка пустого журнала до видимого вывода, настоящий TerminalView: burst, пауза в истории, возврат вниз, resize и disposal. |
| `dslideshow_flutter/test/ota_ready_paint_test.dart` | Пиксели настоящего MainApp→OTAPage на 2560×1600 в embedded-режиме: QR, код и красная версия видны внутри экрана; обнаруживает clipping стартового Stack. |
| `backend/test/config_test.dart`, `config_app/test/config_screen_test.dart`, `dslideshow_flutter/test/frame_language_test.dart` | JSON-язык рамки и defaults, Save/Reload и независимость языка панели, локаль MainApp и реальный русскоязычный экран OTA. |
| `dslideshow_flutter/test/effect_settings_test.dart` | Передача настроек и пиксели начала, промежуточного и конечного кадра для вариантов направления, формы, цвета и стиля. |
| `dslideshow_flutter/test/effect_parameter_rendering_test.dart` | Наблюдаемое влияние активных параметров на изображение и чистые endpoints. |
| Остальные пиксельные тесты эффектов | Полноразмерные кадры, границы, blur и sampling; плотные сетки Mosaic 100/150/200 сохраняются. |
| `dslideshow_flutter/test/video_session_test.dart` | Общие контроллеры, обновление геометрии живых видеопредставлений и освобождение сессий владельцем. |
| `config_app/test/premiere_transitions_preview_test.dart` | Подключение всех 30 исторических вариантов к предпросмотру, завершение переходов, быстрая смена и disposal на `en`. |

Прогон каждого эффекта в предпросмотре не повторяет тестирование переводов и
Ken Burns: движение фото проверяют отдельные сценарии `slideshow_preview_test.dart`
и frontend-тесты PhotoMotion. Подготовка фото предпросмотра сохраняет рабочие
2560×1600; интерфейсный тест не меняет размеры в production-коде. Матрицы обычных
layout-тестов выполняются на `en`. Проверки выбора языка, переводов и форматов
остаются самостоятельными и могут использовать другие локали.

Fake-зависимости панели находятся в `config_app/test/support/`: управляемый
репозиторий конфигурации, bundle встроенных фото и видеоконтроллер галереи
с gates/ошибками. Предпросмотр слайдшоу использует настоящие asset-сессии;
bundle подменяет только получение байтов и контролирует поздние ответы/ошибки.
Общий захват пикселей
frontend находится в `dslideshow_flutter/test/support/pixel_capture.dart`.

## Браузерные проверки

Браузерные тесты пишем и запускаем только с согласия пользователя.
То же правило действует для headless-проб и разовых браузерных скриптов;
их запуск также требует согласия. Явная просьба написать или запустить такие
проверки считается согласием на соответствующее действие. Обычные локальные
проверки и выпуск DEB согласия на браузерные тесты не подразумевают.

Причина ограничения — стоимость компиляции и запуска браузера.
[Датированные замеры и история удаления наборов](history/local-checks-2026-10.md#стоимость-браузерного-startup-29102026)
сохранены отдельно от действующих правил.

Обычные unit/widget-тесты логики Web-приложения сохраняются и выполняются в VM.
Вход и маршруты проверяет `config_app/test/app_startup_test.dart`, черновики и
подтверждение выхода — `config_screen_test.dart` и `config_navigation_test.dart`.
Эти тесты не проверяют web-точку входа, выбор окружения JavaScript/Wasm,
DOM-событие `beforeunload` и настоящий BrowserClient/CORS. Успешная web-сборка
подтверждает компиляцию, но не запуск в браузере. Исторические результаты
браузерных прогонов сохраняются в отчётах; их чтение не требует нового прогона.

Страницы OTA используют встроенные HTML/CSS и обычные формы, работающие без
JavaScript. Необязательный скрипт страницы прошивки меняет подпись кнопки при
отправке и блокирует повторное нажатие. Локальные backend-тесты в VM проверяют
маршруты, ответы, контракт HTML/CSP скрипта и работу сервисов, но не выполнение
скрипта, отправку HTML-форм, отображение CSS и адаптивность в настоящем браузере.
Аппаратная установка DEB и сохранность конфигурации при отключении питания
также не входят в локальное покрытие; [контракт OTA и конфигурации](uploads.md).
Регрессия раннего отказа OTA использует настоящий локальный HTTP-сервер и
передачу тела запроса; это не проверка отправки формы браузером. Дочитывание
отклонённой загрузки ограничено, [поведение и ограничения](uploads.md#отказ-во-время-http-загрузки).

## Запуск

Из корня репозитория:

```bash
(cd common && dart test)
(cd backend && dart test --concurrency=1)
(cd dslideshow_flutter && flutter test --no-pub)
(cd config_app && flutter test --no-pub)
```

Для выборочной проверки соответствующих контрактов:

```bash
(cd common && dart test test/encode_decode_test.dart)
(cd backend && dart test --concurrency=1 test/serializers_test.dart test/ota_test.dart test/ota_upload_test.dart test/ota_config_transfer_test.dart test/streaming_upload_test.dart)
(cd dslideshow_flutter && flutter test --no-pub test/effect_settings_test.dart test/video_session_test.dart test/zoom_blur_effect_test.dart)
(cd config_app && flutter test --no-pub test/premiere_transitions_preview_test.dart test/config_bloc_test.dart test/config_screen_test.dart test/single_video_player_test.dart test/video_grid_item_test.dart test/effects_editor_test.dart test/argb_color_field_test.dart test/device_page_test.dart test/rpc_telemetry_widget_test.dart test/slideshow_preview_test.dart)
```

Для отдельной проверки переносов и прогресса в терминале OTA:

```bash
(cd dslideshow_flutter && flutter test --no-pub test/terminal_backend_test.dart)
(cd dslideshow_flutter && DSLIDESHOW_EMBEDDED=true flutter test --no-pub \
  test/ota_bloc_test.dart test/ota_view_test.dart test/ota_terminal_panel_test.dart \
  test/ota_ready_paint_test.dart)
```

Эти тесты не выполняют установку через `apt` на устройстве; [границы проверки](../dslideshow_flutter/README.md#терминал-ota).

Проверки backend требуют локальных сокетов; сценарии установки подменяют
installer и не устанавливают пакет в систему. Анализаторы запускаются отдельно:
`dart analyze` в common/backend, `flutter analyze --no-pub` в приложениях.
Общий запуск для всех Dart/Flutter-пакетов: `./deb_factory/run_analysis.sh`.
Он останавливается при ошибках и предупреждениях, но оставляет `info`
неблокирующими для DEB. Перед любым релизом требуется исправить все три уровня
замечаний до `No issues found`, см. [правило выпуска](releasing.md#анализатор-перед-любым-релизом).
Полный выпускной набор описан в [deb_factory/readme.md](../deb_factory/readme.md).

## Как сравнивать скорость

Сохраните исходники теста до правки вне репозитория, затем выполните исходный
и изменённый варианты последовательно на одном SDK и в одинаковом окружении.
Для тестов с относительными импортами сохраняйте также `support/` и fixtures.
Используйте одинаковые параметры запуска, например `flutter test --no-pub
--machine ПУТЬ`, и сохраняйте JSONL stdout и stderr. В событиях `testStart`/
`testDone` поле `time` дано в миллисекундах с начала runner; отдельно учитывайте
загрузку и время самого сценария. При замене матрицы локалей явно указывайте
изменившийся состав тестов. Один замер не является оценкой стабильного p95.

[Пример сравнения теста предпросмотра 28.10.2026](history/local-checks-2026-10.md#скорость-теста-предпросмотра-28102026)
сохраняет состав сценариев, время и пределы одиночного замера.
Ускорение локальных тестов не подтверждает ускорение приложения
или аппаратную приёмку RaPi5.
