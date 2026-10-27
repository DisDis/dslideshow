# Локальные инструменты

## Проверка Google Photos Ambient API

`ambient_api_probe.py` — самостоятельный REST-клиент для локальной проверки
конкретного Google Cloud проекта и аккаунта. Нужны Python 3.10+ на Linux/macOS
и доступ в интернет; дополнительные Python/Dart-пакеты, backend, SDK googleapis,
Flutter и ffmpeg для его работы не требуются. Backend и конфигурация фоторамки
скриптом не изменяются.

Он выполняет device OAuth, создаёт тестовое Ambient-устройство, предлагает
выбрать источники в Google Photos, получает страницы медиа конкретного источника
и по умолчанию скачивает **одно фото и одно видео**. Созданное устройство,
токены и выбранный source ID сохраняются для повторных запусков.

### Подготовка и запуск

В том же Google Cloud проекте, где включён Google Photos Ambient API:

1. Настроить Google Auth consent screen; для тестового приложения добавить
   используемый Google-аккаунт в test users, если этого требует Console.
2. Создать OAuth client типа **TVs and Limited Input devices**. Прежний Web client
   backend для этой пробы не подходит. Скачать его JSON.
3. Подготовить контрольный альбом с фотографией и видео.

Из корня репозитория:

```bash
mkdir -p .local/ambient-api
chmod 700 .local/ambient-api
cp /path/to/downloaded-oauth-client.json .local/ambient-api/client.json
chmod 600 .local/ambient-api/client.json

python3 tools/ambient_api_probe.py \
  --client-file .local/ambient-api/client.json
```

Скрипт напечатает Google verification URL и короткий пользовательский код.
Открыть URL в своём браузере, ввести код и разрешить запрошенный доступ.
При первом создании устройства скрипт напечатает `settingsUri`: открыть его
и выбрать альбом для устройства в Google Photos. Браузер автоматически не
открывается. Ожидание учитывает интервалы, возвращённые Google.

Если выбран один доступный источник, он используется автоматически; для
нескольких появится выбор номера или ID в терминале. Выбор сохраняется.
`mediaSourceId` относится к Ambient-устройству: это не прежний album ID Library API.
Специальный источник `highlights` исключён из выбора, поскольку не поддерживает
фильтрацию `mediaItems.list` через `mediaSourceId`.

Scope: `https://www.googleapis.com/auth/photosambient.mediaitems`.
Первый запуск запрашивает device/user codes; далее используются сохранённые
токены и refresh token. Изменение OAuth client требует другого `--state-dir`;
для другой Google-учётной записи также следует использовать отдельный каталог.

У включённого API ещё может не быть достаточного допуска к методам. Probe
показывает HTTP status, Google error status и `reason`, если он присутствует,
а также этап ошибки. Он не трактует любой 403 как отсутствие партнёрства.

Живая проверка 27.10.2026: пользователь успешно разрешил OAuth, после чего
`devices.create` вернул `403 PERMISSION_DENIED`. Сообщение Google прямо
направляет в partner program. Для проверенного проекта включения API в Console
оказалось недостаточно. Выбор альбома, список и загрузка медиа этим прогоном
не проверены: отказ произошёл раньше. Повторить проверку можно той же командой
после получения необходимого допуска; OAuth-токены сохранены локально.

### Результаты и повторный запуск

По умолчанию локальные данные расположены в `.local/ambient-api/`, который
исключён из Git. `state.json` содержит токены, client ID, request ID, device ID
и выбранный source ID. Новые каталоги состояния/прогона имеют права 0700,
JSON и загруженные медиа — 0600. Client secret остаётся в переданном OAuth JSON.

В `runs/<UTC-время>-<суффикс>/` сохраняются:

* `device.json` — состояние устройства и выбранные пользователем источники;
* `media.json` — уникальные полученные медиа с метаданными, без временных base URLs;
* `photo-<hash>.*`, `video-<hash>.*` — завершённые загрузки; имя не берётся из пути API;
* `report.json` — последний этап, число страниц, типы медиа, ограничение обхода,
  результат каждой загрузки с размером/SHA-256 и ошибки.

При ошибке и Ctrl+C незавершённые `.part` удаляются. Токены и client secret
не печатаются в диагностике и не включаются в отчёт; metadata/ID и `settingsUri`
в локальных результатах относятся к выбранному аккаунту.

Повторить обычную команду для нового списка и новых media URLs. ID устройства
переиспользуется, новое устройство на каждый запуск не создаётся. Если прервать
ожидание выбора альбома, следующий запуск продолжит с сохранённым устройством.

Дополнительные режимы:

```bash
# Заново показать settingsUri и подтвердить в терминале завершение выбора.
python3 tools/ambient_api_probe.py --client-file .local/ambient-api/client.json --configure

# Выбрать другой источник из уже настроенных для устройства.
python3 tools/ambient_api_probe.py --client-file .local/ambient-api/client.json --source-id SOURCE_ID

# Только получить список; это не проверяет скачивание медиа.
python3 tools/ambient_api_probe.py --client-file .local/ambient-api/client.json --photos 0 --videos 0

# Скачать больше контрольных файлов и проверить больше страниц.
python3 tools/ambient_api_probe.py --client-file .local/ambient-api/client.json \
  --photos 3 --videos 2 --max-pages 20

# Повторить OAuth после отзыва/истечения refresh token; устройство сохраняется.
python3 tools/ambient_api_probe.py --client-file .local/ambient-api/client.json --reauthorize

# Удалить созданное probe устройство из Google Photos после проверки.
python3 tools/ambient_api_probe.py --client-file .local/ambient-api/client.json --delete-device
```

Device ID и исходный UUID request ID записываются локально. Если Google создал
устройство, но ответ потерялся, повтор не меняет request ID. При `ALREADY_EXISTS`
использовать `--delete-device`, который умеет удалить устройство по сохранённому
request ID, затем повторить запуск. При успешном удалении или NOT_FOUND локальные
device/request/source ID очищаются; сохранённые OAuth-токены остаются.

Другие параметры доступны через `--help`: `--state-dir`, `--output-dir`,
`--display-name`, лимиты и сроки ожидания. `--output-dir` задаёт родителя
отдельного каталога прогона; при выборе каталога вне стандартного пути его
игнорирование Git остаётся ответственностью вызывающего.

### Лимиты и трактовка результата

По умолчанию: до 10 страниц по 100 элементов, до 512 MiB на скачиваемый файл,
таймаут сетевой операции 30 с, ожидание OAuth/выбора по 600 с, скачивание 300 с.
Общий срок загрузки проверяется между чтениями; блокирующий read может добавить
до одного сетевого таймаута. JSON-ответ ограничен 2 MiB. При неудачной загрузке
проверяется следующий кандидат того же типа; максимум попыток на тип — большее
из 3 и запрошенного числа файлов. Автоматического бесконечного retry нет.

| Exit code | Значение |
| --- | --- |
| 0 | Все запрошенные типы/количества скачаны, лимит страниц не обрезал обход |
| 1 | Ошибка настройки, OAuth, устройства, выбора источника или получения списка |
| 2 | Неполная проверка: нет нужного типа/количества, ошибка скачивания либо достигнут лимит страниц |
| 130 | Прерывание пользователем во время прогона; состояние сохранено |

Скачивание требует успешного HTTP 200 и соответствующего media Content-Type
(либо `application/octet-stream` с распознаваемой сигнатурой), проверяет
фактическое число байтов, Content-Length при наличии, сигнатуру распространённых
image/video-контейнеров и SHA-256.
Расширение берётся из Content-Type загрузки, поскольку Google может преобразовать
исходный формат; для `application/octet-stream` используется MIME из API.
Контейнер/кодек не декодируется: результат не доказывает воспроизведение файла
на фоторамке. Фото запрашивается с `=d`, видео — с `=dv`; последний параметр
может возвращать транскодированное видео, а не побайтовый оригинал.
Переходы media URL разрешены только между ожидаемыми HTTPS CDN Google;
перенаправления OAuth/API и передача bearer token на произвольный host запрещены.

У Ambient есть существенная особенность: текущая REST-схема `AmbientMediaItem`
описывает фотографию, а общий guide упоминает и видео. Поэтому probe проверяет
видео по фактически возвращённому `video/*`, не выдумывает поле video metadata
и не выдаёт отсутствие видео за успешную проверку. Для контрольного альбома
с видео такой результат нужно сохранить как ограничение наблюдаемого API.

Отсутствие `nextPageToken` означает окончание полученной последовательности
страниц, но документация Ambient не гарантирует полный снимок всех медиа альбома.
Учитываются дубли, повторяющийся page token вызывает ошибку. Выдача с filtering
не используется для удаления локальных файлов. Для `mediaItems.list` описан
лимит 240 запросов на устройство в день; повторные прогоны расходуют общий лимит.

### Локальные тесты

```bash
python3 -m unittest discover -s tools -p 'test_*.py' -v
python3 -m py_compile tools/ambient_api_probe.py tools/test_ambient_api_probe.py
```

Тесты без Google-аккаунта: OAuth pending/slow_down/denial/refresh, повторный запуск,
источники, реальные HTTP-потоки на loopback, пагинация, отсутствие видео,
удаление устройства, ошибки и reasons, защита redirect, лимит/недокачка/Ctrl+C,
права файлов и освобождение ресурсов. Живой доступ конкретного проекта
подтверждается отдельным пользовательским прогоном с его OAuth JSON.

Официальные источники:

* [Настройка Ambient и тип OAuth client](https://developers.google.com/photos/ambient/guides/configure-your-app).
* [Device OAuth, интервалы и ошибки](https://developers.google.com/identity/protocols/oauth2/limited-input-device).
* [Создание устройства](https://developers.google.com/photos/ambient/reference/rest/v1/devices/create)
  и [удаление по device ID/request ID](https://developers.google.com/photos/ambient/reference/rest/v1/devices/delete).
* [Источники устройства](https://developers.google.com/photos/ambient/reference/rest/v1/devices),
  [пагинация mediaItems](https://developers.google.com/photos/ambient/reference/rest/v1/mediaItems/list)
  и [текущая mediaItems-схема](https://developers.google.com/photos/ambient/reference/rest/v1/mediaItems).
* [Скачивание фото/видео и filtering](https://developers.google.com/photos/ambient/guides/media-items).
