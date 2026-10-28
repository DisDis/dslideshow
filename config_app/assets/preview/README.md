# Встроенные фотографии предпросмотра

Три оригинальных фотореалистичных изображения созданы 28 октября 2026 года
встроенным инструментом OpenAI `image_gen` по приведённым ниже запросам.
Это сгенерированные сцены, а не фотографии конкретных мест или работы стороннего
фотографа. Внешние URL и загрузка медиа во время работы не используются.

| Asset | Размер | Назначение |
| --- | --- | --- |
| [mountain_lake.jpg](mountain_lake.jpg) | 1536×1024 | Озеро, горы и мелкие детали растительности |
| [forest_trail.jpg](forest_trail.jpg) | 1024×1536 | Вертикальная композиция, поля и размытый фон |
| [coastal_cliffs.jpg](coastal_cliffs.jpg) | 1536×1024 | Светлые скалы, тёмное море и открытый горизонт |

Полученные PNG перекодированы в progressive JPEG: quality 90, без цветовой
субдискретизации (`subsampling=0`), без изменения размеров и обрезки.
Суммарный размер JPEG около 2,2 MiB. Регистрация в `pubspec.yaml` перечисляет
только эти файлы; этот README не входит в runtime assets.

Общий каталог `PreviewPhoto` задаёт идентичность и порядок источников.
Декодированием через `DefaultAssetBundle`, подготовленным bitmap и Ken Burns
владеет `AssetPhotoSlideSession`. Настройки композиции не записываются в файлы:
размытый фон, viewport и движение применяются во время подготовки сессии.

## Запросы генерации

`mountain_lake.jpg`:

> Use case: photorealistic-natural. Asset type: original built-in demo photograph for a digital photo frame slideshow. Generate one natural photographic alpine landscape: a turquoise mountain lake with sharp rocky peaks, green trees along shore, clear morning sky with light clouds, natural detailed textures. Wide landscape 3:2 composition. Realistic travel photography, gentle natural light, rich but believable colors. No people, buildings, text, watermark, border or collage. This is an original standalone image, no imitation of any specific photographer.

`forest_trail.jpg`:

> Use case: photorealistic-natural. Asset type: original built-in demo photograph for a digital photo frame slideshow. Generate one natural photograph of a peaceful forest trail under tall deciduous trees, dappled warm sunlight and ferns, visible depth and fine leaf textures. Tall portrait 2:3 composition to demonstrate letterboxing and blurred background on a landscape display. Realistic travel photography, natural believable colors. No people, buildings, text, watermark, border or collage. This is an original standalone image, no imitation of any specific photographer.

`coastal_cliffs.jpg`:

> Use case: photorealistic-natural. Asset type: original built-in demo photograph for a digital photo frame slideshow. Generate one natural coastal landscape photograph: rugged cream sea cliffs and rolling green coastal grass above deep blue sea, distant headland, bright soft sky, gentle waves and detailed rock textures. Wide landscape 3:2 composition, calm late afternoon natural lighting and believable colors. No people, buildings, text, watermark, border or collage. This is an original standalone image, no imitation of any specific photographer.
