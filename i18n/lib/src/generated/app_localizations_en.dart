// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get connectButtonText => 'Connect';

  @override
  String get urlInputText => 'Url';

  @override
  String get codeInputText => 'Code';

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get english => 'English';

  @override
  String get russian => 'Russian';

  @override
  String get feature_scope_user_permission => 'Permissions';

  @override
  String get feature_scope_users => 'Users';

  @override
  String get feature_scope_agreement => 'Agreement';

  @override
  String get feature_scope_goal => 'Goal';

  @override
  String get feature_scope_chat => 'Chat';

  @override
  String get feature_scope_work => 'Work';

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
  String get chat_message_datetime_format => 'hh:mm';

  @override
  String get admin_nav_account_name => 'Account';

  @override
  String get admin_roles_scope => 'Scope';

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
  String get unknown_storage_type_configuration => 'Unknown storage type configuration';

  @override
  String get no_configuration_needed_for_local_disk => 'No configuration needed for local disk yet.';

  @override
  String get slideshow_settings_title => 'Slideshow Settings';

  @override
  String get background_opacity => 'Background Opacity';

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
  String get no_access_contact_administrator => 'No access, contact your administrator';

  @override
  String get ch_text => 'Ch:';

  @override
  String get device_text => 'Device:';

  @override
  String get connect_form_title => 'WiFi Configuration';

  @override
  String get connect_button => 'Connect';

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
  String get manage_your_device_settings_and_updates => 'Manage your device settings and updates.';

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
  String get choose_action_on_device => 'Choose an action to perform on the device';

  @override
  String get restart_application => 'Restart Application';

  @override
  String get reload_software_without_rebooting_os => 'Reloads the software without rebooting the OS.';

  @override
  String get restart_application_question => 'Restart Application?';

  @override
  String get this_will_reload_configuration_app_and_slideshow_services => 'This will reload the configuration app and slideshow services.';

  @override
  String get restart => 'Restart';

  @override
  String get power_off => 'Power Off';

  @override
  String get safely_shuts_down_the_device_operating_system => 'Safely shuts down the device operating system.';

  @override
  String get power_off_device_question => 'Power Off Device?';

  @override
  String get the_device_will_shut_down_completely => 'The device will shut down completely. You will need to physically turn it on again.';

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
    return 'Transition: $transitionTime ms\\nDisplay: $displayTime ms';
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
}
