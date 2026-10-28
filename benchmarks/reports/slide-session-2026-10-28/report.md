# SlideSession: аппаратный A/B настоящего renderer, 28.10.2026

Чистые baseline/candidate прошли по 13 строк измерения и lifecycle без
runtime/native ошибок. Сравнимые показатели кадров близки; ускорение по трём
повторам не заявляется. Семь статичных endpoint/camera кадров совпали полностью
при 2560×1600. Первое различие RSS сохранено и отдельно перепроверено в обратном
порядке: постоянный прирост у candidate в коротком повторе не воспроизвёлся.
Это ограниченная регрессионная проверка, не доказательство отсутствия утечек
или равенства памяти во всех сценариях.

## Условия и границы

Использован [отдельный benchmark target](../../renderer-harness.md), который
монтирует production `SlideShowPage` и настоящие Bloc/сессии. Обычный
`BenchmarkViewport` для приёмки renderer не использовался. Только OpenGL,
release, RaPi5 `pi@192.168.50.143`, дисплей 2560×1600/DPR1/49.9993Hz,
Flutter 3.47.7, engine `deb287481e3ce9468f3434937ced4240a70539ca`.
Фото 4032×3024, 6000×4000 и 8000×6000 сохранены без уменьшения; GIF и H.264
взяты из штатного `MediaCatalog`. FixedAnimationController сохранён.

Парный набор: `glassMotion`, `waterMotion`, `accordionLive`, `specialScreens`.
По одному прогреву, три измерения на фото и шесть переходов живых медиа.
Фото с Ken Burns достигает наблюдаемого progress≥0.2 до перехода; display time
6000ms, nominal transition 1000ms. Проверены native video position при
pause/sleep/resume, PhotoMotion progress, часы при pause, HTTP-запросы камер
при pause/sleep/wake, отмена подготовки камеры с повтором и cleanup страницы.
Radial/Film/VHS выполнялись только в исходной калибровке baseline; кандидат
аппаратно принимается именно на четырёх парных сценариях.

Каждый запуск шёл через supervisor с остановкой/восстановлением `dslideshow`.
Оба bundle заранее полностью переданы и сверены по 60 файлам. Во время чистых
измерений не выполнялись deploy или большие передачи отчётов. ОС, драйверы,
прошивка и runtime не изменялись; Vulkan и 24-часовой тест не запускались.

Runtime SHA256:
`30669efa6ad054744b4c63275cafaf7738d1489b5702c17de666ac73edcbea4b`.
SHA256 общего `libflutter_engine.so`:
`c466d00c4a274e78bb31589ae6cf261ac6a3c447cc980f879d49c94c48537523`.

## Сборки и исходники

Baseline взят из `git archive b8f5c38ce86ffa09aa30d5f8d127f3410307a853`
до изменения renderer. Candidate — чистый tracked snapshot с тем же harness
и ровно четырьмя изменёнными production-файлами: `slideshow_page.dart`,
`slide_session.dart`, `slide_session_factory.dart`, `slide_transition.dart`.
Изменения тестов/документации после сборки в AOT не входят. Сдвиг HEAD во время
работы не меняет сохранённые source/release архивы и их fingerprints.

| Артефакт | Baseline | Candidate |
| --- | --- | --- |
| Source SHA256 | `4ed8fc84d30aef9360a8ebb4ea2911ea25000e4311259ae5235aa32269f41b2c` | `20800feead69a0a2bf39859a69fe0f4033cbb2a66d2a70c46cf446672e0feb0a` |
| AOT SHA256 | `a9548b5a34fd8c72551a12c279141fa518284581f39bf742bb7a6868fb26ca59` | `4681f097285d8c689ee38d3dc3314ea4d686ea3a38a90b1363196895b53855b4` |

Harness, launcher, builder и тесты одинаковы у обеих сборок. SHA256
`renderer_main.dart` — `c98f3b78303608c574c2d8399b6dc1249c608506ec5daf9b4d832f7a6e18aca8`.
Нормализованные dependency closures содержат одинаковые 145 пакетов;
SHA256 resolved lock — `7cb5b90c9f8b88666ac5d638e46314b731d600274e113431df61654f746efdd3`.
Архивы исходников проверены по именам файлов: только tracked inputs и явно
добавленные файлы harness/рефакторинга, без посторонних ignored inputs.
Исходный lock и tracked build-info asset рабочего checkout сохранены.

## Кадры и подготовка

Основной A/B: baseline `20261028T174449Z-renderer`, затем candidate
`20261028T174749Z-renderer`; обе службы supervisor вернули exit0, errors0,
все 13 строк passed. Таблица показывает медиану показателей отдельных повторов.

| Сценарий | n | sampled FPS B→C | raster p95, ms B→C | Подготовка, ms B→C | Переход wall time, ms B→C |
| --- | --- | --- | --- | --- | --- |
| Glass + Ken Burns | 3 | 15.588→15.679 | 74.038→74.018 | 793.262→817.136 | 7322.769→7315.702 |
| Water + Ken Burns | 3 | 27.292→27.429 | 46.123→46.091 | 803.373→838.027 | 3862.759→3861.442 |
| Accordion фото/GIF/видео | 6 | 37.893→37.717 | 31.769→31.228 | 274.964→275.791 | 2453.427→2428.148 |

Окно FrameTiming включает подготовку и переход; паузы, заданное накопление
motion progress и ожидание UI-уведомления выполняются вне него. Закрытое окно
доставляется через последующие painted markers, поздние callbacks учитываются.
Flutter vsync timestamps здесь не совпадают с частотой дисплея; sampled FPS
относится к submitted Flutter frames, а не DRM completions. Оценка missed-vsync
остаётся unavailable. Wall time намеренно больше nominal из-за FixedAnimationController.
В принятых прогонах throttle bits оставались 0.

## Память, FD и потоки

Cleanup ждёт три последовательных равных FD/thread samples с периодом 250ms,
предел 5s. RSS сохраняется отдельно; GC и allocator не принуждались.

Первый чистый A/B дал существенный положительный RSS offset кандидата:

| После cleanup | RSS MiB B→C | FD B→C | Потоки B→C |
| --- | --- | --- | --- |
| Glass motion | 218.92→298.30 | 39→39 | 15→15 |
| Water motion | 240.27→306.53 | 39→39 | 15→15 |
| Live media | 435.98→512.70 | 40→40 | 17→19 |
| Special screens | 455.83→527.77 | 40→40 | 17→19 |

Kernel VmHWM всего процесса в этом A/B также вырос: 815.40→883.90 MB
(+68.50 MB, +8.4%; десятичные MB). Это пик всего набора сценариев, тогда как
повтор ниже проверяет только Glass motion.

Для проверки воспроизводимости повторён **тот же glassMotion на тех же AOT**,
но candidate первым (`20261028T180157Z-renderer`), baseline вторым
(`20261028T180400Z-renderer`). Оба passed3/errors0/exit0:

| Показатель | Candidate | Baseline |
| --- | --- | --- |
| RSS после cleanup, MiB | 221.22 | 223.56 |
| Kernel VmHWM, MiB | 500.52 | 498.75 |
| FD / потоки | 39 / 15 | 39 / 15 |

Первый offset не воспроизвёлся, знак разницы RSS изменился. Причина различий
из этих данных не устанавливается. Не делается вывод о GC/allocator и не
заявляется отсутствие утечек. Независимая visual-пара также не сохранила
положительный offset, хотя её readback-нагрузка отличается от performance:

| Visual cleanup | RSS MiB B→C | FD B→C | Потоки B→C |
| --- | --- | --- | --- |
| Glass photo | 217.05→211.44 | 39→39 | 16→16 |
| Live media | 372.66→365.23 | 39→39 | 17→17 |
| Special screens | 406.06→396.78 | 40→40 | 18→18 |

## Визуальная проверка

Отдельные capture-прогоны `20261028T175256Z-renderer` и
`20261028T175815Z-renderer` прошли по 10 строк/errors0/exit0, по 23 PNG.
Их FPS не используется для performance comparison. Семь полных статичных
кадров 2560×1600 совпали с max delta0 / changed pixels0: три Glass endpoints,
три фото после живой композиции и изображение камеры. Результат сохранён
в `visual/static-pixel-comparison.json`.

Просмотрены Glass mid-transition, native video test bars, GIF, часы и камера:
видимое содержимое и геометрия ожидаемы. Видео-позиция также проверялась
запросом к native player. Промежуточные кадры захватываются по wall time;
они, GIF, видео и часы не являются синхронизированным pixel-equality A/B.
Несколько PNG не заменяют длительный просмотр всех кадров native video.

## Сохранённые ошибки и материалы

`excluded-attempts/` содержит исходные failed traces без фильтрации:

* `baseline-001`: запуск до завершения deploy, bootstrap missing asset;
  измерений нет, supervisor восстановил службу.
* `baseline-002`: ошибочный критерий exact scheduler/FrameTiming timestamp;
  исправлен benchmark-only painted marker drain, ошибки не считались native-падением.
* `baseline-003`: полная калибровка, 25 строк и 7 unhandled `TickerCanceled`,
  также возможное пересечение с deploy I/O; исключена из сравнительных выводов.
  Вероятная связь с неизменённым `StateNotify.reset/forward().orCancel`
  установлена по исходникам и времени control cycles, не по стеку: stack payload
  отсутствует. Быстрая отмена pause UI остаётся прежней известной ошибкой;
  этот рефакторинг её не исправляет. Финальные paced controls ждут завершения
  существующей notification-анимации и не скрывают исключения.

В этом каталоге локально сохранены `baseline/candidate-{source,release}.tar.gz`,
распакованные `*-frozen/` с bundle/build-info/manifest/lock/package config,
`performance/`, `visual/`, `memory-repeat/`, `summary.json`,
dependency/harness provenance и `final-device-state.json`. Большие исходные
архивы и сырые результаты намеренно остаются ignored; этот report tracked.
Последняя проверка 28.10.2026 21:07:31 MSK: `dslideshow=active`, benchmark PIDs
отсутствуют, шесть принятых managed jobs имеют exit0, runtime SHA256 прежний.

Локально пройдены две Dart-регрессии FrameTiming, четыре Python-проверки
launcher (включая delayed TERM teardown и отказ от непустого output), targeted
Flutter analyze, `bash -n` и `git diff --check`. Команды — в
[руководстве стенда](../../renderer-harness.md).
