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
  String get gallery_load_failed => 'Не удалось загрузить галерею.';

  @override
  String get gallery_refresh_failed =>
      'Не удалось обновить галерею. Предыдущий список остаётся доступен.';

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
  String get preview_repeat => 'Повторить';

  @override
  String get effect_burn_alpha => 'Выгорание';

  @override
  String get effect_fold_motion => 'Складывание';

  @override
  String get effect_glow => 'Свечение';

  @override
  String get effect_kaleidoscope => 'Калейдоскоп';

  @override
  String get effect_tv_power => 'Выключение телевизора';

  @override
  String get effect_spring_motion => 'Пружина';

  @override
  String get effect_shape_dissolve => 'Растворение фигурами';

  @override
  String get effect_vhs_damage => 'Видеокассета';

  @override
  String get effect_radial_blur => 'Радиальное размытие';

  @override
  String get effect_phosphor => 'Послесвечение';

  @override
  String get effect_film_dissolve => 'Кинематографическое растворение';

  @override
  String get effect_frame => 'Рамка';

  @override
  String get effect_louver => 'Поворотные жалюзи';

  @override
  String get effect_mirror => 'Зеркало';

  @override
  String get effect_clock_wipe => 'Часовое раскрытие';

  @override
  String get effect_split => 'Раздвижение половин';

  @override
  String get effect_panel_wipe => 'Раскрытие панелями';

  @override
  String get effect_stretch => 'Растяжение';

  @override
  String get effect_star_wipe => 'Раскрытие звездой';

  @override
  String get effect_light_leak => 'Световая засветка';

  @override
  String get effect_film_roll => 'Прокрутка плёнки';

  @override
  String get effect_cross_zoom => 'Встречный зум';

  @override
  String get effect_whip => 'Резкая панорама';

  @override
  String get effect_glass => 'Стекло';

  @override
  String get effect_soft_wipe => 'Мягкое раскрытие';

  @override
  String get effect_slice => 'Полосы';

  @override
  String get effect_luma_fade => 'Растворение по яркости';

  @override
  String get effect_page_peel => 'Загиб страницы';

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
      'Не удалось подготовить предпросмотр. Повторите попытку.';

  @override
  String get preview_last_valid =>
      'Показаны последние допустимые значения. Исправьте отмеченные поля.';

  @override
  String get preview_device_scale => 'Масштаб относительно экрана 2560 × 1600';

  @override
  String get preview_environment_help =>
      'Используются встроенные фотографии. Внешние медиа не загружаются.';

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
  String get effect_depth => 'Глубина';

  @override
  String get effect_parallax => 'Параллакс';

  @override
  String get effect_stack => 'Стопка';

  @override
  String get effect_tablet => 'Планшет';

  @override
  String get effect_zoom_out_slide => 'Уменьшение';

  @override
  String get effect_fade => 'Растворение';

  @override
  String get effect_mosaic => 'Мозаика';

  @override
  String get effect_liquid_morph => 'Жидкое преобразование';

  @override
  String get effect_blinds => 'Жалюзи';

  @override
  String get effect_blur_fade => 'Растворение с размытием';

  @override
  String get effect_zoom_over => 'Масштабирование';

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

  @override
  String get video_platform_unavailable =>
      'Воспроизведение видео здесь недоступно. Откройте панель в поддерживаемом браузере.';

  @override
  String get video_load_failed => 'Не удалось загрузить видео.';

  @override
  String get video_seek => 'Позиция видео';

  @override
  String get device_telemetry_title => 'Телеметрия';

  @override
  String get device_controls_title => 'Управление фоторамкой';

  @override
  String get device_telemetry_subtitle =>
      'Показатели системы и присутствие с фоторамки';

  @override
  String get device_controls_subtitle => 'Пауза, питание экрана и меню';

  @override
  String get device_refresh => 'Обновить';

  @override
  String get device_stale => 'Последние полученные данные устарели.';

  @override
  String get device_load_failed =>
      'Не удалось получить состояние рамки. Проверьте подключение и версию ПО рамки.';

  @override
  String get device_metrics_failed =>
      'Не удалось обновить системные показатели.';

  @override
  String get device_command_failed =>
      'Не удалось подтвердить команду. Обновите состояние перед повтором.';

  @override
  String get device_disconnected => 'Соединение с фоторамкой потеряно.';

  @override
  String get device_no_data => 'Нет данных';

  @override
  String get device_frontend_unavailable =>
      'Приложение показа рамки недоступно. Управление и сведения о дисплее недоступны.';

  @override
  String get device_controls_context =>
      'Пауза и меню доступны, когда рамка показывает слайд-шоу.';

  @override
  String get device_sample_time => 'Снимок состояния рамки (UTC)';

  @override
  String get device_metrics_time => 'Системные показатели обновлены';

  @override
  String get device_network_time => 'Сетевые данные обновлены';

  @override
  String get device_presence => 'Присутствие человека';

  @override
  String get device_presence_present => 'Человек рядом';

  @override
  String get device_presence_absent => 'Никого нет';

  @override
  String get device_presence_unknown => 'Неизвестно';

  @override
  String get device_presence_time => 'Последнее наблюдение присутствия';

  @override
  String get device_playback => 'Слайд-шоу';

  @override
  String get device_paused => 'Пауза';

  @override
  String get device_playing => 'Воспроизведение';

  @override
  String get device_screen => 'Экран';

  @override
  String get device_screen_on => 'Включён';

  @override
  String get device_screen_off => 'Выключен';

  @override
  String get device_screen_phase => 'Состояние экрана';

  @override
  String get device_screen_waiting => 'Ожидание автоматического сна';

  @override
  String get device_screen_fading_out => 'Затухание';

  @override
  String get device_screen_powering_off => 'Выключение питания';

  @override
  String get device_screen_waking => 'Пробуждение';

  @override
  String get device_screen_fading_in => 'Проявление';

  @override
  String get device_screen_failed => 'Ошибка управления экраном';

  @override
  String get device_screen_power_help =>
      'Питание отражает последнюю успешную команду устройства, а не физическое измерение дисплея.';

  @override
  String get device_screen_lock => 'Ручная блокировка экрана';

  @override
  String get device_turn_on => 'Включить экран';

  @override
  String get device_turn_off => 'Выключить экран';

  @override
  String get device_menu => 'Меню фоторамки';

  @override
  String get device_menu_open => 'Открыто';

  @override
  String get device_menu_closed => 'Закрыто';

  @override
  String get device_open_menu => 'Открыть меню';

  @override
  String get device_close_menu => 'Закрыть меню';

  @override
  String get device_current_page => 'Текущий экран рамки';

  @override
  String get device_page_welcome => 'Приветствие';

  @override
  String get device_page_config => 'Настройка';

  @override
  String get device_page_ota => 'Обновление ПО';

  @override
  String get device_cpu => 'Процессор';

  @override
  String get device_cpu_model => 'Модель';

  @override
  String get device_cpu_hardware => 'Аппаратная платформа';

  @override
  String get device_cpu_revision => 'Ревизия';

  @override
  String get device_cpu_cores => 'Ядра';

  @override
  String get device_cpu_load => 'Средняя нагрузка: 1 / 5 / 15 мин';

  @override
  String get device_os => 'Операционная система';

  @override
  String get device_uptime => 'Время работы';

  @override
  String get device_memory => 'Память';

  @override
  String get device_ram => 'RAM: занято / всего';

  @override
  String get device_swap => 'Swap: занято / всего';

  @override
  String get device_disk => 'Диск';

  @override
  String get device_disk_usage => 'Занято / всего';

  @override
  String get device_disk_percent => 'Заполнено';

  @override
  String get device_network => 'Сеть';

  @override
  String get device_internet => 'Интернет';

  @override
  String get device_online => 'Доступен';

  @override
  String get device_offline => 'Недоступен';

  @override
  String get device_interface_running => 'Активен';

  @override
  String get device_interface_offline => 'Неактивен';

  @override
  String get device_sensors => 'Датчики';

  @override
  String get device_versions_display => 'ПО и дисплей фоторамки';

  @override
  String get device_frontend_version => 'Версия приложения показа';

  @override
  String get device_backend_version => 'Версия backend';

  @override
  String get device_physical_size => 'Физический размер';

  @override
  String get device_logical_size => 'Логический размер';

  @override
  String get device_pixel_ratio => 'Масштаб пикселей';

  @override
  String device_mib(String value) {
    return '$value МиБ';
  }

  @override
  String device_pixels(String width, String height) {
    return '$width × $height пикс.';
  }

  @override
  String device_logical_pixels(String width, String height) {
    return '$width × $height лог. пикс.';
  }

  @override
  String get rpc_title => 'Очереди RPC';

  @override
  String get rpc_description =>
      'Счётчики и максимумы с запуска сервиса. Скорости — за последние 10 секунд или доступную часть окна, включая запросы телеметрии.';

  @override
  String get rpc_node_frontend => 'Приложение показа';

  @override
  String get rpc_node_backend => 'Сервисы рамки';

  @override
  String get rpc_node_web => 'Веб-сервер';

  @override
  String get rpc_node_ota => 'Обновление';

  @override
  String get rpc_unavailable => 'Нет данных RPC';

  @override
  String get rpc_peak_inflight => 'Максимум занятых слотов';

  @override
  String get rpc_peak_queued => 'Максимум ожидающих слот';

  @override
  String get rpc_submitted => 'Всего запросов';

  @override
  String get rpc_sent => 'Отправлено запросов';

  @override
  String get rpc_responses => 'Получено ответов';

  @override
  String get rpc_errors => 'Ошибки ожидания и RPC-ответов';

  @override
  String get rpc_slot_wait => 'Ожидание слота: среднее / максимум';

  @override
  String get rpc_response_wait => 'Ожидание ответа: среднее / максимум';

  @override
  String get rpc_oldest_queued => 'Самый старый ожидающий слот';

  @override
  String get rpc_oldest_inflight => 'Самый старый ожидающий ответ';

  @override
  String get rpc_no_pending => 'Нет';

  @override
  String get rpc_unknown_command => 'Неизвестная команда';

  @override
  String get rpc_handlers_active => 'Выполняется обработчиков у получателя';

  @override
  String get rpc_handlers_completed => 'Завершено обработчиков';

  @override
  String get rpc_handlers_errors => 'Ошибки обработчиков';

  @override
  String get rpc_handler_duration => 'Обработчик: среднее / максимум';

  @override
  String get rpc_receiver_unavailable => 'Метрики получателя недоступны';

  @override
  String get rpc_ws_timeouts => 'Timeout запросов WebSocket с запуска панели';

  @override
  String rpc_occupancy(int used, int capacity, int queued) {
    return 'Слоты: $used/$capacity · Ожидают: $queued';
  }

  @override
  String rpc_rate_summary(String sent, String responses) {
    return 'Отправлено: $sent/с · Ответы: $responses/с';
  }

  @override
  String rpc_duration_summary(String mean, String maximum) {
    return '$mean / $maximum';
  }

  @override
  String rpc_pending_value(String command, String age) {
    return '$command · $age';
  }

  @override
  String rpc_milliseconds(String value) {
    return '$value мс';
  }

  @override
  String get rpc_receiver_stale => 'Данные обработчиков получателя устарели.';

  @override
  String get effects_title => 'Эффекты перехода';

  @override
  String get effects_general => 'Общие настройки слайдшоу';

  @override
  String get effects_search => 'Поиск эффектов';

  @override
  String get effects_all => 'Все';

  @override
  String get effects_enabled => 'Включённые';

  @override
  String get effects_modified => 'Изменённые';

  @override
  String get effects_group => 'Группа';

  @override
  String get effects_fades => 'Затухания';

  @override
  String get effects_movement => 'Движение';

  @override
  String get effects_masks => 'Маски';

  @override
  String get effects_geometric => 'Геометрия';

  @override
  String get effects_cinematic => 'Кинематографические';

  @override
  String get effects_creative => 'Творческие';

  @override
  String get effects_global_duration => 'Общая длительность, мс';

  @override
  String get effects_duration => 'Длительность, мс';

  @override
  String get effects_inherit => 'Общая';

  @override
  String get effects_custom => 'Своя';

  @override
  String get effects_enable_all => 'Включить все эффекты';

  @override
  String get effects_disable_all => 'Выключить все эффекты';

  @override
  String get effects_inherit_all => 'Общая длительность для всех эффектов';

  @override
  String get effects_reset => 'Сбросить параметры';

  @override
  String get effects_empty =>
      'При отсутствии выбранных совместимых эффектов используется затухание с общей длительностью.';

  @override
  String get effects_invalid =>
      'Некорректные настройки эффектов. Исправьте поля или сбросьте набор.';

  @override
  String get effects_restore => 'Сбросить набор эффектов';

  @override
  String get effects_no_results => 'Эффекты не найдены';

  @override
  String get effects_enable => 'Включён';

  @override
  String get effects_grid => 'Размер сетки';

  @override
  String get effects_fade_fraction => 'Плавность ячеек';

  @override
  String get effects_fade_help =>
      'Доля времени перехода для затухания одной ячейки. 0% — исчезновение без затухания.';

  @override
  String get effects_direction => 'Направление';

  @override
  String get effects_random => 'Случайный порядок ячеек';

  @override
  String get effects_topLeft => 'Сверху слева';

  @override
  String get effects_topRight => 'Сверху справа';

  @override
  String get effects_bottomLeft => 'Снизу слева';

  @override
  String get effects_bottomRight => 'Снизу справа';

  @override
  String get effects_center => 'Центр';

  @override
  String get effects_left => 'Влево';

  @override
  String get effects_right => 'Вправо';

  @override
  String get effects_up => 'Вверх';

  @override
  String get effects_down => 'Вниз';

  @override
  String get effects_mode => 'Режим';

  @override
  String get effects_push => 'Выталкивание';

  @override
  String get effects_cover => 'Накрытие';

  @override
  String get effects_reveal => 'Открытие';

  @override
  String get effects_shape => 'Форма';

  @override
  String get effects_wipe => 'Шторка';

  @override
  String get effects_curtain => 'Занавес';

  @override
  String get effects_diagonal => 'Диагональ';

  @override
  String get effects_iris => 'Диафрагма';

  @override
  String get effects_axis => 'Ось';

  @override
  String get effects_horizontal => 'Горизонтальная';

  @override
  String get effects_vertical => 'Вертикальная';

  @override
  String get effects_origin => 'Начало раскрытия';

  @override
  String get color_choose => 'Выбрать цвет';

  @override
  String get color_apply => 'Применить';

  @override
  String get effects_color => 'Цвет, AARRGGBB';

  @override
  String get effects_black => 'Чёрный';

  @override
  String get effects_white => 'Белый';

  @override
  String get effects_style => 'Стиль';

  @override
  String get effects_soft => 'Мягкий';

  @override
  String get effects_lightSweep => 'Световая полоса';

  @override
  String get effects_neon => 'Неон';

  @override
  String get effects_edge => 'Точка поворота';

  @override
  String get effects_top => 'Сверху';

  @override
  String get effects_bottom => 'Снизу';

  @override
  String get effects_angle => 'Угол, градусы';

  @override
  String get effects_count => 'Количество полос / панелей';

  @override
  String get effects_slide => 'Сдвиг';

  @override
  String get effects_reveal_mask => 'Раскрытие маской';

  @override
  String get effects_fade_color => 'Через цвет';

  @override
  String get effects_flip => 'Переворот';

  @override
  String get effects_rotate => 'Поворот';

  @override
  String effects_milliseconds(int value) {
    return '$value мс';
  }

  @override
  String get effect_parameter_gridSize => 'Плотность сетки';

  @override
  String get effect_parameter_fadeFraction => 'Плавность ячеек';

  @override
  String get effect_parameter_direction => 'Направление';

  @override
  String get effect_parameter_randomness => 'Случайность порядка';

  @override
  String get effect_parameter_mode => 'Режим';

  @override
  String get effect_parameter_motionCurve => 'Плавность движения';

  @override
  String get effect_parameter_blurFraction => 'Сила размытия';

  @override
  String get effect_parameter_decoration => 'Оформление';

  @override
  String get effect_parameter_edgeWidth => 'Ширина края';

  @override
  String get effect_parameter_tiltDegrees => 'Наклон';

  @override
  String get effect_parameter_shadowStrength => 'Сила тени';

  @override
  String get effect_parameter_shape => 'Форма';

  @override
  String get effect_parameter_axis => 'Ориентация';

  @override
  String get effect_parameter_origin => 'Начало / центр';

  @override
  String get effect_parameter_operation => 'Действие маски';

  @override
  String get effect_parameter_edgeStyle => 'Стиль границы';

  @override
  String get effect_parameter_featherFraction => 'Мягкость границы';

  @override
  String get effect_parameter_lightStrength => 'Сила подсветки';

  @override
  String get effect_parameter_frameEnabled => 'Окантовка и тень';

  @override
  String get effect_parameter_borderWidth => 'Толщина окантовки';

  @override
  String get effect_parameter_borderColor => 'Цвет окантовки';

  @override
  String get effect_parameter_pointCount => 'Число лучей';

  @override
  String get effect_parameter_innerRadiusRatio => 'Глубина вырезов';

  @override
  String get effect_parameter_rotationDegrees => 'Угол поворота';

  @override
  String get effect_parameter_startAngleDegrees => 'Начальный угол';

  @override
  String get effect_parameter_circularDirection => 'Направление вращения';

  @override
  String get effect_parameter_color => 'Цвет перехода';

  @override
  String get effect_parameter_style => 'Стиль';

  @override
  String get effect_parameter_rotationSense => 'Направление вращения';

  @override
  String get effect_parameter_perspectiveStrength => 'Перспектива';

  @override
  String get effect_parameter_edge => 'Край вращения';

  @override
  String get effect_parameter_angleDegrees => 'Угол';

  @override
  String get effect_parameter_stripCount => 'Число полос';

  @override
  String get effect_parameter_order => 'Порядок';

  @override
  String get effect_parameter_staggerFraction => 'Задержка элементов';

  @override
  String get effect_parameter_pattern => 'Чередование';

  @override
  String get effect_parameter_paneCount => 'Число граней';

  @override
  String get effect_parameter_refractionStrength => 'Сила преломления';

  @override
  String get effect_parameter_glintStrength => 'Сила бликов';

  @override
  String get effect_parameter_panelCount => 'Число панелей';

  @override
  String get effect_parameter_slatCount => 'Число планок';

  @override
  String get effect_parameter_shadowIntensity => 'Сила теней';

  @override
  String get effect_parameter_blendCurve => 'Плавность смешивания';

  @override
  String get effect_parameter_maxSigma => 'Сила размытия (px)';

  @override
  String get effect_parameter_blurTarget => 'Размываемый кадр';

  @override
  String get effect_parameter_holdFraction => 'Выдержка цвета';

  @override
  String get effect_parameter_fadeOutShare => 'Доля исчезновения';

  @override
  String get effect_parameter_softness => 'Мягкость';

  @override
  String get effect_parameter_noiseScale => 'Частота шума';

  @override
  String get effect_parameter_waveAmplitude => 'Амплитуда волны';

  @override
  String get effect_parameter_waveFrequency => 'Частота волны';

  @override
  String get effect_parameter_bandWidth => 'Ширина полосы преломления';

  @override
  String get effect_parameter_waveCount => 'Число волн';

  @override
  String get effect_parameter_waveIntensity => 'Сила волны (px)';

  @override
  String get effect_parameter_outgoingScale => 'Конечный масштаб старого кадра';

  @override
  String get effect_parameter_scale => 'Масштаб в глубине';

  @override
  String get effect_parameter_clipAmount => 'Отставание изображения (px)';

  @override
  String get effect_parameter_zoomOutScale => 'Минимальный масштаб';

  @override
  String get effect_parameter_enableOpacity => 'Затухание прозрачности';

  @override
  String get effect_parameter_startScale => 'Начальный масштаб';

  @override
  String get effect_parameter_corner => 'Угол загиба';

  @override
  String get effect_parameter_foldWidth => 'Ширина сгиба';

  @override
  String get effect_parameter_paperColor => 'Цвет бумаги';

  @override
  String get effect_parameter_splitPosition => 'Положение разреза';

  @override
  String get effect_parameter_maxScale => 'Максимальный масштаб';

  @override
  String get effect_parameter_side => 'Сторона';

  @override
  String get effect_parameter_strength => 'Интенсивность';

  @override
  String get effect_parameter_radius => 'Радиус';

  @override
  String get effect_parameter_warmColor => 'Тёплый цвет засветки';

  @override
  String get effect_parameter_roughness => 'Неровность кромки';

  @override
  String get effect_parameter_emberColor => 'Цвет огня';

  @override
  String get effect_parameter_gain => 'Усиление яркости';

  @override
  String get effect_parameter_sectorCount => 'Число секторов';

  @override
  String get effect_parameter_lineAxis => 'Ориентация светящейся линии';

  @override
  String get effect_parameter_glowStrength => 'Сила свечения';

  @override
  String get effect_parameter_glowColor => 'Цвет свечения';

  @override
  String get effect_parameter_springStrength => 'Сила пружины';

  @override
  String get effect_parameter_cellsAcross =>
      'Число фигур вдоль длинной стороны';

  @override
  String get effect_parameter_colorShiftFraction => 'Цветовой сдвиг';

  @override
  String get effect_parameter_trackingStrength => 'Сила tracking-полос';

  @override
  String get effect_parameter_noiseStrength => 'Сила помех';

  @override
  String get effect_parameter_trailCount => 'Число световых следов';

  @override
  String get effect_parameter_driftFraction => 'Смещение следов';

  @override
  String get effect_parameter_trailStrength => 'Сила следов';

  @override
  String get effect_parameter_trailColor => 'Цвет следов';

  @override
  String get effect_choice_FadeStyle_plain => 'Обычное';

  @override
  String get effect_choice_FadeStyle_linearLight =>
      'Линейное цветовое пространство';

  @override
  String get effect_choice_FadeStyle_blur => 'С размытием';

  @override
  String get effect_choice_FadeStyle_throughColor => 'Через цвет';

  @override
  String get effect_choice_BlendCurve_linear => 'Равномерно';

  @override
  String get effect_choice_BlendCurve_easeIn => 'С ускорением';

  @override
  String get effect_choice_BlendCurve_easeOut => 'С замедлением';

  @override
  String get effect_choice_BlendCurve_easeInOut => 'Плавный разгон и остановка';

  @override
  String get effect_choice_BlurTarget_outgoing => 'Старый кадр';

  @override
  String get effect_choice_BlurTarget_incoming => 'Новый кадр';

  @override
  String get effect_choice_BlurTarget_both => 'Оба кадра';

  @override
  String get effect_choice_DepthMode_recedeStill => 'Уход в глубину на месте';

  @override
  String get effect_choice_DepthMode_recedeSlide => 'Уход в глубину со сдвигом';

  @override
  String get effect_choice_DepthMode_approach => 'Появление из глубины';

  @override
  String get effect_choice_ZoomMode_over => 'Наложение';

  @override
  String get effect_choice_ZoomMode_cross => 'Встречный зум';

  @override
  String get effect_choice_WipeEdgeStyle_hard => 'Жёсткая';

  @override
  String get effect_choice_WipeEdgeStyle_soft => 'Мягкая';

  @override
  String get effect_choice_WipeEdgeStyle_lightSweep => 'Световой проход';

  @override
  String get effect_choice_WipeEdgeStyle_neon => 'Неоновая';

  @override
  String get effect_choice_RevealOperation_revealIncoming =>
      'Раскрывать новый кадр';

  @override
  String get effect_choice_RevealOperation_hideOutgoing =>
      'Закрывать старый кадр';

  @override
  String get effect_choice_SliceMode_slide => 'Сдвиг';

  @override
  String get effect_choice_SliceMode_reveal => 'Раскрытие';

  @override
  String get effect_choice_StripPattern_alternating => 'Встречное';

  @override
  String get effect_choice_StripPattern_sameDirection =>
      'Одинаковое направление';

  @override
  String get effect_choice_SequenceOrder_forward => 'Прямой';

  @override
  String get effect_choice_SequenceOrder_backward => 'Обратный';

  @override
  String get effect_choice_RotationSense_forward => 'Прямой';

  @override
  String get effect_choice_RotationSense_backward => 'Обратный';

  @override
  String get effect_choice_CircularDirection_clockwise => 'По часовой стрелке';

  @override
  String get effect_choice_CircularDirection_counterclockwise =>
      'Против часовой стрелки';

  @override
  String get effect_choice_LumaOrder_brightFirst => 'Сначала светлые';

  @override
  String get effect_choice_LumaOrder_darkFirst => 'Сначала тёмные';

  @override
  String get effect_choice_CellShape_hexagon => 'Шестиугольник';

  @override
  String get effect_choice_CellShape_circle => 'Круг';

  @override
  String get effect_choice_CellShape_diamond => 'Ромб';

  @override
  String get effect_choice_CellShape_square => 'Квадрат';

  @override
  String get effect_choice_MirrorSide_leading => 'Начальная сторона';

  @override
  String get effect_choice_MirrorSide_trailing => 'Конечная сторона';

  @override
  String get effect_choice_SlideDecoration_none => 'Нет';

  @override
  String get effect_choice_SlideDecoration_filmPerforation =>
      'Перфорация плёнки';

  @override
  String get effect_choice_RevealShape_rectangle => 'Прямоугольник';

  @override
  String get effect_choice_RevealShape_star => 'Звезда';

  @override
  String get effect_choice_RevealShape_clock => 'Сектор';

  @override
  String get effects_preset => 'Пресет';

  @override
  String get effects_custom_preset => 'Свои параметры';

  @override
  String get effects_automatic => 'По стилю';

  @override
  String get effect_preset_burnAlpha => 'Выгорание';

  @override
  String get effect_preset_foldMotion => 'Складывание';

  @override
  String get effect_preset_glow => 'Свечение';

  @override
  String get effect_preset_kaleidoscope => 'Калейдоскоп';

  @override
  String get effect_preset_tvPower => 'Выключение телевизора';

  @override
  String get effect_preset_springMotion => 'Пружина';

  @override
  String get effect_preset_shapeDissolve => 'Растворение фигурами';

  @override
  String get effect_preset_vhsDamage => 'Видеокассета';

  @override
  String get effect_preset_radialBlur => 'Радиальное размытие';

  @override
  String get effect_preset_phosphor => 'Послесвечение';

  @override
  String get effect_preset_filmDissolve => 'Кинематографическое растворение';

  @override
  String get effect_preset_frame => 'Рамка';

  @override
  String get effect_preset_louver => 'Поворотные жалюзи';

  @override
  String get effect_preset_mirror => 'Зеркало';

  @override
  String get effect_preset_clockWipe => 'Часовое раскрытие';

  @override
  String get effect_preset_split => 'Раздвижение половин';

  @override
  String get effect_preset_panelWipe => 'Раскрытие панелями';

  @override
  String get effect_preset_stretch => 'Растяжение';

  @override
  String get effect_preset_starWipe => 'Раскрытие звездой';

  @override
  String get effect_preset_lightLeak => 'Световая засветка';

  @override
  String get effect_preset_filmRoll => 'Прокрутка плёнки';

  @override
  String get effect_preset_crossZoom => 'Встречный зум';

  @override
  String get effect_preset_whip => 'Резкая панорама';

  @override
  String get effect_preset_glass => 'Стекло';

  @override
  String get effect_preset_softWipe => 'Мягкое раскрытие';

  @override
  String get effect_preset_slice => 'Сдвиг полос';

  @override
  String get effect_preset_lumaFade => 'Растворение по яркости';

  @override
  String get effect_preset_pagePeel => 'Загиб страницы';

  @override
  String get effect_preset_noiseDissolve => 'Растворение в шуме';

  @override
  String get effect_preset_rippleReveal => 'Раскрытие волнами';

  @override
  String get effect_preset_waterRefraction => 'Преломление воды';

  @override
  String get effect_preset_cube => 'Куб';

  @override
  String get effect_preset_accordion => 'Гармошка';

  @override
  String get effect_preset_backgroundToForeground => 'Из фона на передний план';

  @override
  String get effect_preset_foregroundToBackground => 'С переднего плана в фон';

  @override
  String get effect_preset_depth => 'Глубина';

  @override
  String get effect_preset_parallax => 'Параллакс';

  @override
  String get effect_preset_stack => 'Стопка';

  @override
  String get effect_preset_tablet => 'Планшет';

  @override
  String get effect_preset_zoomOut => 'Уменьшение';

  @override
  String get effect_preset_fade => 'Растворение';

  @override
  String get effect_preset_mosaic => 'Мозаика';

  @override
  String get effect_preset_liquidMorph => 'Жидкое преобразование';

  @override
  String get effect_preset_blinds => 'Жалюзи';

  @override
  String get effect_preset_blurFade => 'Растворение с размытием';

  @override
  String get effect_preset_zoomOver => 'Увеличение поверх';

  @override
  String get effect_preset_slide => 'Сдвиг';

  @override
  String get effect_preset_revealMask => 'Раскрытие маской';

  @override
  String get effect_preset_fadeThroughColor => 'Через цвет';

  @override
  String get effect_preset_flip => 'Переворот';

  @override
  String get effect_preset_rotate => 'Поворот';

  @override
  String get effect_preset_softWipeLightSweep => 'Световой проход';

  @override
  String get effect_preset_softWipeNeon => 'Неоновое раскрытие';

  @override
  String get effect_preset_fadeThroughWhite => 'Через белый';

  @override
  String get effect_preset_flipVertical => 'Вертикальный переворот';

  @override
  String get effect_preset_rotateBottom => 'Вращение от нижнего края';

  @override
  String get effect_preset_mosaicBinary => 'Мозаика без затухания';

  @override
  String get effect_preset_mosaicTopLeft => 'Мозаика из верхнего левого угла';

  @override
  String get effect_preset_mosaicTopRight => 'Мозаика из верхнего правого угла';

  @override
  String get effect_preset_mosaicBottomLeft => 'Мозаика из нижнего левого угла';

  @override
  String get effect_preset_mosaicBottomRight =>
      'Мозаика из нижнего правого угла';

  @override
  String get effect_preset_slidePushRight => 'Вытеснение вправо';

  @override
  String get effect_preset_slidePushUp => 'Вытеснение вверх';

  @override
  String get effect_preset_slidePushDown => 'Вытеснение вниз';

  @override
  String get effect_preset_slideCoverLeft => 'Наложение влево';

  @override
  String get effect_preset_slideCoverRight => 'Наложение вправо';

  @override
  String get effect_preset_slideCoverUp => 'Наложение вверх';

  @override
  String get effect_preset_slideCoverDown => 'Наложение вниз';

  @override
  String get effect_preset_slideRevealLeft => 'Открытие сдвигом влево';

  @override
  String get effect_preset_slideRevealRight => 'Открытие сдвигом вправо';

  @override
  String get effect_preset_slideRevealUp => 'Открытие сдвигом вверх';

  @override
  String get effect_preset_slideRevealDown => 'Открытие сдвигом вниз';

  @override
  String get effect_preset_wipeRight => 'Раскрытие вправо';

  @override
  String get effect_preset_wipeUp => 'Раскрытие вверх';

  @override
  String get effect_preset_wipeDown => 'Раскрытие вниз';

  @override
  String get effect_preset_curtainHorizontal => 'Горизонтальная штора';

  @override
  String get effect_preset_curtainVertical => 'Вертикальная штора';

  @override
  String get effect_preset_diagonalTopRight =>
      'Диагональ из верхнего правого угла';

  @override
  String get effect_preset_diagonalBottomLeft =>
      'Диагональ из нижнего левого угла';

  @override
  String get effect_preset_diagonalBottomRight =>
      'Диагональ из нижнего правого угла';

  @override
  String get effect_preset_diagonalTopLeft =>
      'Диагональ из верхнего левого угла';

  @override
  String get effect_preset_irisCenter => 'Круг из центра';

  @override
  String get effects_wave_origin => 'Начало волны';

  @override
  String get effects_advanced => 'Дополнительно';

  @override
  String get otaTitle => 'Обновление прошивки';

  @override
  String get otaReadyTitle => 'Готово к обновлению';

  @override
  String get otaCurrentVersion => 'Текущая версия';

  @override
  String get otaAccessCode => 'Код доступа';

  @override
  String get otaSameNetwork =>
      'Подключите телефон или компьютер к той же сети, что и рамка.';

  @override
  String get otaScanInstruction =>
      'Отсканируйте QR-код, чтобы открыть страницу обновления.';

  @override
  String get otaManualConnection => 'Или откройте этот адрес';

  @override
  String get otaAddressUnavailable =>
      'Сетевой адрес недоступен. Подключите рамку к сети, чтобы открыть страницу обновления.';

  @override
  String get otaPreparing => 'Подготовка страницы обновления…';

  @override
  String get otaReceiving => 'Получение прошивки';

  @override
  String get otaTransferHint =>
      'Получаем файл на рамку. Затем начнётся установка.';

  @override
  String get otaInstalling => 'Установка прошивки';

  @override
  String get otaDoNotPowerOff => 'Не отключайте питание рамки.';

  @override
  String get otaInstallationHint =>
      'Установка может занять несколько минут. Ход работы показан в журнале ниже.';

  @override
  String get otaFailed => 'Не удалось обновить прошивку';

  @override
  String get otaUnknownError => 'Произошла неизвестная ошибка.';

  @override
  String get otaLogDetails => 'Подробности — в системном журнале.';

  @override
  String get otaReturnToSlideshow =>
      'Для возврата к слайдшоу нажмите кнопку возврата на рамке.';

  @override
  String get otaInstalled => 'Прошивка установлена';

  @override
  String get otaRestartTitle => 'Перезапуск приложения';

  @override
  String get otaWaitingRestart => 'Ожидаем перезапуск приложения…';

  @override
  String get otaLeaving => 'Закрытие экрана обновления…';

  @override
  String get otaSystemLog => 'Системный журнал';

  @override
  String get otaTransferLogPending =>
      'Файл передаётся на рамку. Журнал установки появится после получения файла.';

  @override
  String get otaInstallLogPending => 'Ожидаем вывод установщика…';

  @override
  String get otaFollowingOutput => 'Показ новых строк';

  @override
  String get otaHistoryPaused =>
      'Просмотр истории · автопрокрутка приостановлена';

  @override
  String get otaLatestLine => 'К последней строке';

  @override
  String get otaDevConfig => 'Настройки разработчика';

  @override
  String get otaStepReceive => '1. Получение';

  @override
  String get otaStepInstall => '2. Установка';

  @override
  String get otaStepRestart => '3. Перезапуск';

  @override
  String get frame_language_section => 'Интерфейс фоторамки';

  @override
  String get frame_language_label => 'Язык фоторамки';

  @override
  String get frame_language_hint =>
      'Сохраните настройки и перезапустите приложение рамки, чтобы применить язык. Язык панели выбирается отдельно в меню «Оформление».';
}
