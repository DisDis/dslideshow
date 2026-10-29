# Локальные тесты: покрытие и время прогона

Общие правила качества и стоимости тестов находятся в
[AGENTS.md](../AGENTS.md#стоимость-и-качество-тестов).
Команды выполняются из соответствующего пакета, с заранее установленными
зависимостями. Обычная проверка не должна менять версии и lock-файлы.

Для изменений поведения **диагностические логи входят в критерии приёмки**:
нужно связать начало и итог операции, увидеть количества, ошибку, отмену
и повтор по безопасному ID. Проверяйте реальные записи logger в тестах
сервисов/Bloc, вместе с наблюдаемым результатом действия. Проверка должна
обнаруживать потерянную диагностику, утечку авторизованного URL/EXIF и
неограниченный поток INFO при большой коллекции; точный текст каждой строки
и временные значения фиксировать не нужно. Уровни и команды получения
[логов галереи](gallery.md#логи-управления-медиатекой) описаны в руководстве.

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
| `dslideshow_flutter/test/premiere_transitions_test.dart` | Промежуточные пиксели, живые слои, обратный ход и освобождение ресурсов переходов; у Louver — чёрные зазоры в точные моменты поворота каждой планки ребром и рядом с ними на обеих осях, а также бесшовные дробные границы конечных кадров. |
| Остальные пиксельные тесты эффектов | Полноразмерные кадры, границы, blur и sampling; плотные сетки Mosaic 100/150/200 сохраняются. |
| `dslideshow_flutter/test/video_session_test.dart` | Общие контроллеры, обновление геометрии живых видеопредставлений и освобождение сессий владельцем. |
| `common/test/gallery_management_test.dart` | Реальные JSON-модели новых операций, метаданных, корзины и состояний поиска. |
| `backend/test/gallery_catalog_test.dart`, `gallery_catalog_admission_test.dart`, `gallery_http_test.dart` | ID из пути и версии stat-полей, индекс в памяти и неизменный 32-байтовый `catalog.epoch` при росте/scan, стабильность после перезапуска и сохранённая force-инвалидация. Отказ/повреждение метки и cleanup с безопасными логами. `markDirty()` в одном web-isolate без watcher, сохранение подсказки во время scan и периодическая сверка внешних изменений без уведомления. Старый оригинал доступен до завершённой замены; после неё старая revision отклоняется. |
| `backend/test/gallery_file_operations_test.dart` | Зеркальные пути trash/restore/purge в `<gallery state>/trash` через `File.rename` без manifest/receipts, актуальные stat-ID и старый Undo, занятые файлы/каталоги перед переносом, корни/симлинки/EXDEV, частичный результат, лимиты индекса и прямой preview; уведомление каталога после trash/restore, фактический успех при ошибке вспомогательного кеша и отсутствие сканирования оригиналов при purge. Гонка внешнего создания цели между проверкой и rename принимается и не защищается. |
| `backend/test/thumbnail_service_test.dart`, `gallery_duplicate_cli_test.dart` | Очистка миниатюр не меняет соседний `<gallery state>/trash`; реальная Czkawka не включает фотографии из этой корзины в поиск оригиналов; восемь идентичных файлов в двух режимах дают одну группу из восьми. |
| `backend/test/gallery_media_tools_test.dart`, `gallery_tool_runner_test.dart` | Поворот JPEG настоящим jpegtran и PNG через Dart, EXIF/ICC/alpha/bit depth, сравнение JPEG EXIF с WARNING при изменении без восстановления тегов, отказ при неверном формате/геометрии/ICC, атомарная публикация без удаления оригинала и журнала; повтор старой revision отклоняется, включая перезапуск. Отмена/таймаут/лимит вывода дочернего процесса и освобождение pipes. |
| `backend/test/gallery_metadata_reader_test.dart`, `gallery_png_rotation_test.dart` | Реальное чтение EXIF/ICC и фактических размеров без EXIF CLI, FD/budgets, video ffprobe; PNG — все Orientation по независимой координатной модели, 16-битные каналы, нормализация EXIF, CRC/layout, отмена/timeout и закрытие worker. |
| `backend/test/gallery_duplicate_service_test.dart` | Снимок кандидатов, конечный JSON CLI, пустой результат/ошибки, stop/restart, освобождение процесса, объединение повторных наборов участников с приоритетом exact, сохранение более широких similar-групп и пропуск групп с менее чем двумя актуальными участниками без переписывания job.json и повторная проверка оставляемых экземпляров; fake подменяет внешнюю CLI-команду. |
| `config_app/test/gallery_management_repository_test.dart`, `gallery_management_ui_test.dart` | Рабочий transport/API, предел HTTP JSON, не более четырёх запросов metadata и отмена ожидающих без запуска HTTP; состав панели выбора, lazy metadata и закрытие, поворот/версии, частичный отказ/Undo, подтверждение purge, ожидание/остановка поиска, keeper/stale. |
| `config_app/test/gallery_mutation_confirmation_test.dart` | Подтверждение trash/purge в сетке и просмотре: количество, первые 10 имён, размер purge, отмена без HTTP и привязка команды к точным файлам/версиям; устаревшее подтверждение отклоняется. |
| `config_app/test/gallery_comparison_metadata_ui_test.dart` | Сведения при первом показе списка и возврате к кешу; отказ metadata и fallback размеров из Czkawka, отдельные повторы изображения и сведений с безопасной причиной ошибки. |
| `config_app/test/gallery_trash_bulk_test.dart` | «Выделить всё», очистка независимо от выбора с подтверждением, компактные границы batch/UTF-8 JSON, частичный и неизвестный ответ с обновлением текущего списка, новые поступления вне подтверждения, прогресс/постоянная геометрия панели на EN 320 px с text scale 1.5. |
| `config_app/test/gallery_management_bloc_test.dart`, `gallery_viewer_bloc_test.dart`, `gallery_duplicates_bloc_test.dart`, `gallery_undo_bloc_test.dart` | Состояния и действия рабочих Bloc: выбор/частичный результат, версии и отмена запросов, страницы по 10 участников и решения сравнения, освобождение опроса, обновление списка после неизвестного ответа и новая команда по текущим данным; Undo восстанавливает только оставшиеся исходные записи. |
| `config_app/test/gallery_fullscreen_revision_test.dart`, `gallery_viewport_test.dart`, `single_item_viewer_page_test.dart` | Смена/исчезновение открытого файла, bounded demand сетки/fullscreen, управление видео сквозь скрытые панели и освобождение ресурсов. |
| `config_app/test/gallery_repository_test.dart`, `gallery_viewport_test.dart`, `gallery_management_bloc_test.dart`, `gallery_duplicates_bloc_test.dart` | 50 001 запись: реальный JSON-разбор без усечения, доступ к концу ленивой сетки с ограниченными очередями, индексированный выбор и сверка изменившейся версии. Без порогов времени/RSS и без утверждения о производительности устройства. |
| `config_app/test/gallery_selection_visual_test.dart`, `gallery_viewer_design_test.dart`, `gallery_dialog_test.dart` | Настоящий декодированный кадр не исчезает при выборе/снятии выбора и открытии диалога, тема и адаптивные карточки, ограниченный список из 10 имён, сохранение фоновых запросов и освобождение ресурсов под непрозрачным экраном. |
| `config_app/test/gallery_notifications_test.dart`, `gallery_duplicate_diagnostics_test.dart` | Ручное закрытие и timeout уведомления с Undo, сохранение восстановления, постоянная карточка конкретной ошибки CLI/связи и точные счётчики без чувствительных строк. |
| `backend/test/gallery_http_test.dart`, `web_socket_user_test.dart` | Короткие web-сводки результата/отказа без фаз и замеров времени, освобождение media lease при завершении/отмене выдачи и безопасные логи WebSocket/auth. |
| `backend/test/gallery_file_operations_test.dart`, `gallery_duplicate_service_test.dart`, `config_app/test/gallery_management_bloc_test.dart`, `gallery_management_repository_test.dart` | Записи рабочих logger: начало/результат, счётчики, частичный отказ и повтор, ошибка/отмена; deadline не переклассифицирует раннюю отмену; безопасные идентификаторы вместо чувствительных URL и данных. |
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

Для управления медиатекой отдельно:

```bash
(cd common && dart test test/gallery_management_test.dart)
(cd backend && dart test --concurrency=1 test/gallery_file_operations_test.dart \
  test/gallery_media_tools_test.dart test/gallery_tool_runner_test.dart \
  test/gallery_metadata_reader_test.dart test/gallery_png_rotation_test.dart \
  test/gallery_duplicate_service_test.dart)
(cd config_app && flutter test --no-pub test/gallery_repository_test.dart \
  test/gallery_management_repository_test.dart \
  test/gallery_management_bloc_test.dart test/gallery_viewer_bloc_test.dart \
  test/gallery_duplicates_bloc_test.dart test/gallery_undo_bloc_test.dart \
  test/gallery_mutation_confirmation_test.dart \
  test/gallery_comparison_metadata_ui_test.dart \
  test/gallery_trash_bulk_test.dart \
  test/gallery_management_ui_test.dart test/gallery_fullscreen_revision_test.dart \
  test/gallery_viewport_test.dart test/single_item_viewer_page_test.dart)
```

Для codec/metadata-проверок нужны утилиты из [README backend](../backend/README.md).
VM-тесты управления не заменяют Web/CORS и аппаратную проверку конкуренции
Czkawka/поворота со слайдшоу; [границы приёмки галереи](gallery.md#локальное-покрытие-управления-медиатекой).

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
