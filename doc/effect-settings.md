# Настройки эффектов перехода

Сверено с кодом 29.10.2026. Формат `slideshow.effects` хранит одну запись
семейства с собственными параметрами. В каталоге 37 типов и 82 встроенных
пресета. Направления, оси, цвета и стили выбираются в настройках.
`items` — карта `Map<EffectType, EffectConfig>`: тип находится только в ключе,
значение содержит `enabled` и типизированные `options`.

[Визуальное поведение и совместимость](effects.md),
[сессии и контракт входов renderer](slideshow-renderer.md).

## Формат

```json
{
  "slideshow": {
    "effects": {
      "schemaVersion": 1,
      "defaultDurationMs": 1000,
      "items": {
        "mosaic": {
          "enabled": true,
          "options": {
            "durationMs": 1800,
            "gridSize": 100,
            "fadeFraction": 0.3,
            "direction": "topLeft"
          }
        },
        "slide": {
          "enabled": false,
          "options": {
            "durationMs": 0,
            "mode": "push",
            "direction": "left"
          }
        }
      }
    }
  }
}
```

* `options.durationMs=0` наследует `defaultDurationMs`. Положительное целое
  задаёт персональное время. Глобальное время — 1–3 600 000 ms; персональное —
  0 либо 1–3 600 000 ms. Ноль не означает мгновенную смену медиа.
* Отсутствующее/`null` поле длительности читается как 0:
  в модели `options.durationMs=0`. При записи в файл значения по умолчанию
  опускаются, поэтому наследование может храниться без поля `durationMs`.
  Вне `options` персональная длительность не хранится.
* `enabled` по умолчанию false. Выключение сохраняет параметры. Отсутствующий
  в `items` тип выключен; включение или редактирование создаёт запись.
* Пустой `items`, отсутствие `items` внутри явного блока и полностью
  выключенный набор используют служебный Fade с глобальным временем.
  Если ни один выбранный эффект не поддерживает текущую пару медиа, действует
  тот же fallback. Персональные настройки записи Fade на него не влияют.
* Отсутствие всего `effects` также означает пустой набор и служебный Fade.
  Стартовый набор не хранится в конфигурации. Новые типы сами не включаются.
  В модели у каждого ключа ровно одно значение.
* Хранение компактное: `toJson()` моделей options убирает default-параметры,
  `EffectConfig.toJson()` — пустые options и выключенность по умолчанию,
  а `EffectsConfig.toJson()` — пустые записи и defaults самого раздела. Выключенные эффекты с персональными параметрами сохраняются.
  Генерируемая сериализация слайдшоу вызывает `effects.toJson()` автоматически.
  У специальных экранов тот же подход; отдельный `SlideShowConfig.toStorageJson`
  удалён. `AppConfig` использует обычный `stripDefaults` без исключений.
  Поэтому весь раздел `effects` с default-значениями может отсутствовать.
* Версия схемы по умолчанию 1. Проверки диапазонов, сочетаний параметров,
  соответствия options ключу и блокировка Save находятся только в `config_app`
  (`effect_settings_validation.dart`). Backend разбирает и сохраняет модель
  без такой валидации; рамка также не повторяет проверки формы.
* Неизвестные ключи типов и значения карты, не являющиеся объектами,
  пропускаются при чтении с предупреждением. Известная запись с ошибкой
  разбора options сохраняет исходные данные для исправления в панели;
  рамка её не исполняет. Неподдерживаемую версию схемы рамка не исполняет.
  При отсутствии пригодного эффекта используется Fade. Файл при чтении
  автоматически не переписывается.

Пример компактной записи настроек (`durationMs=0` и остальные defaults
не записываются):

```json
{
  "slideshow": {
    "effects": {
      "items": {
        "mosaic": {
          "enabled": true,
          "options": {"durationMs": 1800, "direction": "topLeft"}
        },
        "slide": {"options": {"mode": "cover"}}
      }
    }
  }
}
```

Здесь выключенный `slide` сохраняет персональный `mode=cover`. Пустая
конфигурация `{}` использует Fade с длительностью 1000 мс.

**Старый формат:** прежние `allowedEffects` и `transitionTimeMs` не читаются
и не записываются. В файле без нового блока рамка использует служебный Fade.
Время показа `displayTimeMs` и затухание экрана `fadeTimeMs` независимы.

Модели и enum находятся в `common/lib/effects.dart`, конкретные рендеры и
единая фабрика — в `dslideshow_flutter/lib/src/effect/effect.dart`.
Модели используют Freezed: `copyWith`, равенство и `hashCode` генерируются;
JSON-сериализация генерируется json_serializable. Коллекции неизменяемые. Изменения настроек
применяются к рамке после сохранения и перезапуска; предпросмотр работает
с текущим черновиком сразу. Выбранный переход получает неизменяемые параметры
и вычисленную длительность до подготовки и сохраняет их до завершения.
`FixedAnimationController` продолжает плавно замедляться под нагрузкой.

## Пресеты и объединение каталога

Одна запись семейства хранит один выбранный режим. Несколько одновременно
выбранных профилей семейства, веса и порядок проигрывания в этом формате
не задаются; порядок JSON-ключей на очередь не влияет. Пресеты — неизменяемые
готовые наборы визуальных параметров из `effectPresets` / `EffectPresetId`
в `common/lib/effects.dart`; идентификатор пресета не записывается в конфиг.
После применения сохраняются обычные `options`. Ручные изменения дают
«Свои параметры»; совпадение с пресетом определяется по визуальным полям.
Выбор пресета сохраняет включённость и текущую длительность, заменяет
визуальные параметры и очищает их незавершённый ввод. Ошибка длительности
сохраняется до исправления. Переключение отдельного режима сохраняет скрытые
поля; «Сбросить параметры» возвращает default семейства.

| Семейство | Прежние эффекты / пресеты |
| --- | --- |
| `fade` | Fade, Film Dissolve, Blur Fade, Fade Through Color; дополнительно вариант через белый |
| `slide` | Slide, Stack, Whip, Film Roll; направления и Push/Cover/Reveal |
| `depth` | Depth, Background To Foreground, Foreground To Background |
| `zoomOver` | Zoom Over, Cross Zoom |
| `revealMask` | Reveal Mask, Soft Wipe, Light Sweep, Neon, Frame, Star Wipe, Clock Wipe; прежние направления и формы |
| `slice` | Slice и Panel Wipe: режимы slide / reveal |

Blinds и Louver остаются отдельными. Ripple Reveal и Water Refraction остаются
отдельными; у обоих есть пять точек начала волны.

Ключи и режимы в модели, форме и фабрике представлены enum. JSON-имена
стабильны и не выводятся из имени класса, `runtimeType` или перевода подписи.
Объединение записей не требует одного Dart-класса на семейство: режимы
сохраняют свои кривые, матричный порядок, clip и композицию. Общая внешняя
кривая поверх всех алгоритмов не вводится. У Depth, например, смена порядка
масштабирования и переноса изменила бы траекторию прежнего режима.

Старые ключи объединяемых типов читаются как aliases и преобразуются в
семейство с прежними параметрами. Персональное время и выключенные настройки
сохраняются. Если в старом файле несколько записей одного семейства, приоритет:
явная запись нового семейства, затем включённый прежний эффект, затем порядок
`EffectType`. Конфликт записывается в журнал; результат не зависит от порядка
JSON-полей. Само чтение файл не переписывает, следующий Save сохраняет одну
запись. Перед переносом собственной конфигурации с несколькими такими
эффектами полезно сохранить её копию: одновременно выбранных режимов больше нет.
Ошибочные прежние параметры преобразуются в диагностируемую invalid-запись,
а не теряются при следующем сохранении.

`EffectType` сохраняет старые aliases для чтения и инструментов; пользовательский
каталог определяется `catalogEffectTypes` и `Effect.values`, в каждом 37 типов.
[Полная таблица соответствия](#соответствие-пресетов) приведена ниже;
результат принятого сравнения сохранён в
[историческом отчёте](../benchmarks/reports/effect-presets-2026-10-28/report.md).

## Параметры эффектов

Все типы имеют `durationMs=0`. Ниже — defaults и границы редактора. Доли
показываются в процентах, масштабы задаются множителями; sigma/clipAmount/
waveIntensity используют логические пиксели. Отсутствующее/`null` новое поле
получает default. Абсолютные `maxSigma`, `clipAmount` и `waveIntensity`
не переводятся в доли экрана; относительные параметры сохраняют свою
нормировку. Прозрачность цвета умножается на огибающую и силу оформления,
а итоговая alpha ограничивается 0…1. Границы редактора не являются
обещанием аппаратной производительности всех сочетаний.
`featherFraction=null` означает мягкость по стилю: `.12`
для Soft/Light Sweep и `.02` для Neon. Режимы и варианты перечислены в форме;
неприменимые поля скрываются и сохраняют свои значения.

| Тип | Персональные визуальные параметры |
| --- | --- |
| `burnAlpha` | `direction=right`; `roughness=0.065` (0…0.12); `edgeWidth=0.065` (0.01…0.12); `emberColor=0xFFFF4B00` (0…4294967295) |
| `foldMotion` | `axis=vertical`; `shadowIntensity=0.65` (0…1); `perspectiveStrength=1` (0…1.25) |
| `glow` | `strength=0.7` (0…1); `radius=0.045` (0…0.08); `gain=2.4` (1…3) |
| `kaleidoscope` | `sectorCount=6` (чётное, 2…12); `rotationDegrees=54` (0…180); `origin=center` |
| `tvPower` | `lineAxis=horizontal`; `glowStrength=1` (0…1.5); `glowColor=0xFF80EDFF` (0…4294967295) |
| `springMotion` | `direction=left`; `springStrength=1` (0…1.5); `startScale=0.85` (0.6…1) |
| `shapeDissolve` | `shape=hexagon`; `cellsAcross=12` (6…32); `staggerFraction=0.28` (0…0.6) |
| `vhsDamage` | `colorShiftFraction=0.035` (0…0.06); `trackingStrength=1` (0…2); `noiseStrength=1` (0…2) |
| `radialBlur` | `angleDegrees=0.2 * 180 / π` (0…20); `origin=center` |
| `phosphor` | `trailCount=3` (1…6); `driftFraction=0.32` (0…0.5); `trailStrength=1` (0…1.5); `trailColor=0xFF50FFC8` (0…4294967295) |
| `louver` | `slatCount=8` (1…32); `axis=vertical`; `staggerFraction=0.25` (0…0.8); `shadowIntensity=0.35` (0…1); `rotationSense=forward` |
| `mirror` | `axis=vertical`; `side=leading`; `strength=1` (0…1) |
| `split` | `axis=horizontal`; `splitPosition=0.5` (0.2…0.8) |
| `stretch` | `axis=horizontal`; `maxScale=3` (1…4) |
| `lightLeak` | `direction=right`; `strength=1` (0…1.5); `radius=0.8` (0.3…1.2); `warmColor=0xFFFFC26B` (0…4294967295) |
| `glass` | `paneCount=8` (1…32); `axis=vertical`; `refractionStrength=1` (0…2); `glintStrength=1` (0…2) |
| `slice` | `stripCount=8` (1…32); `mode=slide`; `axis=horizontal`; `staggerFraction=0.32` (0…0.8); `pattern=alternating` |
| `lumaFade` | `order=brightFirst`; `softness=0.18` (0.02…0.5) |
| `pagePeel` | `corner=topRight`; `foldWidth=0.12` (0.04…0.25); `paperColor=0xFFFFFDF5` (0…4294967295); `shadowStrength=0.55` (0…1) |
| `noiseDissolve` | `noiseScale=28` (8…80); `softness=0.08` (0.01…0.2) |
| `rippleReveal` | `origin=center`; `waveAmplitude=0.045` (0…0.08); `waveFrequency=82` (20…140); `softness=0.025` (0.005…0.08) |
| `waterRefraction` | `origin=center`; `refractionStrength=0.012` (0…0.025); `waveFrequency=92` (40…140); `bandWidth=1` (0.5…1.5) |
| `cube` | `direction=left`; `shadowIntensity=0.5` (0…1); `perspectiveStrength=1` (0…1.25) |
| `accordion` | `direction=left`; `shadowIntensity=0.5` (0…1) |
| `depth` | `mode=recedeStill`; `scale=0.5` (0.2…1); `shadowIntensity=0.5` (0…1); `direction=left` |
| `parallax` | `clipAmount=200` (0…400); `direction=left` |
| `tablet` | `direction=left`; `tiltDegrees=45` (0…70); `perspectiveStrength=1` (0…1.25) |
| `zoomOut` | `zoomOutScale=0.8` (0.5…1); `enableOpacity=true`; `direction=left` |
| `fade` | `style=plain`; `blendCurve=linear`; `maxSigma=10` (0…30); `blurTarget=outgoing`; `color=0xFF000000` (0…4294967295); `holdFraction=0` (0…0.4); `fadeOutShare=0.5` (0.2…0.8) |
| `mosaic` | `gridSize=100` (100…200); `fadeFraction=0.3` (0…1); `direction=random`; `randomness=0.2` (0…1) |
| `liquidMorph` | `waveCount=12` (3…32); `waveIntensity=15` (0…60); `outgoingScale=1.1` (1…1.3); `origin=center` |
| `blinds` | `stripCount=10` (1…32); `axis=horizontal`; `order=forward`; `staggerFraction=0.5` (0…0.8) |
| `zoomOver` | `mode=over`; `startScale=1.5` (1…2); `outgoingScale=0.9` (0.7…2); `blurFraction=0` (0…0.03); `origin=center` |
| `slide` | `mode=push`; `direction=left`; `motionCurve=linear`; `blurFraction=0` (0…0.08); `decoration=none`; `edgeWidth=0.055` (0.02…0.1); `tiltDegrees=0` (-12…12); `shadowStrength=0` (0…0.6) |
| `revealMask` | `shape=wipe`; `direction=left`; `axis=horizontal`; `origin=topLeft`; `operation=revealIncoming`; `edgeStyle=hard`; `featherFraction=null` (0.005…0.3); `lightStrength=1` (0…1.5); `frameEnabled=false`; `borderWidth=0.004` (0…0.02); `borderColor=0xFFFFF4DC` (0…4294967295); `shadowStrength=0.8` (0…1); `pointCount=5` (3…12); `innerRadiusRatio=0.42` (0.2…0.8); `rotationDegrees=0` (0…359.999); `startAngleDegrees=0` (0…359.999); `circularDirection=clockwise` |
| `flip` | `axis=horizontal`; `rotationSense=forward`; `perspectiveStrength=1` (0…1.25) |
| `rotate` | `edge=top`; `angleDegrees=45` (0…90); `direction=left` |

У Kaleidoscope число секторов чётное. У Page Peel доступны четыре угла без
центра. У диагональной маски центр недопустим; переключение с центрированной
формы автоматически выбирает верхний левый угол, оставляя форму редактируемой.
Служебный Fade всегда обычный, с глобальным временем, независимо от пресетов.

**Water Refraction:** «Начало волны» — центр (default), верхний левый,
верхний правый, нижний левый или нижний правый угол. Радиус считается до самого
дальнего угла; маска и преломление используют одно начало. Точка волны не
меняет центр камеры Ken Burns. Water требует двух статичных фото; Ripple
Reveal допускает также GIF, видео и специальные экраны.

Canvas остаётся рабочим backend Mosaic; сетки 100×100, 150×150 и 200×200
сохраняются. Seed и диагностический выбор Canvas/shader не являются
сохраняемыми пользовательскими настройками. Фильтрация Water остаётся
16-точечной Catmull–Rom; исходные медиа не уменьшаются. FixedAnimationController
сохраняет плавное замедление под нагрузкой.

## Редактор config_app

В настройках слайдшоу отдельно открываются «Общие настройки слайдшоу»
и «Эффекты перехода». Каталог поддерживает поиск, группы, фильтры включённых
и изменённых настроек. В строке показаны включённость, эффективное время
и изменённые параметры. На широком окне параметры находятся рядом;
на узком открываются отдельным экраном с сохранением черновика.

В режиме **Общая** поле времени недоступно и показывает фактическую глобальную
длительность. Поле имеет одинаковые вертикальные отступы в обоих режимах.
Общая и своя длительность вводятся целым числом миллисекунд (1–3 600 000 мс),
например `1000` для одной секунды. Дробные значения не принимаются. Поле в режиме
**Общая** и строки каталога также показывают миллисекунды. Первое переключение
в **Своя** подставляет глобальное время. После временного переключения в Общая
восстанавливается последнее корректное своё значение текущего черновика. Оно не является
вторым сохраняемым параметром. Reload/сброс очищает временное значение.

Невалидный ввод сохраняется при выборе другой строки и блокирует Save.
Явный выбор Общая записывает 0 и снимает ошибку поля своей длительности.
Предпросмотр показывает последние корректные значения с пояснением ошибки;
быстрые изменения объединяются перед новой подготовкой. На странице эффектов
один выбранный тип управляет и формой, и предпросмотром. Выключенный эффект
можно просматривать без включения. В каталоге эффектов первый переход начинается
между двумя подготовленными фотографиями. Кнопка «Повторить» заново подготавливает
последнюю фотопару и запускает выбранный эффект с текущими параметрами;
время ожидания показа пропускается. Во время загрузки и паузы кнопка недоступна.
Под индикатор загрузки всегда выделено место: его появление не меняет высоту
предпросмотра и положение локальных элементов управления.
Предпросмотры слайдшоу и эффектов показывают только встроенные фото панели;
поле адреса видео и внешние источники тестовых медиа удалены. Они работают
при недоступном frontend после загрузки приложения и его assets. В Web assets
могут доставляться по HTTP с того же origin; сетевые камеры имеют отдельный
предпросмотр и прежние ограничения доступа.
Скрытие preview/уход со страницы
освобождают ресурсы по существующим правилам.

Цвет перехода, фон слайдшоу и цвета часов используют общий ColorPicker
([flutter_colorpicker 1.1.0](https://pub.dev/packages/flutter_colorpicker)).
Кнопка палитры рядом с AARRGGBB открывает выбор оттенка и прозрачности.
«Применить» переносит цвет в черновик и предпросмотр; «Отмена» сохраняет
предыдущий цвет и незавершённый ручной ввод. При закрытии редактора его
диалог также закрывается. Ручной ввод AARRGGBB остаётся доступен.

Невалидные сохранённые параметры показываются с предупреждением; форма
не создаёт контролы с недопустимыми значениями. Можно сбросить параметры
одного эффекта, сохранив его включённость, либо весь набор. Переполнение
JSON-чисел (например, `1e999`) сохраняется для диагностики как строка
`Infinity`/`-Infinity`: загрузка черновика работает, а `config_app` блокирует
Save до исправления. Запрос с невалидными настройками не отправляется.
Прямая запись через API не проверяет диапазоны и сочетания параметров.

«Сбросить параметры» возвращает default options, включая durationMs=0,
сохраняя включённость. Массовые действия меню относятся ко всему каталогу,
включая скрытые фильтром записи. Общий Save/Reload и защита выхода сохраняются.

## Проверки

Команды анализатора, VM unit/widget-тестов и генераторов приведены в
[общем руководстве тестирования](testing.md) и README соответствующих пакетов.
Генерацию Freezed/JSON запускают через `dart run build_runner build` из пакета
с изменёнными исходными моделями; локализации — через `flutter gen-l10n` из
`i18n/`. Генерация и web-сборка не нужны при изменении только документации.
Браузерные проверки требуют отдельного согласия пользователя.

Проверки включают JSON/хранение карты, удаление defaults, сохранение
выключенных персональных параметров, Fade для отсутствующего/пустого набора,
отказ Save в панели до отправки запроса, сохранение backend без валидации,
пустой набор, параметры фабрики,
влияние каждого активного поля на пиксели, пять начал волны, границы 3D, renderer,
видео/паузы/cleanup на рамке и в галерее, локальные asset-фото и очистку
предпросмотра, переключение Общая/Своя и адаптивный редактор на `en`.
Переводы и выбор языка проверяются отдельными сценариями RU/EN.
Матрица standard сохраняет 684 сценария: прежние варианты представлены
типизированными settings только внутри `benchmarks/`. В `effect_configs`
варианты сгруппированы по ключам типов, например
`"effect_configs":{"mosaic":[{"options":{"fadeFraction":0}},{"options":{"fadeFraction":0.3}}]}`.
В `effect_config` отчёта находится карта с одним ключом типа. ID и отчёт содержат
параметры; `options.durationMs=0` наследует `transition_ms` стенда.
`grids` стенда задаёт фактическую сетку матрицы поверх `gridSize` выбранной
записи; `effect_config` отчёта соответствует этой фактической сетке
(default 100 может быть опущен), а поле `grid` всегда содержит её явно.
Повторяющиеся ID сценариев отклоняются до запуска.

При объединении каталога 28.10.2026 пользователь принял визуальное
соответствие 82 пресетов. Условия, результаты и границы локальной приёмки
сохранены в [отчёте](../benchmarks/reports/effect-presets-2026-10-28/report.md).
Последующие аппаратные исследования имеют собственные сборки и условия;
они перечислены в [индексе отчётов](../benchmarks/reports/README.md).

## Соответствие пресетов

Таблица связывает прежние варианты с текущими пресетами. Имя пресета
не добавляет отдельную запись семейства в конфиг; сохраняются его `options`.

| Прежний тип | Пресет в config_app | Семейство |
| --- | --- | --- |
| `burnAlpha` | Выгорание (`burnAlpha`) | `burnAlpha` |
| `foldMotion` | Складывание (`foldMotion`) | `foldMotion` |
| `glow` | Свечение (`glow`) | `glow` |
| `kaleidoscope` | Калейдоскоп (`kaleidoscope`) | `kaleidoscope` |
| `tvPower` | Выключение телевизора (`tvPower`) | `tvPower` |
| `springMotion` | Пружина (`springMotion`) | `springMotion` |
| `shapeDissolve` | Растворение фигурами (`shapeDissolve`) | `shapeDissolve` |
| `vhsDamage` | Видеокассета (`vhsDamage`) | `vhsDamage` |
| `radialBlur` | Радиальное размытие (`radialBlur`) | `radialBlur` |
| `phosphor` | Послесвечение (`phosphor`) | `phosphor` |
| `filmDissolve` | Кинематографическое растворение (`filmDissolve`) | `fade` |
| `frame` | Рамка (`frame`) | `revealMask` |
| `louver` | Поворотные жалюзи (`louver`) | `louver` |
| `mirror` | Зеркало (`mirror`) | `mirror` |
| `clockWipe` | Часовое раскрытие (`clockWipe`) | `revealMask` |
| `split` | Раздвижение половин (`split`) | `split` |
| `panelWipe` | Раскрытие панелями (`panelWipe`) | `slice` |
| `stretch` | Растяжение (`stretch`) | `stretch` |
| `starWipe` | Раскрытие звездой (`starWipe`) | `revealMask` |
| `lightLeak` | Световая засветка (`lightLeak`) | `lightLeak` |
| `filmRoll` | Прокрутка плёнки (`filmRoll`) | `slide` |
| `crossZoom` | Встречный зум (`crossZoom`) | `zoomOver` |
| `whip` | Резкая панорама (`whip`) | `slide` |
| `glass` | Стекло (`glass`) | `glass` |
| `softWipe` | Мягкое раскрытие (`softWipe`) | `revealMask` |
| `slice` | Сдвиг полос (`slice`) | `slice` |
| `lumaFade` | Растворение по яркости (`lumaFade`) | `lumaFade` |
| `pagePeel` | Загиб страницы (`pagePeel`) | `pagePeel` |
| `noiseDissolve` | Растворение в шуме (`noiseDissolve`) | `noiseDissolve` |
| `rippleReveal` | Раскрытие волнами (`rippleReveal`) | `rippleReveal` |
| `waterRefraction` | Преломление воды (`waterRefraction`) | `waterRefraction` |
| `cube` | Куб (`cube`) | `cube` |
| `accordion` | Гармошка (`accordion`) | `accordion` |
| `backgroundToForeground` | Из фона на передний план (`backgroundToForeground`) | `depth` |
| `foregroundToBackground` | С переднего плана в фон (`foregroundToBackground`) | `depth` |
| `depth` | Глубина (`depth`) | `depth` |
| `parallax` | Параллакс (`parallax`) | `parallax` |
| `stack` | Стопка (`stack`) | `slide` |
| `tablet` | Планшет (`tablet`) | `tablet` |
| `zoomOut` | Уменьшение (`zoomOut`) | `zoomOut` |
| `fade` | Растворение (`fade`) | `fade` |
| `mosaic` | Мозаика (`mosaic`) | `mosaic` |
| `liquidMorph` | Жидкое преобразование (`liquidMorph`) | `liquidMorph` |
| `blinds` | Жалюзи (`blinds`) | `blinds` |
| `blurFade` | Растворение с размытием (`blurFade`) | `fade` |
| `zoomOver` | Увеличение поверх (`zoomOver`) | `zoomOver` |
| `slide` | Сдвиг (`slide`) | `slide` |
| `revealMask` | Раскрытие маской (`revealMask`) | `revealMask` |
| `fadeThroughColor` | Через цвет (`fadeThroughColor`) | `fade` |
| `flip` | Переворот (`flip`) | `flip` |
| `rotate` | Поворот (`rotate`) | `rotate` |
| `softWipe` | Световой проход (`softWipeLightSweep`) | `revealMask` |
| `softWipe` | Неоновое раскрытие (`softWipeNeon`) | `revealMask` |
| `fadeThroughColor` | Через белый (`fadeThroughWhite`) | `fade` |
| `flip` | Вертикальный переворот (`flipVertical`) | `flip` |
| `rotate` | Вращение от нижнего края (`rotateBottom`) | `rotate` |
| `mosaic` | Мозаика без затухания (`mosaicBinary`) | `mosaic` |
| `mosaic` | Мозаика из верхнего левого угла (`mosaicTopLeft`) | `mosaic` |
| `mosaic` | Мозаика из верхнего правого угла (`mosaicTopRight`) | `mosaic` |
| `mosaic` | Мозаика из нижнего левого угла (`mosaicBottomLeft`) | `mosaic` |
| `mosaic` | Мозаика из нижнего правого угла (`mosaicBottomRight`) | `mosaic` |
| `slide` | Вытеснение вправо (`slidePushRight`) | `slide` |
| `slide` | Вытеснение вверх (`slidePushUp`) | `slide` |
| `slide` | Вытеснение вниз (`slidePushDown`) | `slide` |
| `slide` | Наложение влево (`slideCoverLeft`) | `slide` |
| `slide` | Наложение вправо (`slideCoverRight`) | `slide` |
| `slide` | Наложение вверх (`slideCoverUp`) | `slide` |
| `slide` | Наложение вниз (`slideCoverDown`) | `slide` |
| `slide` | Открытие сдвигом влево (`slideRevealLeft`) | `slide` |
| `slide` | Открытие сдвигом вправо (`slideRevealRight`) | `slide` |
| `slide` | Открытие сдвигом вверх (`slideRevealUp`) | `slide` |
| `slide` | Открытие сдвигом вниз (`slideRevealDown`) | `slide` |
| `revealMask` | Раскрытие вправо (`wipeRight`) | `revealMask` |
| `revealMask` | Раскрытие вверх (`wipeUp`) | `revealMask` |
| `revealMask` | Раскрытие вниз (`wipeDown`) | `revealMask` |
| `revealMask` | Горизонтальная штора (`curtainHorizontal`) | `revealMask` |
| `revealMask` | Вертикальная штора (`curtainVertical`) | `revealMask` |
| `revealMask` | Диагональ из верхнего правого угла (`diagonalTopRight`) | `revealMask` |
| `revealMask` | Диагональ из нижнего левого угла (`diagonalBottomLeft`) | `revealMask` |
| `revealMask` | Диагональ из нижнего правого угла (`diagonalBottomRight`) | `revealMask` |
| `revealMask` | Диагональ из верхнего левого угла (`diagonalTopLeft`) | `revealMask` |
| `revealMask` | Круг из центра (`irisCenter`) | `revealMask` |
