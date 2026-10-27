# Один FFmpeg, JPEG и thumbnail: локальная проверка 27.10.2026

Реализован единый путь фото/анимаций/видео: один FFmpeg читает локальный файл,
учитывает EXIF, вырезает центральный квадрат, уменьшает без upscale, накладывает
прозрачность на фон, выбирает кадр фильтром `thumbnail` и выдаёт JPEG.
`ffprobe`, определение demuxer и промежуточный RGBA в Dart удалены.
Основные backend/web/OTA isolates сохранены. [Настройки и API](../../../doc/gallery.md).

Все проверки локальные. Устройство, ОС, прошивка и рабочая служба не изменялись.
Результат не является аппаратной приёмкой или подтверждением ускорения на RaPi.

## Условия сравнения

Linux x64, Intel Core i7-9750H, Dart 3.13.5 AOT release, FFmpeg 8.0.1-3ubuntu2.
Baseline заморожен до этих изменений: предыдущий probe → FFmpeg RGBA → FFmpeg
encode, четыре workers, JPEG qscale 2 / yuvj444p, decoder lowres для JPEG.
Candidate-final — текущий исходный код: один FFmpeg, JPEG quality 60 → qscale 14,
yuvj420p, frameSelectionFrames=30, фон #202020, четыре workers, MD5 digest.
Обратная совместимость с прежними производными не нужна, используется policy 3
и hash настроек в URL/ключах. Качество, subsampling и способ decode изменились
вместе; сравнение не выделяет эффект одного удаления subprocess.

Одинаковый HTTP harness и четыре оригинала: photo_a 4032×3024, photo_b 6000×4000,
photo_large 8000×6000 и его побайтовая копия под другим именем для четвёртой
identity. Никакого уменьшения/перекодирования исходников. В каждом свежем
процессе — 1000 metadata-only записей и эти четыре файла; backend thumbnail
cache пустой, OS page cache прогрет созданием fixture. По три свежих процесса
на вариант/сторону, четыре параллельных cold-запроса в каждом: 12 задержек.
Порядок: baseline/candidate-final 256, затем 512, затем 1024. Полные тесты и
компиляции не выполнялись параллельно финальной серии `final-*`.
Ранние `baseline-512` и `four-workers-*` сохранены отдельно и в таблицу не входят.

## Холодная генерация: baseline / candidate-final

| Размер | Медиана партии из 4, мс | p95 запроса, мс | Медиана CPU дерева на партию, мс | Максимум sampled sum RSS, MiB | Байты четырёх JPEG |
| --- | --- | --- | --- | --- | --- |
| 256 | 404 / 401 | 442 / 447 | 1480 / 1170 | 273.5 / 623.5 | 184999 / 16295 |
| 512 | 366 / 415 | 396 / 419 | 1320 / 1240 | 276.5 / 655.0 | 584501 / 73260 |
| 1024 | 481 / 426 | 485 / 575 | 1780 / 1330 | 330.1 / 663.1 | 1851316 / 333283 |

Малый набор не показывает устойчивого общего выигрыша по времени. Выходные
JPEG меньше на 82–91%, но это также результат более низкого качества и 4:2:0.
Память заметно выросла: вместо JPEG lowres декодируется полный native-кадр.
Сумма RSS включает shared pages повторно, снимается примерно каждые 10 мс
и не равна PSS/истинному пику. Максимум candidate 663.1 MiB против 330.1 MiB
baseline; это существенный компромисс текущего простого конвейера.
Pixel/input/output limits не являются глобальным пределом памяти. Для
анимации/видео добавляется буфер группы уже уменьшенных кадров; эти данные
производительности относятся только к фото, не к длительности видео.

p95 по nearest-rank при 12 запросах совпадает с максимумом; длинные хвосты
production не оценивались. CPU включает reaped children через cutime/cstime.
HTTP/`/info` ошибок нет, после групп не остаётся дочерних процессов. Candidate
достигал 5 процессов (backend + 4 FFmpeg), 49 FD и 25 потоков дерева; лимит
codec/filter=1 не исключает служебные потоки runtime. Максимальная задержка
`/info` — 9.94 мс, sampled event-loop lateness — 8.96 мс. `/info` — HTTP proxy
отзывчивости, не RPC и не FrameTiming интерфейса. Старый pipeline имел до 54 FD
и 28 потоков. Тёплые запросы, validators, оригиналы и socket cancel также
проверены HTTP harness; сырые результаты сохраняют все отдельные группы.

## Функциональные проверки

* Backend: анализатор чистый, полный набор 418 тестов прошёл. После финального
  ревью повторены регрессии изменённых маршрутов/кеша/кодека/конфигурации.
* Common: анализатор чистый, 12 тестов прошли. JsonSerializable-файлы обновлены
  build_runner. Конфигурация использует enum names, catalog сохраняет numeric enum.
* Config_app: 304 теста и release Web build прошли; анализатор показывает
  5 прежних info в неизменённых auth/login/power bloc.
* Dslideshow_flutter: 106 тестов прошли; анализатор показывает 7 прежних info
  в неизменённых меню/theme/background_to_foreground_effect.
* Benchmarks: анализатор чистый, 9 Python HTTP/resource/provenance тестов прошли.
* DEB: 26 Python-тестов прошли. Финальный DEB не собирался, версии не менялись.

Native codec-тесты не пропускаются при отсутствии FFmpeg. Проверены все восемь
EXIF rotations/mirrors, центр и отсутствие upscale, tiny/odd JPEG/PNG/WebP,
прозрачность 0/128/255 и иной фон, изменение качества, GIF и seekable MOV с
представительным кадром вместо первого, изменение размера начальной группы,
повреждённые/крупные источники, bounded stdout/stderr, отсутствующий executable,
Process.start race, timeout/TERM→KILL, shutdown и освобождение слота после cleanup.
MD5 проверяется по JPEG, используется как ETag и checksum при восстановлении
кеша; повреждённый кеш пересоздаётся, прежние производные удаляются.

HTTP/клиентские регрессии проверяют configured enum buckets и фон, лимит файловых
тел, смену URL/cache key после render settings при прежней identity оригинала,
409 для старого каталога даже после удаления его bucket, отсутствие native video
controller до нажатия и JPEG-постер на платформе без плеера.
Набор `gallery` применяется после перезапуска рамки. Автоматического прогрева
всей медиатеки нет. SHA-256 коротких ключей источника/параметров сохранён.

## Артефакты и повтор

Локально сохранены source.tar.gz, source manifest/provenance, package config,
AOT binary/build metadata, frozen harness/runner в `baseline/`, `candidate/`
(ранний) и `candidate-final/` (финальный). `execution/final-{256,512,1024}/`
содержит run.json, summary и raw.json каждого свежего процесса.
`comparison.json` сводит таблицу; `fixtures/` содержит четвёртую копию исходника,
`samples/` — JPEG-пробы и их JSON с MD5 результата/SHA-256 источника.
Логи анализаторов, тестов и Web-сборки сохранены в `validation/`. Этот report.md
хранится в Git; большие локальные артефакты остаются ignored.

* Baseline AOT: `27c3d34271d0e4a222b0b97c617a9585d12114179499eee6a56166fc18a7fb87`;
  source archive SHA-256: `859042c523c3ef8114fbc317159993703d614cd90bc81ca0a7c6d629a2a5dd37`.
* Candidate-final AOT: `8f3bf20ae533f3debca3df2b51bc92ccf73a42919e43b7423ec3db1a7aacb785`;
  source archive SHA-256: `25e1f0f077f70e14e59e794ca4140e5d5652fc63032eb1ff3b440b2693ae6e4b`.

Из корня с сохранёнными snapshot, новый `--run-name` на каждый запуск:

```sh
# Для baseline заменить --variant; для других размеров — --bucket.
python3 benchmarks/tool/gallery_http.py --reuse-binary --variant candidate-final \
  --output benchmarks/reports/thumbnail-jpeg-local-2026-10-27 \
  --run-name repeat-256 --bucket 256 --cold-concurrency 4 \
  --sizes 1000 --concurrency 1,4 --requests 8 --repeats 3 \
  --media benchmarks/assets/media/photo_a.jpg \
  --media benchmarks/assets/media/photo_b.jpg \
  --media benchmarks/assets/media/photo_large.jpg \
  --media benchmarks/reports/thumbnail-jpeg-local-2026-10-27/fixtures/photo_large_copy.jpg

dart compile exe --packages=backend/.dart_tool/package_config.json \
  benchmarks/tool/gallery_thumbnail_probe.dart -o /tmp/gallery-thumbnail-probe
/tmp/gallery-thumbnail-probe benchmarks/assets/media/video_a.mp4 256 /tmp/video-poster.jpg
```

Из чистого checkout сначала нужен baseline до изменения кода и новый experiment
dir (`--freeze-current`), как описано в [README стенда](../../README.md).
Для будущей аппаратной проверки перенести одинаковые snapshot/harness/оригиналы
и закрепить одну сборку FFmpeg/SDK; выполнить те же серии 256/512/1024 с новым
output. Следовать [правилам RaPi5](../../../doc/raspberry-pi-benchmarks.md).
Аппаратный прогон и оценка эффектов под нагрузкой сейчас не запускались.
