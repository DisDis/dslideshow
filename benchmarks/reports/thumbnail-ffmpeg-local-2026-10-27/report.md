# Миниатюры через FFmpeg: локальная проверка 27.10.2026

Исторический этап с probe/RGBA/encode. Следующая реализация и новые проверки:
[один FFmpeg, JPEG и thumbnail](../thumbnail-jpeg-local-2026-10-27/report.md).

Переход реализован в backend: `FfmpegThumbnailWorker` заменяет isolate на запрос.
Основные backend/web/OTA isolates сохранены. По последнему указанию пользователя
`maxWorkers=4`, очередь 8 и до 32 ожидающих потребителей; одинаковые запросы
объединяются. Обратная совместимость с прежними миниатюрами не нужна: policy 2
создаёт новые производные по спросу, старые вытесняются LRU без миграции.
[Production-поведение и лимиты](../../../doc/gallery.md).

Все проверки этого этапа локальные. RaPi4/5, прошивка, ОС и рабочая служба
не использовались и не менялись. Результат не является аппаратной приёмкой
или измерением ускорения эффектов.

## Условия

Linux x64, Intel Core i7-9750H, Dart 3.13.5 AOT release; FFmpeg/ffprobe
8.0.1-3ubuntu2. Один и тот же HTTP harness и оригиналы; каталог 1000 metadata-only
записей плюс четыре настоящих JPEG: photo_a, photo_b, photo_large (8000×6000)
и побайтовая копия photo_large под другим именем, чтобы получить четыре разные
thumbnail identity. Источники не уменьшались и не перекодировались.
OS cache прогрет при создании fixture, backend cache в начале каждого свежего
процесса пустой. Три свежих процесса на сторону и bucket, четыре параллельных
холодных запроса в каждом: 12 измерений задержки на строку/сторону.

Baseline заморожен до production-правок: Dart image 4.12 + isolate,
`maxWorkers=1`, policy 1, JPEG quality 88. Candidate: FFmpeg pipeline,
`maxWorkers=4`, policy 2, mjpeg qscale 2 / yuvj444p, resize area.
Изменены и codec, и степень параллелизма; измерение включает оба изменения.
Чистый вклад одного FFmpeg этим сравнением не выделен. JPEG quality 88 и
qscale 2 являются разными шкалами.

Сначала выполнен candidate 256, затем baseline 256, candidate 512, baseline 512,
candidate 1024, baseline 1024. Старые `confirmed`/`compare-256` сохранены отдельно;
в таблице используются только серии `four-workers-*` с одинаковым финальным
Python runner. Сборки и unit-тесты не выполнялись параллельно этим сериям.

## Холодная генерация: baseline / candidate

| Размер | Медиана партии из 4, мс | p95 запроса, мс | Медиана CPU дерева на партию, мс | Максимум sampled sum RSS, MiB | Байты четырёх JPEG |
| --- | --- | --- | --- | --- | --- |
| 256 | 1480 / 444 | 1559 / 466 | 1560 / 1550 | 67.0 / 272.0 | 145007 / 184999 |
| 512 | 2741 / 374 | 2764 / 402 | 2880 / 1330 | 61.0 / 276.6 | 488607 / 584501 |
| 1024 | 5998 / 426 | 6110 / 436 | 6260 / 1600 | 78.9 / 319.6 | 1616424 / 1851316 |

p95 при 12 измерениях по nearest-rank совпадает с максимумом; это малый
локальный набор, не оценка длинных хвостов production-нагрузки. Полученные
ускорения относятся к этим фото и рабочей машине. RSS candidate выше: у него
до четырёх одновременно работающих native процессов. Сумма RSS включает shared
pages повторно и снимается примерно каждые 10 мс; это не точная физическая память,
не PSS и не истинный peak. В CPU включены завершившиеся дети через cutime/cstime;
показатель `cpu_ms` в raw по-прежнему относится только к backend-процессу.

Всего в финальных сериях нет HTTP/`/info` ошибок, после каждого group — ноль
дочерних процессов. Наблюдались до пяти процессов суммарно (backend + 4), до
54 FD и 27 потоков дерева; отдельные decoder/filter/encoder ограничены 1,
служебные потоки CLI/runtime учитываются дополнительно. Максимальная задержка
`/info` во время холодного candidate — 5.3 мс; это HTTP proxy отзывчивости,
не WebSocket/RPC, Flutter FrameTiming или проверка эффектов. Cold/warm,
HEAD/ETag/Range, отмена тела и завершение сервера проверялись тем же harness;
их полные результаты находятся в raw, без подстановки нулей вместо ошибок.

## Качество и поведение

Сохранены 18 производных: три разных оригинала × 256/512/1024 × две стороны
в `quality/`, их SHA-256/размеры — в `quality/results.json`. Размеры результатов
проверены независимым Pillow, SHA-256 оригиналов проверен до/после каждого вызова.
Визуально просмотрен `quality/comparison.jpg` (512 px): геометрия и цветовые
поля на контрольных изображениях соответствуют, заметного повреждения нет;
байты, мелкие детали и размеры файлов закономерно отличаются. Это ограниченный
синтетический набор, не доказательство равного качества на произвольной фототеке.

Backend-тесты отдельно проверяют все 8 EXIF rotations/mirrors до crop,
нечётные/малые/однопиксельные оригиналы, первый GIF-кадр, статический WebP,
actual alpha / opaque alpha / прозрачность вне crop, отказ прозрачного JPEG,
лимиты входа/пикселей/выхода, рост источника, отсутствующие executable, общий
deadline, отмену внутри Process.start, заблокированный stdin, переполнение
stdout/stderr, TERM→KILL, закрытие FD и shutdown без поздней публикации.
Отдельный тест подтверждает 4 активных / 8 queued и отказ тринадцатой задачи.

## Проверки

* Backend: `dart analyze` — чисто; `dart test --concurrency=1` — 409 прошли.
* config_app: 300 unit/widget-тестов прошли, release Web build прошёл;
  анализатор сообщил 5 существующих info в неизменённых auth/login/power bloc.
* dslideshow_flutter: 106 тестов прошли; анализатор сообщил 7 существующих info
  в неизменённых меню/theme/background_to_foreground_effect.
* Benchmarks: Flutter analyzer — чисто; 9 Python HTTP/provenance/resource тестов прошли.
* DEB: 26 Python-тестов прошли, fixture package подтверждает Depends: ffmpeg;
  финальная прошивка не собиралась, версии не увеличивались.

`image` оставлен только в backend dev_dependencies для fixtures/независимого
декодирования. Lock backend поменял только классификацию image; у frontend и
benchmarks штатный offline pub удалил image/archive/posix. Другие версии не
обновлялись. `config_app` сохраняет image через независимую зависимость панели;
из backend runtime этот пакет удалён (панель использует image через media_kit).

## Артефакты и повтор

Локально сохранены `baseline/` и `candidate/`: source.tar.gz, source manifest,
package config, provenance, AOT binary/build metadata, frozen harness; под
`execution/four-workers-{256,512,1024}/` — параметры, summary и сырые выборки
со всеми телами/ресурсами. `comparison.json` сводит холодные серии. README
отслеживается Git, большие локальные архивы/медиа/бинарники остаются ignored.

* baseline AOT: `a31f305a91c01ac16fba35d4e97d1eae1592dcf18337c0300003ad87c4d02501`; source archive SHA-256: `0154b9cd6f1a19b19621f82576818e2e1cd3cba7bf5ca115695f3d6041dc4aa1`.
* candidate AOT: `61079483c566cdea565c8c210d6a25adcc7148cfc5bfa31ee42d70cc9ea0f15b`; source archive SHA-256: `d64803f32070aadcd4aa42f018744183b426bb1119568f07b11115e16440016b`.

Из корня checkout с сохранёнными локальными snapshot (новый `--run-name` каждый раз):

```sh
# Для baseline повторить с --variant baseline; для остальных размеров — --bucket.
python3 benchmarks/tool/gallery_http.py --reuse-binary --variant candidate \
  --output benchmarks/reports/thumbnail-ffmpeg-local-2026-10-27 \
  --run-name repeat-256 --bucket 256 --cold-concurrency 4 \
  --sizes 1000 --concurrency 1,4 --requests 8 --repeats 3 \
  --media benchmarks/assets/media/photo_a.jpg \
  --media benchmarks/assets/media/photo_b.jpg \
  --media benchmarks/assets/media/photo_large.jpg \
  --media benchmarks/reports/thumbnail-ffmpeg-local-2026-10-27/fixtures/photo_large_copy.jpg
```

Из чистого checkout нужен новый experiment dir и baseline, замороженный до
изменения кода: команды `--freeze-current` описаны в [README стенда](../../README.md).
Побайтовую четвёртую копию сделать из того же photo_large, сохранить SHA-256.
Probe текущего worker компилируется с backend package config:

```sh
dart compile exe --packages=backend/.dart_tool/package_config.json \
  benchmarks/tool/gallery_thumbnail_probe.dart -o /tmp/ffmpeg-thumbnail-probe
/tmp/ffmpeg-thumbnail-probe benchmarks/assets/media/photo_large.jpg 1024 /tmp/thumbnail-1024.jpg
```

Для будущего аппаратного сравнения перенести frozen snapshot/harness/оригиналы,
проверить сопоставимость SDK и FFmpeg/кодеков и выполнить те же серии 256/512/1024
с новым output. Команды A/B и [правила RaPi5](../../../doc/raspberry-pi-benchmarks.md)
сохранены, автоматического подключения/прогона нет. UI/эффекты под нагрузкой
требуют отдельного согласованного сценария OpenGL; сейчас его не запускали.
