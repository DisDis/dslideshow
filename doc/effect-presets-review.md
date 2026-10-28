# Проверка пресетов эффектов

Согласованы пять основных объединений и Slice/Panel Wipe. В основном каталоге
37 семейств, один выбранный режим на семейство, 82 встроенных пресета.
Ripple Reveal, Water Refraction, Blinds и Louver остаются самостоятельными.

При выборе пресета в config_app сохраняются enabled и длительность. Другие
визуальные параметры заменяются; затем их можно редактировать вручную.

## Принятое визуальное сравнение

**28.10.2026 пользователь проверил сравнение и подтвердил визуальное
соответствие всех вариантов.** Отдельные строки прежних эффектов в каталог
возвращать не требуется.

До удаления временных эталонов каждый из 82 пресетов был сопоставлен со своим
прежним типом при seed=42, 160×100, в 21 фазе (0…100% с шагом 5%).
Изображения — общие асимметричные градиенты и детали. Автоматический результат:
**82/82, максимальная разница каналов 0** на этих входных данных.
Пользователь также просмотрел HTML с парами кадров.

После подтверждения удалены временные копии прежних рендеров и шейдеров,
тест их попарного сравнения и сгенерированный HTML/PNG/JSON-отчёт из benchmarks.
Таблица ниже сохраняет соответствие и результаты уже выполненной проверки;
она не является командой повторной генерации удалённого отчёта.
Старые enum aliases остаются для чтения, CLI и исторической benchmark-матрицы.

Текущие локальные регрессии проверяют 144 активных параметра на крайних
значениях, конечные кадры, пять начал волны на широком/портретном viewport,
положительную глубину 3D при максимальной перспективе до 2560×1600/1600×2560,
покрытие кадра при вращении Radial Blur/Kaleidoscope вокруг каждого угла,
живые медиа, паузу, поздние ответы и освобождение ресурсов.

Пользователь разрешил не проводить проверку на устройстве. Аппаратный прогон
в рамках этой задачи не требуется и не выполнялся; результаты локального
сравнения не являются измерением производительности на RaPi5.

## Таблица соответствия

| Прежний тип | Пресет в config_app | Семейство | Разница каналов |
| --- | --- | --- | ---: |
| `burnAlpha` | Выгорание (`burnAlpha`) | `burnAlpha` | 0 |
| `foldMotion` | Складывание (`foldMotion`) | `foldMotion` | 0 |
| `glow` | Свечение (`glow`) | `glow` | 0 |
| `kaleidoscope` | Калейдоскоп (`kaleidoscope`) | `kaleidoscope` | 0 |
| `tvPower` | Выключение телевизора (`tvPower`) | `tvPower` | 0 |
| `springMotion` | Пружина (`springMotion`) | `springMotion` | 0 |
| `shapeDissolve` | Растворение фигурами (`shapeDissolve`) | `shapeDissolve` | 0 |
| `vhsDamage` | Видеокассета (`vhsDamage`) | `vhsDamage` | 0 |
| `radialBlur` | Радиальное размытие (`radialBlur`) | `radialBlur` | 0 |
| `phosphor` | Послесвечение (`phosphor`) | `phosphor` | 0 |
| `filmDissolve` | Кинематографическое растворение (`filmDissolve`) | `fade` | 0 |
| `frame` | Рамка (`frame`) | `revealMask` | 0 |
| `louver` | Поворотные жалюзи (`louver`) | `louver` | 0 |
| `mirror` | Зеркало (`mirror`) | `mirror` | 0 |
| `clockWipe` | Часовое раскрытие (`clockWipe`) | `revealMask` | 0 |
| `split` | Раздвижение половин (`split`) | `split` | 0 |
| `panelWipe` | Раскрытие панелями (`panelWipe`) | `slice` | 0 |
| `stretch` | Растяжение (`stretch`) | `stretch` | 0 |
| `starWipe` | Раскрытие звездой (`starWipe`) | `revealMask` | 0 |
| `lightLeak` | Световая засветка (`lightLeak`) | `lightLeak` | 0 |
| `filmRoll` | Прокрутка плёнки (`filmRoll`) | `slide` | 0 |
| `crossZoom` | Встречный зум (`crossZoom`) | `zoomOver` | 0 |
| `whip` | Резкая панорама (`whip`) | `slide` | 0 |
| `glass` | Стекло (`glass`) | `glass` | 0 |
| `softWipe` | Мягкое раскрытие (`softWipe`) | `revealMask` | 0 |
| `slice` | Сдвиг полос (`slice`) | `slice` | 0 |
| `lumaFade` | Растворение по яркости (`lumaFade`) | `lumaFade` | 0 |
| `pagePeel` | Загиб страницы (`pagePeel`) | `pagePeel` | 0 |
| `noiseDissolve` | Растворение в шуме (`noiseDissolve`) | `noiseDissolve` | 0 |
| `rippleReveal` | Раскрытие волнами (`rippleReveal`) | `rippleReveal` | 0 |
| `waterRefraction` | Преломление воды (`waterRefraction`) | `waterRefraction` | 0 |
| `cube` | Куб (`cube`) | `cube` | 0 |
| `accordion` | Гармошка (`accordion`) | `accordion` | 0 |
| `backgroundToForeground` | Из фона на передний план (`backgroundToForeground`) | `depth` | 0 |
| `foregroundToBackground` | С переднего плана в фон (`foregroundToBackground`) | `depth` | 0 |
| `depth` | Глубина (`depth`) | `depth` | 0 |
| `parallax` | Параллакс (`parallax`) | `parallax` | 0 |
| `stack` | Стопка (`stack`) | `slide` | 0 |
| `tablet` | Планшет (`tablet`) | `tablet` | 0 |
| `zoomOut` | Уменьшение (`zoomOut`) | `zoomOut` | 0 |
| `fade` | Растворение (`fade`) | `fade` | 0 |
| `mosaic` | Мозаика (`mosaic`) | `mosaic` | 0 |
| `liquidMorph` | Жидкое преобразование (`liquidMorph`) | `liquidMorph` | 0 |
| `blinds` | Жалюзи (`blinds`) | `blinds` | 0 |
| `blurFade` | Растворение с размытием (`blurFade`) | `fade` | 0 |
| `zoomOver` | Увеличение поверх (`zoomOver`) | `zoomOver` | 0 |
| `slide` | Сдвиг (`slide`) | `slide` | 0 |
| `revealMask` | Раскрытие маской (`revealMask`) | `revealMask` | 0 |
| `fadeThroughColor` | Через цвет (`fadeThroughColor`) | `fade` | 0 |
| `flip` | Переворот (`flip`) | `flip` | 0 |
| `rotate` | Поворот (`rotate`) | `rotate` | 0 |
| `softWipe` | Световой проход (`softWipeLightSweep`) | `revealMask` | 0 |
| `softWipe` | Неоновое раскрытие (`softWipeNeon`) | `revealMask` | 0 |
| `fadeThroughColor` | Через белый (`fadeThroughWhite`) | `fade` | 0 |
| `flip` | Вертикальный переворот (`flipVertical`) | `flip` | 0 |
| `rotate` | Вращение от нижнего края (`rotateBottom`) | `rotate` | 0 |
| `mosaic` | Мозаика без затухания (`mosaicBinary`) | `mosaic` | 0 |
| `mosaic` | Мозаика из верхнего левого угла (`mosaicTopLeft`) | `mosaic` | 0 |
| `mosaic` | Мозаика из верхнего правого угла (`mosaicTopRight`) | `mosaic` | 0 |
| `mosaic` | Мозаика из нижнего левого угла (`mosaicBottomLeft`) | `mosaic` | 0 |
| `mosaic` | Мозаика из нижнего правого угла (`mosaicBottomRight`) | `mosaic` | 0 |
| `slide` | Вытеснение вправо (`slidePushRight`) | `slide` | 0 |
| `slide` | Вытеснение вверх (`slidePushUp`) | `slide` | 0 |
| `slide` | Вытеснение вниз (`slidePushDown`) | `slide` | 0 |
| `slide` | Наложение влево (`slideCoverLeft`) | `slide` | 0 |
| `slide` | Наложение вправо (`slideCoverRight`) | `slide` | 0 |
| `slide` | Наложение вверх (`slideCoverUp`) | `slide` | 0 |
| `slide` | Наложение вниз (`slideCoverDown`) | `slide` | 0 |
| `slide` | Открытие сдвигом влево (`slideRevealLeft`) | `slide` | 0 |
| `slide` | Открытие сдвигом вправо (`slideRevealRight`) | `slide` | 0 |
| `slide` | Открытие сдвигом вверх (`slideRevealUp`) | `slide` | 0 |
| `slide` | Открытие сдвигом вниз (`slideRevealDown`) | `slide` | 0 |
| `revealMask` | Раскрытие вправо (`wipeRight`) | `revealMask` | 0 |
| `revealMask` | Раскрытие вверх (`wipeUp`) | `revealMask` | 0 |
| `revealMask` | Раскрытие вниз (`wipeDown`) | `revealMask` | 0 |
| `revealMask` | Горизонтальная штора (`curtainHorizontal`) | `revealMask` | 0 |
| `revealMask` | Вертикальная штора (`curtainVertical`) | `revealMask` | 0 |
| `revealMask` | Диагональ из верхнего правого угла (`diagonalTopRight`) | `revealMask` | 0 |
| `revealMask` | Диагональ из нижнего левого угла (`diagonalBottomLeft`) | `revealMask` | 0 |
| `revealMask` | Диагональ из нижнего правого угла (`diagonalBottomRight`) | `revealMask` | 0 |
| `revealMask` | Диагональ из верхнего левого угла (`diagonalTopLeft`) | `revealMask` | 0 |
| `revealMask` | Круг из центра (`irisCenter`) | `revealMask` | 0 |

## Перенос сохранённых настроек

Схема остаётся 1. Убранные ключи преобразуются в семейство и соответствующий
режим; собственная длительность и выключенные персональные параметры
сохраняются. При нескольких записях одного семейства побеждает явный
канонический ключ, затем включённый прежний тип, затем порядок EffectType.
Конфликт пишется в журнал. Чтение само не переписывает файл; следующий Save
сохраняет одну запись. Исходную конфигурацию с несколькими такими типами
нужно сохранить отдельно, если потребуется вернуть прежний набор.

## Необязательная аппаратная диагностика

На устройстве в этой работе ничего не запускалось и служба не менялась.
Следующие сценарии оставлены для возможной будущей диагностики; запускать их
для завершения текущей задачи не требуется. При необходимости используйте
[руководство RaPi5](raspberry-pi-benchmarks.md): supervisor останавливает
`dslideshow` и восстанавливает службу после завершения, ошибки или обрыва SSH.

Подготовлены два новых конфига:

* [effect-options-visual.json](../benchmarks/config/effect-options-visual.json):
  прежние варианты через канонические options, все плотные сетки Mosaic,
  отдельные начала волн, контрольные кадры.
* [effect-options-performance.json](../benchmarks/config/effect-options-performance.json):
  фото, большие фото, GIF, фото/видео и video→video, старые варианты и
  наиболее дорогие blur/zoom/грани/сектора/следы/рефракция.

Команды после создания supervisor из руководства (выполнять по очереди,
следующий запуск — после восстановления службы предыдущим):

```sh
cd /home/pi/workspace/benchmarks
effects_visual_job="$(date -u +%Y%m%dT%H%M%SZ)-effect-options-visual"
mkdir -p "managed/$effects_visual_job"
nohup ./run-managed.sh "$effects_visual_job" \
  --config config/effect-options-visual.json --renderers opengl --timeout 7200 \
  > "managed/$effects_visual_job/launcher.log" 2>&1 < /dev/null &
```

После завершения первого прогона и проверки `managed/JOB/exit-code`:

```sh
cd /home/pi/workspace/benchmarks
effects_performance_job="$(date -u +%Y%m%dT%H%M%SZ)-effect-options-performance"
mkdir -p "managed/$effects_performance_job"
nohup ./run-managed.sh "$effects_performance_job" \
  --config config/effect-options-performance.json --renderers opengl --timeout 21600 \
  > "managed/$effects_performance_job/launcher.log" 2>&1 < /dev/null &
```

Перед A/B сохранить release baseline/candidate и оба архива; использовать
одинаковые SDK/engine, закреплённый flutter-pi, разрешение, оригиналы, seed,
прогрев и повторы. Удалённые временные Dart-эталоны не заменяют архив
release baseline. Сопоставимость прежних аппаратных отчётов нужно проверить
перед использованием. Сравнивать одинаковые визуальные варианты; крайние
новые настройки измеряются отдельно как стоимость варианта.

Сетки Mosaic 100×100, 150×150, 200×200 и оригиналы не уменьшать. Видео и
cleanup проверять отдельно; отсутствующие метрики не заменять нулями,
native-падения сохранять с active-operation/native.log. Water пропускает
несовместимые пары до создания плеера. ОС, драйверы, прошивку и flutter-pi
не менять; Vulkan и 24-часовой прогон не входят в эту проверку.

[Действующее руководство настроек](effect-settings.md).
