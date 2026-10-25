# Бенчмарки и проверки на Raspberry Pi 5

Руководство для повторной проверки исправлений на настоящей фоторамке.
Сборка выполняется на рабочей Linux-машине, запуск — автоматически по SSH.
Клавиатура, мышь и нажатия на фоторамке не нужны; подключённый дисплей нужен
для аппаратного рендеринга. Описание метрик и всех наборов — в
[README стенда](../benchmarks/README.md), очередь исправлений — в
[плане эффектов](effects-work.md).

## Устройство и пути

Пути проверены на стенде 25.10.2026:

| Что | Значение |
| --- | --- |
| SSH | `pi@192.168.50.143` |
| Экран | 2560×1600, DPR 1; в проверенном режиме около 50 Hz |
| Служба фоторамки | `dslideshow` |
| Установленное приложение | `/opt/dslideshow` |
| Рабочий native runtime | `/opt/dslideshow/flutter-pi` |
| Исходники flutter-pi | `/home/pi/workspace/flutter-pi` |
| Исходная папка сборки flutter-pi | `/home/pi/workspace/flutter-pi/build` |
| Embedder header | `/home/pi/workspace/flutter-pi/third_party/flutter_embedder_header/include/flutter_embedder.h` |
| Установленный стенд | `/home/pi/workspace/benchmarks` |
| AOT и engine стенда | `/home/pi/workspace/benchmarks/bundle` |
| Аппаратные отчёты | `/home/pi/workspace/benchmarks/reports` |

Проверенный commit исходников flutter-pi:
`129b07481d7607fbc41cfe4057fa348993d36a66`. Проверенный SHA256 рабочего бинарника:
`e1b6b7d263b4cd4962770542a40f430ea3b2f4bd0fe4ed552ecf1ddcccb418b7`.
Путь к checkout не доказывает, что бинарник собран из его текущего HEAD:
фиксируйте оба идентификатора при диагностике.

`/home/pi/workspace/benchmarks/native/` содержит отдельные экспериментальные
копии/сборки предыдущего расследования. Рабочая служба их не использует;
не выбирайте их вместо `/opt/dslideshow/flutter-pi` по умолчанию.

**В обычной проверке эффектов ОС, драйверы и прошивку не обновляем, flutter-pi
не меняем и не переустанавливаем. 24-часовой тест отложен.** Пользователь отдельно
разрешил исправления видео и испытание отдельной OpenGL-сборки flutter-pi;
[эта работа](../benchmarks/reports/flutter-pi-video-2026-10-25/README.md) ведётся
отдельно, а сравнения эффектов закрепляют один и тот же runtime.
Для сборки бенчмарка native runtime
пересобирать не требуется. Финальная прошивка DEB собирается отдельно через
`deb_factory/build.sh`, см. [порядок выпуска](releasing.md).

## 1. Подготовка и сборка на рабочей машине

Нужны установленный Flutter SDK, совместимый `flutterpi_tool` с поддержкой
`--cpu=pi5`, локальные зависимости backend из
[инструкции сборки](../dslideshow_flutter/README.md). На устройстве нужны Bash,
Python 3, coreutils (`timeout`, `sha256sum`), `flock`, `tar` и `rsync`.
Они используются из существующего окружения; обновление системы не является
частью подготовки стенда. Pillow/ffmpeg нужны только при пересоздании fixtures
на рабочей машине, не при обычном запуске на RaPi5.

```bash
cd /home/dis/workspace/dslideshow/benchmarks
flutter pub get
flutter analyze --no-pub
flutter test --no-pub
python3 -m unittest discover -s tool -p 'test_*.py'
bash -n run.sh build_aot_pi5.sh
./build_aot_pi5.sh
```

Скрипт выводит точное имя `build/benchmarks-pi5-release-XXXXXXXX.tar.gz`.
Рядом находится распакованный пакет
`build/package/benchmarks-pi5-release-XXXXXXXX/`: `bundle/`, `run.sh`, конфиги,
инструменты отчётов и provenance сборки. Используйте каталог **этой сборки**.
В примерах ниже замените `XXXXXXXX` на напечатанный суффикс.

Для сравнения производительности используйте release. Profile-сборка доступна
через `BENCHMARK_BUILD_MODE=profile ./build_aot_pi5.sh`, но её результаты нельзя
сравнивать напрямую с release. Pi4 требует отдельной сборки и аппаратной проверки;
результаты RaPi5 на него автоматически не распространяются.

## 2. Проверка связи и установка пакета

Wi-Fi нестабилен. Во всех SSH-командах используйте большой timeout соединения
и keepalive, в rsync — возможность продолжения передачи и `--timeout=600`.
Ниже команды выполняются на рабочей машине:

```bash
ssh -o BatchMode=yes -o ConnectTimeout=120 \
  -o ServerAliveInterval=30 -o ServerAliveCountMax=10 pi@192.168.50.143 'bash -s' <<'REMOTE'
set -euo pipefail
mkdir -p /home/pi/workspace/benchmarks
systemctl is-active dslideshow || true
sha256sum /opt/dslideshow/flutter-pi
git -C /home/pi/workspace/flutter-pi rev-parse HEAD
git -C /home/pi/workspace/flutter-pi status --short
df -h /home/pi/workspace/benchmarks
REMOTE

cd /home/dis/workspace/dslideshow/benchmarks
package_dir="$PWD/build/package/benchmarks-pi5-release-XXXXXXXX"
test -f "$package_dir/bundle/app.so"
rsync -a --checksum --partial --timeout=600 \
  -e 'ssh -o BatchMode=yes -o ConnectTimeout=120 -o ServerAliveInterval=30 -o ServerAliveCountMax=10' \
  "$package_dir/" pi@192.168.50.143:/home/pi/workspace/benchmarks/
```

Повторите rsync при обрыве. Не используйте `--delete`: на устройстве остаются
отчёты, пользовательские конфиги и исходные медиа. Разворачивайте новую сборку,
только когда предыдущий benchmark завершён; не заменяйте bundle под работающим
процессом. После переноса можно сверить `sha256sum bundle/app.so` на обеих машинах.

## 3. Запуск, независимый от SSH, с восстановлением фоторамки

`run.sh` намеренно не управляет службой. Перед GPU-прогоном нужно выполнить
`sudo -n service dslideshow stop`, после завершения/ошибки — `start`.
Два flutter-pi одновременно не могут владеть GPU и дисплеем.
Не запускайте стенд, если остановка службы не удалась.

Для нестабильной связи используйте supervisor ниже. Один раз создайте его
**на устройстве**, вставив команду в SSH-сеанс
(`ssh` с параметрами из предыдущего раздела). Он не входит в AOT и не изменяет
основное приложение. `sudo -n` должен работать без запроса пароля.
Все аппаратные запуски в этой схеме выполняйте через supervisor. Не запускайте
`run.sh` напрямую параллельно ему: блокировка supervisor защищает именно
управляемые запуски и восстановление службы между ними.

```bash
cd /home/pi/workspace/benchmarks
cat > run-managed.sh <<'BASH'
#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
job=${1:?Usage: run-managed.sh UNIQUE_JOB [run.sh arguments]}
shift
[[ "$job" =~ ^[a-zA-Z0-9_-]+$ ]] || exit 2
control="$PWD/managed/$job"
mkdir -p "$control"
child=''
restore_needed=0
stopping=0
cleanup() {
  local result=$?
  trap - EXIT
  trap '' INT TERM
  if [[ -n "$child" ]]; then
    kill -TERM "$child" 2>/dev/null || true
    wait "$child" 2>/dev/null || true
  fi
  if ((restore_needed)); then
    if ! sudo -n service dslideshow start; then
      echo 'ERROR: could not restore dslideshow' >&2
      ((result != 0)) || result=1
    fi
  fi
  printf '%s\n' "$result" > "$control/exit-code"
  rm -f "$control/pid"
  exit "$result"
}
stop() {
  stopping=1
  if [[ -n "$child" ]]; then kill -TERM "$child" 2>/dev/null || true; fi
}
# Отдельная блокировка: run.sh сам использует другой launcher lock.
exec 8>"$PWD/managed-supervisor.lock"
flock -n 8 || { echo 'Another managed run is active' >&2; exit 2; }
[[ ! -e "$control/started-utc" ]] || { echo 'Use a new job name' >&2; exit 2; }
trap cleanup EXIT
trap stop INT TERM
printf '%s\n' "$$" > "$control/pid"
printf '%q ' "$@" > "$control/arguments"
date -u +%Y-%m-%dT%H:%M:%SZ > "$control/started-utc"
((stopping == 0)) || exit 130
restore_needed=1
sudo -n service dslideshow stop
((stopping == 0)) || exit 130
./run.sh "$@" &
child=$!
if ((stopping)); then kill -TERM "$child" 2>/dev/null || true; fi
code=0
wait "$child" || code=$?
if ((stopping)); then wait "$child" 2>/dev/null || true; code=130; fi
child=''
printf '%s\n' "$code" > "$control/benchmark-exit-code"
exit "$code"
BASH
chmod +x run-managed.sh
bash -n run-managed.sh
```

Запуск короткой проверки всех эффектов на фото в OpenGL:

```bash
cd /home/pi/workspace/benchmarks
job="$(date -u +%Y%m%dT%H%M%SZ)-visual"
mkdir -p "managed/$job"
nohup ./run-managed.sh "$job" --config config/visual.json --renderers opengl --timeout 3600 \
  > "managed/$job/launcher.log" 2>&1 < /dev/null &
printf '%s\n' "$job" > managed/latest-job
```

Можно отключиться от SSH: supervisor продолжит работу. Каждый следующий запуск
получает новое имя `job`. После окончания служба фоторамки запускается снова;
`managed/JOB/exit-code` появляется **после** попытки восстановления.
`benchmark-exit-code` хранит результат самого стенда. Если восстановление службы
не удалось, это отдельно видно в `launcher.log`, общий код будет ненулевым.

### Статус и остановка

После повторного SSH-входа на устройстве:

```bash
cd /home/pi/workspace/benchmarks
job=$(cat managed/latest-job)
tail -n 60 "managed/$job/launcher.log"
if [[ -f "managed/$job/exit-code" ]]; then
  cat "managed/$job/exit-code"
else
  ps -p "$(cat "managed/$job/pid")" -o pid,etime,args
fi
systemctl is-active dslideshow || true
```

Для непрерывного наблюдения — `tail -f "managed/$job/launcher.log"`; Ctrl+C
останавливает только просмотр. Для штатной остановки **активного** прогона:

```bash
kill -TERM "$(cat "managed/$job/pid")"
```

Supervisor передаст TERM launcher, дождётся завершения, упаковки отчёта и
восстановит службу. Это может занять время: timeout даёт зависшему engine
30 секунд перед KILL, затем ещё требуется упаковка. Не запускайте фоторамку
вручную, пока тестовый flutter-pi не завершён. После SIGKILL supervisor или
перезагрузки trap не работает: сначала убедитесь по `ps -eo pid,args`, что
стенд больше не работает, затем восстановите `sudo -n service dslideshow start`.

Коды `run.sh`: 0 — успешная приёмка выбранного набора с допустимыми
`unsupported`; 2 — ошибки/неполная приёмка; 130 — прерывание. Не судите об успехе
по одному коду завершения engine: важны также ошибки и coverage в общем отчёте.

## 4. Какой набор запускать при исправлениях

Следующие примеры выполняются на устройстве после создания supervisor. Сохраняйте
ту же схему `job`/`mkdir`/`nohup` из раздела 3, заменяя аргументы `run.sh`.

| Изменение / задача | Проверка |
| --- | --- |
| Сборка, запуск, конфиг, сбор телеметрии | `--suite smoke --renderers opengl --timeout 3600` |
| Эффекты, clipping/transform, полигональные артефакты | `--config config/visual.json --renderers opengl --timeout 3600` и просмотр `visual-report.html` |
| Общие изменения, влияющие на производительность | `--suite standard --renderers opengl --timeout 21600`, baseline и candidate в одинаковых условиях |
| Уточнение одного пути/эффекта | Свой JSON с `--config /полный/путь.json`; примеры ниже |
| Подготовка больших оригиналов | `large-photo` и `photo-photo`, затем реальные фото через `BENCHMARK_MEDIA_DIR` |
| Жизненный цикл видео | `photo-video`, `video-photo`, `video-video` в OpenGL, отдельно от фото |

`--timeout` — предел **для каждого renderer**, не длительность всего набора.
`standard` содержит 486 сценариев, один прогрев и три измерения. По умолчанию
запускается только OpenGL. При будущем явном выборе Vulkan без видеоподдержки
будут пропущены 237 видеосценариев до создания плеера; останутся 249 поддерживаемых.
OpenGL video→video сейчас имеет известные native-падения: полный проход может
продолжаться с новыми процессами, но такие случаи остаются ошибками в отчёте.
Не используйте полный проход как утверждение о стабильности текущего runtime.

### Точечная проверка эффекта и производительности

Создайте на устройстве `config/local-effects.json`:

```json
{
  "suite": "standard",
  "effects": ["Baseline", "Cube", "Mosaic", "MosaicFade"],
  "media_cases": ["photo-photo", "large-photo"],
  "warmups": 1,
  "repeats": 3,
  "grids": [100, 150, 200],
  "backends": ["canvas", "shader"],
  "capture_frames": false
}
```

Аргументы supervisor: `--config config/local-effects.json --renderers opengl
--timeout 7200`. Имена эффектов берутся из
[`Effect`](../dslideshow_flutter/lib/src/effect/effect.dart), поля JSON — из
[`BenchmarkConfig`](../benchmarks/lib/src/config.dart). Неизвестные имена и поля
отклоняются. При фильтрации standard намеренные stall-сценарии добавляются только
для выбранных эффектов/медиа, которым они соответствуют.

### Воспроизведение OpenGL video→video без правок native

Создайте `config/local-video.json`:

```json
{
  "suite": "smoke",
  "effects": ["Baseline", "Cube", "Fade", "Blinds"],
  "media_cases": ["video-video"],
  "warmups": 0,
  "repeats": 3,
  "capture_frames": false
}
```

Аргументы: `--config config/local-video.json --renderers opengl --timeout 1800`.
Baseline позволяет отделить ошибку передачи/освобождения видеокадров от эффекта.
Для будущей проверки lifecycle расширьте `media_cases` до всех трёх сочетаний
с видео. Сохраняйте `native.log`, `active-case.json`, `active-operation.json`,
`errors.jsonl` и все попытки после перезапуска.

Предыдущее расследование воспроизвело SIGSEGV в цепочке GStreamer → GBM/Mesa уже
на Baseline. Список будущих native-проверок, включая ownership/cancel/dispose и
Vulkan callback, находится в [плане](effects-work.md#native-opengl-исследовано-исправление-отложено).
Самостоятельный GBM stress не воспроизвёл полную ошибку и не заменяет этот тест.
Исходники для будущего анализа: `src/plugins/gstreamer_video_player/frame.c`,
`player.c`, `plugin.c` внутри `/home/pi/workspace/flutter-pi`.
Сборка и установка исправленного flutter-pi сейчас отложены.

### Vulkan и реальные оригиналы

Аппаратные проверки Vulkan сейчас отложены: default renderer — **OpenGL**.
Переход на Vulkan планируется после поддержки видео в native runtime.
Видео Vulkan также **выключено по умолчанию**. `--no-vulkan-video` принудительно
отключает его даже поверх `vulkan_video: true` в JSON. После будущей реализации
поддержки в native runtime есть явный opt-in `--vulkan-video`; сейчас его не
нужно добавлять к обычным прогонам. Flutter API и текущая реализация flutter-pi
описаны в [README стенда](../benchmarks/README.md).

Внешние оригиналы положите в отдельный каталог, например
`/home/pi/workspace/benchmark-originals`, с именами `photo_a.jpg`, `photo_b.jpg`,
`photo_large.jpg`, `animation.gif`, `video_a.mp4`, `video_b.mp4`.
Не уменьшайте фото под экран и не перекодируйте ролики для упрощения нагрузки.
В схеме запуска задайте переменную перед `nohup`, чтобы supervisor её унаследовал:

```bash
BENCHMARK_MEDIA_DIR=/home/pi/workspace/benchmark-originals \
  nohup ./run-managed.sh "$job" --suite standard --renderers opengl --timeout 21600 \
  > "managed/$job/launcher.log" 2>&1 < /dev/null &
```

Предварительно создайте **новый** `job` и каталог, как в разделе 3.
Встроенные JPEG имеют размеры 4032×3024, 6000×4000 и 8000×6000; это повторяемые
fixtures, а не замена реальным телефонным/камерным оригиналам. Исходные медиа
в архив отчёта не включаются; сохраняются их размеры и хеши.

## 5. Получение отчётов и сравнение

В конце `launcher.log` содержит `BENCHMARK_ARCHIVE=/.../reports/ИМЯ.tar.gz`.
Копируйте **весь архив**, а не только HTML. На рабочей машине:

```bash
cd /home/dis/workspace/dslideshow/benchmarks
mkdir -p reports/device-downloads
rsync -a --partial --append-verify --timeout=600 \
  -e 'ssh -o BatchMode=yes -o ConnectTimeout=120 -o ServerAliveInterval=30 -o ServerAliveCountMax=10' \
  pi@192.168.50.143:/home/pi/workspace/benchmarks/reports/ИМЯ.tar.gz \
  reports/device-downloads/
sha256sum reports/device-downloads/ИМЯ.tar.gz
mkdir -p reports/device-downloads/extracted
tar -xzf reports/device-downloads/ИМЯ.tar.gz -C reports/device-downloads/extracted
python3 tool/collect_reports.py reports/device-downloads/extracted/ИМЯ
```

Сверьте SHA256 с `sha256sum` того же архива на устройстве. Исходный архив
сохраняйте неизменным, повторную агрегацию выполняйте в распакованной копии.
Большой архив после разрыва rsync можно докачать той же командой.

* `report.html`, `collection-summary.json` — итог выбранных renderer, coverage и ошибки.
* `visual-report.html` — контрольные кадры всех эффектов, если включён visual audit.
* `opengl/`, `vulkan/` — сводки и `attempt-NNN/` каждой попытки.
* В попытках: `runs.jsonl`, `frames.jsonl`, `telemetry.jsonl`, `errors.jsonl`,
  `native.log`, `launch.json`, `launcher-status.json`, активный случай/операция;
  при доступности — `audit/`, `captures/`, `video-probes/`.

`complete` и coverage означают завершённость набора, `successful` — приёмку
без ошибок. `all_cases_accounted_for` учитывает допустимые `unsupported`,
`all_supported_cases_attempted` — охват поддерживаемой матрицы.
`all_cases_attempted` может быть false при нормальном пропуске видео Vulkan.
Нативные падения и ошибки cleanup не исчезают после успешного перезапуска.

Для A/B фиксируйте одну версию SDK/engine/runtime, одинаковые media hashes,
разрешение, renderer, JSON, seed и тепловые условия. Сравнивайте подготовку,
FrameTiming p50/p95/p99/max, растяжение времени, память, FD/потоки и ошибки
после прогрева. Среднее p95 отдельных повторов не является p95 всех кадров.
Показывайте исходные значения вместе с разницей; данных короткого визуального
прогона без прогрева недостаточно для вывода о приросте производительности.

FixedAnimationController намеренно растягивает переход под нагрузкой — его
сохраняем. Уменьшение сетки, blur или исходников не является допустимой
оптимизацией. RSS не учитывает всю GPU-память, HWM считается с запуска процесса;
рестарты не доказывают отсутствия утечки. При несогласованности Flutter timestamps
с частотой экрана оценка пропущенных vsync равна null. FPS стенда описывает
кадры Flutter, не измеряет физический scanout дисплея.

Визуальный набор снимает 21 неподвижный контрольный кадр вне измерения времени,
на экране есть соответствующая надпись. Дискретная смена этих кадров не описывает
плавность реального перехода. Чёрный/неинформативный readback означает
`unverified_capture`, а не успешную визуальную проверку. Снимок движущейся
видеотекстуры также не доказывает её физический вывод на дисплей.

## 6. Локальные регрессионные проверки перед устройством

Из корня репозитория, после получения зависимостей соответствующего пакета:

```bash
(cd dslideshow_flutter && flutter test --no-pub)
(cd benchmarks && flutter analyze --no-pub)
(cd benchmarks && flutter test --no-pub)
(cd benchmarks && python3 -m unittest discover -s tool -p 'test_*.py')
(cd benchmarks && bash -n run.sh build_aot_pi5.sh)
(cd benchmarks && flutter test --no-pub tool/audit_effects_test.dart)
```

Последняя команда проверяет 48 эффектов в 21 точке на 160×100 и 2560×1600,
включая конечные состояния и глубину 3D-преобразований. Выход:
`benchmarks/build/effects/visual-audit.json`.
Дополнительные PNG-галереи:
`(cd benchmarks && flutter test --no-pub tool/render_effect_gallery_test.dart)`.
Остальные проверки пакетов и Linux-сборки перечислены в
[README приложения](../dslideshow_flutter/README.md#проверки).

При добавлении эффекта обновляйте реестр/метаданные и тесты так, чтобы он попадал
в автоматическую матрицу, а число эффектов в документации не устаревало.
Локальные проверки предшествуют аппаратным и не заменяют их.
