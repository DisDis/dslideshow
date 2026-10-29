import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// No description provided for @home_userid.
  ///
  /// In en, this message translates to:
  /// **'UserId: \'{userId}\''**
  String home_userid(String userId);

  /// No description provided for @home_page_name.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_page_name;

  /// No description provided for @home_page_logout_button.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get home_page_logout_button;

  /// No description provided for @login_page_name.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_page_name;

  /// No description provided for @admin_account_info_title.
  ///
  /// In en, this message translates to:
  /// **'Title: {title}'**
  String admin_account_info_title(String title);

  /// Title for the upload queue page
  ///
  /// In en, this message translates to:
  /// **'Upload Queue'**
  String get upload_queue_title;

  /// Menu item to add files for upload
  ///
  /// In en, this message translates to:
  /// **'Add Files'**
  String get add_files_menu_item;

  /// Menu item to add a folder for upload
  ///
  /// In en, this message translates to:
  /// **'Add Folder'**
  String get add_folder_menu_item;

  /// Message shown when upload queue is empty
  ///
  /// In en, this message translates to:
  /// **'Queue is empty'**
  String get queue_is_empty;

  /// Message shown when no images are found in selected folder
  ///
  /// In en, this message translates to:
  /// **'No images found in folder'**
  String get no_images_found_in_folder;

  /// Message shown when authentication fails
  ///
  /// In en, this message translates to:
  /// **'Authentication Failure'**
  String get authentication_failure;

  /// Title for the OTA update page
  ///
  /// In en, this message translates to:
  /// **'OTA Update'**
  String get ota_update_title;

  /// Message shown when system is in unknown state
  ///
  /// In en, this message translates to:
  /// **'Unknown state'**
  String get unknown_state;

  /// Text for initialize button
  ///
  /// In en, this message translates to:
  /// **'Initialize'**
  String get initialize_button;

  /// Text for select file button
  ///
  /// In en, this message translates to:
  /// **'Select File'**
  String get select_file_button;

  /// Text for update button
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update_button;

  /// Text for reset button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset_button;

  /// Home menu item text
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_menu_item;

  /// Gallery menu item text
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery_menu_item;

  /// Upload media menu item text
  ///
  /// In en, this message translates to:
  /// **'Upload media'**
  String get upload_media_menu_item;

  /// Configuration menu item text
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration_menu_item;

  /// WiFi menu item text
  ///
  /// In en, this message translates to:
  /// **'Wifi'**
  String get wifi_menu_item;

  /// System control menu item text
  ///
  /// In en, this message translates to:
  /// **'System Control'**
  String get system_control_menu_item;

  /// Exit menu item text
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit_menu_item;

  /// Title for storage settings page
  ///
  /// In en, this message translates to:
  /// **'Storage Settings'**
  String get storage_settings_title;

  /// Message for unknown storage type configuration
  ///
  /// In en, this message translates to:
  /// **'Unknown storage type configuration'**
  String get unknown_storage_type_configuration;

  /// Message when no configuration is needed for local disk
  ///
  /// In en, this message translates to:
  /// **'No configuration needed for local disk yet.'**
  String get no_configuration_needed_for_local_disk;

  /// Title for slideshow settings page
  ///
  /// In en, this message translates to:
  /// **'Slideshow Settings'**
  String get slideshow_settings_title;

  /// Label for background opacity setting
  ///
  /// In en, this message translates to:
  /// **'Background Opacity'**
  String get background_opacity;

  /// No description provided for @config_save_button.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get config_save_button;

  /// No description provided for @config_reload_button.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get config_reload_button;

  /// No description provided for @config_unsaved_changes.
  ///
  /// In en, this message translates to:
  /// **'Unsaved changes'**
  String get config_unsaved_changes;

  /// No description provided for @config_saved_state.
  ///
  /// In en, this message translates to:
  /// **'No unsaved changes'**
  String get config_saved_state;

  /// No description provided for @config_restart_hint.
  ///
  /// In en, this message translates to:
  /// **'Saved settings take effect after restarting the application.'**
  String get config_restart_hint;

  /// No description provided for @config_reload_title.
  ///
  /// In en, this message translates to:
  /// **'Reload settings?'**
  String get config_reload_title;

  /// No description provided for @config_reload_warning.
  ///
  /// In en, this message translates to:
  /// **'Discard your changes and load the saved settings from the device?'**
  String get config_reload_warning;

  /// No description provided for @config_leave_warning.
  ///
  /// In en, this message translates to:
  /// **'Your changes have not been saved. Discard them and leave settings?'**
  String get config_leave_warning;

  /// No description provided for @config_keep_editing.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get config_keep_editing;

  /// No description provided for @config_discard_changes.
  ///
  /// In en, this message translates to:
  /// **'Discard changes'**
  String get config_discard_changes;

  /// No description provided for @config_operation_in_progress.
  ///
  /// In en, this message translates to:
  /// **'Wait for the current settings operation to finish.'**
  String get config_operation_in_progress;

  /// No description provided for @config_load_failed.
  ///
  /// In en, this message translates to:
  /// **'Could not load settings'**
  String get config_load_failed;

  /// Message shown when config is saved successfully
  ///
  /// In en, this message translates to:
  /// **'Config saved successfully'**
  String get config_saved_successfully;

  /// Message shown when config is reloading
  ///
  /// In en, this message translates to:
  /// **'Config is reloading...'**
  String get config_is_reloading;

  /// Title for settings page
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// Title for select items dialog
  ///
  /// In en, this message translates to:
  /// **'Select items'**
  String get select_items_dialog_title;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_button;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok_button;

  /// Not found message
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get not_found;

  /// Title for no access page
  ///
  /// In en, this message translates to:
  /// **'No access'**
  String get no_access_title;

  /// Message to contact administrator when no access
  ///
  /// In en, this message translates to:
  /// **'No access, contact your administrator'**
  String get no_access_contact_administrator;

  /// Short text for 'Channel' in WiFi context
  ///
  /// In en, this message translates to:
  /// **'Ch:'**
  String get ch_text;

  /// Text for 'Device' label
  ///
  /// In en, this message translates to:
  /// **'Device:'**
  String get device_text;

  /// Title for WiFi connect form
  ///
  /// In en, this message translates to:
  /// **'WiFi Configuration'**
  String get connect_form_title;

  /// Connect button text
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect_button;

  /// No description provided for @gallery_load_failed.
  ///
  /// In en, this message translates to:
  /// **'Could not load the gallery.'**
  String get gallery_load_failed;

  /// No description provided for @gallery_refresh_failed.
  ///
  /// In en, this message translates to:
  /// **'Could not refresh the gallery. Your previous list is still available.'**
  String get gallery_refresh_failed;

  /// Title for gallery page
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery_title;

  /// Title for system control page
  ///
  /// In en, this message translates to:
  /// **'System Control'**
  String get system_control_title;

  /// Try again button text
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get try_again_button;

  /// Generic error text
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_text;

  /// Welcome back greeting text
  ///
  /// In en, this message translates to:
  /// **'Welcome back,'**
  String get welcome_back;

  /// Description text on home page
  ///
  /// In en, this message translates to:
  /// **'Manage your device settings and updates.'**
  String get manage_your_device_settings_and_updates;

  /// Title for gallery card on home page
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery_card_title;

  /// Subtitle for gallery card
  ///
  /// In en, this message translates to:
  /// **'View media'**
  String get view_media_subtitle;

  /// Title for upload card on home page
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload_card_title;

  /// Subtitle for upload card
  ///
  /// In en, this message translates to:
  /// **'Upload media'**
  String get upload_media_subtitle;

  /// Title for OTA update card on home page
  ///
  /// In en, this message translates to:
  /// **'OTA Update'**
  String get ota_update_card_title;

  /// Subtitle for OTA update card
  ///
  /// In en, this message translates to:
  /// **'Firmware upgrade'**
  String get firmware_upgrade_subtitle;

  /// Title for WiFi setup card on home page
  ///
  /// In en, this message translates to:
  /// **'WiFi Setup'**
  String get wifi_setup_card_title;

  /// Subtitle for WiFi setup card
  ///
  /// In en, this message translates to:
  /// **'Manage connections'**
  String get manage_connections_subtitle;

  /// Title for configuration card on home page
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration_card_title;

  /// Subtitle for configuration card
  ///
  /// In en, this message translates to:
  /// **'System settings'**
  String get system_settings_subtitle;

  /// Title for system control card on home page
  ///
  /// In en, this message translates to:
  /// **'System Control'**
  String get system_control_card_title;

  /// Subtitle for system control card
  ///
  /// In en, this message translates to:
  /// **'Restart app, power off'**
  String get restart_app_power_off_subtitle;

  /// Title for MQTT settings page
  ///
  /// In en, this message translates to:
  /// **'MQTT Settings'**
  String get mqtt_settings_title;

  /// Title for WebServer settings page
  ///
  /// In en, this message translates to:
  /// **'WebServer Settings'**
  String get webserver_settings_title;

  /// Title for Welcome settings page
  ///
  /// In en, this message translates to:
  /// **'Welcome Settings'**
  String get welcome_settings_title;

  /// Subtitle for saved connections section in WiFi
  ///
  /// In en, this message translates to:
  /// **'Saved Connections'**
  String get saved_connections_subtitle;

  /// Message when no WiFi networks are found nearby
  ///
  /// In en, this message translates to:
  /// **'No networks found nearby'**
  String get no_networks_found_nearby;

  /// Title for adding a new WiFi network
  ///
  /// In en, this message translates to:
  /// **'Add Network'**
  String get add_network;

  /// Title for connecting to a WiFi network
  ///
  /// In en, this message translates to:
  /// **'Connect to Network'**
  String get connect_to_network;

  /// Label for SSID input field
  ///
  /// In en, this message translates to:
  /// **'SSID (Name)'**
  String get ssid_name_label;

  /// Message for required field validation
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required_field;

  /// Message shown when connection fails
  ///
  /// In en, this message translates to:
  /// **'Connection Failed'**
  String get connection_failed;

  /// Title for power management section
  ///
  /// In en, this message translates to:
  /// **'Power Management'**
  String get power_management_title;

  /// Description text for power management section
  ///
  /// In en, this message translates to:
  /// **'Choose an action to perform on the device'**
  String get choose_action_on_device;

  /// Title for restart application action
  ///
  /// In en, this message translates to:
  /// **'Restart Application'**
  String get restart_application;

  /// Description for restart application action
  ///
  /// In en, this message translates to:
  /// **'Reloads the software without rebooting the OS.'**
  String get reload_software_without_rebooting_os;

  /// Question for restart application confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Restart Application?'**
  String get restart_application_question;

  /// Description for restart application confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'This will reload the configuration app and slideshow services.'**
  String get this_will_reload_configuration_app_and_slideshow_services;

  /// Restart button text
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// Title for power off action
  ///
  /// In en, this message translates to:
  /// **'Power Off'**
  String get power_off;

  /// Description for power off action
  ///
  /// In en, this message translates to:
  /// **'Safely shuts down the device operating system.'**
  String get safely_shuts_down_the_device_operating_system;

  /// Question for power off confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Power Off Device?'**
  String get power_off_device_question;

  /// Description for power off confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'The device will shut down completely. You will need to physically turn it on again.'**
  String get the_device_will_shut_down_completely;

  /// Power off button text
  ///
  /// In en, this message translates to:
  /// **'Power Off'**
  String get power_off_button;

  /// Message prompting user to sign in
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue'**
  String get please_sign_in_to_continue;

  /// Label for server URI input field
  ///
  /// In en, this message translates to:
  /// **'Server URI'**
  String get server_uri;

  /// Error message for invalid URI
  ///
  /// In en, this message translates to:
  /// **'Invalid URI'**
  String get invalid_uri;

  /// Error message for invalid username
  ///
  /// In en, this message translates to:
  /// **'Invalid username'**
  String get invalid_username;

  /// Error message for invalid password
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get invalid_password;

  /// Sign in button text
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// Message for not found item with specific ID
  ///
  /// In en, this message translates to:
  /// **'Not found \"{id}\"'**
  String not_found_with_id(String id);

  /// Display transition and display times
  ///
  /// In en, this message translates to:
  /// **'Transition: {transitionTime} ms\nDisplay: {displayTime} ms'**
  String transition_display_times(int transitionTime, int displayTime);

  /// Label for 5GHz WiFi networks
  ///
  /// In en, this message translates to:
  /// **'5G'**
  String get wifi_5ghz_label;

  /// Text showing the WiFi channel number
  ///
  /// In en, this message translates to:
  /// **'Ch: {channel}'**
  String channel_text(int channel);

  /// Information about device connection
  ///
  /// In en, this message translates to:
  /// **'Device: {device} • {type}'**
  String device_connection_info(String device, String type);

  /// Title for slideshow section in config
  ///
  /// In en, this message translates to:
  /// **'Slideshow'**
  String get slideshow_section_title;

  /// Title for general and effects settings
  ///
  /// In en, this message translates to:
  /// **'General & Effects'**
  String get general_and_effects_title;

  /// Title for welcome screen settings
  ///
  /// In en, this message translates to:
  /// **'Welcome Screen'**
  String get welcome_screen_title;

  /// Title for storage configuration
  ///
  /// In en, this message translates to:
  /// **'Storage Configuration'**
  String get storage_configuration_title;

  /// Text indicating local disk is being used
  ///
  /// In en, this message translates to:
  /// **'Using Local Disk'**
  String get using_local_disk;

  /// Text indicating Google Photos is being used
  ///
  /// In en, this message translates to:
  /// **'Using Google Photos'**
  String get using_google_photos;

  /// Title for connectivity section
  ///
  /// In en, this message translates to:
  /// **'Connectivity'**
  String get connectivity_title;

  /// Title for web server settings
  ///
  /// In en, this message translates to:
  /// **'Web server'**
  String get web_server_settings_title;

  /// Title for MQTT settings
  ///
  /// In en, this message translates to:
  /// **'MQTT'**
  String get mqtt_title;

  /// Title for hardware section
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get hardware_title;

  /// Label for GPIO smoothing setting
  ///
  /// In en, this message translates to:
  /// **'GPIO Smoothing (ms)'**
  String get gpio_smoothing_label;

  /// Title for logging levels section
  ///
  /// In en, this message translates to:
  /// **'Logging Levels'**
  String get logging_levels_title;

  /// Label for main logic logging level
  ///
  /// In en, this message translates to:
  /// **'Main Logic'**
  String get main_logic_label;

  /// Label for OTA update logging level
  ///
  /// In en, this message translates to:
  /// **'OTA Update'**
  String get ota_update_label;

  /// Label for hardware frame logging level
  ///
  /// In en, this message translates to:
  /// **'Hardware Frame'**
  String get hardware_frame_label;

  /// Title for storage section
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage_title;

  /// Text for retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry_button;

  /// Error message with specific details
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String error_with_message(String message);

  /// Example email address for display purposes
  ///
  /// In en, this message translates to:
  /// **'example@gmail.com'**
  String get example_email_address;

  /// No description provided for @special_screens_title.
  ///
  /// In en, this message translates to:
  /// **'Special screens'**
  String get special_screens_title;

  /// No description provided for @special_screen_clock.
  ///
  /// In en, this message translates to:
  /// **'Date and time'**
  String get special_screen_clock;

  /// No description provided for @special_screen_cameras.
  ///
  /// In en, this message translates to:
  /// **'Cameras'**
  String get special_screen_cameras;

  /// No description provided for @special_add_screen.
  ///
  /// In en, this message translates to:
  /// **'Add screen'**
  String get special_add_screen;

  /// No description provided for @special_empty.
  ///
  /// In en, this message translates to:
  /// **'Add a clock or a camera screen to the slideshow.'**
  String get special_empty;

  /// No description provided for @special_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get special_name;

  /// No description provided for @special_enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get special_enabled;

  /// No description provided for @special_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get special_delete;

  /// No description provided for @special_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get special_done;

  /// No description provided for @special_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get special_cancel;

  /// No description provided for @special_preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get special_preview;

  /// No description provided for @special_preview_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Preview unavailable. Check the camera URL and network access.'**
  String get special_preview_unavailable;

  /// No description provided for @special_next_camera.
  ///
  /// In en, this message translates to:
  /// **'Next camera'**
  String get special_next_camera;

  /// No description provided for @special_common.
  ///
  /// In en, this message translates to:
  /// **'Playback'**
  String get special_common;

  /// No description provided for @special_frequency.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get special_frequency;

  /// No description provided for @special_after_slides.
  ///
  /// In en, this message translates to:
  /// **'After media slides'**
  String get special_after_slides;

  /// No description provided for @special_interval.
  ///
  /// In en, this message translates to:
  /// **'At an active playback interval'**
  String get special_interval;

  /// No description provided for @special_slide_count.
  ///
  /// In en, this message translates to:
  /// **'Number of photos / videos'**
  String get special_slide_count;

  /// No description provided for @special_interval_minutes.
  ///
  /// In en, this message translates to:
  /// **'Interval (minutes)'**
  String get special_interval_minutes;

  /// No description provided for @special_duration_seconds.
  ///
  /// In en, this message translates to:
  /// **'Display duration (seconds)'**
  String get special_duration_seconds;

  /// No description provided for @special_seconds.
  ///
  /// In en, this message translates to:
  /// **'s'**
  String get special_seconds;

  /// No description provided for @special_minutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get special_minutes;

  /// No description provided for @special_clock_settings.
  ///
  /// In en, this message translates to:
  /// **'Clock appearance'**
  String get special_clock_settings;

  /// No description provided for @special_time_format.
  ///
  /// In en, this message translates to:
  /// **'Time format'**
  String get special_time_format;

  /// No description provided for @special_24h.
  ///
  /// In en, this message translates to:
  /// **'24 hours'**
  String get special_24h;

  /// No description provided for @special_12h.
  ///
  /// In en, this message translates to:
  /// **'12 hours (AM/PM)'**
  String get special_12h;

  /// No description provided for @special_show_seconds.
  ///
  /// In en, this message translates to:
  /// **'Show seconds'**
  String get special_show_seconds;

  /// No description provided for @special_show_date.
  ///
  /// In en, this message translates to:
  /// **'Show date'**
  String get special_show_date;

  /// No description provided for @special_date_format.
  ///
  /// In en, this message translates to:
  /// **'Date format'**
  String get special_date_format;

  /// No description provided for @special_time_size.
  ///
  /// In en, this message translates to:
  /// **'Time font (% of shorter screen side)'**
  String get special_time_size;

  /// No description provided for @special_date_size.
  ///
  /// In en, this message translates to:
  /// **'Date and weekday size (% of shorter screen side)'**
  String get special_date_size;

  /// No description provided for @special_text_color.
  ///
  /// In en, this message translates to:
  /// **'Text color (AARRGGBB)'**
  String get special_text_color;

  /// No description provided for @special_background_color.
  ///
  /// In en, this message translates to:
  /// **'Background color (AARRGGBB)'**
  String get special_background_color;

  /// No description provided for @special_camera_settings.
  ///
  /// In en, this message translates to:
  /// **'Camera display'**
  String get special_camera_settings;

  /// No description provided for @special_camera_mode.
  ///
  /// In en, this message translates to:
  /// **'Display mode'**
  String get special_camera_mode;

  /// No description provided for @special_grid.
  ///
  /// In en, this message translates to:
  /// **'All cameras in a grid'**
  String get special_grid;

  /// No description provided for @special_sequence.
  ///
  /// In en, this message translates to:
  /// **'One camera per appearance'**
  String get special_sequence;

  /// No description provided for @special_sequence_help.
  ///
  /// In en, this message translates to:
  /// **'Each appearance shows the next camera in list order.'**
  String get special_sequence_help;

  /// No description provided for @special_columns.
  ///
  /// In en, this message translates to:
  /// **'Grid columns (0 = automatic)'**
  String get special_columns;

  /// No description provided for @special_fit.
  ///
  /// In en, this message translates to:
  /// **'Image placement'**
  String get special_fit;

  /// No description provided for @special_contain.
  ///
  /// In en, this message translates to:
  /// **'Entire image'**
  String get special_contain;

  /// No description provided for @special_cover.
  ///
  /// In en, this message translates to:
  /// **'Fill and crop'**
  String get special_cover;

  /// No description provided for @special_show_names.
  ///
  /// In en, this message translates to:
  /// **'Show camera names'**
  String get special_show_names;

  /// No description provided for @special_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh (seconds; 0 = on appearance only)'**
  String get special_refresh;

  /// No description provided for @special_add_camera.
  ///
  /// In en, this message translates to:
  /// **'Add camera'**
  String get special_add_camera;

  /// No description provided for @special_camera_url.
  ///
  /// In en, this message translates to:
  /// **'Snapshot URL (HTTP/HTTPS, JPEG/PNG)'**
  String get special_camera_url;

  /// No description provided for @special_check_camera.
  ///
  /// In en, this message translates to:
  /// **'Check snapshot'**
  String get special_check_camera;

  /// No description provided for @special_move_up.
  ///
  /// In en, this message translates to:
  /// **'Move up'**
  String get special_move_up;

  /// No description provided for @special_move_down.
  ///
  /// In en, this message translates to:
  /// **'Move down'**
  String get special_move_down;

  /// No description provided for @special_invalid_number.
  ///
  /// In en, this message translates to:
  /// **'Enter a number in the allowed range.'**
  String get special_invalid_number;

  /// No description provided for @special_invalid_url.
  ///
  /// In en, this message translates to:
  /// **'Enter an HTTP/HTTPS URL.'**
  String get special_invalid_url;

  /// No description provided for @special_invalid_color.
  ///
  /// In en, this message translates to:
  /// **'Enter 8 hexadecimal digits (AARRGGBB).'**
  String get special_invalid_color;

  /// No description provided for @special_camera_required.
  ///
  /// In en, this message translates to:
  /// **'Add at least one camera.'**
  String get special_camera_required;

  /// No description provided for @special_unsupported.
  ///
  /// In en, this message translates to:
  /// **'Unsupported screen type'**
  String get special_unsupported;

  /// No description provided for @special_auth.
  ///
  /// In en, this message translates to:
  /// **'Authentication (optional)'**
  String get special_auth;

  /// No description provided for @special_save_hint.
  ///
  /// In en, this message translates to:
  /// **'Use Save on the main settings page to write changes to the device.'**
  String get special_save_hint;

  /// No description provided for @special_browser_camera_help.
  ///
  /// In en, this message translates to:
  /// **'Previews load cameras directly from this browser. The camera must allow browser access (CORS); HTTPS pages also require HTTPS camera URLs.'**
  String get special_browser_camera_help;

  /// No description provided for @photo_motion_title.
  ///
  /// In en, this message translates to:
  /// **'Photo motion'**
  String get photo_motion_title;

  /// No description provided for @photo_motion_off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get photo_motion_off;

  /// No description provided for @photo_motion_ken_burns.
  ///
  /// In en, this message translates to:
  /// **'Ken Burns (slow pan and zoom)'**
  String get photo_motion_ken_burns;

  /// No description provided for @photo_motion_zoom.
  ///
  /// In en, this message translates to:
  /// **'Maximum zoom'**
  String get photo_motion_zoom;

  /// No description provided for @preview_repeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get preview_repeat;

  /// No description provided for @effect_burn_alpha.
  ///
  /// In en, this message translates to:
  /// **'Burn Alpha'**
  String get effect_burn_alpha;

  /// No description provided for @effect_fold_motion.
  ///
  /// In en, this message translates to:
  /// **'Fold Motion'**
  String get effect_fold_motion;

  /// No description provided for @effect_glow.
  ///
  /// In en, this message translates to:
  /// **'Glow'**
  String get effect_glow;

  /// No description provided for @effect_kaleidoscope.
  ///
  /// In en, this message translates to:
  /// **'Kaleidoscope'**
  String get effect_kaleidoscope;

  /// No description provided for @effect_tv_power.
  ///
  /// In en, this message translates to:
  /// **'TV Power'**
  String get effect_tv_power;

  /// No description provided for @effect_spring_motion.
  ///
  /// In en, this message translates to:
  /// **'Spring Motion'**
  String get effect_spring_motion;

  /// No description provided for @effect_shape_dissolve.
  ///
  /// In en, this message translates to:
  /// **'Shape Dissolve'**
  String get effect_shape_dissolve;

  /// No description provided for @effect_vhs_damage.
  ///
  /// In en, this message translates to:
  /// **'VHS Damage'**
  String get effect_vhs_damage;

  /// No description provided for @effect_radial_blur.
  ///
  /// In en, this message translates to:
  /// **'Radial Blur'**
  String get effect_radial_blur;

  /// No description provided for @effect_phosphor.
  ///
  /// In en, this message translates to:
  /// **'Phosphor'**
  String get effect_phosphor;

  /// No description provided for @effect_film_dissolve.
  ///
  /// In en, this message translates to:
  /// **'Film Dissolve'**
  String get effect_film_dissolve;

  /// No description provided for @effect_frame.
  ///
  /// In en, this message translates to:
  /// **'Frame'**
  String get effect_frame;

  /// No description provided for @effect_louver.
  ///
  /// In en, this message translates to:
  /// **'Louver'**
  String get effect_louver;

  /// No description provided for @effect_mirror.
  ///
  /// In en, this message translates to:
  /// **'Mirror'**
  String get effect_mirror;

  /// No description provided for @effect_clock_wipe.
  ///
  /// In en, this message translates to:
  /// **'Clock Wipe'**
  String get effect_clock_wipe;

  /// No description provided for @effect_split.
  ///
  /// In en, this message translates to:
  /// **'Split'**
  String get effect_split;

  /// No description provided for @effect_panel_wipe.
  ///
  /// In en, this message translates to:
  /// **'Panel Wipe'**
  String get effect_panel_wipe;

  /// No description provided for @effect_stretch.
  ///
  /// In en, this message translates to:
  /// **'Stretch'**
  String get effect_stretch;

  /// No description provided for @effect_star_wipe.
  ///
  /// In en, this message translates to:
  /// **'Star Wipe'**
  String get effect_star_wipe;

  /// No description provided for @effect_light_leak.
  ///
  /// In en, this message translates to:
  /// **'Light Leak'**
  String get effect_light_leak;

  /// No description provided for @effect_film_roll.
  ///
  /// In en, this message translates to:
  /// **'Film Roll'**
  String get effect_film_roll;

  /// No description provided for @effect_cross_zoom.
  ///
  /// In en, this message translates to:
  /// **'Cross Zoom'**
  String get effect_cross_zoom;

  /// No description provided for @effect_whip.
  ///
  /// In en, this message translates to:
  /// **'Whip'**
  String get effect_whip;

  /// No description provided for @effect_glass.
  ///
  /// In en, this message translates to:
  /// **'Glass'**
  String get effect_glass;

  /// No description provided for @effect_soft_wipe.
  ///
  /// In en, this message translates to:
  /// **'Soft Wipe'**
  String get effect_soft_wipe;

  /// No description provided for @effect_slice.
  ///
  /// In en, this message translates to:
  /// **'Strips'**
  String get effect_slice;

  /// No description provided for @effect_luma_fade.
  ///
  /// In en, this message translates to:
  /// **'Luma Fade'**
  String get effect_luma_fade;

  /// No description provided for @effect_page_peel.
  ///
  /// In en, this message translates to:
  /// **'Page Peel'**
  String get effect_page_peel;

  /// No description provided for @effect_noise_dissolve.
  ///
  /// In en, this message translates to:
  /// **'Noise Dissolve'**
  String get effect_noise_dissolve;

  /// No description provided for @effect_ripple_reveal.
  ///
  /// In en, this message translates to:
  /// **'Ripple Reveal'**
  String get effect_ripple_reveal;

  /// No description provided for @effect_water_refraction.
  ///
  /// In en, this message translates to:
  /// **'Water Refraction'**
  String get effect_water_refraction;

  /// No description provided for @ui_system_default.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get ui_system_default;

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Photo frame'**
  String get app_title;

  /// No description provided for @appearance_title.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance_title;

  /// No description provided for @language_label.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_label;

  /// No description provided for @theme_mode_label.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme_mode_label;

  /// No description provided for @theme_mode_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get theme_mode_light;

  /// No description provided for @theme_mode_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get theme_mode_dark;

  /// No description provided for @device_panel_title.
  ///
  /// In en, this message translates to:
  /// **'Photo frame'**
  String get device_panel_title;

  /// No description provided for @device_settings_description.
  ///
  /// In en, this message translates to:
  /// **'Manage media, appearance and device settings.'**
  String get device_settings_description;

  /// No description provided for @connection_title.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get connection_title;

  /// No description provided for @authentication_title.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get authentication_title;

  /// No description provided for @enabled_label.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled_label;

  /// No description provided for @disabled_label.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled_label;

  /// No description provided for @server_host_label.
  ///
  /// In en, this message translates to:
  /// **'Server host'**
  String get server_host_label;

  /// No description provided for @port_label.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get port_label;

  /// No description provided for @permanent_code_label.
  ///
  /// In en, this message translates to:
  /// **'Permanent access code'**
  String get permanent_code_label;

  /// No description provided for @always_enabled_label.
  ///
  /// In en, this message translates to:
  /// **'Always enabled'**
  String get always_enabled_label;

  /// No description provided for @active_storage_label.
  ///
  /// In en, this message translates to:
  /// **'Active storage'**
  String get active_storage_label;

  /// No description provided for @provider_label.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get provider_label;

  /// No description provided for @local_disk_label.
  ///
  /// In en, this message translates to:
  /// **'Local disk'**
  String get local_disk_label;

  /// No description provided for @google_photos_label.
  ///
  /// In en, this message translates to:
  /// **'Google Photos'**
  String get google_photos_label;

  /// No description provided for @auth_refresh_token_label.
  ///
  /// In en, this message translates to:
  /// **'Refresh token'**
  String get auth_refresh_token_label;

  /// No description provided for @client_id_label.
  ///
  /// In en, this message translates to:
  /// **'Client ID'**
  String get client_id_label;

  /// No description provided for @client_secret_label.
  ///
  /// In en, this message translates to:
  /// **'Client secret'**
  String get client_secret_label;

  /// No description provided for @upload_from_disk_label.
  ///
  /// In en, this message translates to:
  /// **'Upload photos from disk'**
  String get upload_from_disk_label;

  /// No description provided for @image_width_label.
  ///
  /// In en, this message translates to:
  /// **'Image width'**
  String get image_width_label;

  /// No description provided for @image_height_label.
  ///
  /// In en, this message translates to:
  /// **'Image height'**
  String get image_height_label;

  /// No description provided for @show_secret.
  ///
  /// In en, this message translates to:
  /// **'Show value'**
  String get show_secret;

  /// No description provided for @hide_secret.
  ///
  /// In en, this message translates to:
  /// **'Hide value'**
  String get hide_secret;

  /// No description provided for @items_none.
  ///
  /// In en, this message translates to:
  /// **'None selected'**
  String get items_none;

  /// No description provided for @items_all.
  ///
  /// In en, this message translates to:
  /// **'All selected'**
  String get items_all;

  /// No description provided for @items_selected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{None selected} one{{count} item selected} other{{count} items selected}}'**
  String items_selected(int count);

  /// No description provided for @config_editor_draft_hint.
  ///
  /// In en, this message translates to:
  /// **'Edits stay in the draft. Use Save on Settings to write them to the device.'**
  String get config_editor_draft_hint;

  /// No description provided for @config_reset_button.
  ///
  /// In en, this message translates to:
  /// **'Undo edits'**
  String get config_reset_button;

  /// No description provided for @invalid_port.
  ///
  /// In en, this message translates to:
  /// **'Enter a port from 1 to 65535.'**
  String get invalid_port;

  /// No description provided for @invalid_positive_integer.
  ///
  /// In en, this message translates to:
  /// **'Enter a positive whole number.'**
  String get invalid_positive_integer;

  /// No description provided for @invalid_nonnegative_integer.
  ///
  /// In en, this message translates to:
  /// **'Enter zero or a positive whole number.'**
  String get invalid_nonnegative_integer;

  /// No description provided for @slideshow_summary.
  ///
  /// In en, this message translates to:
  /// **'Photo display: {seconds} s'**
  String slideshow_summary(num seconds);

  /// No description provided for @special_enabled_summary.
  ///
  /// In en, this message translates to:
  /// **'{enabled} of {total} enabled'**
  String special_enabled_summary(int enabled, int total);

  /// No description provided for @preview_title.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview_title;

  /// No description provided for @preview_local_controls.
  ///
  /// In en, this message translates to:
  /// **'Preview controls are local and are not saved.'**
  String get preview_local_controls;

  /// No description provided for @preview_hide.
  ///
  /// In en, this message translates to:
  /// **'Hide preview'**
  String get preview_hide;

  /// No description provided for @preview_show.
  ///
  /// In en, this message translates to:
  /// **'Show preview'**
  String get preview_show;

  /// No description provided for @preview_effect.
  ///
  /// In en, this message translates to:
  /// **'Preview transition'**
  String get preview_effect;

  /// No description provided for @preview_aspect.
  ///
  /// In en, this message translates to:
  /// **'Screen aspect ratio'**
  String get preview_aspect;

  /// No description provided for @preview_pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get preview_pause;

  /// No description provided for @preview_resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get preview_resume;

  /// No description provided for @preview_failed.
  ///
  /// In en, this message translates to:
  /// **'Could not prepare the preview. Try again.'**
  String get preview_failed;

  /// No description provided for @preview_last_valid.
  ///
  /// In en, this message translates to:
  /// **'Showing the last valid values. Correct the marked fields.'**
  String get preview_last_valid;

  /// No description provided for @preview_device_scale.
  ///
  /// In en, this message translates to:
  /// **'Scaled relative to a 2560 × 1600 screen'**
  String get preview_device_scale;

  /// No description provided for @preview_environment_help.
  ///
  /// In en, this message translates to:
  /// **'Uses bundled sample photos. No external media is loaded.'**
  String get preview_environment_help;

  /// No description provided for @preview_clock_help.
  ///
  /// In en, this message translates to:
  /// **'Uses this computer’s current time.'**
  String get preview_clock_help;

  /// No description provided for @timing_title.
  ///
  /// In en, this message translates to:
  /// **'Timing'**
  String get timing_title;

  /// No description provided for @display_time_ms.
  ///
  /// In en, this message translates to:
  /// **'Display duration (ms)'**
  String get display_time_ms;

  /// No description provided for @transition_time_ms.
  ///
  /// In en, this message translates to:
  /// **'Transition duration (ms)'**
  String get transition_time_ms;

  /// No description provided for @visuals_title.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get visuals_title;

  /// No description provided for @allowed_transitions.
  ///
  /// In en, this message translates to:
  /// **'Allowed transitions'**
  String get allowed_transitions;

  /// No description provided for @allowed_transitions_all.
  ///
  /// In en, this message translates to:
  /// **'An empty list allows all transitions.'**
  String get allowed_transitions_all;

  /// No description provided for @blur_background.
  ///
  /// In en, this message translates to:
  /// **'Blur background'**
  String get blur_background;

  /// No description provided for @background_blur_sigma.
  ///
  /// In en, this message translates to:
  /// **'Background blur'**
  String get background_blur_sigma;

  /// No description provided for @background_color_argb.
  ///
  /// In en, this message translates to:
  /// **'Background color (AARRGGBB)'**
  String get background_color_argb;

  /// No description provided for @welcome_text.
  ///
  /// In en, this message translates to:
  /// **'Welcome text'**
  String get welcome_text;

  /// No description provided for @welcome_text_size.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get welcome_text_size;

  /// No description provided for @welcome_delay_ms.
  ///
  /// In en, this message translates to:
  /// **'Animation phase duration (ms)'**
  String get welcome_delay_ms;

  /// No description provided for @welcome_replay.
  ///
  /// In en, this message translates to:
  /// **'Replay welcome'**
  String get welcome_replay;

  /// No description provided for @welcome_animation_help.
  ///
  /// In en, this message translates to:
  /// **'The welcome fades in and out; the delay sets the duration of each phase.'**
  String get welcome_animation_help;

  /// No description provided for @invalid_positive_number.
  ///
  /// In en, this message translates to:
  /// **'Enter a positive number.'**
  String get invalid_positive_number;

  /// No description provided for @effect_cube.
  ///
  /// In en, this message translates to:
  /// **'Cube'**
  String get effect_cube;

  /// No description provided for @effect_accordion.
  ///
  /// In en, this message translates to:
  /// **'Accordion'**
  String get effect_accordion;

  /// No description provided for @effect_background_to_foreground.
  ///
  /// In en, this message translates to:
  /// **'Background to foreground'**
  String get effect_background_to_foreground;

  /// No description provided for @effect_foreground_to_background.
  ///
  /// In en, this message translates to:
  /// **'Foreground to background'**
  String get effect_foreground_to_background;

  /// No description provided for @effect_depth.
  ///
  /// In en, this message translates to:
  /// **'Depth'**
  String get effect_depth;

  /// No description provided for @effect_parallax.
  ///
  /// In en, this message translates to:
  /// **'Parallax'**
  String get effect_parallax;

  /// No description provided for @effect_stack.
  ///
  /// In en, this message translates to:
  /// **'Stack'**
  String get effect_stack;

  /// No description provided for @effect_tablet.
  ///
  /// In en, this message translates to:
  /// **'Tablet'**
  String get effect_tablet;

  /// No description provided for @effect_zoom_out_slide.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get effect_zoom_out_slide;

  /// No description provided for @effect_fade.
  ///
  /// In en, this message translates to:
  /// **'Fade'**
  String get effect_fade;

  /// No description provided for @effect_mosaic.
  ///
  /// In en, this message translates to:
  /// **'Mosaic'**
  String get effect_mosaic;

  /// No description provided for @effect_liquid_morph.
  ///
  /// In en, this message translates to:
  /// **'Liquid morph'**
  String get effect_liquid_morph;

  /// No description provided for @effect_blinds.
  ///
  /// In en, this message translates to:
  /// **'Blinds'**
  String get effect_blinds;

  /// No description provided for @effect_blur_fade.
  ///
  /// In en, this message translates to:
  /// **'Blur fade'**
  String get effect_blur_fade;

  /// No description provided for @effect_zoom_over.
  ///
  /// In en, this message translates to:
  /// **'Zoom'**
  String get effect_zoom_over;

  /// No description provided for @sync_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Sync settings'**
  String get sync_settings_title;

  /// No description provided for @sync_period_label.
  ///
  /// In en, this message translates to:
  /// **'Sync period'**
  String get sync_period_label;

  /// No description provided for @albums_title.
  ///
  /// In en, this message translates to:
  /// **'Albums'**
  String get albums_title;

  /// No description provided for @album_names_label.
  ///
  /// In en, this message translates to:
  /// **'Album names, separated by commas'**
  String get album_names_label;

  /// No description provided for @pixels_unit.
  ///
  /// In en, this message translates to:
  /// **'px'**
  String get pixels_unit;

  /// No description provided for @minutes_unit.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutes_unit;

  /// No description provided for @milliseconds_unit.
  ///
  /// In en, this message translates to:
  /// **'ms'**
  String get milliseconds_unit;

  /// No description provided for @config_reset_warning.
  ///
  /// In en, this message translates to:
  /// **'Discard all edits and restore the last loaded or saved settings?'**
  String get config_reset_warning;

  /// No description provided for @refresh_button.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh_button;

  /// No description provided for @add_manually.
  ///
  /// In en, this message translates to:
  /// **'Add manually'**
  String get add_manually;

  /// No description provided for @delete_connection.
  ///
  /// In en, this message translates to:
  /// **'Delete connection'**
  String get delete_connection;

  /// No description provided for @forget_network_title.
  ///
  /// In en, this message translates to:
  /// **'Forget network?'**
  String get forget_network_title;

  /// No description provided for @forget_network_question.
  ///
  /// In en, this message translates to:
  /// **'Delete the saved connection “{name}”?'**
  String forget_network_question(String name);

  /// No description provided for @delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete_button;

  /// No description provided for @ota_code_label.
  ///
  /// In en, this message translates to:
  /// **'Update code'**
  String get ota_code_label;

  /// No description provided for @ota_version.
  ///
  /// In en, this message translates to:
  /// **'Version: {version}'**
  String ota_version(String version);

  /// No description provided for @ota_uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading firmware…'**
  String get ota_uploading;

  /// No description provided for @ota_upload_complete.
  ///
  /// In en, this message translates to:
  /// **'Firmware upload completed successfully.'**
  String get ota_upload_complete;

  /// No description provided for @gallery_selected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} selected} other{{count} selected}}'**
  String gallery_selected(int count);

  /// No description provided for @clear_selection.
  ///
  /// In en, this message translates to:
  /// **'Clear selection'**
  String get clear_selection;

  /// No description provided for @gallery_empty.
  ///
  /// In en, this message translates to:
  /// **'No media files yet.'**
  String get gallery_empty;

  /// No description provided for @upload_empty_hint.
  ///
  /// In en, this message translates to:
  /// **'Add photos and videos to display on the frame.'**
  String get upload_empty_hint;

  /// No description provided for @upload_remove_task.
  ///
  /// In en, this message translates to:
  /// **'Remove from queue'**
  String get upload_remove_task;

  /// No description provided for @video_load.
  ///
  /// In en, this message translates to:
  /// **'Load video'**
  String get video_load;

  /// No description provided for @video_tap_to_play.
  ///
  /// In en, this message translates to:
  /// **'Tap to play'**
  String get video_tap_to_play;

  /// No description provided for @media_info.
  ///
  /// In en, this message translates to:
  /// **'File information'**
  String get media_info;

  /// No description provided for @invalid_editor_leave_warning.
  ///
  /// In en, this message translates to:
  /// **'Some fields contain invalid values. Discard the incomplete input and return to settings?'**
  String get invalid_editor_leave_warning;

  /// No description provided for @discard_invalid_input.
  ///
  /// In en, this message translates to:
  /// **'Discard input'**
  String get discard_invalid_input;

  /// No description provided for @special_no_image.
  ///
  /// In en, this message translates to:
  /// **'No image'**
  String get special_no_image;

  /// No description provided for @special_request_timeout.
  ///
  /// In en, this message translates to:
  /// **'Snapshot timeout (seconds)'**
  String get special_request_timeout;

  /// No description provided for @special_request_timeout_help.
  ///
  /// In en, this message translates to:
  /// **'Time allowed for one snapshot request: 0.1–120 seconds. An unavailable image is replaced with a message.'**
  String get special_request_timeout_help;

  /// No description provided for @special_time_font.
  ///
  /// In en, this message translates to:
  /// **'Time font'**
  String get special_time_font;

  /// No description provided for @special_date_font.
  ///
  /// In en, this message translates to:
  /// **'Date and weekday font'**
  String get special_date_font;

  /// No description provided for @special_show_weekday.
  ///
  /// In en, this message translates to:
  /// **'Show day of the week'**
  String get special_show_weekday;

  /// No description provided for @special_font_system.
  ///
  /// In en, this message translates to:
  /// **'Default font'**
  String get special_font_system;

  /// No description provided for @special_font_roboto.
  ///
  /// In en, this message translates to:
  /// **'Roboto'**
  String get special_font_roboto;

  /// No description provided for @special_font_orbitron.
  ///
  /// In en, this message translates to:
  /// **'Orbitron'**
  String get special_font_orbitron;

  /// No description provided for @special_font_righteous.
  ///
  /// In en, this message translates to:
  /// **'Righteous'**
  String get special_font_righteous;

  /// No description provided for @special_font_fredoka.
  ///
  /// In en, this message translates to:
  /// **'Fredoka One'**
  String get special_font_fredoka;

  /// No description provided for @special_font_help.
  ///
  /// In en, this message translates to:
  /// **'Fonts are bundled and work offline. Characters absent from a decorative font use a fallback font.'**
  String get special_font_help;

  /// No description provided for @special_weekday_monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get special_weekday_monday;

  /// No description provided for @special_weekday_tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get special_weekday_tuesday;

  /// No description provided for @special_weekday_wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get special_weekday_wednesday;

  /// No description provided for @special_weekday_thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get special_weekday_thursday;

  /// No description provided for @special_weekday_friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get special_weekday_friday;

  /// No description provided for @special_weekday_saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get special_weekday_saturday;

  /// No description provided for @special_weekday_sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get special_weekday_sunday;

  /// No description provided for @video_platform_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Video playback is unavailable here. Open the panel in a supported browser.'**
  String get video_platform_unavailable;

  /// No description provided for @video_load_failed.
  ///
  /// In en, this message translates to:
  /// **'Could not load video.'**
  String get video_load_failed;

  /// No description provided for @video_seek.
  ///
  /// In en, this message translates to:
  /// **'Video position'**
  String get video_seek;

  /// No description provided for @device_telemetry_title.
  ///
  /// In en, this message translates to:
  /// **'Telemetry'**
  String get device_telemetry_title;

  /// No description provided for @device_controls_title.
  ///
  /// In en, this message translates to:
  /// **'Frame control'**
  String get device_controls_title;

  /// No description provided for @device_telemetry_subtitle.
  ///
  /// In en, this message translates to:
  /// **'System readings and presence from the frame'**
  String get device_telemetry_subtitle;

  /// No description provided for @device_controls_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Pause, screen power and menu'**
  String get device_controls_subtitle;

  /// No description provided for @device_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get device_refresh;

  /// No description provided for @device_stale.
  ///
  /// In en, this message translates to:
  /// **'The last received data is out of date.'**
  String get device_stale;

  /// No description provided for @device_load_failed.
  ///
  /// In en, this message translates to:
  /// **'Could not read the frame state. Check the connection and frame software version.'**
  String get device_load_failed;

  /// No description provided for @device_metrics_failed.
  ///
  /// In en, this message translates to:
  /// **'Could not update system readings.'**
  String get device_metrics_failed;

  /// No description provided for @device_command_failed.
  ///
  /// In en, this message translates to:
  /// **'Could not confirm the command. Refresh the state before trying again.'**
  String get device_command_failed;

  /// No description provided for @device_disconnected.
  ///
  /// In en, this message translates to:
  /// **'Connection to the frame was lost.'**
  String get device_disconnected;

  /// No description provided for @device_no_data.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get device_no_data;

  /// No description provided for @device_frontend_unavailable.
  ///
  /// In en, this message translates to:
  /// **'The frame display app is unavailable. Controls and display details cannot be read.'**
  String get device_frontend_unavailable;

  /// No description provided for @device_controls_context.
  ///
  /// In en, this message translates to:
  /// **'Pause and menu are available while the frame is showing a slideshow.'**
  String get device_controls_context;

  /// No description provided for @device_sample_time.
  ///
  /// In en, this message translates to:
  /// **'Frame snapshot (UTC)'**
  String get device_sample_time;

  /// No description provided for @device_metrics_time.
  ///
  /// In en, this message translates to:
  /// **'System readings updated'**
  String get device_metrics_time;

  /// No description provided for @device_network_time.
  ///
  /// In en, this message translates to:
  /// **'Network readings updated'**
  String get device_network_time;

  /// No description provided for @device_presence.
  ///
  /// In en, this message translates to:
  /// **'Human presence'**
  String get device_presence;

  /// No description provided for @device_presence_present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get device_presence_present;

  /// No description provided for @device_presence_absent.
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get device_presence_absent;

  /// No description provided for @device_presence_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get device_presence_unknown;

  /// No description provided for @device_presence_time.
  ///
  /// In en, this message translates to:
  /// **'Presence last observed'**
  String get device_presence_time;

  /// No description provided for @device_playback.
  ///
  /// In en, this message translates to:
  /// **'Slideshow'**
  String get device_playback;

  /// No description provided for @device_paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get device_paused;

  /// No description provided for @device_playing.
  ///
  /// In en, this message translates to:
  /// **'Playing'**
  String get device_playing;

  /// No description provided for @device_screen.
  ///
  /// In en, this message translates to:
  /// **'Screen'**
  String get device_screen;

  /// No description provided for @device_screen_on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get device_screen_on;

  /// No description provided for @device_screen_off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get device_screen_off;

  /// No description provided for @device_screen_phase.
  ///
  /// In en, this message translates to:
  /// **'Screen transition'**
  String get device_screen_phase;

  /// No description provided for @device_screen_waiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting for automatic sleep'**
  String get device_screen_waiting;

  /// No description provided for @device_screen_fading_out.
  ///
  /// In en, this message translates to:
  /// **'Fading out'**
  String get device_screen_fading_out;

  /// No description provided for @device_screen_powering_off.
  ///
  /// In en, this message translates to:
  /// **'Powering off'**
  String get device_screen_powering_off;

  /// No description provided for @device_screen_waking.
  ///
  /// In en, this message translates to:
  /// **'Waking up'**
  String get device_screen_waking;

  /// No description provided for @device_screen_fading_in.
  ///
  /// In en, this message translates to:
  /// **'Fading in'**
  String get device_screen_fading_in;

  /// No description provided for @device_screen_failed.
  ///
  /// In en, this message translates to:
  /// **'Screen operation failed'**
  String get device_screen_failed;

  /// No description provided for @device_screen_power_help.
  ///
  /// In en, this message translates to:
  /// **'Power status reflects the last successful device command, not a physical display measurement.'**
  String get device_screen_power_help;

  /// No description provided for @device_screen_lock.
  ///
  /// In en, this message translates to:
  /// **'Manual screen lock'**
  String get device_screen_lock;

  /// No description provided for @device_turn_on.
  ///
  /// In en, this message translates to:
  /// **'Turn screen on'**
  String get device_turn_on;

  /// No description provided for @device_turn_off.
  ///
  /// In en, this message translates to:
  /// **'Turn screen off'**
  String get device_turn_off;

  /// No description provided for @device_menu.
  ///
  /// In en, this message translates to:
  /// **'Frame menu'**
  String get device_menu;

  /// No description provided for @device_menu_open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get device_menu_open;

  /// No description provided for @device_menu_closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get device_menu_closed;

  /// No description provided for @device_open_menu.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get device_open_menu;

  /// No description provided for @device_close_menu.
  ///
  /// In en, this message translates to:
  /// **'Close menu'**
  String get device_close_menu;

  /// No description provided for @device_current_page.
  ///
  /// In en, this message translates to:
  /// **'Frame screen'**
  String get device_current_page;

  /// No description provided for @device_page_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get device_page_welcome;

  /// No description provided for @device_page_config.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get device_page_config;

  /// No description provided for @device_page_ota.
  ///
  /// In en, this message translates to:
  /// **'Firmware update'**
  String get device_page_ota;

  /// No description provided for @device_cpu.
  ///
  /// In en, this message translates to:
  /// **'CPU'**
  String get device_cpu;

  /// No description provided for @device_cpu_model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get device_cpu_model;

  /// No description provided for @device_cpu_hardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get device_cpu_hardware;

  /// No description provided for @device_cpu_revision.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get device_cpu_revision;

  /// No description provided for @device_cpu_cores.
  ///
  /// In en, this message translates to:
  /// **'Cores'**
  String get device_cpu_cores;

  /// No description provided for @device_cpu_load.
  ///
  /// In en, this message translates to:
  /// **'Load average: 1 / 5 / 15 min'**
  String get device_cpu_load;

  /// No description provided for @device_os.
  ///
  /// In en, this message translates to:
  /// **'Operating system'**
  String get device_os;

  /// No description provided for @device_uptime.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get device_uptime;

  /// No description provided for @device_memory.
  ///
  /// In en, this message translates to:
  /// **'Memory'**
  String get device_memory;

  /// No description provided for @device_ram.
  ///
  /// In en, this message translates to:
  /// **'RAM: used / total'**
  String get device_ram;

  /// No description provided for @device_swap.
  ///
  /// In en, this message translates to:
  /// **'Swap: used / total'**
  String get device_swap;

  /// No description provided for @device_disk.
  ///
  /// In en, this message translates to:
  /// **'Disk'**
  String get device_disk;

  /// No description provided for @device_disk_usage.
  ///
  /// In en, this message translates to:
  /// **'Used / total'**
  String get device_disk_usage;

  /// No description provided for @device_disk_percent.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get device_disk_percent;

  /// No description provided for @device_network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get device_network;

  /// No description provided for @device_internet.
  ///
  /// In en, this message translates to:
  /// **'Internet'**
  String get device_internet;

  /// No description provided for @device_online.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get device_online;

  /// No description provided for @device_offline.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get device_offline;

  /// No description provided for @device_interface_running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get device_interface_running;

  /// No description provided for @device_interface_offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get device_interface_offline;

  /// No description provided for @device_sensors.
  ///
  /// In en, this message translates to:
  /// **'Sensors'**
  String get device_sensors;

  /// No description provided for @device_versions_display.
  ///
  /// In en, this message translates to:
  /// **'Frame software and display'**
  String get device_versions_display;

  /// No description provided for @device_frontend_version.
  ///
  /// In en, this message translates to:
  /// **'Display app version'**
  String get device_frontend_version;

  /// No description provided for @device_backend_version.
  ///
  /// In en, this message translates to:
  /// **'Backend version'**
  String get device_backend_version;

  /// No description provided for @device_physical_size.
  ///
  /// In en, this message translates to:
  /// **'Physical size'**
  String get device_physical_size;

  /// No description provided for @device_logical_size.
  ///
  /// In en, this message translates to:
  /// **'Logical size'**
  String get device_logical_size;

  /// No description provided for @device_pixel_ratio.
  ///
  /// In en, this message translates to:
  /// **'Device pixel ratio'**
  String get device_pixel_ratio;

  /// No description provided for @device_mib.
  ///
  /// In en, this message translates to:
  /// **'{value} MiB'**
  String device_mib(String value);

  /// No description provided for @device_pixels.
  ///
  /// In en, this message translates to:
  /// **'{width} × {height} px'**
  String device_pixels(String width, String height);

  /// No description provided for @device_logical_pixels.
  ///
  /// In en, this message translates to:
  /// **'{width} × {height} logical px'**
  String device_logical_pixels(String width, String height);

  /// No description provided for @rpc_title.
  ///
  /// In en, this message translates to:
  /// **'RPC queues'**
  String get rpc_title;

  /// No description provided for @rpc_description.
  ///
  /// In en, this message translates to:
  /// **'Counters and peaks since service startup. Rates cover up to the last 10 seconds and include telemetry requests.'**
  String get rpc_description;

  /// No description provided for @rpc_node_frontend.
  ///
  /// In en, this message translates to:
  /// **'Slideshow'**
  String get rpc_node_frontend;

  /// No description provided for @rpc_node_backend.
  ///
  /// In en, this message translates to:
  /// **'Backend'**
  String get rpc_node_backend;

  /// No description provided for @rpc_node_web.
  ///
  /// In en, this message translates to:
  /// **'Web server'**
  String get rpc_node_web;

  /// No description provided for @rpc_node_ota.
  ///
  /// In en, this message translates to:
  /// **'Updater'**
  String get rpc_node_ota;

  /// No description provided for @rpc_unavailable.
  ///
  /// In en, this message translates to:
  /// **'No RPC data'**
  String get rpc_unavailable;

  /// No description provided for @rpc_peak_inflight.
  ///
  /// In en, this message translates to:
  /// **'Peak occupied slots'**
  String get rpc_peak_inflight;

  /// No description provided for @rpc_peak_queued.
  ///
  /// In en, this message translates to:
  /// **'Peak waiting for a slot'**
  String get rpc_peak_queued;

  /// No description provided for @rpc_submitted.
  ///
  /// In en, this message translates to:
  /// **'Requests submitted'**
  String get rpc_submitted;

  /// No description provided for @rpc_sent.
  ///
  /// In en, this message translates to:
  /// **'Requests sent'**
  String get rpc_sent;

  /// No description provided for @rpc_responses.
  ///
  /// In en, this message translates to:
  /// **'Responses received'**
  String get rpc_responses;

  /// No description provided for @rpc_errors.
  ///
  /// In en, this message translates to:
  /// **'Wait and RPC result errors'**
  String get rpc_errors;

  /// No description provided for @rpc_slot_wait.
  ///
  /// In en, this message translates to:
  /// **'Slot wait: mean / maximum'**
  String get rpc_slot_wait;

  /// No description provided for @rpc_response_wait.
  ///
  /// In en, this message translates to:
  /// **'Response wait: mean / maximum'**
  String get rpc_response_wait;

  /// No description provided for @rpc_oldest_queued.
  ///
  /// In en, this message translates to:
  /// **'Oldest waiting for a slot'**
  String get rpc_oldest_queued;

  /// No description provided for @rpc_oldest_inflight.
  ///
  /// In en, this message translates to:
  /// **'Oldest waiting for a response'**
  String get rpc_oldest_inflight;

  /// No description provided for @rpc_no_pending.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get rpc_no_pending;

  /// No description provided for @rpc_unknown_command.
  ///
  /// In en, this message translates to:
  /// **'Unknown command'**
  String get rpc_unknown_command;

  /// No description provided for @rpc_handlers_active.
  ///
  /// In en, this message translates to:
  /// **'Handlers running at receiver'**
  String get rpc_handlers_active;

  /// No description provided for @rpc_handlers_completed.
  ///
  /// In en, this message translates to:
  /// **'Handlers completed'**
  String get rpc_handlers_completed;

  /// No description provided for @rpc_handlers_errors.
  ///
  /// In en, this message translates to:
  /// **'Handler errors'**
  String get rpc_handlers_errors;

  /// No description provided for @rpc_handler_duration.
  ///
  /// In en, this message translates to:
  /// **'Handler duration: mean / maximum'**
  String get rpc_handler_duration;

  /// No description provided for @rpc_receiver_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Receiver metrics unavailable'**
  String get rpc_receiver_unavailable;

  /// No description provided for @rpc_ws_timeouts.
  ///
  /// In en, this message translates to:
  /// **'WebSocket request timeouts since panel startup'**
  String get rpc_ws_timeouts;

  /// No description provided for @rpc_occupancy.
  ///
  /// In en, this message translates to:
  /// **'Slots: {used}/{capacity} · Waiting: {queued}'**
  String rpc_occupancy(int used, int capacity, int queued);

  /// No description provided for @rpc_rate_summary.
  ///
  /// In en, this message translates to:
  /// **'Sent: {sent}/s · Responses: {responses}/s'**
  String rpc_rate_summary(String sent, String responses);

  /// No description provided for @rpc_duration_summary.
  ///
  /// In en, this message translates to:
  /// **'{mean} / {maximum}'**
  String rpc_duration_summary(String mean, String maximum);

  /// No description provided for @rpc_pending_value.
  ///
  /// In en, this message translates to:
  /// **'{command} · {age}'**
  String rpc_pending_value(String command, String age);

  /// No description provided for @rpc_milliseconds.
  ///
  /// In en, this message translates to:
  /// **'{value} ms'**
  String rpc_milliseconds(String value);

  /// No description provided for @rpc_receiver_stale.
  ///
  /// In en, this message translates to:
  /// **'Receiver handler metrics are out of date.'**
  String get rpc_receiver_stale;

  /// No description provided for @effects_title.
  ///
  /// In en, this message translates to:
  /// **'Transition effects'**
  String get effects_title;

  /// No description provided for @effects_general.
  ///
  /// In en, this message translates to:
  /// **'General slideshow settings'**
  String get effects_general;

  /// No description provided for @effects_search.
  ///
  /// In en, this message translates to:
  /// **'Search effects'**
  String get effects_search;

  /// No description provided for @effects_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get effects_all;

  /// No description provided for @effects_enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get effects_enabled;

  /// No description provided for @effects_modified.
  ///
  /// In en, this message translates to:
  /// **'Modified'**
  String get effects_modified;

  /// No description provided for @effects_group.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get effects_group;

  /// No description provided for @effects_fades.
  ///
  /// In en, this message translates to:
  /// **'Fades'**
  String get effects_fades;

  /// No description provided for @effects_movement.
  ///
  /// In en, this message translates to:
  /// **'Movement'**
  String get effects_movement;

  /// No description provided for @effects_masks.
  ///
  /// In en, this message translates to:
  /// **'Masks'**
  String get effects_masks;

  /// No description provided for @effects_geometric.
  ///
  /// In en, this message translates to:
  /// **'Geometric'**
  String get effects_geometric;

  /// No description provided for @effects_cinematic.
  ///
  /// In en, this message translates to:
  /// **'Cinematic'**
  String get effects_cinematic;

  /// No description provided for @effects_creative.
  ///
  /// In en, this message translates to:
  /// **'Creative'**
  String get effects_creative;

  /// No description provided for @effects_global_duration.
  ///
  /// In en, this message translates to:
  /// **'Global duration, ms'**
  String get effects_global_duration;

  /// No description provided for @effects_duration.
  ///
  /// In en, this message translates to:
  /// **'Duration, ms'**
  String get effects_duration;

  /// No description provided for @effects_inherit.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get effects_inherit;

  /// No description provided for @effects_custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get effects_custom;

  /// No description provided for @effects_enable_all.
  ///
  /// In en, this message translates to:
  /// **'Enable all effects'**
  String get effects_enable_all;

  /// No description provided for @effects_disable_all.
  ///
  /// In en, this message translates to:
  /// **'Disable all effects'**
  String get effects_disable_all;

  /// No description provided for @effects_inherit_all.
  ///
  /// In en, this message translates to:
  /// **'Use global duration for all effects'**
  String get effects_inherit_all;

  /// No description provided for @effects_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset parameters'**
  String get effects_reset;

  /// No description provided for @effects_empty.
  ///
  /// In en, this message translates to:
  /// **'No compatible effect selected: Fade uses the global duration.'**
  String get effects_empty;

  /// No description provided for @effects_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid effect configuration. Fix the fields or reset the effect set.'**
  String get effects_invalid;

  /// No description provided for @effects_restore.
  ///
  /// In en, this message translates to:
  /// **'Reset effect set'**
  String get effects_restore;

  /// No description provided for @effects_no_results.
  ///
  /// In en, this message translates to:
  /// **'No effects found'**
  String get effects_no_results;

  /// No description provided for @effects_enable.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get effects_enable;

  /// No description provided for @effects_grid.
  ///
  /// In en, this message translates to:
  /// **'Grid size'**
  String get effects_grid;

  /// No description provided for @effects_fade_fraction.
  ///
  /// In en, this message translates to:
  /// **'Cell fade duration'**
  String get effects_fade_fraction;

  /// No description provided for @effects_fade_help.
  ///
  /// In en, this message translates to:
  /// **'Fraction of transition time spent fading each cell. 0% gives a hard cutoff.'**
  String get effects_fade_help;

  /// No description provided for @effects_direction.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get effects_direction;

  /// No description provided for @effects_random.
  ///
  /// In en, this message translates to:
  /// **'Random cells'**
  String get effects_random;

  /// No description provided for @effects_topLeft.
  ///
  /// In en, this message translates to:
  /// **'Top left'**
  String get effects_topLeft;

  /// No description provided for @effects_topRight.
  ///
  /// In en, this message translates to:
  /// **'Top right'**
  String get effects_topRight;

  /// No description provided for @effects_bottomLeft.
  ///
  /// In en, this message translates to:
  /// **'Bottom left'**
  String get effects_bottomLeft;

  /// No description provided for @effects_bottomRight.
  ///
  /// In en, this message translates to:
  /// **'Bottom right'**
  String get effects_bottomRight;

  /// No description provided for @effects_center.
  ///
  /// In en, this message translates to:
  /// **'Center'**
  String get effects_center;

  /// No description provided for @effects_left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get effects_left;

  /// No description provided for @effects_right.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get effects_right;

  /// No description provided for @effects_up.
  ///
  /// In en, this message translates to:
  /// **'Up'**
  String get effects_up;

  /// No description provided for @effects_down.
  ///
  /// In en, this message translates to:
  /// **'Down'**
  String get effects_down;

  /// No description provided for @effects_mode.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get effects_mode;

  /// No description provided for @effects_push.
  ///
  /// In en, this message translates to:
  /// **'Push'**
  String get effects_push;

  /// No description provided for @effects_cover.
  ///
  /// In en, this message translates to:
  /// **'Cover'**
  String get effects_cover;

  /// No description provided for @effects_reveal.
  ///
  /// In en, this message translates to:
  /// **'Reveal'**
  String get effects_reveal;

  /// No description provided for @effects_shape.
  ///
  /// In en, this message translates to:
  /// **'Shape'**
  String get effects_shape;

  /// No description provided for @effects_wipe.
  ///
  /// In en, this message translates to:
  /// **'Wipe'**
  String get effects_wipe;

  /// No description provided for @effects_curtain.
  ///
  /// In en, this message translates to:
  /// **'Curtain'**
  String get effects_curtain;

  /// No description provided for @effects_diagonal.
  ///
  /// In en, this message translates to:
  /// **'Diagonal'**
  String get effects_diagonal;

  /// No description provided for @effects_iris.
  ///
  /// In en, this message translates to:
  /// **'Iris'**
  String get effects_iris;

  /// No description provided for @effects_axis.
  ///
  /// In en, this message translates to:
  /// **'Axis'**
  String get effects_axis;

  /// No description provided for @effects_horizontal.
  ///
  /// In en, this message translates to:
  /// **'Horizontal'**
  String get effects_horizontal;

  /// No description provided for @effects_vertical.
  ///
  /// In en, this message translates to:
  /// **'Vertical'**
  String get effects_vertical;

  /// No description provided for @effects_origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get effects_origin;

  /// No description provided for @color_choose.
  ///
  /// In en, this message translates to:
  /// **'Choose color'**
  String get color_choose;

  /// No description provided for @color_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get color_apply;

  /// No description provided for @effects_color.
  ///
  /// In en, this message translates to:
  /// **'Color, AARRGGBB'**
  String get effects_color;

  /// No description provided for @effects_black.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get effects_black;

  /// No description provided for @effects_white.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get effects_white;

  /// No description provided for @effects_style.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get effects_style;

  /// No description provided for @effects_soft.
  ///
  /// In en, this message translates to:
  /// **'Soft'**
  String get effects_soft;

  /// No description provided for @effects_lightSweep.
  ///
  /// In en, this message translates to:
  /// **'Light sweep'**
  String get effects_lightSweep;

  /// No description provided for @effects_neon.
  ///
  /// In en, this message translates to:
  /// **'Neon'**
  String get effects_neon;

  /// No description provided for @effects_edge.
  ///
  /// In en, this message translates to:
  /// **'Pivot edge'**
  String get effects_edge;

  /// No description provided for @effects_top.
  ///
  /// In en, this message translates to:
  /// **'Top'**
  String get effects_top;

  /// No description provided for @effects_bottom.
  ///
  /// In en, this message translates to:
  /// **'Bottom'**
  String get effects_bottom;

  /// No description provided for @effects_angle.
  ///
  /// In en, this message translates to:
  /// **'Angle, degrees'**
  String get effects_angle;

  /// No description provided for @effects_count.
  ///
  /// In en, this message translates to:
  /// **'Strip / panel count'**
  String get effects_count;

  /// No description provided for @effects_slide.
  ///
  /// In en, this message translates to:
  /// **'Slide'**
  String get effects_slide;

  /// No description provided for @effects_reveal_mask.
  ///
  /// In en, this message translates to:
  /// **'Reveal mask'**
  String get effects_reveal_mask;

  /// No description provided for @effects_fade_color.
  ///
  /// In en, this message translates to:
  /// **'Fade through color'**
  String get effects_fade_color;

  /// No description provided for @effects_flip.
  ///
  /// In en, this message translates to:
  /// **'Flip'**
  String get effects_flip;

  /// No description provided for @effects_rotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get effects_rotate;

  /// No description provided for @effects_milliseconds.
  ///
  /// In en, this message translates to:
  /// **'{value} ms'**
  String effects_milliseconds(int value);

  /// No description provided for @effect_parameter_gridSize.
  ///
  /// In en, this message translates to:
  /// **'Grid size'**
  String get effect_parameter_gridSize;

  /// No description provided for @effect_parameter_fadeFraction.
  ///
  /// In en, this message translates to:
  /// **'Fade fraction'**
  String get effect_parameter_fadeFraction;

  /// No description provided for @effect_parameter_direction.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get effect_parameter_direction;

  /// No description provided for @effect_parameter_randomness.
  ///
  /// In en, this message translates to:
  /// **'Randomness'**
  String get effect_parameter_randomness;

  /// No description provided for @effect_parameter_mode.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get effect_parameter_mode;

  /// No description provided for @effect_parameter_motionCurve.
  ///
  /// In en, this message translates to:
  /// **'Motion curve'**
  String get effect_parameter_motionCurve;

  /// No description provided for @effect_parameter_blurFraction.
  ///
  /// In en, this message translates to:
  /// **'Blur fraction'**
  String get effect_parameter_blurFraction;

  /// No description provided for @effect_parameter_decoration.
  ///
  /// In en, this message translates to:
  /// **'Decoration'**
  String get effect_parameter_decoration;

  /// No description provided for @effect_parameter_edgeWidth.
  ///
  /// In en, this message translates to:
  /// **'Edge width'**
  String get effect_parameter_edgeWidth;

  /// No description provided for @effect_parameter_tiltDegrees.
  ///
  /// In en, this message translates to:
  /// **'Tilt degrees'**
  String get effect_parameter_tiltDegrees;

  /// No description provided for @effect_parameter_shadowStrength.
  ///
  /// In en, this message translates to:
  /// **'Shadow strength'**
  String get effect_parameter_shadowStrength;

  /// No description provided for @effect_parameter_shape.
  ///
  /// In en, this message translates to:
  /// **'Shape'**
  String get effect_parameter_shape;

  /// No description provided for @effect_parameter_axis.
  ///
  /// In en, this message translates to:
  /// **'Axis'**
  String get effect_parameter_axis;

  /// No description provided for @effect_parameter_origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get effect_parameter_origin;

  /// No description provided for @effect_parameter_operation.
  ///
  /// In en, this message translates to:
  /// **'Operation'**
  String get effect_parameter_operation;

  /// No description provided for @effect_parameter_edgeStyle.
  ///
  /// In en, this message translates to:
  /// **'Edge style'**
  String get effect_parameter_edgeStyle;

  /// No description provided for @effect_parameter_featherFraction.
  ///
  /// In en, this message translates to:
  /// **'Feather fraction'**
  String get effect_parameter_featherFraction;

  /// No description provided for @effect_parameter_lightStrength.
  ///
  /// In en, this message translates to:
  /// **'Light strength'**
  String get effect_parameter_lightStrength;

  /// No description provided for @effect_parameter_frameEnabled.
  ///
  /// In en, this message translates to:
  /// **'Frame enabled'**
  String get effect_parameter_frameEnabled;

  /// No description provided for @effect_parameter_borderWidth.
  ///
  /// In en, this message translates to:
  /// **'Border width'**
  String get effect_parameter_borderWidth;

  /// No description provided for @effect_parameter_borderColor.
  ///
  /// In en, this message translates to:
  /// **'Border color'**
  String get effect_parameter_borderColor;

  /// No description provided for @effect_parameter_pointCount.
  ///
  /// In en, this message translates to:
  /// **'Point count'**
  String get effect_parameter_pointCount;

  /// No description provided for @effect_parameter_innerRadiusRatio.
  ///
  /// In en, this message translates to:
  /// **'Inner radius ratio'**
  String get effect_parameter_innerRadiusRatio;

  /// No description provided for @effect_parameter_rotationDegrees.
  ///
  /// In en, this message translates to:
  /// **'Rotation degrees'**
  String get effect_parameter_rotationDegrees;

  /// No description provided for @effect_parameter_startAngleDegrees.
  ///
  /// In en, this message translates to:
  /// **'Start angle degrees'**
  String get effect_parameter_startAngleDegrees;

  /// No description provided for @effect_parameter_circularDirection.
  ///
  /// In en, this message translates to:
  /// **'Circular direction'**
  String get effect_parameter_circularDirection;

  /// No description provided for @effect_parameter_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get effect_parameter_color;

  /// No description provided for @effect_parameter_style.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get effect_parameter_style;

  /// No description provided for @effect_parameter_rotationSense.
  ///
  /// In en, this message translates to:
  /// **'Rotation sense'**
  String get effect_parameter_rotationSense;

  /// No description provided for @effect_parameter_perspectiveStrength.
  ///
  /// In en, this message translates to:
  /// **'Perspective strength'**
  String get effect_parameter_perspectiveStrength;

  /// No description provided for @effect_parameter_edge.
  ///
  /// In en, this message translates to:
  /// **'Edge'**
  String get effect_parameter_edge;

  /// No description provided for @effect_parameter_angleDegrees.
  ///
  /// In en, this message translates to:
  /// **'Angle degrees'**
  String get effect_parameter_angleDegrees;

  /// No description provided for @effect_parameter_stripCount.
  ///
  /// In en, this message translates to:
  /// **'Strip count'**
  String get effect_parameter_stripCount;

  /// No description provided for @effect_parameter_order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get effect_parameter_order;

  /// No description provided for @effect_parameter_staggerFraction.
  ///
  /// In en, this message translates to:
  /// **'Stagger fraction'**
  String get effect_parameter_staggerFraction;

  /// No description provided for @effect_parameter_pattern.
  ///
  /// In en, this message translates to:
  /// **'Pattern'**
  String get effect_parameter_pattern;

  /// No description provided for @effect_parameter_paneCount.
  ///
  /// In en, this message translates to:
  /// **'Pane count'**
  String get effect_parameter_paneCount;

  /// No description provided for @effect_parameter_refractionStrength.
  ///
  /// In en, this message translates to:
  /// **'Refraction strength'**
  String get effect_parameter_refractionStrength;

  /// No description provided for @effect_parameter_glintStrength.
  ///
  /// In en, this message translates to:
  /// **'Glint strength'**
  String get effect_parameter_glintStrength;

  /// No description provided for @effect_parameter_panelCount.
  ///
  /// In en, this message translates to:
  /// **'Panel count'**
  String get effect_parameter_panelCount;

  /// No description provided for @effect_parameter_slatCount.
  ///
  /// In en, this message translates to:
  /// **'Slat count'**
  String get effect_parameter_slatCount;

  /// No description provided for @effect_parameter_shadowIntensity.
  ///
  /// In en, this message translates to:
  /// **'Shadow intensity'**
  String get effect_parameter_shadowIntensity;

  /// No description provided for @effect_parameter_blendCurve.
  ///
  /// In en, this message translates to:
  /// **'Blend curve'**
  String get effect_parameter_blendCurve;

  /// No description provided for @effect_parameter_maxSigma.
  ///
  /// In en, this message translates to:
  /// **'Max sigma'**
  String get effect_parameter_maxSigma;

  /// No description provided for @effect_parameter_blurTarget.
  ///
  /// In en, this message translates to:
  /// **'Blur target'**
  String get effect_parameter_blurTarget;

  /// No description provided for @effect_parameter_holdFraction.
  ///
  /// In en, this message translates to:
  /// **'Hold fraction'**
  String get effect_parameter_holdFraction;

  /// No description provided for @effect_parameter_fadeOutShare.
  ///
  /// In en, this message translates to:
  /// **'Fade out share'**
  String get effect_parameter_fadeOutShare;

  /// No description provided for @effect_parameter_softness.
  ///
  /// In en, this message translates to:
  /// **'Softness'**
  String get effect_parameter_softness;

  /// No description provided for @effect_parameter_noiseScale.
  ///
  /// In en, this message translates to:
  /// **'Noise scale'**
  String get effect_parameter_noiseScale;

  /// No description provided for @effect_parameter_waveAmplitude.
  ///
  /// In en, this message translates to:
  /// **'Wave amplitude'**
  String get effect_parameter_waveAmplitude;

  /// No description provided for @effect_parameter_waveFrequency.
  ///
  /// In en, this message translates to:
  /// **'Wave frequency'**
  String get effect_parameter_waveFrequency;

  /// No description provided for @effect_parameter_bandWidth.
  ///
  /// In en, this message translates to:
  /// **'Band width'**
  String get effect_parameter_bandWidth;

  /// No description provided for @effect_parameter_waveCount.
  ///
  /// In en, this message translates to:
  /// **'Wave count'**
  String get effect_parameter_waveCount;

  /// No description provided for @effect_parameter_waveIntensity.
  ///
  /// In en, this message translates to:
  /// **'Wave intensity'**
  String get effect_parameter_waveIntensity;

  /// No description provided for @effect_parameter_outgoingScale.
  ///
  /// In en, this message translates to:
  /// **'Outgoing scale'**
  String get effect_parameter_outgoingScale;

  /// No description provided for @effect_parameter_scale.
  ///
  /// In en, this message translates to:
  /// **'Scale'**
  String get effect_parameter_scale;

  /// No description provided for @effect_parameter_clipAmount.
  ///
  /// In en, this message translates to:
  /// **'Clip amount'**
  String get effect_parameter_clipAmount;

  /// No description provided for @effect_parameter_zoomOutScale.
  ///
  /// In en, this message translates to:
  /// **'Zoom out scale'**
  String get effect_parameter_zoomOutScale;

  /// No description provided for @effect_parameter_enableOpacity.
  ///
  /// In en, this message translates to:
  /// **'Enable opacity'**
  String get effect_parameter_enableOpacity;

  /// No description provided for @effect_parameter_startScale.
  ///
  /// In en, this message translates to:
  /// **'Start scale'**
  String get effect_parameter_startScale;

  /// No description provided for @effect_parameter_corner.
  ///
  /// In en, this message translates to:
  /// **'Corner'**
  String get effect_parameter_corner;

  /// No description provided for @effect_parameter_foldWidth.
  ///
  /// In en, this message translates to:
  /// **'Fold width'**
  String get effect_parameter_foldWidth;

  /// No description provided for @effect_parameter_paperColor.
  ///
  /// In en, this message translates to:
  /// **'Paper color'**
  String get effect_parameter_paperColor;

  /// No description provided for @effect_parameter_splitPosition.
  ///
  /// In en, this message translates to:
  /// **'Split position'**
  String get effect_parameter_splitPosition;

  /// No description provided for @effect_parameter_maxScale.
  ///
  /// In en, this message translates to:
  /// **'Max scale'**
  String get effect_parameter_maxScale;

  /// No description provided for @effect_parameter_side.
  ///
  /// In en, this message translates to:
  /// **'Side'**
  String get effect_parameter_side;

  /// No description provided for @effect_parameter_strength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get effect_parameter_strength;

  /// No description provided for @effect_parameter_radius.
  ///
  /// In en, this message translates to:
  /// **'Radius'**
  String get effect_parameter_radius;

  /// No description provided for @effect_parameter_warmColor.
  ///
  /// In en, this message translates to:
  /// **'Warm color'**
  String get effect_parameter_warmColor;

  /// No description provided for @effect_parameter_roughness.
  ///
  /// In en, this message translates to:
  /// **'Roughness'**
  String get effect_parameter_roughness;

  /// No description provided for @effect_parameter_emberColor.
  ///
  /// In en, this message translates to:
  /// **'Ember color'**
  String get effect_parameter_emberColor;

  /// No description provided for @effect_parameter_gain.
  ///
  /// In en, this message translates to:
  /// **'Gain'**
  String get effect_parameter_gain;

  /// No description provided for @effect_parameter_sectorCount.
  ///
  /// In en, this message translates to:
  /// **'Sector count'**
  String get effect_parameter_sectorCount;

  /// No description provided for @effect_parameter_lineAxis.
  ///
  /// In en, this message translates to:
  /// **'Line axis'**
  String get effect_parameter_lineAxis;

  /// No description provided for @effect_parameter_glowStrength.
  ///
  /// In en, this message translates to:
  /// **'Glow strength'**
  String get effect_parameter_glowStrength;

  /// No description provided for @effect_parameter_glowColor.
  ///
  /// In en, this message translates to:
  /// **'Glow color'**
  String get effect_parameter_glowColor;

  /// No description provided for @effect_parameter_springStrength.
  ///
  /// In en, this message translates to:
  /// **'Spring strength'**
  String get effect_parameter_springStrength;

  /// No description provided for @effect_parameter_cellsAcross.
  ///
  /// In en, this message translates to:
  /// **'Cells across'**
  String get effect_parameter_cellsAcross;

  /// No description provided for @effect_parameter_colorShiftFraction.
  ///
  /// In en, this message translates to:
  /// **'Color shift fraction'**
  String get effect_parameter_colorShiftFraction;

  /// No description provided for @effect_parameter_trackingStrength.
  ///
  /// In en, this message translates to:
  /// **'Tracking strength'**
  String get effect_parameter_trackingStrength;

  /// No description provided for @effect_parameter_noiseStrength.
  ///
  /// In en, this message translates to:
  /// **'Noise strength'**
  String get effect_parameter_noiseStrength;

  /// No description provided for @effect_parameter_trailCount.
  ///
  /// In en, this message translates to:
  /// **'Trail count'**
  String get effect_parameter_trailCount;

  /// No description provided for @effect_parameter_driftFraction.
  ///
  /// In en, this message translates to:
  /// **'Drift fraction'**
  String get effect_parameter_driftFraction;

  /// No description provided for @effect_parameter_trailStrength.
  ///
  /// In en, this message translates to:
  /// **'Trail strength'**
  String get effect_parameter_trailStrength;

  /// No description provided for @effect_parameter_trailColor.
  ///
  /// In en, this message translates to:
  /// **'Trail color'**
  String get effect_parameter_trailColor;

  /// No description provided for @effect_choice_FadeStyle_plain.
  ///
  /// In en, this message translates to:
  /// **'Plain'**
  String get effect_choice_FadeStyle_plain;

  /// No description provided for @effect_choice_FadeStyle_linearLight.
  ///
  /// In en, this message translates to:
  /// **'Linear light'**
  String get effect_choice_FadeStyle_linearLight;

  /// No description provided for @effect_choice_FadeStyle_blur.
  ///
  /// In en, this message translates to:
  /// **'Blur'**
  String get effect_choice_FadeStyle_blur;

  /// No description provided for @effect_choice_FadeStyle_throughColor.
  ///
  /// In en, this message translates to:
  /// **'Through color'**
  String get effect_choice_FadeStyle_throughColor;

  /// No description provided for @effect_choice_BlendCurve_linear.
  ///
  /// In en, this message translates to:
  /// **'Linear'**
  String get effect_choice_BlendCurve_linear;

  /// No description provided for @effect_choice_BlendCurve_easeIn.
  ///
  /// In en, this message translates to:
  /// **'Ease in'**
  String get effect_choice_BlendCurve_easeIn;

  /// No description provided for @effect_choice_BlendCurve_easeOut.
  ///
  /// In en, this message translates to:
  /// **'Ease out'**
  String get effect_choice_BlendCurve_easeOut;

  /// No description provided for @effect_choice_BlendCurve_easeInOut.
  ///
  /// In en, this message translates to:
  /// **'Ease in out'**
  String get effect_choice_BlendCurve_easeInOut;

  /// No description provided for @effect_choice_BlurTarget_outgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get effect_choice_BlurTarget_outgoing;

  /// No description provided for @effect_choice_BlurTarget_incoming.
  ///
  /// In en, this message translates to:
  /// **'Incoming'**
  String get effect_choice_BlurTarget_incoming;

  /// No description provided for @effect_choice_BlurTarget_both.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get effect_choice_BlurTarget_both;

  /// No description provided for @effect_choice_DepthMode_recedeStill.
  ///
  /// In en, this message translates to:
  /// **'Recede still'**
  String get effect_choice_DepthMode_recedeStill;

  /// No description provided for @effect_choice_DepthMode_recedeSlide.
  ///
  /// In en, this message translates to:
  /// **'Recede slide'**
  String get effect_choice_DepthMode_recedeSlide;

  /// No description provided for @effect_choice_DepthMode_approach.
  ///
  /// In en, this message translates to:
  /// **'Approach'**
  String get effect_choice_DepthMode_approach;

  /// No description provided for @effect_choice_ZoomMode_over.
  ///
  /// In en, this message translates to:
  /// **'Over'**
  String get effect_choice_ZoomMode_over;

  /// No description provided for @effect_choice_ZoomMode_cross.
  ///
  /// In en, this message translates to:
  /// **'Cross'**
  String get effect_choice_ZoomMode_cross;

  /// No description provided for @effect_choice_WipeEdgeStyle_hard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get effect_choice_WipeEdgeStyle_hard;

  /// No description provided for @effect_choice_WipeEdgeStyle_soft.
  ///
  /// In en, this message translates to:
  /// **'Soft'**
  String get effect_choice_WipeEdgeStyle_soft;

  /// No description provided for @effect_choice_WipeEdgeStyle_lightSweep.
  ///
  /// In en, this message translates to:
  /// **'Light sweep'**
  String get effect_choice_WipeEdgeStyle_lightSweep;

  /// No description provided for @effect_choice_WipeEdgeStyle_neon.
  ///
  /// In en, this message translates to:
  /// **'Neon'**
  String get effect_choice_WipeEdgeStyle_neon;

  /// No description provided for @effect_choice_RevealOperation_revealIncoming.
  ///
  /// In en, this message translates to:
  /// **'Reveal incoming'**
  String get effect_choice_RevealOperation_revealIncoming;

  /// No description provided for @effect_choice_RevealOperation_hideOutgoing.
  ///
  /// In en, this message translates to:
  /// **'Hide outgoing'**
  String get effect_choice_RevealOperation_hideOutgoing;

  /// No description provided for @effect_choice_SliceMode_slide.
  ///
  /// In en, this message translates to:
  /// **'Slide'**
  String get effect_choice_SliceMode_slide;

  /// No description provided for @effect_choice_SliceMode_reveal.
  ///
  /// In en, this message translates to:
  /// **'Reveal'**
  String get effect_choice_SliceMode_reveal;

  /// No description provided for @effect_choice_StripPattern_alternating.
  ///
  /// In en, this message translates to:
  /// **'Alternating'**
  String get effect_choice_StripPattern_alternating;

  /// No description provided for @effect_choice_StripPattern_sameDirection.
  ///
  /// In en, this message translates to:
  /// **'Same direction'**
  String get effect_choice_StripPattern_sameDirection;

  /// No description provided for @effect_choice_SequenceOrder_forward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get effect_choice_SequenceOrder_forward;

  /// No description provided for @effect_choice_SequenceOrder_backward.
  ///
  /// In en, this message translates to:
  /// **'Backward'**
  String get effect_choice_SequenceOrder_backward;

  /// No description provided for @effect_choice_RotationSense_forward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get effect_choice_RotationSense_forward;

  /// No description provided for @effect_choice_RotationSense_backward.
  ///
  /// In en, this message translates to:
  /// **'Backward'**
  String get effect_choice_RotationSense_backward;

  /// No description provided for @effect_choice_CircularDirection_clockwise.
  ///
  /// In en, this message translates to:
  /// **'Clockwise'**
  String get effect_choice_CircularDirection_clockwise;

  /// No description provided for @effect_choice_CircularDirection_counterclockwise.
  ///
  /// In en, this message translates to:
  /// **'Counterclockwise'**
  String get effect_choice_CircularDirection_counterclockwise;

  /// No description provided for @effect_choice_LumaOrder_brightFirst.
  ///
  /// In en, this message translates to:
  /// **'Bright first'**
  String get effect_choice_LumaOrder_brightFirst;

  /// No description provided for @effect_choice_LumaOrder_darkFirst.
  ///
  /// In en, this message translates to:
  /// **'Dark first'**
  String get effect_choice_LumaOrder_darkFirst;

  /// No description provided for @effect_choice_CellShape_hexagon.
  ///
  /// In en, this message translates to:
  /// **'Hexagon'**
  String get effect_choice_CellShape_hexagon;

  /// No description provided for @effect_choice_CellShape_circle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get effect_choice_CellShape_circle;

  /// No description provided for @effect_choice_CellShape_diamond.
  ///
  /// In en, this message translates to:
  /// **'Diamond'**
  String get effect_choice_CellShape_diamond;

  /// No description provided for @effect_choice_CellShape_square.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get effect_choice_CellShape_square;

  /// No description provided for @effect_choice_MirrorSide_leading.
  ///
  /// In en, this message translates to:
  /// **'Leading'**
  String get effect_choice_MirrorSide_leading;

  /// No description provided for @effect_choice_MirrorSide_trailing.
  ///
  /// In en, this message translates to:
  /// **'Trailing'**
  String get effect_choice_MirrorSide_trailing;

  /// No description provided for @effect_choice_SlideDecoration_none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get effect_choice_SlideDecoration_none;

  /// No description provided for @effect_choice_SlideDecoration_filmPerforation.
  ///
  /// In en, this message translates to:
  /// **'Film perforation'**
  String get effect_choice_SlideDecoration_filmPerforation;

  /// No description provided for @effect_choice_RevealShape_rectangle.
  ///
  /// In en, this message translates to:
  /// **'Rectangle'**
  String get effect_choice_RevealShape_rectangle;

  /// No description provided for @effect_choice_RevealShape_star.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get effect_choice_RevealShape_star;

  /// No description provided for @effect_choice_RevealShape_clock.
  ///
  /// In en, this message translates to:
  /// **'Clock'**
  String get effect_choice_RevealShape_clock;

  /// No description provided for @effects_preset.
  ///
  /// In en, this message translates to:
  /// **'Preset'**
  String get effects_preset;

  /// No description provided for @effects_custom_preset.
  ///
  /// In en, this message translates to:
  /// **'Custom settings'**
  String get effects_custom_preset;

  /// No description provided for @effects_automatic.
  ///
  /// In en, this message translates to:
  /// **'From style'**
  String get effects_automatic;

  /// No description provided for @effect_preset_burnAlpha.
  ///
  /// In en, this message translates to:
  /// **'Burn Alpha'**
  String get effect_preset_burnAlpha;

  /// No description provided for @effect_preset_foldMotion.
  ///
  /// In en, this message translates to:
  /// **'Fold Motion'**
  String get effect_preset_foldMotion;

  /// No description provided for @effect_preset_glow.
  ///
  /// In en, this message translates to:
  /// **'Glow'**
  String get effect_preset_glow;

  /// No description provided for @effect_preset_kaleidoscope.
  ///
  /// In en, this message translates to:
  /// **'Kaleidoscope'**
  String get effect_preset_kaleidoscope;

  /// No description provided for @effect_preset_tvPower.
  ///
  /// In en, this message translates to:
  /// **'TV Power'**
  String get effect_preset_tvPower;

  /// No description provided for @effect_preset_springMotion.
  ///
  /// In en, this message translates to:
  /// **'Spring Motion'**
  String get effect_preset_springMotion;

  /// No description provided for @effect_preset_shapeDissolve.
  ///
  /// In en, this message translates to:
  /// **'Shape Dissolve'**
  String get effect_preset_shapeDissolve;

  /// No description provided for @effect_preset_vhsDamage.
  ///
  /// In en, this message translates to:
  /// **'VHS Damage'**
  String get effect_preset_vhsDamage;

  /// No description provided for @effect_preset_radialBlur.
  ///
  /// In en, this message translates to:
  /// **'Radial Blur'**
  String get effect_preset_radialBlur;

  /// No description provided for @effect_preset_phosphor.
  ///
  /// In en, this message translates to:
  /// **'Phosphor'**
  String get effect_preset_phosphor;

  /// No description provided for @effect_preset_filmDissolve.
  ///
  /// In en, this message translates to:
  /// **'Film Dissolve'**
  String get effect_preset_filmDissolve;

  /// No description provided for @effect_preset_frame.
  ///
  /// In en, this message translates to:
  /// **'Frame'**
  String get effect_preset_frame;

  /// No description provided for @effect_preset_louver.
  ///
  /// In en, this message translates to:
  /// **'Louver'**
  String get effect_preset_louver;

  /// No description provided for @effect_preset_mirror.
  ///
  /// In en, this message translates to:
  /// **'Mirror'**
  String get effect_preset_mirror;

  /// No description provided for @effect_preset_clockWipe.
  ///
  /// In en, this message translates to:
  /// **'Clock Wipe'**
  String get effect_preset_clockWipe;

  /// No description provided for @effect_preset_split.
  ///
  /// In en, this message translates to:
  /// **'Split'**
  String get effect_preset_split;

  /// No description provided for @effect_preset_panelWipe.
  ///
  /// In en, this message translates to:
  /// **'Panel Wipe'**
  String get effect_preset_panelWipe;

  /// No description provided for @effect_preset_stretch.
  ///
  /// In en, this message translates to:
  /// **'Stretch'**
  String get effect_preset_stretch;

  /// No description provided for @effect_preset_starWipe.
  ///
  /// In en, this message translates to:
  /// **'Star Wipe'**
  String get effect_preset_starWipe;

  /// No description provided for @effect_preset_lightLeak.
  ///
  /// In en, this message translates to:
  /// **'Light Leak'**
  String get effect_preset_lightLeak;

  /// No description provided for @effect_preset_filmRoll.
  ///
  /// In en, this message translates to:
  /// **'Film Roll'**
  String get effect_preset_filmRoll;

  /// No description provided for @effect_preset_crossZoom.
  ///
  /// In en, this message translates to:
  /// **'Cross Zoom'**
  String get effect_preset_crossZoom;

  /// No description provided for @effect_preset_whip.
  ///
  /// In en, this message translates to:
  /// **'Whip'**
  String get effect_preset_whip;

  /// No description provided for @effect_preset_glass.
  ///
  /// In en, this message translates to:
  /// **'Glass'**
  String get effect_preset_glass;

  /// No description provided for @effect_preset_softWipe.
  ///
  /// In en, this message translates to:
  /// **'Soft Wipe'**
  String get effect_preset_softWipe;

  /// No description provided for @effect_preset_slice.
  ///
  /// In en, this message translates to:
  /// **'Slice'**
  String get effect_preset_slice;

  /// No description provided for @effect_preset_lumaFade.
  ///
  /// In en, this message translates to:
  /// **'Luma Fade'**
  String get effect_preset_lumaFade;

  /// No description provided for @effect_preset_pagePeel.
  ///
  /// In en, this message translates to:
  /// **'Page Peel'**
  String get effect_preset_pagePeel;

  /// No description provided for @effect_preset_noiseDissolve.
  ///
  /// In en, this message translates to:
  /// **'Noise Dissolve'**
  String get effect_preset_noiseDissolve;

  /// No description provided for @effect_preset_rippleReveal.
  ///
  /// In en, this message translates to:
  /// **'Ripple Reveal'**
  String get effect_preset_rippleReveal;

  /// No description provided for @effect_preset_waterRefraction.
  ///
  /// In en, this message translates to:
  /// **'Water Refraction'**
  String get effect_preset_waterRefraction;

  /// No description provided for @effect_preset_cube.
  ///
  /// In en, this message translates to:
  /// **'Cube'**
  String get effect_preset_cube;

  /// No description provided for @effect_preset_accordion.
  ///
  /// In en, this message translates to:
  /// **'Accordion'**
  String get effect_preset_accordion;

  /// No description provided for @effect_preset_backgroundToForeground.
  ///
  /// In en, this message translates to:
  /// **'Background to foreground'**
  String get effect_preset_backgroundToForeground;

  /// No description provided for @effect_preset_foregroundToBackground.
  ///
  /// In en, this message translates to:
  /// **'Foreground to background'**
  String get effect_preset_foregroundToBackground;

  /// No description provided for @effect_preset_depth.
  ///
  /// In en, this message translates to:
  /// **'Depth'**
  String get effect_preset_depth;

  /// No description provided for @effect_preset_parallax.
  ///
  /// In en, this message translates to:
  /// **'Parallax'**
  String get effect_preset_parallax;

  /// No description provided for @effect_preset_stack.
  ///
  /// In en, this message translates to:
  /// **'Stack'**
  String get effect_preset_stack;

  /// No description provided for @effect_preset_tablet.
  ///
  /// In en, this message translates to:
  /// **'Tablet'**
  String get effect_preset_tablet;

  /// No description provided for @effect_preset_zoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get effect_preset_zoomOut;

  /// No description provided for @effect_preset_fade.
  ///
  /// In en, this message translates to:
  /// **'Fade'**
  String get effect_preset_fade;

  /// No description provided for @effect_preset_mosaic.
  ///
  /// In en, this message translates to:
  /// **'Mosaic'**
  String get effect_preset_mosaic;

  /// No description provided for @effect_preset_liquidMorph.
  ///
  /// In en, this message translates to:
  /// **'Liquid morph'**
  String get effect_preset_liquidMorph;

  /// No description provided for @effect_preset_blinds.
  ///
  /// In en, this message translates to:
  /// **'Blinds'**
  String get effect_preset_blinds;

  /// No description provided for @effect_preset_blurFade.
  ///
  /// In en, this message translates to:
  /// **'Blur fade'**
  String get effect_preset_blurFade;

  /// No description provided for @effect_preset_zoomOver.
  ///
  /// In en, this message translates to:
  /// **'Zoom over'**
  String get effect_preset_zoomOver;

  /// No description provided for @effect_preset_slide.
  ///
  /// In en, this message translates to:
  /// **'Slide'**
  String get effect_preset_slide;

  /// No description provided for @effect_preset_revealMask.
  ///
  /// In en, this message translates to:
  /// **'Reveal mask'**
  String get effect_preset_revealMask;

  /// No description provided for @effect_preset_fadeThroughColor.
  ///
  /// In en, this message translates to:
  /// **'Fade through color'**
  String get effect_preset_fadeThroughColor;

  /// No description provided for @effect_preset_flip.
  ///
  /// In en, this message translates to:
  /// **'Flip'**
  String get effect_preset_flip;

  /// No description provided for @effect_preset_rotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get effect_preset_rotate;

  /// No description provided for @effect_preset_softWipeLightSweep.
  ///
  /// In en, this message translates to:
  /// **'Soft wipe light sweep'**
  String get effect_preset_softWipeLightSweep;

  /// No description provided for @effect_preset_softWipeNeon.
  ///
  /// In en, this message translates to:
  /// **'Soft wipe neon'**
  String get effect_preset_softWipeNeon;

  /// No description provided for @effect_preset_fadeThroughWhite.
  ///
  /// In en, this message translates to:
  /// **'Fade through white'**
  String get effect_preset_fadeThroughWhite;

  /// No description provided for @effect_preset_flipVertical.
  ///
  /// In en, this message translates to:
  /// **'Flip vertical'**
  String get effect_preset_flipVertical;

  /// No description provided for @effect_preset_rotateBottom.
  ///
  /// In en, this message translates to:
  /// **'Rotate bottom'**
  String get effect_preset_rotateBottom;

  /// No description provided for @effect_preset_mosaicBinary.
  ///
  /// In en, this message translates to:
  /// **'Mosaic binary'**
  String get effect_preset_mosaicBinary;

  /// No description provided for @effect_preset_mosaicTopLeft.
  ///
  /// In en, this message translates to:
  /// **'Mosaic top left'**
  String get effect_preset_mosaicTopLeft;

  /// No description provided for @effect_preset_mosaicTopRight.
  ///
  /// In en, this message translates to:
  /// **'Mosaic top right'**
  String get effect_preset_mosaicTopRight;

  /// No description provided for @effect_preset_mosaicBottomLeft.
  ///
  /// In en, this message translates to:
  /// **'Mosaic bottom left'**
  String get effect_preset_mosaicBottomLeft;

  /// No description provided for @effect_preset_mosaicBottomRight.
  ///
  /// In en, this message translates to:
  /// **'Mosaic bottom right'**
  String get effect_preset_mosaicBottomRight;

  /// No description provided for @effect_preset_slidePushRight.
  ///
  /// In en, this message translates to:
  /// **'Slide push right'**
  String get effect_preset_slidePushRight;

  /// No description provided for @effect_preset_slidePushUp.
  ///
  /// In en, this message translates to:
  /// **'Slide push up'**
  String get effect_preset_slidePushUp;

  /// No description provided for @effect_preset_slidePushDown.
  ///
  /// In en, this message translates to:
  /// **'Slide push down'**
  String get effect_preset_slidePushDown;

  /// No description provided for @effect_preset_slideCoverLeft.
  ///
  /// In en, this message translates to:
  /// **'Slide cover left'**
  String get effect_preset_slideCoverLeft;

  /// No description provided for @effect_preset_slideCoverRight.
  ///
  /// In en, this message translates to:
  /// **'Slide cover right'**
  String get effect_preset_slideCoverRight;

  /// No description provided for @effect_preset_slideCoverUp.
  ///
  /// In en, this message translates to:
  /// **'Slide cover up'**
  String get effect_preset_slideCoverUp;

  /// No description provided for @effect_preset_slideCoverDown.
  ///
  /// In en, this message translates to:
  /// **'Slide cover down'**
  String get effect_preset_slideCoverDown;

  /// No description provided for @effect_preset_slideRevealLeft.
  ///
  /// In en, this message translates to:
  /// **'Slide reveal left'**
  String get effect_preset_slideRevealLeft;

  /// No description provided for @effect_preset_slideRevealRight.
  ///
  /// In en, this message translates to:
  /// **'Slide reveal right'**
  String get effect_preset_slideRevealRight;

  /// No description provided for @effect_preset_slideRevealUp.
  ///
  /// In en, this message translates to:
  /// **'Slide reveal up'**
  String get effect_preset_slideRevealUp;

  /// No description provided for @effect_preset_slideRevealDown.
  ///
  /// In en, this message translates to:
  /// **'Slide reveal down'**
  String get effect_preset_slideRevealDown;

  /// No description provided for @effect_preset_wipeRight.
  ///
  /// In en, this message translates to:
  /// **'Wipe right'**
  String get effect_preset_wipeRight;

  /// No description provided for @effect_preset_wipeUp.
  ///
  /// In en, this message translates to:
  /// **'Wipe up'**
  String get effect_preset_wipeUp;

  /// No description provided for @effect_preset_wipeDown.
  ///
  /// In en, this message translates to:
  /// **'Wipe down'**
  String get effect_preset_wipeDown;

  /// No description provided for @effect_preset_curtainHorizontal.
  ///
  /// In en, this message translates to:
  /// **'Curtain horizontal'**
  String get effect_preset_curtainHorizontal;

  /// No description provided for @effect_preset_curtainVertical.
  ///
  /// In en, this message translates to:
  /// **'Curtain vertical'**
  String get effect_preset_curtainVertical;

  /// No description provided for @effect_preset_diagonalTopRight.
  ///
  /// In en, this message translates to:
  /// **'Diagonal top right'**
  String get effect_preset_diagonalTopRight;

  /// No description provided for @effect_preset_diagonalBottomLeft.
  ///
  /// In en, this message translates to:
  /// **'Diagonal bottom left'**
  String get effect_preset_diagonalBottomLeft;

  /// No description provided for @effect_preset_diagonalBottomRight.
  ///
  /// In en, this message translates to:
  /// **'Diagonal bottom right'**
  String get effect_preset_diagonalBottomRight;

  /// No description provided for @effect_preset_diagonalTopLeft.
  ///
  /// In en, this message translates to:
  /// **'Diagonal top left'**
  String get effect_preset_diagonalTopLeft;

  /// No description provided for @effect_preset_irisCenter.
  ///
  /// In en, this message translates to:
  /// **'Iris center'**
  String get effect_preset_irisCenter;

  /// No description provided for @effects_wave_origin.
  ///
  /// In en, this message translates to:
  /// **'Wave origin'**
  String get effects_wave_origin;

  /// No description provided for @effects_advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get effects_advanced;

  /// No description provided for @otaTitle.
  ///
  /// In en, this message translates to:
  /// **'Update firmware'**
  String get otaTitle;

  /// No description provided for @otaCurrentVersion.
  ///
  /// In en, this message translates to:
  /// **'Current version'**
  String get otaCurrentVersion;

  /// No description provided for @otaAccessCode.
  ///
  /// In en, this message translates to:
  /// **'Access code'**
  String get otaAccessCode;

  /// No description provided for @otaSameNetwork.
  ///
  /// In en, this message translates to:
  /// **'Connect your phone or computer to the same network as the frame.'**
  String get otaSameNetwork;

  /// No description provided for @otaScanInstruction.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code to open the update page.'**
  String get otaScanInstruction;

  /// No description provided for @otaManualConnection.
  ///
  /// In en, this message translates to:
  /// **'Or open this address'**
  String get otaManualConnection;

  /// No description provided for @otaAddressUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No network address is available. Connect the frame to a network to open the update page.'**
  String get otaAddressUnavailable;

  /// No description provided for @otaPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing the update page…'**
  String get otaPreparing;

  /// No description provided for @otaUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading firmware'**
  String get otaUploading;

  /// No description provided for @otaInstalling.
  ///
  /// In en, this message translates to:
  /// **'Installing firmware'**
  String get otaInstalling;

  /// No description provided for @otaDoNotPowerOff.
  ///
  /// In en, this message translates to:
  /// **'Keep the frame connected to power.'**
  String get otaDoNotPowerOff;

  /// No description provided for @otaInstallationHint.
  ///
  /// In en, this message translates to:
  /// **'Installation may take a few minutes. Follow the system log below.'**
  String get otaInstallationHint;

  /// No description provided for @otaFailed.
  ///
  /// In en, this message translates to:
  /// **'Update failed'**
  String get otaFailed;

  /// No description provided for @otaUnknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get otaUnknownError;

  /// No description provided for @otaLogDetails.
  ///
  /// In en, this message translates to:
  /// **'See the system log for details.'**
  String get otaLogDetails;

  /// No description provided for @otaComplete.
  ///
  /// In en, this message translates to:
  /// **'Firmware updated'**
  String get otaComplete;

  /// No description provided for @otaWaitingRestart.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the application to restart…'**
  String get otaWaitingRestart;

  /// No description provided for @otaRestarting.
  ///
  /// In en, this message translates to:
  /// **'Restarting the application…'**
  String get otaRestarting;

  /// No description provided for @otaLeaving.
  ///
  /// In en, this message translates to:
  /// **'Closing the update screen…'**
  String get otaLeaving;

  /// No description provided for @otaSystemLog.
  ///
  /// In en, this message translates to:
  /// **'System log'**
  String get otaSystemLog;

  /// No description provided for @otaFollowingOutput.
  ///
  /// In en, this message translates to:
  /// **'Following new output'**
  String get otaFollowingOutput;

  /// No description provided for @otaHistoryPaused.
  ///
  /// In en, this message translates to:
  /// **'Viewing history · auto-scroll paused'**
  String get otaHistoryPaused;

  /// No description provided for @otaLatestLine.
  ///
  /// In en, this message translates to:
  /// **'Go to latest line'**
  String get otaLatestLine;

  /// No description provided for @otaDevConfig.
  ///
  /// In en, this message translates to:
  /// **'Developer settings'**
  String get otaDevConfig;

  /// No description provided for @otaStageUpload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get otaStageUpload;

  /// No description provided for @otaStageInstall.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get otaStageInstall;

  /// No description provided for @otaStageComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get otaStageComplete;

  /// No description provided for @frame_language_section.
  ///
  /// In en, this message translates to:
  /// **'Frame interface'**
  String get frame_language_section;

  /// No description provided for @frame_language_label.
  ///
  /// In en, this message translates to:
  /// **'Frame language'**
  String get frame_language_label;

  /// No description provided for @frame_language_hint.
  ///
  /// In en, this message translates to:
  /// **'Save and restart the frame application to apply this language. The panel language is selected separately in Appearance.'**
  String get frame_language_hint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
