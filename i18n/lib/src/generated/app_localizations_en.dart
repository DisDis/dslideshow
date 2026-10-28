// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get password => 'Password';

  @override
  String get username => 'Username';

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get english => 'English';

  @override
  String get russian => 'Russian';

  @override
  String home_userid(String userId) {
    return 'UserId: \'$userId\'';
  }

  @override
  String get home_page_name => 'Home';

  @override
  String get home_page_logout_button => 'Logout';

  @override
  String get login_page_name => 'Login';

  @override
  String admin_account_info_title(String title) {
    return 'Title: $title';
  }

  @override
  String get upload_queue_title => 'Upload Queue';

  @override
  String get add_files_menu_item => 'Add Files';

  @override
  String get add_folder_menu_item => 'Add Folder';

  @override
  String get queue_is_empty => 'Queue is empty';

  @override
  String get no_images_found_in_folder => 'No images found in folder';

  @override
  String get authentication_failure => 'Authentication Failure';

  @override
  String get ota_update_title => 'OTA Update';

  @override
  String get unknown_state => 'Unknown state';

  @override
  String get initialize_button => 'Initialize';

  @override
  String get select_file_button => 'Select File';

  @override
  String get update_button => 'Update';

  @override
  String get reset_button => 'Reset';

  @override
  String get home_menu_item => 'Home';

  @override
  String get gallery_menu_item => 'Gallery';

  @override
  String get upload_media_menu_item => 'Upload media';

  @override
  String get configuration_menu_item => 'Configuration';

  @override
  String get wifi_menu_item => 'Wifi';

  @override
  String get system_control_menu_item => 'System Control';

  @override
  String get exit_menu_item => 'Exit';

  @override
  String get storage_settings_title => 'Storage Settings';

  @override
  String get unknown_storage_type_configuration =>
      'Unknown storage type configuration';

  @override
  String get no_configuration_needed_for_local_disk =>
      'No configuration needed for local disk yet.';

  @override
  String get slideshow_settings_title => 'Slideshow Settings';

  @override
  String get background_opacity => 'Background Opacity';

  @override
  String get config_save_button => 'Save';

  @override
  String get config_reload_button => 'Reload';

  @override
  String get config_unsaved_changes => 'Unsaved changes';

  @override
  String get config_saved_state => 'No unsaved changes';

  @override
  String get config_restart_hint =>
      'Saved settings take effect after restarting the application.';

  @override
  String get config_reload_title => 'Reload settings?';

  @override
  String get config_reload_warning =>
      'Discard your changes and load the saved settings from the device?';

  @override
  String get config_leave_warning =>
      'Your changes have not been saved. Discard them and leave settings?';

  @override
  String get config_keep_editing => 'Keep editing';

  @override
  String get config_discard_changes => 'Discard changes';

  @override
  String get config_operation_in_progress =>
      'Wait for the current settings operation to finish.';

  @override
  String get config_load_failed => 'Could not load settings';

  @override
  String get config_saved_successfully => 'Config saved successfully';

  @override
  String get config_is_reloading => 'Config is reloading...';

  @override
  String get settings_title => 'Settings';

  @override
  String get select_items_dialog_title => 'Select items';

  @override
  String get cancel_button => 'Cancel';

  @override
  String get ok_button => 'OK';

  @override
  String get not_found => 'Not found';

  @override
  String get no_access_title => 'No access';

  @override
  String get no_access_contact_administrator =>
      'No access, contact your administrator';

  @override
  String get ch_text => 'Ch:';

  @override
  String get device_text => 'Device:';

  @override
  String get connect_form_title => 'WiFi Configuration';

  @override
  String get connect_button => 'Connect';

  @override
  String get gallery_load_failed => 'Could not load the gallery.';

  @override
  String get gallery_refresh_failed =>
      'Could not refresh the gallery. Your previous list is still available.';

  @override
  String get gallery_title => 'Gallery';

  @override
  String get system_control_title => 'System Control';

  @override
  String get try_again_button => 'Try Again';

  @override
  String get error_text => 'Error';

  @override
  String get welcome_back => 'Welcome back,';

  @override
  String get manage_your_device_settings_and_updates =>
      'Manage your device settings and updates.';

  @override
  String get gallery_card_title => 'Gallery';

  @override
  String get view_media_subtitle => 'View media';

  @override
  String get upload_card_title => 'Upload';

  @override
  String get upload_media_subtitle => 'Upload media';

  @override
  String get ota_update_card_title => 'OTA Update';

  @override
  String get firmware_upgrade_subtitle => 'Firmware upgrade';

  @override
  String get wifi_setup_card_title => 'WiFi Setup';

  @override
  String get manage_connections_subtitle => 'Manage connections';

  @override
  String get configuration_card_title => 'Configuration';

  @override
  String get system_settings_subtitle => 'System settings';

  @override
  String get system_control_card_title => 'System Control';

  @override
  String get restart_app_power_off_subtitle => 'Restart app, power off';

  @override
  String get mqtt_settings_title => 'MQTT Settings';

  @override
  String get webserver_settings_title => 'WebServer Settings';

  @override
  String get welcome_settings_title => 'Welcome Settings';

  @override
  String get saved_connections_subtitle => 'Saved Connections';

  @override
  String get no_networks_found_nearby => 'No networks found nearby';

  @override
  String get add_network => 'Add Network';

  @override
  String get connect_to_network => 'Connect to Network';

  @override
  String get ssid_name_label => 'SSID (Name)';

  @override
  String get required_field => 'Required';

  @override
  String get connection_failed => 'Connection Failed';

  @override
  String get power_management_title => 'Power Management';

  @override
  String get choose_action_on_device =>
      'Choose an action to perform on the device';

  @override
  String get restart_application => 'Restart Application';

  @override
  String get reload_software_without_rebooting_os =>
      'Reloads the software without rebooting the OS.';

  @override
  String get restart_application_question => 'Restart Application?';

  @override
  String get this_will_reload_configuration_app_and_slideshow_services =>
      'This will reload the configuration app and slideshow services.';

  @override
  String get restart => 'Restart';

  @override
  String get power_off => 'Power Off';

  @override
  String get safely_shuts_down_the_device_operating_system =>
      'Safely shuts down the device operating system.';

  @override
  String get power_off_device_question => 'Power Off Device?';

  @override
  String get the_device_will_shut_down_completely =>
      'The device will shut down completely. You will need to physically turn it on again.';

  @override
  String get power_off_button => 'Power Off';

  @override
  String get please_sign_in_to_continue => 'Please sign in to continue';

  @override
  String get server_uri => 'Server URI';

  @override
  String get invalid_uri => 'Invalid URI';

  @override
  String get invalid_username => 'Invalid username';

  @override
  String get invalid_password => 'Invalid password';

  @override
  String get sign_in => 'Sign In';

  @override
  String not_found_with_id(String id) {
    return 'Not found \"$id\"';
  }

  @override
  String transition_display_times(int transitionTime, int displayTime) {
    return 'Transition: $transitionTime ms\nDisplay: $displayTime ms';
  }

  @override
  String get wifi_5ghz_label => '5G';

  @override
  String channel_text(int channel) {
    return 'Ch: $channel';
  }

  @override
  String device_connection_info(String device, String type) {
    return 'Device: $device • $type';
  }

  @override
  String get slideshow_section_title => 'Slideshow';

  @override
  String get general_and_effects_title => 'General & Effects';

  @override
  String get welcome_screen_title => 'Welcome Screen';

  @override
  String get storage_configuration_title => 'Storage Configuration';

  @override
  String get using_local_disk => 'Using Local Disk';

  @override
  String get using_google_photos => 'Using Google Photos';

  @override
  String get connectivity_title => 'Connectivity';

  @override
  String get web_server_settings_title => 'Web server';

  @override
  String get mqtt_title => 'MQTT';

  @override
  String get hardware_title => 'Hardware';

  @override
  String get gpio_smoothing_label => 'GPIO Smoothing (ms)';

  @override
  String get logging_levels_title => 'Logging Levels';

  @override
  String get main_logic_label => 'Main Logic';

  @override
  String get ota_update_label => 'OTA Update';

  @override
  String get hardware_frame_label => 'Hardware Frame';

  @override
  String get storage_title => 'Storage';

  @override
  String get retry_button => 'Retry';

  @override
  String error_with_message(String message) {
    return 'Error: $message';
  }

  @override
  String get example_email_address => 'example@gmail.com';

  @override
  String get special_screens_title => 'Special screens';

  @override
  String get special_screen_clock => 'Date and time';

  @override
  String get special_screen_cameras => 'Cameras';

  @override
  String get special_add_screen => 'Add screen';

  @override
  String get special_empty =>
      'Add a clock or a camera screen to the slideshow.';

  @override
  String get special_name => 'Name';

  @override
  String get special_enabled => 'Enabled';

  @override
  String get special_delete => 'Delete';

  @override
  String get special_done => 'Done';

  @override
  String get special_cancel => 'Cancel';

  @override
  String get special_preview => 'Preview';

  @override
  String get special_preview_unavailable =>
      'Preview unavailable. Check the camera URL and network access.';

  @override
  String get special_next_camera => 'Next camera';

  @override
  String get special_common => 'Playback';

  @override
  String get special_frequency => 'Show';

  @override
  String get special_after_slides => 'After media slides';

  @override
  String get special_interval => 'At an active playback interval';

  @override
  String get special_slide_count => 'Number of photos / videos';

  @override
  String get special_interval_minutes => 'Interval (minutes)';

  @override
  String get special_duration_seconds => 'Display duration (seconds)';

  @override
  String get special_seconds => 's';

  @override
  String get special_minutes => 'min';

  @override
  String get special_clock_settings => 'Clock appearance';

  @override
  String get special_time_format => 'Time format';

  @override
  String get special_24h => '24 hours';

  @override
  String get special_12h => '12 hours (AM/PM)';

  @override
  String get special_show_seconds => 'Show seconds';

  @override
  String get special_show_date => 'Show date';

  @override
  String get special_date_format => 'Date format';

  @override
  String get special_time_size => 'Time font (% of shorter screen side)';

  @override
  String get special_date_size =>
      'Date and weekday size (% of shorter screen side)';

  @override
  String get special_text_color => 'Text color (AARRGGBB)';

  @override
  String get special_background_color => 'Background color (AARRGGBB)';

  @override
  String get special_camera_settings => 'Camera display';

  @override
  String get special_camera_mode => 'Display mode';

  @override
  String get special_grid => 'All cameras in a grid';

  @override
  String get special_sequence => 'One camera per appearance';

  @override
  String get special_sequence_help =>
      'Each appearance shows the next camera in list order.';

  @override
  String get special_columns => 'Grid columns (0 = automatic)';

  @override
  String get special_fit => 'Image placement';

  @override
  String get special_contain => 'Entire image';

  @override
  String get special_cover => 'Fill and crop';

  @override
  String get special_show_names => 'Show camera names';

  @override
  String get special_refresh => 'Refresh (seconds; 0 = on appearance only)';

  @override
  String get special_add_camera => 'Add camera';

  @override
  String get special_camera_url => 'Snapshot URL (HTTP/HTTPS, JPEG/PNG)';

  @override
  String get special_check_camera => 'Check snapshot';

  @override
  String get special_move_up => 'Move up';

  @override
  String get special_move_down => 'Move down';

  @override
  String get special_invalid_number => 'Enter a number in the allowed range.';

  @override
  String get special_invalid_url => 'Enter an HTTP/HTTPS URL.';

  @override
  String get special_invalid_color => 'Enter 8 hexadecimal digits (AARRGGBB).';

  @override
  String get special_camera_required => 'Add at least one camera.';

  @override
  String get special_unsupported => 'Unsupported screen type';

  @override
  String get special_auth => 'Authentication (optional)';

  @override
  String get special_save_hint =>
      'Use Save on the main settings page to write changes to the device.';

  @override
  String get special_browser_camera_help =>
      'Previews load cameras directly from this browser. The camera must allow browser access (CORS); HTTPS pages also require HTTPS camera URLs.';

  @override
  String get photo_motion_title => 'Photo motion';

  @override
  String get photo_motion_off => 'Off';

  @override
  String get photo_motion_ken_burns => 'Ken Burns (slow pan and zoom)';

  @override
  String get photo_motion_zoom => 'Maximum zoom';

  @override
  String get preview_repeat => 'Repeat';

  @override
  String get effect_burn_alpha => 'Burn Alpha';

  @override
  String get effect_fold_motion => 'Fold Motion';

  @override
  String get effect_glow => 'Glow';

  @override
  String get effect_kaleidoscope => 'Kaleidoscope';

  @override
  String get effect_tv_power => 'TV Power';

  @override
  String get effect_spring_motion => 'Spring Motion';

  @override
  String get effect_shape_dissolve => 'Shape Dissolve';

  @override
  String get effect_vhs_damage => 'VHS Damage';

  @override
  String get effect_radial_blur => 'Radial Blur';

  @override
  String get effect_phosphor => 'Phosphor';

  @override
  String get effect_film_dissolve => 'Film Dissolve';

  @override
  String get effect_frame => 'Frame';

  @override
  String get effect_louver => 'Louver';

  @override
  String get effect_mirror => 'Mirror';

  @override
  String get effect_clock_wipe => 'Clock Wipe';

  @override
  String get effect_split => 'Split';

  @override
  String get effect_panel_wipe => 'Panel Wipe';

  @override
  String get effect_stretch => 'Stretch';

  @override
  String get effect_star_wipe => 'Star Wipe';

  @override
  String get effect_light_leak => 'Light Leak';

  @override
  String get effect_film_roll => 'Film Roll';

  @override
  String get effect_cross_zoom => 'Cross Zoom';

  @override
  String get effect_whip => 'Whip';

  @override
  String get effect_glass => 'Glass';

  @override
  String get effect_soft_wipe => 'Soft Wipe';

  @override
  String get effect_slice => 'Strips';

  @override
  String get effect_luma_fade => 'Luma Fade';

  @override
  String get effect_page_peel => 'Page Peel';

  @override
  String get effect_noise_dissolve => 'Noise Dissolve';

  @override
  String get effect_ripple_reveal => 'Ripple Reveal';

  @override
  String get effect_water_refraction => 'Water Refraction';

  @override
  String get ui_system_default => 'System default';

  @override
  String get app_title => 'Photo frame';

  @override
  String get appearance_title => 'Appearance';

  @override
  String get language_label => 'Language';

  @override
  String get theme_mode_label => 'Theme';

  @override
  String get theme_mode_light => 'Light';

  @override
  String get theme_mode_dark => 'Dark';

  @override
  String get device_panel_title => 'Photo frame';

  @override
  String get device_settings_description =>
      'Manage media, appearance and device settings.';

  @override
  String get connection_title => 'Connection';

  @override
  String get authentication_title => 'Authentication';

  @override
  String get enabled_label => 'Enabled';

  @override
  String get disabled_label => 'Disabled';

  @override
  String get server_host_label => 'Server host';

  @override
  String get port_label => 'Port';

  @override
  String get permanent_code_label => 'Permanent access code';

  @override
  String get always_enabled_label => 'Always enabled';

  @override
  String get active_storage_label => 'Active storage';

  @override
  String get provider_label => 'Provider';

  @override
  String get local_disk_label => 'Local disk';

  @override
  String get google_photos_label => 'Google Photos';

  @override
  String get auth_refresh_token_label => 'Refresh token';

  @override
  String get client_id_label => 'Client ID';

  @override
  String get client_secret_label => 'Client secret';

  @override
  String get upload_from_disk_label => 'Upload photos from disk';

  @override
  String get image_width_label => 'Image width';

  @override
  String get image_height_label => 'Image height';

  @override
  String get show_secret => 'Show value';

  @override
  String get hide_secret => 'Hide value';

  @override
  String get items_none => 'None selected';

  @override
  String get items_all => 'All selected';

  @override
  String items_selected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items selected',
      one: '$count item selected',
      zero: 'None selected',
    );
    return '$_temp0';
  }

  @override
  String get config_editor_draft_hint =>
      'Edits stay in the draft. Use Save on Settings to write them to the device.';

  @override
  String get config_reset_button => 'Undo edits';

  @override
  String get invalid_port => 'Enter a port from 1 to 65535.';

  @override
  String get invalid_positive_integer => 'Enter a positive whole number.';

  @override
  String get invalid_nonnegative_integer =>
      'Enter zero or a positive whole number.';

  @override
  String slideshow_summary(num seconds) {
    final intl.NumberFormat secondsNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String secondsString = secondsNumberFormat.format(seconds);

    return 'Photo display: $secondsString s';
  }

  @override
  String special_enabled_summary(int enabled, int total) {
    return '$enabled of $total enabled';
  }

  @override
  String get preview_title => 'Preview';

  @override
  String get preview_local_controls =>
      'Preview controls are local and are not saved.';

  @override
  String get preview_hide => 'Hide preview';

  @override
  String get preview_show => 'Show preview';

  @override
  String get preview_effect => 'Preview transition';

  @override
  String get preview_aspect => 'Screen aspect ratio';

  @override
  String get preview_pause => 'Pause';

  @override
  String get preview_resume => 'Resume';

  @override
  String get preview_failed => 'Could not prepare the preview. Try again.';

  @override
  String get preview_last_valid =>
      'Showing the last valid values. Correct the marked fields.';

  @override
  String get preview_device_scale => 'Scaled relative to a 2560 × 1600 screen';

  @override
  String get preview_environment_help =>
      'Uses bundled sample photos. No external media is loaded.';

  @override
  String get preview_clock_help => 'Uses this computer’s current time.';

  @override
  String get timing_title => 'Timing';

  @override
  String get display_time_ms => 'Display duration (ms)';

  @override
  String get transition_time_ms => 'Transition duration (ms)';

  @override
  String get visuals_title => 'Appearance';

  @override
  String get allowed_transitions => 'Allowed transitions';

  @override
  String get allowed_transitions_all => 'An empty list allows all transitions.';

  @override
  String get blur_background => 'Blur background';

  @override
  String get background_blur_sigma => 'Background blur';

  @override
  String get background_color_argb => 'Background color (AARRGGBB)';

  @override
  String get welcome_text => 'Welcome text';

  @override
  String get welcome_text_size => 'Text size';

  @override
  String get welcome_delay_ms => 'Animation phase duration (ms)';

  @override
  String get welcome_replay => 'Replay welcome';

  @override
  String get welcome_animation_help =>
      'The welcome fades in and out; the delay sets the duration of each phase.';

  @override
  String get invalid_positive_number => 'Enter a positive number.';

  @override
  String get effect_cube => 'Cube';

  @override
  String get effect_accordion => 'Accordion';

  @override
  String get effect_background_to_foreground => 'Background to foreground';

  @override
  String get effect_foreground_to_background => 'Foreground to background';

  @override
  String get effect_depth => 'Depth';

  @override
  String get effect_parallax => 'Parallax';

  @override
  String get effect_stack => 'Stack';

  @override
  String get effect_tablet => 'Tablet';

  @override
  String get effect_zoom_out_slide => 'Zoom out';

  @override
  String get effect_fade => 'Fade';

  @override
  String get effect_mosaic => 'Mosaic';

  @override
  String get effect_liquid_morph => 'Liquid morph';

  @override
  String get effect_blinds => 'Blinds';

  @override
  String get effect_blur_fade => 'Blur fade';

  @override
  String get effect_zoom_over => 'Zoom';

  @override
  String get sync_settings_title => 'Sync settings';

  @override
  String get sync_period_label => 'Sync period';

  @override
  String get albums_title => 'Albums';

  @override
  String get album_names_label => 'Album names, separated by commas';

  @override
  String get pixels_unit => 'px';

  @override
  String get minutes_unit => 'min';

  @override
  String get milliseconds_unit => 'ms';

  @override
  String get config_reset_warning =>
      'Discard all edits and restore the last loaded or saved settings?';

  @override
  String get refresh_button => 'Refresh';

  @override
  String get add_manually => 'Add manually';

  @override
  String get delete_connection => 'Delete connection';

  @override
  String get forget_network_title => 'Forget network?';

  @override
  String forget_network_question(String name) {
    return 'Delete the saved connection “$name”?';
  }

  @override
  String get delete_button => 'Delete';

  @override
  String get ota_code_label => 'Update code';

  @override
  String ota_version(String version) {
    return 'Version: $version';
  }

  @override
  String get ota_uploading => 'Uploading firmware…';

  @override
  String get ota_upload_complete => 'Firmware upload completed successfully.';

  @override
  String gallery_selected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selected',
      one: '$count selected',
    );
    return '$_temp0';
  }

  @override
  String get clear_selection => 'Clear selection';

  @override
  String get gallery_empty => 'No media files yet.';

  @override
  String get upload_empty_hint =>
      'Add photos and videos to display on the frame.';

  @override
  String get upload_remove_task => 'Remove from queue';

  @override
  String get video_load => 'Load video';

  @override
  String get video_tap_to_play => 'Tap to play';

  @override
  String get media_info => 'File information';

  @override
  String get invalid_editor_leave_warning =>
      'Some fields contain invalid values. Discard the incomplete input and return to settings?';

  @override
  String get discard_invalid_input => 'Discard input';

  @override
  String get special_no_image => 'No image';

  @override
  String get special_request_timeout => 'Snapshot timeout (seconds)';

  @override
  String get special_request_timeout_help =>
      'Time allowed for one snapshot request: 0.1–120 seconds. An unavailable image is replaced with a message.';

  @override
  String get special_time_font => 'Time font';

  @override
  String get special_date_font => 'Date and weekday font';

  @override
  String get special_show_weekday => 'Show day of the week';

  @override
  String get special_font_system => 'Default font';

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
      'Fonts are bundled and work offline. Characters absent from a decorative font use a fallback font.';

  @override
  String get special_weekday_monday => 'Monday';

  @override
  String get special_weekday_tuesday => 'Tuesday';

  @override
  String get special_weekday_wednesday => 'Wednesday';

  @override
  String get special_weekday_thursday => 'Thursday';

  @override
  String get special_weekday_friday => 'Friday';

  @override
  String get special_weekday_saturday => 'Saturday';

  @override
  String get special_weekday_sunday => 'Sunday';

  @override
  String get video_platform_unavailable =>
      'Video playback is unavailable here. Open the panel in a supported browser.';

  @override
  String get video_load_failed => 'Could not load video.';

  @override
  String get video_seek => 'Video position';

  @override
  String get device_telemetry_title => 'Telemetry';

  @override
  String get device_controls_title => 'Frame control';

  @override
  String get device_telemetry_subtitle =>
      'System readings and presence from the frame';

  @override
  String get device_controls_subtitle => 'Pause, screen power and menu';

  @override
  String get device_refresh => 'Refresh';

  @override
  String get device_stale => 'The last received data is out of date.';

  @override
  String get device_load_failed =>
      'Could not read the frame state. Check the connection and frame software version.';

  @override
  String get device_metrics_failed => 'Could not update system readings.';

  @override
  String get device_command_failed =>
      'Could not confirm the command. Refresh the state before trying again.';

  @override
  String get device_disconnected => 'Connection to the frame was lost.';

  @override
  String get device_no_data => 'No data';

  @override
  String get device_frontend_unavailable =>
      'The frame display app is unavailable. Controls and display details cannot be read.';

  @override
  String get device_controls_context =>
      'Pause and menu are available while the frame is showing a slideshow.';

  @override
  String get device_sample_time => 'Frame snapshot (UTC)';

  @override
  String get device_metrics_time => 'System readings updated';

  @override
  String get device_network_time => 'Network readings updated';

  @override
  String get device_presence => 'Human presence';

  @override
  String get device_presence_present => 'Present';

  @override
  String get device_presence_absent => 'Absent';

  @override
  String get device_presence_unknown => 'Unknown';

  @override
  String get device_presence_time => 'Presence last observed';

  @override
  String get device_playback => 'Slideshow';

  @override
  String get device_paused => 'Paused';

  @override
  String get device_playing => 'Playing';

  @override
  String get device_screen => 'Screen';

  @override
  String get device_screen_on => 'On';

  @override
  String get device_screen_off => 'Off';

  @override
  String get device_screen_phase => 'Screen transition';

  @override
  String get device_screen_waiting => 'Waiting for automatic sleep';

  @override
  String get device_screen_fading_out => 'Fading out';

  @override
  String get device_screen_powering_off => 'Powering off';

  @override
  String get device_screen_waking => 'Waking up';

  @override
  String get device_screen_fading_in => 'Fading in';

  @override
  String get device_screen_failed => 'Screen operation failed';

  @override
  String get device_screen_power_help =>
      'Power status reflects the last successful device command, not a physical display measurement.';

  @override
  String get device_screen_lock => 'Manual screen lock';

  @override
  String get device_turn_on => 'Turn screen on';

  @override
  String get device_turn_off => 'Turn screen off';

  @override
  String get device_menu => 'Frame menu';

  @override
  String get device_menu_open => 'Open';

  @override
  String get device_menu_closed => 'Closed';

  @override
  String get device_open_menu => 'Open menu';

  @override
  String get device_close_menu => 'Close menu';

  @override
  String get device_current_page => 'Frame screen';

  @override
  String get device_page_welcome => 'Welcome';

  @override
  String get device_page_config => 'Configuration';

  @override
  String get device_page_ota => 'Firmware update';

  @override
  String get device_cpu => 'CPU';

  @override
  String get device_cpu_model => 'Model';

  @override
  String get device_cpu_hardware => 'Hardware';

  @override
  String get device_cpu_revision => 'Revision';

  @override
  String get device_cpu_cores => 'Cores';

  @override
  String get device_cpu_load => 'Load average: 1 / 5 / 15 min';

  @override
  String get device_os => 'Operating system';

  @override
  String get device_uptime => 'Uptime';

  @override
  String get device_memory => 'Memory';

  @override
  String get device_ram => 'RAM: used / total';

  @override
  String get device_swap => 'Swap: used / total';

  @override
  String get device_disk => 'Disk';

  @override
  String get device_disk_usage => 'Used / total';

  @override
  String get device_disk_percent => 'Used';

  @override
  String get device_network => 'Network';

  @override
  String get device_internet => 'Internet';

  @override
  String get device_online => 'Connected';

  @override
  String get device_offline => 'Disconnected';

  @override
  String get device_interface_running => 'Running';

  @override
  String get device_interface_offline => 'Offline';

  @override
  String get device_sensors => 'Sensors';

  @override
  String get device_versions_display => 'Frame software and display';

  @override
  String get device_frontend_version => 'Display app version';

  @override
  String get device_backend_version => 'Backend version';

  @override
  String get device_physical_size => 'Physical size';

  @override
  String get device_logical_size => 'Logical size';

  @override
  String get device_pixel_ratio => 'Device pixel ratio';

  @override
  String device_mib(String value) {
    return '$value MiB';
  }

  @override
  String device_pixels(String width, String height) {
    return '$width × $height px';
  }

  @override
  String device_logical_pixels(String width, String height) {
    return '$width × $height logical px';
  }

  @override
  String get rpc_title => 'RPC queues';

  @override
  String get rpc_description =>
      'Counters and peaks since service startup. Rates cover up to the last 10 seconds and include telemetry requests.';

  @override
  String get rpc_node_frontend => 'Slideshow';

  @override
  String get rpc_node_backend => 'Backend';

  @override
  String get rpc_node_web => 'Web server';

  @override
  String get rpc_node_ota => 'Updater';

  @override
  String get rpc_unavailable => 'No RPC data';

  @override
  String get rpc_peak_inflight => 'Peak occupied slots';

  @override
  String get rpc_peak_queued => 'Peak waiting for a slot';

  @override
  String get rpc_submitted => 'Requests submitted';

  @override
  String get rpc_sent => 'Requests sent';

  @override
  String get rpc_responses => 'Responses received';

  @override
  String get rpc_errors => 'Wait and RPC result errors';

  @override
  String get rpc_slot_wait => 'Slot wait: mean / maximum';

  @override
  String get rpc_response_wait => 'Response wait: mean / maximum';

  @override
  String get rpc_oldest_queued => 'Oldest waiting for a slot';

  @override
  String get rpc_oldest_inflight => 'Oldest waiting for a response';

  @override
  String get rpc_no_pending => 'None';

  @override
  String get rpc_unknown_command => 'Unknown command';

  @override
  String get rpc_handlers_active => 'Handlers running at receiver';

  @override
  String get rpc_handlers_completed => 'Handlers completed';

  @override
  String get rpc_handlers_errors => 'Handler errors';

  @override
  String get rpc_handler_duration => 'Handler duration: mean / maximum';

  @override
  String get rpc_receiver_unavailable => 'Receiver metrics unavailable';

  @override
  String get rpc_ws_timeouts =>
      'WebSocket request timeouts since panel startup';

  @override
  String rpc_occupancy(int used, int capacity, int queued) {
    return 'Slots: $used/$capacity · Waiting: $queued';
  }

  @override
  String rpc_rate_summary(String sent, String responses) {
    return 'Sent: $sent/s · Responses: $responses/s';
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
    return '$value ms';
  }

  @override
  String get rpc_receiver_stale => 'Receiver handler metrics are out of date.';

  @override
  String get effects_title => 'Transition effects';

  @override
  String get effects_general => 'General slideshow settings';

  @override
  String get effects_search => 'Search effects';

  @override
  String get effects_all => 'All';

  @override
  String get effects_enabled => 'Enabled';

  @override
  String get effects_modified => 'Modified';

  @override
  String get effects_group => 'Group';

  @override
  String get effects_fades => 'Fades';

  @override
  String get effects_movement => 'Movement';

  @override
  String get effects_masks => 'Masks';

  @override
  String get effects_geometric => 'Geometric';

  @override
  String get effects_cinematic => 'Cinematic';

  @override
  String get effects_creative => 'Creative';

  @override
  String get effects_global_duration => 'Global duration, ms';

  @override
  String get effects_duration => 'Duration, ms';

  @override
  String get effects_inherit => 'Global';

  @override
  String get effects_custom => 'Custom';

  @override
  String get effects_enable_all => 'Enable all effects';

  @override
  String get effects_disable_all => 'Disable all effects';

  @override
  String get effects_inherit_all => 'Use global duration for all effects';

  @override
  String get effects_reset => 'Reset parameters';

  @override
  String get effects_empty =>
      'No compatible effect selected: Fade uses the global duration.';

  @override
  String get effects_invalid =>
      'Invalid effect configuration. Fix the fields or reset the effect set.';

  @override
  String get effects_restore => 'Reset effect set';

  @override
  String get effects_no_results => 'No effects found';

  @override
  String get effects_enable => 'Enabled';

  @override
  String get effects_grid => 'Grid size';

  @override
  String get effects_fade_fraction => 'Cell fade duration';

  @override
  String get effects_fade_help =>
      'Fraction of transition time spent fading each cell. 0% gives a hard cutoff.';

  @override
  String get effects_direction => 'Direction';

  @override
  String get effects_random => 'Random cells';

  @override
  String get effects_topLeft => 'Top left';

  @override
  String get effects_topRight => 'Top right';

  @override
  String get effects_bottomLeft => 'Bottom left';

  @override
  String get effects_bottomRight => 'Bottom right';

  @override
  String get effects_center => 'Center';

  @override
  String get effects_left => 'Left';

  @override
  String get effects_right => 'Right';

  @override
  String get effects_up => 'Up';

  @override
  String get effects_down => 'Down';

  @override
  String get effects_mode => 'Mode';

  @override
  String get effects_push => 'Push';

  @override
  String get effects_cover => 'Cover';

  @override
  String get effects_reveal => 'Reveal';

  @override
  String get effects_shape => 'Shape';

  @override
  String get effects_wipe => 'Wipe';

  @override
  String get effects_curtain => 'Curtain';

  @override
  String get effects_diagonal => 'Diagonal';

  @override
  String get effects_iris => 'Iris';

  @override
  String get effects_axis => 'Axis';

  @override
  String get effects_horizontal => 'Horizontal';

  @override
  String get effects_vertical => 'Vertical';

  @override
  String get effects_origin => 'Origin';

  @override
  String get color_choose => 'Choose color';

  @override
  String get color_apply => 'Apply';

  @override
  String get effects_color => 'Color, AARRGGBB';

  @override
  String get effects_black => 'Black';

  @override
  String get effects_white => 'White';

  @override
  String get effects_style => 'Style';

  @override
  String get effects_soft => 'Soft';

  @override
  String get effects_lightSweep => 'Light sweep';

  @override
  String get effects_neon => 'Neon';

  @override
  String get effects_edge => 'Pivot edge';

  @override
  String get effects_top => 'Top';

  @override
  String get effects_bottom => 'Bottom';

  @override
  String get effects_angle => 'Angle, degrees';

  @override
  String get effects_count => 'Strip / panel count';

  @override
  String get effects_slide => 'Slide';

  @override
  String get effects_reveal_mask => 'Reveal mask';

  @override
  String get effects_fade_color => 'Fade through color';

  @override
  String get effects_flip => 'Flip';

  @override
  String get effects_rotate => 'Rotate';

  @override
  String effects_milliseconds(int value) {
    return '$value ms';
  }

  @override
  String get effect_parameter_gridSize => 'Grid size';

  @override
  String get effect_parameter_fadeFraction => 'Fade fraction';

  @override
  String get effect_parameter_direction => 'Direction';

  @override
  String get effect_parameter_randomness => 'Randomness';

  @override
  String get effect_parameter_mode => 'Mode';

  @override
  String get effect_parameter_motionCurve => 'Motion curve';

  @override
  String get effect_parameter_blurFraction => 'Blur fraction';

  @override
  String get effect_parameter_decoration => 'Decoration';

  @override
  String get effect_parameter_edgeWidth => 'Edge width';

  @override
  String get effect_parameter_tiltDegrees => 'Tilt degrees';

  @override
  String get effect_parameter_shadowStrength => 'Shadow strength';

  @override
  String get effect_parameter_shape => 'Shape';

  @override
  String get effect_parameter_axis => 'Axis';

  @override
  String get effect_parameter_origin => 'Origin';

  @override
  String get effect_parameter_operation => 'Operation';

  @override
  String get effect_parameter_edgeStyle => 'Edge style';

  @override
  String get effect_parameter_featherFraction => 'Feather fraction';

  @override
  String get effect_parameter_lightStrength => 'Light strength';

  @override
  String get effect_parameter_frameEnabled => 'Frame enabled';

  @override
  String get effect_parameter_borderWidth => 'Border width';

  @override
  String get effect_parameter_borderColor => 'Border color';

  @override
  String get effect_parameter_pointCount => 'Point count';

  @override
  String get effect_parameter_innerRadiusRatio => 'Inner radius ratio';

  @override
  String get effect_parameter_rotationDegrees => 'Rotation degrees';

  @override
  String get effect_parameter_startAngleDegrees => 'Start angle degrees';

  @override
  String get effect_parameter_circularDirection => 'Circular direction';

  @override
  String get effect_parameter_color => 'Color';

  @override
  String get effect_parameter_style => 'Style';

  @override
  String get effect_parameter_rotationSense => 'Rotation sense';

  @override
  String get effect_parameter_perspectiveStrength => 'Perspective strength';

  @override
  String get effect_parameter_edge => 'Edge';

  @override
  String get effect_parameter_angleDegrees => 'Angle degrees';

  @override
  String get effect_parameter_stripCount => 'Strip count';

  @override
  String get effect_parameter_order => 'Order';

  @override
  String get effect_parameter_staggerFraction => 'Stagger fraction';

  @override
  String get effect_parameter_pattern => 'Pattern';

  @override
  String get effect_parameter_paneCount => 'Pane count';

  @override
  String get effect_parameter_refractionStrength => 'Refraction strength';

  @override
  String get effect_parameter_glintStrength => 'Glint strength';

  @override
  String get effect_parameter_panelCount => 'Panel count';

  @override
  String get effect_parameter_slatCount => 'Slat count';

  @override
  String get effect_parameter_shadowIntensity => 'Shadow intensity';

  @override
  String get effect_parameter_blendCurve => 'Blend curve';

  @override
  String get effect_parameter_maxSigma => 'Max sigma';

  @override
  String get effect_parameter_blurTarget => 'Blur target';

  @override
  String get effect_parameter_holdFraction => 'Hold fraction';

  @override
  String get effect_parameter_fadeOutShare => 'Fade out share';

  @override
  String get effect_parameter_softness => 'Softness';

  @override
  String get effect_parameter_noiseScale => 'Noise scale';

  @override
  String get effect_parameter_waveAmplitude => 'Wave amplitude';

  @override
  String get effect_parameter_waveFrequency => 'Wave frequency';

  @override
  String get effect_parameter_bandWidth => 'Band width';

  @override
  String get effect_parameter_waveCount => 'Wave count';

  @override
  String get effect_parameter_waveIntensity => 'Wave intensity';

  @override
  String get effect_parameter_outgoingScale => 'Outgoing scale';

  @override
  String get effect_parameter_scale => 'Scale';

  @override
  String get effect_parameter_clipAmount => 'Clip amount';

  @override
  String get effect_parameter_zoomOutScale => 'Zoom out scale';

  @override
  String get effect_parameter_enableOpacity => 'Enable opacity';

  @override
  String get effect_parameter_startScale => 'Start scale';

  @override
  String get effect_parameter_corner => 'Corner';

  @override
  String get effect_parameter_foldWidth => 'Fold width';

  @override
  String get effect_parameter_paperColor => 'Paper color';

  @override
  String get effect_parameter_splitPosition => 'Split position';

  @override
  String get effect_parameter_maxScale => 'Max scale';

  @override
  String get effect_parameter_side => 'Side';

  @override
  String get effect_parameter_strength => 'Strength';

  @override
  String get effect_parameter_radius => 'Radius';

  @override
  String get effect_parameter_warmColor => 'Warm color';

  @override
  String get effect_parameter_roughness => 'Roughness';

  @override
  String get effect_parameter_emberColor => 'Ember color';

  @override
  String get effect_parameter_gain => 'Gain';

  @override
  String get effect_parameter_sectorCount => 'Sector count';

  @override
  String get effect_parameter_lineAxis => 'Line axis';

  @override
  String get effect_parameter_glowStrength => 'Glow strength';

  @override
  String get effect_parameter_glowColor => 'Glow color';

  @override
  String get effect_parameter_springStrength => 'Spring strength';

  @override
  String get effect_parameter_cellsAcross => 'Cells across';

  @override
  String get effect_parameter_colorShiftFraction => 'Color shift fraction';

  @override
  String get effect_parameter_trackingStrength => 'Tracking strength';

  @override
  String get effect_parameter_noiseStrength => 'Noise strength';

  @override
  String get effect_parameter_trailCount => 'Trail count';

  @override
  String get effect_parameter_driftFraction => 'Drift fraction';

  @override
  String get effect_parameter_trailStrength => 'Trail strength';

  @override
  String get effect_parameter_trailColor => 'Trail color';

  @override
  String get effect_choice_FadeStyle_plain => 'Plain';

  @override
  String get effect_choice_FadeStyle_linearLight => 'Linear light';

  @override
  String get effect_choice_FadeStyle_blur => 'Blur';

  @override
  String get effect_choice_FadeStyle_throughColor => 'Through color';

  @override
  String get effect_choice_BlendCurve_linear => 'Linear';

  @override
  String get effect_choice_BlendCurve_easeIn => 'Ease in';

  @override
  String get effect_choice_BlendCurve_easeOut => 'Ease out';

  @override
  String get effect_choice_BlendCurve_easeInOut => 'Ease in out';

  @override
  String get effect_choice_BlurTarget_outgoing => 'Outgoing';

  @override
  String get effect_choice_BlurTarget_incoming => 'Incoming';

  @override
  String get effect_choice_BlurTarget_both => 'Both';

  @override
  String get effect_choice_DepthMode_recedeStill => 'Recede still';

  @override
  String get effect_choice_DepthMode_recedeSlide => 'Recede slide';

  @override
  String get effect_choice_DepthMode_approach => 'Approach';

  @override
  String get effect_choice_ZoomMode_over => 'Over';

  @override
  String get effect_choice_ZoomMode_cross => 'Cross';

  @override
  String get effect_choice_WipeEdgeStyle_hard => 'Hard';

  @override
  String get effect_choice_WipeEdgeStyle_soft => 'Soft';

  @override
  String get effect_choice_WipeEdgeStyle_lightSweep => 'Light sweep';

  @override
  String get effect_choice_WipeEdgeStyle_neon => 'Neon';

  @override
  String get effect_choice_RevealOperation_revealIncoming => 'Reveal incoming';

  @override
  String get effect_choice_RevealOperation_hideOutgoing => 'Hide outgoing';

  @override
  String get effect_choice_SliceMode_slide => 'Slide';

  @override
  String get effect_choice_SliceMode_reveal => 'Reveal';

  @override
  String get effect_choice_StripPattern_alternating => 'Alternating';

  @override
  String get effect_choice_StripPattern_sameDirection => 'Same direction';

  @override
  String get effect_choice_SequenceOrder_forward => 'Forward';

  @override
  String get effect_choice_SequenceOrder_backward => 'Backward';

  @override
  String get effect_choice_RotationSense_forward => 'Forward';

  @override
  String get effect_choice_RotationSense_backward => 'Backward';

  @override
  String get effect_choice_CircularDirection_clockwise => 'Clockwise';

  @override
  String get effect_choice_CircularDirection_counterclockwise =>
      'Counterclockwise';

  @override
  String get effect_choice_LumaOrder_brightFirst => 'Bright first';

  @override
  String get effect_choice_LumaOrder_darkFirst => 'Dark first';

  @override
  String get effect_choice_CellShape_hexagon => 'Hexagon';

  @override
  String get effect_choice_CellShape_circle => 'Circle';

  @override
  String get effect_choice_CellShape_diamond => 'Diamond';

  @override
  String get effect_choice_CellShape_square => 'Square';

  @override
  String get effect_choice_MirrorSide_leading => 'Leading';

  @override
  String get effect_choice_MirrorSide_trailing => 'Trailing';

  @override
  String get effect_choice_SlideDecoration_none => 'None';

  @override
  String get effect_choice_SlideDecoration_filmPerforation =>
      'Film perforation';

  @override
  String get effect_choice_RevealShape_rectangle => 'Rectangle';

  @override
  String get effect_choice_RevealShape_star => 'Star';

  @override
  String get effect_choice_RevealShape_clock => 'Clock';

  @override
  String get effects_preset => 'Preset';

  @override
  String get effects_custom_preset => 'Custom settings';

  @override
  String get effects_automatic => 'From style';

  @override
  String get effect_preset_burnAlpha => 'Burn Alpha';

  @override
  String get effect_preset_foldMotion => 'Fold Motion';

  @override
  String get effect_preset_glow => 'Glow';

  @override
  String get effect_preset_kaleidoscope => 'Kaleidoscope';

  @override
  String get effect_preset_tvPower => 'TV Power';

  @override
  String get effect_preset_springMotion => 'Spring Motion';

  @override
  String get effect_preset_shapeDissolve => 'Shape Dissolve';

  @override
  String get effect_preset_vhsDamage => 'VHS Damage';

  @override
  String get effect_preset_radialBlur => 'Radial Blur';

  @override
  String get effect_preset_phosphor => 'Phosphor';

  @override
  String get effect_preset_filmDissolve => 'Film Dissolve';

  @override
  String get effect_preset_frame => 'Frame';

  @override
  String get effect_preset_louver => 'Louver';

  @override
  String get effect_preset_mirror => 'Mirror';

  @override
  String get effect_preset_clockWipe => 'Clock Wipe';

  @override
  String get effect_preset_split => 'Split';

  @override
  String get effect_preset_panelWipe => 'Panel Wipe';

  @override
  String get effect_preset_stretch => 'Stretch';

  @override
  String get effect_preset_starWipe => 'Star Wipe';

  @override
  String get effect_preset_lightLeak => 'Light Leak';

  @override
  String get effect_preset_filmRoll => 'Film Roll';

  @override
  String get effect_preset_crossZoom => 'Cross Zoom';

  @override
  String get effect_preset_whip => 'Whip';

  @override
  String get effect_preset_glass => 'Glass';

  @override
  String get effect_preset_softWipe => 'Soft Wipe';

  @override
  String get effect_preset_slice => 'Slice';

  @override
  String get effect_preset_lumaFade => 'Luma Fade';

  @override
  String get effect_preset_pagePeel => 'Page Peel';

  @override
  String get effect_preset_noiseDissolve => 'Noise Dissolve';

  @override
  String get effect_preset_rippleReveal => 'Ripple Reveal';

  @override
  String get effect_preset_waterRefraction => 'Water Refraction';

  @override
  String get effect_preset_cube => 'Cube';

  @override
  String get effect_preset_accordion => 'Accordion';

  @override
  String get effect_preset_backgroundToForeground => 'Background to foreground';

  @override
  String get effect_preset_foregroundToBackground => 'Foreground to background';

  @override
  String get effect_preset_depth => 'Depth';

  @override
  String get effect_preset_parallax => 'Parallax';

  @override
  String get effect_preset_stack => 'Stack';

  @override
  String get effect_preset_tablet => 'Tablet';

  @override
  String get effect_preset_zoomOut => 'Zoom out';

  @override
  String get effect_preset_fade => 'Fade';

  @override
  String get effect_preset_mosaic => 'Mosaic';

  @override
  String get effect_preset_liquidMorph => 'Liquid morph';

  @override
  String get effect_preset_blinds => 'Blinds';

  @override
  String get effect_preset_blurFade => 'Blur fade';

  @override
  String get effect_preset_zoomOver => 'Zoom over';

  @override
  String get effect_preset_slide => 'Slide';

  @override
  String get effect_preset_revealMask => 'Reveal mask';

  @override
  String get effect_preset_fadeThroughColor => 'Fade through color';

  @override
  String get effect_preset_flip => 'Flip';

  @override
  String get effect_preset_rotate => 'Rotate';

  @override
  String get effect_preset_softWipeLightSweep => 'Soft wipe light sweep';

  @override
  String get effect_preset_softWipeNeon => 'Soft wipe neon';

  @override
  String get effect_preset_fadeThroughWhite => 'Fade through white';

  @override
  String get effect_preset_flipVertical => 'Flip vertical';

  @override
  String get effect_preset_rotateBottom => 'Rotate bottom';

  @override
  String get effect_preset_mosaicBinary => 'Mosaic binary';

  @override
  String get effect_preset_mosaicTopLeft => 'Mosaic top left';

  @override
  String get effect_preset_mosaicTopRight => 'Mosaic top right';

  @override
  String get effect_preset_mosaicBottomLeft => 'Mosaic bottom left';

  @override
  String get effect_preset_mosaicBottomRight => 'Mosaic bottom right';

  @override
  String get effect_preset_slidePushRight => 'Slide push right';

  @override
  String get effect_preset_slidePushUp => 'Slide push up';

  @override
  String get effect_preset_slidePushDown => 'Slide push down';

  @override
  String get effect_preset_slideCoverLeft => 'Slide cover left';

  @override
  String get effect_preset_slideCoverRight => 'Slide cover right';

  @override
  String get effect_preset_slideCoverUp => 'Slide cover up';

  @override
  String get effect_preset_slideCoverDown => 'Slide cover down';

  @override
  String get effect_preset_slideRevealLeft => 'Slide reveal left';

  @override
  String get effect_preset_slideRevealRight => 'Slide reveal right';

  @override
  String get effect_preset_slideRevealUp => 'Slide reveal up';

  @override
  String get effect_preset_slideRevealDown => 'Slide reveal down';

  @override
  String get effect_preset_wipeRight => 'Wipe right';

  @override
  String get effect_preset_wipeUp => 'Wipe up';

  @override
  String get effect_preset_wipeDown => 'Wipe down';

  @override
  String get effect_preset_curtainHorizontal => 'Curtain horizontal';

  @override
  String get effect_preset_curtainVertical => 'Curtain vertical';

  @override
  String get effect_preset_diagonalTopRight => 'Diagonal top right';

  @override
  String get effect_preset_diagonalBottomLeft => 'Diagonal bottom left';

  @override
  String get effect_preset_diagonalBottomRight => 'Diagonal bottom right';

  @override
  String get effect_preset_diagonalTopLeft => 'Diagonal top left';

  @override
  String get effect_preset_irisCenter => 'Iris center';

  @override
  String get effects_wave_origin => 'Wave origin';

  @override
  String get effects_advanced => 'Advanced';
}
