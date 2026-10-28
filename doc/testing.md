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
| `backend/test/ota_test.dart`, `ota_upload_test.dart` | Выбор DEB из ответа релиза, повреждённые ответы, отказ от скачивания установленной/старой версии, загрузка и установка. |
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
репозиторий конфигурации и видеоконтроллер с gates/ошибками. Общий захват пикселей
frontend находится в `dslideshow_flutter/test/support/pixel_capture.dart`.

## Запуск

Из корня репозитория:

```bash
(cd common && dart test)
(cd backend && dart test --concurrency=1)
(cd dslideshow_flutter && flutter test --no-pub)
(cd config_app && flutter test --no-pub)
```

Для быстрой проверки изменений из этого аудита:

```bash
(cd common && dart test test/encode_decode_test.dart)
(cd backend && dart test --concurrency=1 test/serializers_test.dart test/ota_test.dart test/ota_upload_test.dart)
(cd dslideshow_flutter && flutter test --no-pub test/effect_settings_test.dart test/video_session_test.dart test/zoom_blur_effect_test.dart)
(cd config_app && flutter test --no-pub test/premiere_transitions_preview_test.dart test/config_bloc_test.dart test/config_screen_test.dart test/single_video_player_test.dart test/video_grid_item_test.dart test/effects_editor_test.dart test/argb_color_field_test.dart test/device_page_test.dart test/rpc_telemetry_widget_test.dart test/slideshow_preview_video_support_test.dart)
```

Проверки backend требуют локальных сокетов; сценарии установки подменяют
installer и не устанавливают пакет в систему. Анализаторы запускаются отдельно:
`dart analyze` в common/backend, `flutter analyze --no-pub` в приложениях.
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

### Замер 28.10.2026

Последовательные запуски исходной копии и изменённого
`premiere_transitions_preview_test.dart` через `flutter test --no-pub --machine`
на одной рабочей машине и SDK, без изменения production-кода:

| Вариант | Состав | Время runner с загрузкой |
| --- | --- | --- |
| До | 2 одинаковых round-trip теста; 30 вариантов переходов × en/ru; Ken Burns; 30 безусловных кадров на ожидание | 366,954 с |
| После | 30 вариантов переходов на en; ожидание готовности и завершения; round-trip и Ken Burns остаются в профильных наборах | 28,107 с |

В этом одиночном сравнении файл выполняется примерно в 13 раз быстрее.
Это сравнение указанного файла с изменившимся составом сценариев, а не всего
репозитория или производительности фоторамки. Сырые JSONL/stdout и stderr
сохранены локально в `/tmp/dslideshow-test-speed-baseline/preview.*` и
`/tmp/dslideshow-test-speed-preview-after.*`; `/tmp` не является постоянным архивом.

Тесты и инструменты `benchmarks` в рамках этого аудита не изменяются.
Ускорение локальных тестов не является подтверждением ускорения приложения
или аппаратной приёмкой RaPi5.
