// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get password => 'Пароль';

  @override
  String get username => 'Имя пользователя';

  @override
  String get helloWorld => 'Привет, мир!';

  @override
  String get english => 'Английский';

  @override
  String get russian => 'Русский';

  @override
  String home_userid(String userId) {
    return 'Пользователь: \'$userId\'';
  }

  @override
  String get home_page_name => 'Главная';

  @override
  String get home_page_logout_button => 'Выйти';

  @override
  String get login_page_name => 'Вход';

  @override
  String admin_account_info_title(String title) {
    return 'Название: $title';
  }

  @override
  String get upload_queue_title => 'Очередь загрузки';

  @override
  String get add_files_menu_item => 'Добавить файлы';

  @override
  String get add_folder_menu_item => 'Добавить папку';

  @override
  String get queue_is_empty => 'Очередь пуста';

  @override
  String get no_images_found_in_folder => 'В папке не найдены изображения';

  @override
  String get authentication_failure => 'Ошибка входа';

  @override
  String get ota_update_title => 'Обновление прошивки';

  @override
  String get unknown_state => 'Неизвестное состояние';

  @override
  String get initialize_button => 'Подготовить';

  @override
  String get select_file_button => 'Выбрать файл';

  @override
  String get update_button => 'Обновить';

  @override
  String get reset_button => 'Сбросить';

  @override
  String get home_menu_item => 'Главная';

  @override
  String get gallery_menu_item => 'Галерея';

  @override
  String get upload_media_menu_item => 'Загрузка медиа';

  @override
  String get configuration_menu_item => 'Настройки';

  @override
  String get wifi_menu_item => 'Wi-Fi';

  @override
  String get system_control_menu_item => 'Управление устройством';

  @override
  String get exit_menu_item => 'Выйти';

  @override
  String get storage_settings_title => 'Настройки хранилища';

  @override
  String get unknown_storage_type_configuration => 'Неизвестный тип хранилища';

  @override
  String get no_configuration_needed_for_local_disk =>
      'Для локального диска дополнительные настройки пока не нужны.';

  @override
  String get slideshow_settings_title => 'Настройки слайд-шоу';

  @override
  String get background_opacity => 'Непрозрачность фона';

  @override
  String get config_save_button => 'Сохранить';

  @override
  String get config_reload_button => 'Загрузить заново';

  @override
  String get config_unsaved_changes => 'Есть несохранённые изменения';

  @override
  String get config_saved_state => 'Нет несохранённых изменений';

  @override
  String get config_restart_hint =>
      'Сохранённые настройки вступят в силу после перезапуска приложения.';

  @override
  String get config_reload_title => 'Загрузить настройки заново?';

  @override
  String get config_reload_warning =>
      'Отменить изменения и загрузить сохранённые настройки с устройства?';

  @override
  String get config_leave_warning =>
      'Изменения не сохранены. Отменить их и выйти из настроек?';

  @override
  String get config_keep_editing => 'Продолжить редактирование';

  @override
  String get config_discard_changes => 'Отменить изменения';

  @override
  String get config_operation_in_progress =>
      'Дождитесь завершения текущей операции с настройками.';

  @override
  String get config_load_failed => 'Не удалось загрузить настройки';

  @override
  String get config_saved_successfully => 'Настройки сохранены';

  @override
  String get config_is_reloading => 'Загрузка настроек…';

  @override
  String get settings_title => 'Настройки';

  @override
  String get select_items_dialog_title => 'Выберите элементы';

  @override
  String get cancel_button => 'Отмена';

  @override
  String get ok_button => 'ОК';

  @override
  String get not_found => 'Не найдено';

  @override
  String get no_access_title => 'Нет доступа';

  @override
  String get no_access_contact_administrator =>
      'Нет доступа. Обратитесь к администратору.';

  @override
  String get ch_text => 'Канал:';

  @override
  String get device_text => 'Устройство:';

  @override
  String get connect_form_title => 'Настройки Wi-Fi';

  @override
  String get connect_button => 'Подключить';

  @override
  String get gallery_title => 'Галерея';

  @override
  String get system_control_title => 'Управление устройством';

  @override
  String get try_again_button => 'Повторить';

  @override
  String get error_text => 'Ошибка';

  @override
  String get welcome_back => 'С возвращением!';

  @override
  String get manage_your_device_settings_and_updates =>
      'Управляйте настройками и обновлениями фоторамки.';

  @override
  String get gallery_card_title => 'Галерея';

  @override
  String get view_media_subtitle => 'Просмотр медиа';

  @override
  String get upload_card_title => 'Загрузка';

  @override
  String get upload_media_subtitle => 'Загрузить медиа';

  @override
  String get ota_update_card_title => 'Обновление прошивки';

  @override
  String get firmware_upgrade_subtitle => 'Установка новой версии';

  @override
  String get wifi_setup_card_title => 'Настройки Wi-Fi';

  @override
  String get manage_connections_subtitle => 'Управление подключениями';

  @override
  String get configuration_card_title => 'Настройки';

  @override
  String get system_settings_subtitle => 'Настройки системы';

  @override
  String get system_control_card_title => 'Управление устройством';

  @override
  String get restart_app_power_off_subtitle => 'Перезапуск и выключение';

  @override
  String get mqtt_settings_title => 'Настройки MQTT';

  @override
  String get webserver_settings_title => 'Настройки веб-сервера';

  @override
  String get welcome_settings_title => 'Настройки приветствия';

  @override
  String get saved_connections_subtitle => 'Сохранённые подключения';

  @override
  String get no_networks_found_nearby => 'Поблизости не найдено сетей';

  @override
  String get add_network => 'Добавить сеть';

  @override
  String get connect_to_network => 'Подключиться к сети';

  @override
  String get ssid_name_label => 'SSID (имя сети)';

  @override
  String get required_field => 'Обязательное поле';

  @override
  String get connection_failed => 'Не удалось подключиться';

  @override
  String get power_management_title => 'Управление питанием';

  @override
  String get choose_action_on_device => 'Выберите действие для устройства';

  @override
  String get restart_application => 'Перезапустить приложение';

  @override
  String get reload_software_without_rebooting_os =>
      'Перезапускает приложение без перезагрузки операционной системы.';

  @override
  String get restart_application_question => 'Перезапустить приложение?';

  @override
  String get this_will_reload_configuration_app_and_slideshow_services =>
      'Службы панели настройки и слайд-шоу будут перезапущены.';

  @override
  String get restart => 'Перезапустить';

  @override
  String get power_off => 'Выключить';

  @override
  String get safely_shuts_down_the_device_operating_system =>
      'Безопасно завершает работу операционной системы устройства.';

  @override
  String get power_off_device_question => 'Выключить устройство?';

  @override
  String get the_device_will_shut_down_completely =>
      'Устройство будет полностью выключено. Для повторного включения потребуется физический доступ к нему.';

  @override
  String get power_off_button => 'Выключить';

  @override
  String get please_sign_in_to_continue => 'Войдите, чтобы продолжить';

  @override
  String get server_uri => 'Адрес сервера';

  @override
  String get invalid_uri => 'Некорректный адрес';

  @override
  String get invalid_username => 'Некорректное имя пользователя';

  @override
  String get invalid_password => 'Некорректный пароль';

  @override
  String get sign_in => 'Войти';

  @override
  String not_found_with_id(String id) {
    return 'Не найдено: «$id»';
  }

  @override
  String transition_display_times(int transitionTime, int displayTime) {
    return 'Переход: $transitionTime мс\nПоказ: $displayTime мс';
  }

  @override
  String get wifi_5ghz_label => '5 ГГц';

  @override
  String channel_text(int channel) {
    return 'Канал: $channel';
  }

  @override
  String device_connection_info(String device, String type) {
    return 'Устройство: $device • $type';
  }

  @override
  String get slideshow_section_title => 'Слайд-шоу';

  @override
  String get general_and_effects_title => 'Основные настройки и эффекты';

  @override
  String get welcome_screen_title => 'Экран приветствия';

  @override
  String get storage_configuration_title => 'Настройки хранилища';

  @override
  String get using_local_disk => 'Используется локальный диск';

  @override
  String get using_google_photos => 'Используется Google Фото';

  @override
  String get connectivity_title => 'Подключения';

  @override
  String get web_server_settings_title => 'Веб-сервер';

  @override
  String get mqtt_title => 'MQTT';

  @override
  String get hardware_title => 'Оборудование';

  @override
  String get gpio_smoothing_label => 'Сглаживание GPIO (мс)';

  @override
  String get logging_levels_title => 'Уровни журналирования';

  @override
  String get main_logic_label => 'Основная логика';

  @override
  String get ota_update_label => 'Обновление прошивки';

  @override
  String get hardware_frame_label => 'Оборудование фоторамки';

  @override
  String get storage_title => 'Хранилище';

  @override
  String get retry_button => 'Повторить';

  @override
  String error_with_message(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get example_email_address => 'example@gmail.com';

  @override
  String get special_screens_title => 'Специальные экраны';

  @override
  String get special_screen_clock => 'Дата и время';

  @override
  String get special_screen_cameras => 'Камеры';

  @override
  String get special_add_screen => 'Добавить экран';

  @override
  String get special_empty => 'Добавьте в слайд-шоу часы или экран с камерами.';

  @override
  String get special_name => 'Название';

  @override
  String get special_enabled => 'Включён';

  @override
  String get special_delete => 'Удалить';

  @override
  String get special_done => 'Готово';

  @override
  String get special_cancel => 'Отмена';

  @override
  String get special_preview => 'Предпросмотр';

  @override
  String get special_preview_unavailable =>
      'Предпросмотр недоступен. Проверьте адрес камеры и доступ к сети.';

  @override
  String get special_next_camera => 'Следующая камера';

  @override
  String get special_common => 'Показ';

  @override
  String get special_frequency => 'Показывать';

  @override
  String get special_after_slides => 'После медиафайлов';

  @override
  String get special_interval => 'Через интервал активного показа';

  @override
  String get special_slide_count => 'Количество фото / видео';

  @override
  String get special_interval_minutes => 'Интервал (минуты)';

  @override
  String get special_duration_seconds => 'Продолжительность показа (секунды)';

  @override
  String get special_seconds => 'с';

  @override
  String get special_minutes => 'мин';

  @override
  String get special_clock_settings => 'Внешний вид часов';

  @override
  String get special_time_format => 'Формат времени';

  @override
  String get special_24h => '24 часа';

  @override
  String get special_12h => '12 часов (AM/PM)';

  @override
  String get special_show_seconds => 'Показывать секунды';

  @override
  String get special_show_date => 'Показывать дату';

  @override
  String get special_date_format => 'Формат даты';

  @override
  String get special_time_size =>
      'Размер времени (% от короткой стороны экрана)';

  @override
  String get special_date_size =>
      'Размер даты и дня недели (% от короткой стороны экрана)';

  @override
  String get special_text_color => 'Цвет текста (AARRGGBB)';

  @override
  String get special_background_color => 'Цвет фона (AARRGGBB)';

  @override
  String get special_camera_settings => 'Отображение камер';

  @override
  String get special_camera_mode => 'Режим отображения';

  @override
  String get special_grid => 'Все камеры в сетке';

  @override
  String get special_sequence => 'Одна камера за показ';

  @override
  String get special_sequence_help =>
      'При каждом появлении экрана показывается следующая камера из списка.';

  @override
  String get special_columns => 'Столбцы сетки (0 = автоматически)';

  @override
  String get special_fit => 'Размещение изображения';

  @override
  String get special_contain => 'Изображение целиком';

  @override
  String get special_cover => 'Заполнение с обрезкой';

  @override
  String get special_show_names => 'Показывать названия камер';

  @override
  String get special_refresh =>
      'Обновление (секунды; 0 = только при появлении)';

  @override
  String get special_add_camera => 'Добавить камеру';

  @override
  String get special_camera_url => 'Адрес снимка (HTTP/HTTPS, JPEG/PNG)';

  @override
  String get special_check_camera => 'Проверить снимок';

  @override
  String get special_move_up => 'Переместить выше';

  @override
  String get special_move_down => 'Переместить ниже';

  @override
  String get special_invalid_number => 'Введите число в допустимом диапазоне.';

  @override
  String get special_invalid_url => 'Введите адрес HTTP/HTTPS.';

  @override
  String get special_invalid_color =>
      'Введите 8 шестнадцатеричных цифр (AARRGGBB).';

  @override
  String get special_camera_required => 'Добавьте хотя бы одну камеру.';

  @override
  String get special_unsupported => 'Неподдерживаемый тип экрана';

  @override
  String get special_auth => 'Аутентификация (необязательно)';

  @override
  String get special_save_hint =>
      'Нажмите «Сохранить» на главной странице настроек, чтобы записать изменения на устройство.';

  @override
  String get special_browser_camera_help =>
      'Камеры для предпросмотра загружаются напрямую из этого браузера. Камера должна разрешать доступ из браузера (CORS). Для страницы HTTPS адрес камеры также должен использовать HTTPS.';

  @override
  String get photo_motion_title => 'Движение фото';

  @override
  String get photo_motion_off => 'Выключено';

  @override
  String get photo_motion_ken_burns =>
      'Кен Бёрнс (плавное движение и увеличение)';

  @override
  String get photo_motion_zoom => 'Максимальное увеличение';

  @override
  String get water_photo_only =>
      'Для эффекта «Преломление воды» нужны два неподвижных фото. Для GIF и видео используется другой разрешённый переход.';

  @override
  String get preview_video_url => 'Адрес видео (необязательно)';

  @override
  String get preview_play => 'Предпросмотр';

  @override
  String get effect_noise_dissolve => 'Растворение в шуме';

  @override
  String get effect_ripple_reveal => 'Раскрытие волнами';

  @override
  String get effect_water_refraction => 'Преломление воды';

  @override
  String get ui_system_default => 'Как в системе';

  @override
  String get app_title => 'Фоторамка';

  @override
  String get appearance_title => 'Оформление';

  @override
  String get language_label => 'Язык';

  @override
  String get theme_mode_label => 'Тема';

  @override
  String get theme_mode_light => 'Светлая';

  @override
  String get theme_mode_dark => 'Тёмная';

  @override
  String get device_panel_title => 'Фоторамка';

  @override
  String get device_settings_description =>
      'Медиафайлы, оформление и настройки устройства.';

  @override
  String get connection_title => 'Подключение';

  @override
  String get authentication_title => 'Авторизация';

  @override
  String get enabled_label => 'Включено';

  @override
  String get disabled_label => 'Выключено';

  @override
  String get server_host_label => 'Адрес сервера';

  @override
  String get port_label => 'Порт';

  @override
  String get permanent_code_label => 'Постоянный код доступа';

  @override
  String get always_enabled_label => 'Всегда включён';

  @override
  String get active_storage_label => 'Активное хранилище';

  @override
  String get provider_label => 'Тип хранилища';

  @override
  String get local_disk_label => 'Локальный диск';

  @override
  String get google_photos_label => 'Google Фото';

  @override
  String get auth_refresh_token_label => 'Токен обновления';

  @override
  String get client_id_label => 'ID клиента';

  @override
  String get client_secret_label => 'Секрет клиента';

  @override
  String get upload_from_disk_label => 'Загружать фото с диска';

  @override
  String get image_width_label => 'Ширина изображения';

  @override
  String get image_height_label => 'Высота изображения';

  @override
  String get show_secret => 'Показать значение';

  @override
  String get hide_secret => 'Скрыть значение';

  @override
  String get items_none => 'Ничего не выбрано';

  @override
  String get items_all => 'Выбраны все';

  @override
  String items_selected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выбрано $count элемента',
      many: 'Выбрано $count элементов',
      few: 'Выбрано $count элемента',
      one: 'Выбран $count элемент',
      zero: 'Ничего не выбрано',
    );
    return '$_temp0';
  }

  @override
  String get config_editor_draft_hint =>
      'Изменения остаются в черновике. Для записи на устройство нажмите «Сохранить» в настройках.';

  @override
  String get config_reset_button => 'Отменить правки';

  @override
  String get invalid_port => 'Введите порт от 1 до 65535.';

  @override
  String get invalid_positive_integer => 'Введите целое положительное число.';

  @override
  String get invalid_nonnegative_integer =>
      'Введите ноль или целое положительное число.';

  @override
  String slideshow_summary(num seconds) {
    final intl.NumberFormat secondsNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String secondsString = secondsNumberFormat.format(seconds);

    return 'Показ фото: $secondsString с';
  }

  @override
  String special_enabled_summary(int enabled, int total) {
    return 'Включено $enabled из $total';
  }

  @override
  String get preview_title => 'Предпросмотр';

  @override
  String get preview_local_controls =>
      'Локальные инструменты предпросмотра — не сохраняются';

  @override
  String get preview_hide => 'Скрыть предпросмотр';

  @override
  String get preview_show => 'Показать предпросмотр';

  @override
  String get preview_effect => 'Эффект для предпросмотра';

  @override
  String get preview_aspect => 'Пропорции экрана';

  @override
  String get preview_pause => 'Пауза';

  @override
  String get preview_resume => 'Продолжить';

  @override
  String get preview_failed =>
      'Не удалось загрузить медиа. Проверьте адрес и доступ к сети.';

  @override
  String get preview_last_valid =>
      'Показаны последние допустимые значения. Исправьте отмеченные поля.';

  @override
  String get preview_device_scale => 'Масштаб относительно экрана 2560 × 1600';

  @override
  String get preview_environment_help =>
      'Тестовые медиа загружаются из сети. Предпросмотр не подтверждает поддержку кодеков устройством.';

  @override
  String get preview_clock_help => 'Используется время этого компьютера';

  @override
  String get timing_title => 'Время показа';

  @override
  String get display_time_ms => 'Продолжительность показа (мс)';

  @override
  String get transition_time_ms => 'Продолжительность перехода (мс)';

  @override
  String get visuals_title => 'Внешний вид';

  @override
  String get allowed_transitions => 'Разрешённые переходы';

  @override
  String get allowed_transitions_all => 'Пустой список разрешает все переходы';

  @override
  String get blur_background => 'Размывать фон';

  @override
  String get background_blur_sigma => 'Размытие фона';

  @override
  String get background_color_argb => 'Цвет фона (AARRGGBB)';

  @override
  String get welcome_text => 'Текст приветствия';

  @override
  String get welcome_text_size => 'Размер текста';

  @override
  String get welcome_delay_ms => 'Продолжительность фазы анимации (мс)';

  @override
  String get welcome_replay => 'Повторить приветствие';

  @override
  String get welcome_animation_help =>
      'Приветствие плавно появляется и исчезает; длительность каждой фазы задаётся задержкой';

  @override
  String get invalid_positive_number => 'Введите положительное число.';

  @override
  String get effect_cube => 'Куб';

  @override
  String get effect_accordion => 'Гармошка';

  @override
  String get effect_background_to_foreground => 'Из фона на передний план';

  @override
  String get effect_foreground_to_background => 'С переднего плана в фон';

  @override
  String get effect_default => 'Сдвиг';

  @override
  String get effect_depth => 'Глубина';

  @override
  String get effect_flip_horizontal => 'Горизонтальный переворот';

  @override
  String get effect_flip_vertical => 'Вертикальный переворот';

  @override
  String get effect_parallax => 'Параллакс';

  @override
  String get effect_stack => 'Стопка';

  @override
  String get effect_tablet => 'Планшет';

  @override
  String get effect_rotate_down => 'Поворот вниз';

  @override
  String get effect_rotate_up => 'Поворот вверх';

  @override
  String get effect_zoom_out_slide => 'Уменьшение';

  @override
  String get effect_fade => 'Растворение';

  @override
  String get effect_mosaic => 'Мозаика';

  @override
  String get effect_mosaic_fade => 'Растворение мозаикой';

  @override
  String get effect_mosaic_tl_fade => 'Мозаика из верхнего левого угла';

  @override
  String get effect_mosaic_br_fade => 'Мозаика из нижнего правого угла';

  @override
  String get effect_liquid_morph => 'Жидкое преобразование';

  @override
  String get effect_blinds => 'Жалюзи';

  @override
  String get effect_blur_fade => 'Растворение с размытием';

  @override
  String get effect_zoom_over => 'Увеличение поверх';

  @override
  String get effect_mosaic_tr_fade => 'Мозаика из верхнего правого угла';

  @override
  String get effect_mosaic_bl_fade => 'Мозаика из нижнего левого угла';

  @override
  String get effect_wipe_left => 'Открытие влево';

  @override
  String get effect_wipe_right => 'Открытие вправо';

  @override
  String get effect_wipe_up => 'Открытие вверх';

  @override
  String get effect_wipe_down => 'Открытие вниз';

  @override
  String get effect_curtain_horizontal => 'Горизонтальные шторы';

  @override
  String get effect_curtain_vertical => 'Вертикальные шторы';

  @override
  String get effect_diagonal_top_left => 'По диагонали из верхнего левого угла';

  @override
  String get effect_diagonal_top_right =>
      'По диагонали из верхнего правого угла';

  @override
  String get effect_diagonal_bottom_left =>
      'По диагонали из нижнего левого угла';

  @override
  String get effect_diagonal_bottom_right =>
      'По диагонали из нижнего правого угла';

  @override
  String get effect_iris => 'Диафрагма';

  @override
  String get effect_fade_through_black => 'Через чёрный';

  @override
  String get effect_fade_through_white => 'Через белый';

  @override
  String get effect_push_right => 'Выталкивание вправо';

  @override
  String get effect_push_up => 'Выталкивание вверх';

  @override
  String get effect_push_down => 'Выталкивание вниз';

  @override
  String get effect_cover_right => 'Накрытие вправо';

  @override
  String get effect_cover_up => 'Накрытие вверх';

  @override
  String get effect_cover_down => 'Накрытие вниз';

  @override
  String get effect_reveal_left => 'Снятие влево';

  @override
  String get effect_reveal_right => 'Снятие вправо';

  @override
  String get effect_reveal_up => 'Снятие вверх';

  @override
  String get effect_reveal_down => 'Снятие вниз';

  @override
  String get sync_settings_title => 'Синхронизация';

  @override
  String get sync_period_label => 'Период синхронизации';

  @override
  String get albums_title => 'Альбомы';

  @override
  String get album_names_label => 'Названия альбомов через запятую';

  @override
  String get pixels_unit => 'пикс.';

  @override
  String get minutes_unit => 'мин';

  @override
  String get milliseconds_unit => 'мс';

  @override
  String get config_reset_warning =>
      'Отменить все правки и восстановить последние загруженные или сохранённые настройки?';

  @override
  String get refresh_button => 'Обновить';

  @override
  String get add_manually => 'Добавить вручную';

  @override
  String get delete_connection => 'Удалить подключение';

  @override
  String get forget_network_title => 'Забыть сеть?';

  @override
  String forget_network_question(String name) {
    return 'Удалить сохранённое подключение «$name»?';
  }

  @override
  String get delete_button => 'Удалить';

  @override
  String get ota_code_label => 'Код обновления';

  @override
  String ota_version(String version) {
    return 'Версия: $version';
  }

  @override
  String get ota_uploading => 'Загрузка прошивки…';

  @override
  String get ota_upload_complete => 'Прошивка загружена.';

  @override
  String gallery_selected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выбрано $count файла',
      many: 'Выбрано $count файлов',
      few: 'Выбрано $count файла',
      one: 'Выбран $count файл',
    );
    return '$_temp0';
  }

  @override
  String get clear_selection => 'Снять выделение';

  @override
  String get gallery_empty => 'Медиафайлов пока нет.';

  @override
  String get upload_empty_hint =>
      'Добавьте фото и видео для показа на фоторамке.';

  @override
  String get upload_remove_task => 'Убрать из очереди';

  @override
  String get video_load => 'Загрузить видео';

  @override
  String get video_tap_to_play => 'Нажмите для воспроизведения';

  @override
  String get media_info => 'Информация о файле';

  @override
  String get invalid_editor_leave_warning =>
      'В форме есть некорректные значения. Отбросить незавершённый ввод и вернуться к настройкам?';

  @override
  String get discard_invalid_input => 'Отбросить ввод';

  @override
  String get special_no_image => 'Нет изображения';

  @override
  String get special_request_timeout => 'Таймаут снимка (секунды)';

  @override
  String get special_request_timeout_help =>
      'Время ожидания одного снимка: 0,1–120 секунд. Недоступное изображение заменяется сообщением.';

  @override
  String get special_time_font => 'Шрифт времени';

  @override
  String get special_date_font => 'Шрифт даты и дня недели';

  @override
  String get special_show_weekday => 'Показывать день недели';

  @override
  String get special_font_system => 'Шрифт по умолчанию';

  @override
  String get special_font_roboto => 'Roboto';

  @override
  String get special_font_orbitron => 'Orbitron';

  @override
  String get special_font_righteous => 'Righteous';

  @override
  String get special_font_fredoka => 'Fredoka One';

  @override
  String get special_font_help =>
      'Шрифты встроены и работают без сети. Отсутствующие в декоративном шрифте символы выводятся запасным шрифтом.';

  @override
  String get special_weekday_monday => 'Понедельник';

  @override
  String get special_weekday_tuesday => 'Вторник';

  @override
  String get special_weekday_wednesday => 'Среда';

  @override
  String get special_weekday_thursday => 'Четверг';

  @override
  String get special_weekday_friday => 'Пятница';

  @override
  String get special_weekday_saturday => 'Суббота';

  @override
  String get special_weekday_sunday => 'Воскресенье';
}
