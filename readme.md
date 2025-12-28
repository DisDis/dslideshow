Flutter photoframe on Raspberry Pi 4/5 with Human detection, buttons. (Google photo, local storage)

Features:
* Shows a slideshow with different effects.
* Pause/Play
* Screen On/Off
* Support Image/GIF/Video
* Support 2560x1600 resolution
* [Optional] Shows media only when there are people nearby. Fall asleep if there is no movement nearby.
* [Optional/**WIP**] Can download photos/video from Google Photo (non-trivial setting)  
* Over-the-air update (OTA)
* Support MQTT
* Web config [**Work in Progress**]

# Demo version - v7
[![Demo](https://img.youtube.com/vi/eRx7BAgu3N0/0.jpg)](https://youtu.be/eRx7BAgu3N0)

# Common view
![3d_1.png](https://raw.githubusercontent.com/DisDis/article-dslideshow/master/images/v7/3d_1.png)
![3d_2.png](https://raw.githubusercontent.com/DisDis/article-dslideshow/master/images/v7/3d_2.png)
![common_1.jpg](https://raw.githubusercontent.com/DisDis/article-dslideshow/master/images/v7/common_1.jpg)
![common_2.jpg](https://raw.githubusercontent.com/DisDis/article-dslideshow/master/images/v7/common_2.jpg)

More [info](https://github.com/DisDis/article-dslideshow)


# TODO:

* Выкачивать во временную папку.
* [+]Выводить сплеш скрин при старте(выводить версию)
* Получать данные из разных источников
  * [+]Гугл фото
  * [+]Папка на диске
  * ftp
  * samba
  * ssh
* Кэшировать изображения локально:
  * Настроить размер кэша?
  * Если нет доступа к источникам показывать из кэша
  * Если нет доступа к источникам выводить индикацию(красный значёк разрыва связи в правом углу)
* [*]Отключать дисплей если:
  * [+]Нажата кнопка выключить дисплей
  * Темно (Датчик освещённости)
  * [+]Рядом нет движения больше 30 минут.(Датчик присутствия)
* [+] При включении дисплея показывать анимацию(Из тёмноты)
* [+] При выключении дисплея показывать анимацию(В темноту)
* [+]Когда дисплей отключается сохраняется состояние и ничего не меняется
* [+]Когда дисплей влкючается востанавливается состояние и процесс запускается
* [+]Можно остановить воспроизведение(Пауза/Воспроизведение) через кнопку.
* [+]Индикация паузы.
* Физ. кнопка сброса настроек
* Физ. кнопка перезагрузки
* Индикация FPS
* [+]Индикация времени до смены изображения (тонкая полоска снизу)
* Индикация кол-ва изображений и текущую позицию(тонкая полоска сверху)
* [*]Индикатор питания (Очень тусклый)
* Кнопка выключения(выключается через 5 секунд, ведёт отсчёт)
* [+] Уметь выводить отладочную информацию
* [+] Анимация при смене изображений
* [*] Проигрывать видео, ожидать окончания видио
* [+] Поддерживать gif анимацию
* Автоматически обновлять на новую версию(нажимая на клавишу пауза для согласия, иначе 5 секунд и всё дальше грузится).
* Алгоритм показа:
  * Показывать новый чаще
  * Показывать все изображения равномерно по кол-ву
* Востанавливать состояние при включении(продолжать с того же места)
* [+] Support MQTT
* Конфигурация:
  * [+] Время между изображениями
  * Выводить дату изображения?
  * [+] Настройка индикаций
