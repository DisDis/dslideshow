# FFmpeg 5.1: падение миниатюр и диагностика, 27.10.2026

Проверка выполнена по запросу пользователя, включая SSH `pi@192.168.50.143`.
Ранее codec-тесты проходили на FFmpeg 8.0.1; установленная на рамке сборка —
`5.1.9-0+deb12u1+rpt1`, aarch64. [Поведение и уровни журналов](../../../doc/gallery.md#диагностика-на-рамке).

## Причина и исправление

Предыдущий фильтр создавал фон через
`[background]drawbox=c=0x202020@1:t=fill:replace=1[canvas]` на RGBA.
На FFmpeg 5.1.9 он вызывает native SIGSEGV. На рамке зафиксированы `exit=-11`,
пустой stderr и 0 байт результата; в локальном Debian 12 тот же сбой даёт
shell exit 139. Отсутствие stderr объясняет, почему требовался также exit code.

Фон теперь рисуется через
`[background]format=rgb24,drawbox=c=0x202020:t=fill[canvas]`, затем накладывается
исходный RGBA. Входная прозрачность учитывается прежним overlay. Один процесс
FFmpeg, отсутствие ffprobe, квадрат/EXIF/no-upscale/thumbnail/JPEG сохранены.
Policy повышена до 4: смена фильтра не публикует другие байты под прежними URL.
Старый каталог обновляется через существующий 409.

Локально в Debian 12 сравнены три варианта: прежний RGBA drawbox падает;
RGB drawbox и `lutrgb=r=32:g=32:b=32:a=255` проходят. Выбран RGB drawbox.
На host FFmpeg 8.0.1 новый путь также проверен, обновлять FFmpeg на рамке не нужно.

## Результаты на RaPi

В отдельном `/tmp/dslideshow-thumbnail-diagnostic-rjgkkybi` создан тестовый PNG
64×48 с полупрозрачным красным. Старый путь падает (-11, 0 байт), исправленный
успешен (0, 238 байт). JPEG независимо декодирован FFmpeg в RGB: 48×48,
первый пиксель `[144,16,15]`, ожидаемый после наложения на #202020 — около
`[144,16,16]`. Прозрачность не была просто отброшена.

На одном существующем фото из медиатеки (316701 байт), последовательно:

| Вариант | Exit | JPEG, байт | Полное время команды, мс |
| --- | --- | --- | --- |
| small, 256 | 0 | 4647 | 186 |
| medium, 512 | 0 | 13161 | 187 |
| large, 1024 | 0 | 38857 | 238 |

Stderr пуст у всех успешных команд. SHA-256 оригинала до/после совпадает.
Это функциональная проверка одного FFmpeg-процесса, не A/B UI/эффектов,
не проверка четырёх параллельных workers и не общая аппаратная приёмка.
Тестовые файлы и результаты оставлены в указанном /tmp-каталоге рамки.
Приложение на устройстве не заменялось; проверен исправленный CLI-конвейер.
Для новых фильтров и логов нужна сборка приложения с текущими исходниками.
ОС, драйверы, runtime и службы не изменялись.

## Новая диагностика

INFO показывает активные gallery-настройки и восстановление кеша. При
`log.web=ALL` видны catalog/refresh, media identity, HTTP status, очередь,
cache/negative-cache hit, запуск FFmpeg, PID, точные arguments, время и размер.
WARNING показывает native exit/stderr, ошибки файлов/диска/кеша и исходный
Dart exception. Общий formatter теперь печатает переданный stackTrace.
Новые сообщения не включают код авторизации из HTTP URL и бинарный stdout;
подробности не добавляются к безопасным HTTP error responses.

Ограничение stderr осталось 64 KiB; при переполнении сохраняется его начало.
В лог выводится максимум 8192 символа с `[truncated]`. Отмена — FINE, ошибка
кодека/timeout — WARNING. Слот удерживается до exit и закрытия pipes; TERM/KILL
не отправляются повторно после наблюдённого завершения ребёнка.

## Проверки и повтор

* Backend: analyze — чисто; полный набор 426 тестов прошёл, затем повторены
  затронутые native/process/cache/HTTP-регрессии после финального ревью.
* Common: analyze — чисто, 13 тестов прошли, включая реальный console formatter.
* Config_app: 304 теста прошли, переход версии policy сохраняет работу клиента.
* Standalone AOT codec probe: 19 случаев прошли на FFmpeg 5.1.9 Debian 12 и
  8.0.1 host: alpha 0/128/255, иной фон, один пиксель, EXIF, представитель GIF,
  три больших JPEG и MP4 для каждого размера 256/512/1024. Проверяются JPEG,
  MD5 результата и неизменность исходников, без молчаливых пропусков ошибок.
* Benchmarks analyze — чисто. Standalone probe компилируется с backend package
  config: image — его существующая dev-зависимость, поэтому Flutter-анализатор
  benchmarks исключает этот файл аналогично browser probe.

Из корня репозитория:

```sh
dart compile exe --packages=backend/.dart_tool/package_config.json \
  benchmarks/tool/ffmpeg_thumbnail_compat.dart -o /tmp/ffmpeg-thumbnail-compat
/tmp/ffmpeg-thumbnail-compat benchmarks/assets/media
# Без аргумента запускаются только создаваемые alpha/EXIF/GIF/tiny fixtures.
```

Для локального повтора в Debian 12 можно запустить тот же x64 probe в одноразовом
контейнере (FFmpeg устанавливается только внутри этого контейнера):

```sh
docker run --rm \
  --mount type=bind,src=/tmp/ffmpeg-thumbnail-compat,dst=/compat,readonly \
  --mount type=bind,src="$PWD/benchmarks/assets/media",dst=/media,readonly \
  debian:bookworm-slim sh -c \
  'apt-get update -qq && apt-get install -y -qq --no-install-recommends ffmpeg && ffmpeg -version && /compat /media'
```

Прежний фильтр для воспроизведения SIGSEGV — приведённая выше строка RGBA
`drawbox replace=1`; остальные аргументы остаются как в production worker.
Проба при возврате этой ошибки падает на alpha fixture. Для arm64 нужен probe,
собранный arm64 Dart SDK; x64 бинарник на RaPi не переносить.

`raspi-filter.json` и `raspi-photo.json` сохраняют ответы SSH-проверки;
`validation/` — результаты native probes и тестов. Report хранится в Git,
локальные логи и артефакты остаются ignored. Созданный контейнер остановлен
и удалён; кэшированный базовый образ не меняет окружение фоторамки.
