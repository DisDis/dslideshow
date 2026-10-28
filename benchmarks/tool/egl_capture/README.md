# Захват экранного EGL backbuffer для проверки raster cache

Это отдельный диагностический interposer для OpenGL. Он читает настоящий FBO0
перед `eglSwapBuffers`, после отрисовки обычного Flutter-кадра, включая применённый
движком raster cache. `RenderRepaintBoundary.toImage` создаёт отдельный захват и
сам по себе не подтверждает совпадение закешированных экранных текстур.

Захват проверяет GL backbuffer, **не физический scanout**. Последующие KMS, панель,
цветовые преобразования дисплея и фактическое появление кадра на экране им не
проверяются. Interposer используется только для качества. `glReadPixels`, запись
файлов и барьеры меняют нагрузку; результаты FPS/latency с ним недействительны.
Для измерений производительности запускайте исходный runtime без `LD_PRELOAD`.

## Сборка и подключение

Нужны уже установленные `gcc`, `pkg-config`, заголовки и библиотеки EGL/GLES2;
скрипт ничего не устанавливает и не изменяет runtime, ОС или драйверы.
Собирать библиотеку следует на той архитектуре, где будет запуск.

```sh
# Из benchmarks/; на RaPi5 выполнить после завершения активных измерений.
tool/egl_capture/build.sh
# По умолчанию: build/egl_capture/libegl_capture.so.
# Другой путь можно передать единственным аргументом build.sh.
```

`run.sh` поддерживает `--flutter-pi FILE` и передаёт wrapper все аргументы.
После ручного визуального принятия эффектов временный pixel-comparison target
и его original/reference-копии удалены из рабочих исходников. Завершённый target
доступен из сохранённых [release/source архивов](../../reports/effect-performance-2026-10-28/corrected-harness/egl-pixels-painted-bootstrap/):
`release-package.tar.gz`, `sources.tar.gz`, `build-info.json` и `bundle.sha256`.
Нативная instrumentation и Dart helper `lib/src/egl_backbuffer_capture.dart`
остаются универсальными средствами IPC; их наличие не создаёт нового audit target.
Не пересобирайте удалённый entrypoint из текущего checkout. Для повторения
завершённой проверки сначала распакуйте сохранённый release-пакет, затем передайте
его `bundle/`:

```sh
BENCHMARK_PIXEL_CAPTURE_BACKEND=eglBackbuffer \
  ./run.sh --renderers opengl --bundle /path/to/pixel-bundle \
  --flutter-pi "$PWD/tool/egl_capture/flutter-pi-capture.sh" \
  --output "$PWD/reports/egl-pixels" --timeout 7200
```

GPU/дисплей требует обычной остановки фоторамки и supervisor с восстановлением
службы, описанных в [аппаратном руководстве](../../../doc/raspberry-pi-benchmarks.md).
Эта команда не останавливает и не восстанавливает службу самостоятельно.

Wrapper по умолчанию исполняет `/opt/dslideshow/flutter-pi` и подгружает
`benchmarks/build/egl_capture/libegl_capture.so`. Переопределения:

* `BENCHMARK_EGL_REAL_RUNTIME` — настоящий исполняемый runtime;
* `BENCHMARK_EGL_CAPTURE_LIBRARY` — собранная библиотека interposer;
* `BENCHMARK_EGL_CAPTURE_DIR` — каталог IPC, по умолчанию
  `$BENCHMARK_OUTPUT/egl-capture` текущей попытки.

Аргументы и код завершения настоящего runtime сохраняются. Vulkan отвергается.
Wrapper оставляет приоритет bundle/engine в `LD_LIBRARY_PATH` и добавляет каталог
настоящего runtime последним fallback. Существующий `LD_PRELOAD` сохраняется после
библиотеки захвата и записывается в provenance.

В каждой попытке атомарно создаётся `egl-capture/runtime-provenance.json`:
пути и SHA-256 настоящего runtime, interposer и wrapper, аргументы, каталог IPC,
эффективный `LD_LIBRARY_PATH` и отметка `timing_results_valid=false`. Штатный `launch.json` содержит SHA wrapper;
реальный бинарник следует проверять именно по `runtime-provenance.json`.

При первом входе в настоящий swap interposer дополнительно атомарно пишет
`capture-runtime.json` **до первого barrier ack**. В нём `schema_version=1`,
`kind="egl_capture_loaded_runtime"`, PID процесса, `engine.path`, `engine.sha256`,
`engine.mapped_inode`, `effective_ld_library_path` и
`captured_on="first_eglSwapBuffers_entry"`. Путь engine определяется через
`dl_iterate_phdr` среди действительно загруженных `libflutter_engine.so*`,
затем inode/device сверяются с `/proc/self/maps`; подмена файла по старому пути
не принимается за загруженный engine. Файл хешируется встроенной SHA-256 без
внешних процессов и новых библиотек; size/mtime/ctime проверяются до и после чтения.
Отсутствующий, неоднозначный или изменённый engine проваливает IPC-проверку.
Получать hash поиском по `LD_LIBRARY_PATH` вместо этого доказательства нельзя.
Сохранённый audit-клиент с backend `eglBackbuffer` выполняет один bootstrap barrier до подготовки фото,
читает и валидирует оба provenance JSON, затем сохраняет их в metadata
`native_capture_provenance` / `native_capture_loaded_runtime`. Проверяются schema/kind, PID, SHA-256 и тип
эффективного `LD_LIBRARY_PATH` фактически загруженного engine. Первое однократное хеширование не является измерением FPS.

Текущий исходный flutter-pi вызывает `eglSwapBuffers` напрямую из
`src/egl_gbm_render_surface.c`; проверенный локальный ELF имеет неопределённый
динамический символ `eglSwapBuffers` и зависимости `libEGL.so.1`/`libGLESv2.so.2`.
На другом runtime механизм загрузки должен быть проверен заново. Таймаут IPC
при отсутствии перехвата означает ошибку проверки, а не успешный захват.

## Протокол IPC v1

Есть один клиент и не более одного незавершённого запроса. ID — строго возрастающий
положительный `uint64`; клиент может начинать с UTC microseconds, чтобы не принять
ack предыдущего процесса. Запрос сначала записывается в отдельный временный файл,
затем атомарно переименовывается в `request` внутри capture-каталога.

| Содержимое `request` | Действие |
| --- | --- |
| `123\n` | Захват следующего backbuffer перед swap. |
| `124 barrier\n` | Следующий настоящий swap без readback и без большого буфера. |

Здесь `\n` обозначает настоящий перевод строки. В запросах нет произвольных путей,
размеров или JSON. Процесс атомарно забирает `request` в `request.active`; ID,
размер файла, суффикс и регулярность файла проверяются. Символические ссылки на
payload не разыменовываются. Старый raw с тем же ID не перезаписывается.

Для проверки cache при движущейся анимации клиент последовательно выводит три
соседние фазы: обычно `target−0.03`, `target−0.02`, `target−0.01`; для нуля —
`0.03`, `0.02`, `0.01`, а около нуля интервалы сокращаются, сохраняя разные фазы
в диапазоне `[0, 1]`. Перед каждым изменением дерева он публикует `barrier`,
монтирует следующую фазу с тем же ключом case/variant и ждёт ack настоящего swap.
Затем публикует capture и впервые монтирует целевую фазу. Фотографии и их
статические filter/boundary-слои сохраняются между соседними кадрами; меняющиеся
преобразования и смешивание не позволяют подменить проверку прогревом полностью
неподвижного эффекта. Внешний capture `RepaintBoundary` в этом режиме отсутствует.
В metadata и отдельных capture receipts записаны соседние фазы, номера swap и
`target_first_swap=true`; путь `toImage` сохраняет прежний статический прогрев.

До первого native barrier клиент ждёт `waitUntilFirstFrameRasterized`, затем
публикует запрос и монтирует непрозрачный кадр `Color(0xff010000)`. Это создаёт
настоящий painted display list и damage для первого swap, не затрагивая фото.
EGL viewport имеет постоянную непрозрачную чёрную подложку, как обычный стенд:
прозрачные края переходов не сохраняют цвет bootstrap-кадра. В metadata это
`egl_black_backing=true`; внешний capture boundary по-прежнему отсутствует,
а прежний путь `toImage` не меняется.
Первый аппаратный запуск с исходным пустым `SizedBox.expand()` и дополнительным
`scheduleFrame()` завершился таймаутом первого barrier через 30 секунд; sidecar
`capture-runtime.json` не появился. Engine может завершить UI/raster frame без
`eglSwapBuffers`, если сцена пуста или не изменилась. Для воспроизведения верните
пустой bootstrap и запустите тот же EGL target через wrapper; отсутствие sidecar
и ack нельзя трактовать как успешную проверку. Для повторной аппаратной проверки
исправления ожидаются успешный bootstrap ack и loaded-runtime sidecar до первого
case. Пороговые допуски и все последующие запросы остаются прежними.

Пустой кадр между case подтверждается совпадением номера `FrameTiming.frameNumber`
с `PlatformDispatcher.frameData.frameNumber`, сохранённым в post-frame callback
этого кадра. Подписка на timings начинается до его монтирования; ожидание
ограничено 30 секундами. Это подтверждает завершение raster thread для указанного
кадра; `endOfFrame` сам по себе такого подтверждения не даёт. Отсутствие
совпадающего timing — ошибка, даже если пришёл timing более позднего кадра.
Связь raster finish со swap зависит от runtime: в проверенных локальных исходниках
flutter-pi `eglSwapBuffers` вызывается синхронно внутри `PresentLayers` до
`RecordRasterEnd`. Для другой реализации с отложенным present этот порядок
проверяют отдельно. `target_first_swap` сохранённого audit описывает эту схему
клиента; отдельного пиксельного frame-ID marker в нём нет.

`ack.json` публикуется атомарно **после возврата настоящего `eglSwapBuffers`**.
До публикации удаляется `request.active`, поэтому ack означает полное завершение
предыдущего запроса. Старый ack разрешено оставлять до появления совпадающего ID.

```json
{
  "schema_version": 1,
  "id": 123,
  "request_id": 123,
  "swap_index": 17,
  "kind": "capture",
  "status": "ok",
  "error": null,
  "file": "frame-123.rgba",
  "width": 2560,
  "height": 1600,
  "stride": 10240,
  "bytes": 16384000,
  "format": "RGBA8888",
  "row_order": "top_to_bottom",
  "origin": "top-left",
  "framebuffer": 0,
  "read_framebuffer": 0,
  "gl_error": 0,
  "native_errno": 0,
  "swap_success": true,
  "source": "egl_backbuffer_before_swap"
}
```

Для `kind="barrier"`: `file=null`, `bytes=0`; остальные сведения о поверхности
сохраняются. `swap_index` увеличивается на каждом перехваченном вызове swap,
включая обычные кадры, и должен возрастать между ответами клиента.

Клиент проверяет ID, schema, kind/status, размеры, stride, формат, row order,
FBO0, `gl_error=0`, успешность swap, source и точный размер raw. После чтения
удаляет raw и принятый ack; `request.active` принадлежит interposer. Любая ошибка
или таймаут должны проваливать pixel-проверку. Обычный таймаут клиента — 30 секунд.

## Что делает и сохраняет interposer

На запросе проверяются текущие EGL display/context, совпадение **обоих**
EGL draw/read surface с переданным в swap и размер 2560×1600.
В GLES3 дополнительно проверяются read FBO0, `GL_BACK`, отсутствие pixel pack
buffer и стандартные row length/skip. Нестандартное состояние даёт error ack;
состояние GL не перестраивается под захват. RGBA8 stride 10240 кратен всем
допустимым pack alignment. Предсуществующая GL-ошибка также явно проваливает запрос
и записывается в ack/native.log вместо принятия изображения.

Только capture выделяет 16 384 000 байт, вызывает `glReadPixels` с
`GL_RGBA/GL_UNSIGNED_BYTE`, меняет порядок строк с bottom-left на top-left и
освобождает буфер после записи. Readback синхронизирует предшествующую GPU-работу.
Raw сначала полностью записывается и синхронизируется, затем публикуется атомарно
без замены существующего файла (hard link и удаление временного имени).

Без запроса после однократной инициализации нет readback, GL-запросов состояния
и выделения heap-буфера: остаются проверка mutex и поиск `request` через rename.
Interposer держит один directory FD до завершения процесса; все FD запросов/raw/ack
закрываются. Исходный результат `eglSwapBuffers` возвращается вызывающему коду.
Его EGL error не считывается и не скрывается; неуспешный swap даёт error ack.

## Локальные проверки без GPU

```sh
# Из benchmarks/:
PYTHONDONTWRITEBYTECODE=1 python3 tool/egl_capture/test_protocol.py
bash -n tool/egl_capture/build.sh tool/egl_capture/flutter-pi-capture.sh
```

Тесты компилируют временные fake EGL/GLES и interposer с
`-Wall -Wextra -Werror`, проверяют обычные кадры без GL-readback, три последовательных
barrier, размеры и переворот RGBA, ошибки FBO/разрешения/GL, невалидные и повторные ID,
сохранение имеющегося raw, реальный неуспех swap, аргументы wrapper, draw/read
surface mismatch, загруженный engine и SHA provenance. SHA-256 сверяется с
`hashlib` на границах padding/block, отсутствие загруженного engine даёт ошибку.
Они не открывают DRM, EGL display или драйвер и не заменяют аппаратный pixel-прогон.
