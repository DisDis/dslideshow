# Аппаратный стенд настоящего Slideshow renderer

`lib/renderer_main.dart` монтирует обычный `SlideShowPage`, `SlideshowBloc`,
`SlideshowStatusBloc` и `ButtonsHintBloc`. Подменяется только backend RPC:
источники медиа берутся из штатного `MediaCatalog`, команды паузы и сна проходят
через настоящий status Bloc. Фото, GIF, видеоплееры, Ken Burns, часы, камеры,
подготовка и освобождение принадлежат production-коду. Дополнительных флагов,
точек входа и телеметрии в основном приложении нет.

Сборка из `benchmarks/`:

```sh
./build_renderer_pi5.sh
```

Скрипт печатает `RENDERER_PACKAGE` и `RENDERER_ARCHIVE`. Это отдельный release
bundle с `run.sh`, который запускает только OpenGL, один раз, без автоматического
повторения после ошибки. Существующий `pubspec.lock` восстанавливается после
сборки; зависимости и версии не обновляются в рабочем дереве. Для baseline
сохраните копию исходников **до** production-изменений и добавьте в неё ровно
тот же benchmark harness. В A/B фиксируются SDK, engine, runtime, медиа,
разрешение и настройки. Архивы `build/` и сырые аппаратные отчёты не коммитятся.

Пакет разворачивайте в отдельном каталоге устройства с возобновляемым `rsync`
из [аппаратного руководства](../doc/raspberry-pi-benchmarks.md). Используйте
описанный там supervisor с восстановлением службы; копия `run-managed.sh`
работает рядом с `run.sh` пакета. При отдельных каталогах сделайте
`managed-supervisor.lock` символьной ссылкой на общую блокировку
`/home/pi/workspace/benchmarks/managed-supervisor.lock`. Не запускайте вместе
с фоторамкой или другим GPU-стендом. Runtime берётся из
`/opt/dslideshow/flutter-pi`, ОС, драйверы и runtime не изменяются.

```sh
cd /home/pi/workspace/benchmarks/renderer-baseline
mkdir -p managed/renderer-baseline-001
nohup ./run-managed.sh renderer-baseline-001 \
  > managed/renderer-baseline-001/launcher.log 2>&1 < /dev/null &
```

По умолчанию выполняются следующие сценарии:

| Сценарий | Проверяемая граница |
| --- | --- |
| `glassPhoto`, `glassMotion` | Заимствованные bitmap, outgoing camera, Ken Burns |
| `radialPhoto`, `waterMotion` | Привязка подготовленных фото, путь Water с motion |
| `filmPhoto`, `vhsPhoto` | Фото-шейдеры и кешированный VHS |
| `accordionLive` | Фото → GIF → видео → фото, общий живой вход композиции |
| `specialScreens` | Настоящие часы и камеры; pause, sleep, отмена и повтор подготовки |

Фото остаются исходными 4032×3024, 6000×4000 и 8000×6000; подготовка и дисплей
2560×1600. У каждого эффекта один прогрев и три измеренных перехода;
`accordionLive` делает шесть измерений, чтобы в измеренную часть попали все
границы живых медиа. У motion-сценариев display time составляет 6000ms;
перед каждым переходом стенд ждёт наблюдаемый `PhotoMotionFrame.progress ≥ 0.2`
с пределом 5s, чтобы исходящая камера имела ненулевой pose. У остальных медиа
display time 60000ms; переходы запускаются явной командой.
Видео→видео намеренно не включено: этот отдельный известный
native-риск описан в [материалах видео](reports/flutter-pi-video-2026-10-25/README.md).
Нативные ошибки сохраняются с активной операцией и делают запуск failed.

`RENDERER_SCENARIOS=glassMotion,accordionLive,specialScreens` перед supervisor
ограничивает набор. Фиксируйте одинаковый набор у обеих сборок.
`RENDERER_CAPTURE=true` включает отдельный визуальный запуск с PNG в середине
переходов и после display; его FPS **не используется** для сравнения
производительности. Доступность видео в CPU `RepaintBoundary.toImage` зависит
от native texture, поэтому PNG дополняют просмотр экрана, а не доказывают
корректность native video pixels. Часы, GIF, видео и motion имеют живое время;
их PNG нельзя объявлять строгим pixel equality A/B.

Отчёты включают `launch.json` с SHA256 runtime/AOT; `metadata.json` с source
fingerprint, SDK/engine, оригиналами и аппаратными параметрами;
`events.jsonl` с фазами, командами и production-логами; `telemetry.jsonl` с
RSS, FD, потоками, температурой/частотами; `renderer-report.json` с временем
подготовки и перехода, полными FrameTiming и распределениями. Окно FrameTiming
закрывается по системному timestamp при завершении перехода. После завершения
этого кадра benchmark перерисовывает два однопиксельных маркера в нижнем правом
углу и ждёт callback с timestamp не меньше конца окна (предел 2s); пустое окно
или недоставленный маркер — ошибка. Точное совпадение scheduler timestamp
с submitted frame не требуется. Кадр начала окна исключён; поздние batched
callbacks учитываются, последующие idle/motion/marker кадры исключены. FrameTiming
описывает весь переход вместе с подготовкой, `preparation_ms` и `transition_ms`
даны отдельно по наблюдаемым фазам Bloc. Cleanup наблюдается после удаления
страницы: стенд ждёт три подряд одинаковых FD/thread telemetry samples
с периодом 250ms и пределом 5s. RSS сохраняется, но не используется как критерий
покоя из-за GC и системных кешей. Controls проверяют native video position
запросом к плееру, замороженный/возобновлённый PhotoMotion progress,
clock ticks при pause, camera HTTP requests при pause/sleep/wake и отмену
подготовки камеры с повтором после wake. Это короткая
регрессионная проверка, не длительное доказательство отсутствия утечек.

Между pause/resume и следующим управлением стенд ждёт фактического завершения
анимации `StateNotify` по её существующему `AnimatedBuilder` (dismissed после
forward/reverse, предел 5s). Быстрые повторные команды и отмена этой UI-анимации
не входят в такой paced hardware-сценарий. В калибровке 28.10.2026 обнаружены
прежние `TickerCanceled`; их исходные failed traces сохранены, исключения
не фильтруются. Подробности и итоговый A/B — в
[отчёте рефакторинга](reports/slide-session-2026-10-28/report.md).

Результат записывается после каждого измерения. Если native процесс падает,
launcher сохраняет `native.log`, SHA256, exit code и частичный отчёт в архиве,
не заменяет отсутствующие измерения нулями и не перезапускает приложение.
Непустой output отклоняется до запуска runtime. При TERM/INT launcher ждёт
завершения дочернего процесса прежде, чем supervisor восстановит службу.

Локальная проверка:

```sh
flutter test --no-pub test/renderer_harness_test.dart
flutter analyze --no-pub lib/renderer_main.dart test/renderer_harness_test.dart
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest discover -s tool -p test_renderer_launcher.py -v
bash -n build_renderer_pi5.sh run_renderer.sh
```
