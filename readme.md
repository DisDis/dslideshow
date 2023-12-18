Flutter photoframe on Raspberry pi 4 with PIR, GPIO. (Google photo, local storage)

Prototype 2:
![Proto2_1](https://raw.githubusercontent.com/DisDis/dslideshow/master/doc/images/proto2_1.jpg)
![Proto2_2](https://raw.githubusercontent.com/DisDis/dslideshow/master/doc/images/proto2_2.jpg)
![Proto2_3](https://raw.githubusercontent.com/DisDis/dslideshow/master/doc/images/proto2_3.jpg)
![Proto2_4](https://raw.githubusercontent.com/DisDis/dslideshow/master/doc/images/proto2_4.jpg)


Video: https://youtu.be/NFGFnHmX0TY


Backcover prototype:

![Backcover](https://raw.githubusercontent.com/DisDis/dslideshow/master/doc/images/animation.gif)

Hardware:

1 * RaPi4 (min 512Mb)

1 * LED (something like LED Diode 5 mm) [Optional]

1 * 100Ohm resistor [Optional]

4 * Button [Optional]

1 * 10K Ohm resistor [Optional]

4 * 33K Ohm resistor [Optional]

1 * PIR sensor - AM312 (https://aliexpress.com/item/32862878941.html?&sku_id=65345259272) [Optional]

1 * 2560*1600 Display (TFTMD089030 + Driver TC358870XBG) (https://aliexpress.com/item/1005002008224190.html)

1 * Power supply 30W (9-30V)

1 * Power supply port

1 * DC-DC 9-30V -> 5V5A (https://aliexpress.com/item/32763711912.html)

1 * MiniUSB connector male

1 * USB Type-C connector male

1 * HDMI - Micro-HDMI (30cm?)


https://easyeda.com/igor.demyanov/dslideshow

TODO:

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
  * Настройка индикаций
