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

  /// No description provided for @water_photo_only.
  ///
  /// In en, this message translates to:
  /// **'Water Refraction requires two static photos. GIF and video use another allowed transition.'**
  String get water_photo_only;

  /// No description provided for @preview_video_url.
  ///
  /// In en, this message translates to:
  /// **'Video URL (optional)'**
  String get preview_video_url;

  /// No description provided for @preview_play.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview_play;

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
  /// **'Could not load media. Check the address and network access.'**
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
  /// **'Sample media loads from the network. Preview does not confirm device codec support.'**
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

  /// No description provided for @effect_default.
  ///
  /// In en, this message translates to:
  /// **'Slide'**
  String get effect_default;

  /// No description provided for @effect_depth.
  ///
  /// In en, this message translates to:
  /// **'Depth'**
  String get effect_depth;

  /// No description provided for @effect_flip_horizontal.
  ///
  /// In en, this message translates to:
  /// **'Horizontal flip'**
  String get effect_flip_horizontal;

  /// No description provided for @effect_flip_vertical.
  ///
  /// In en, this message translates to:
  /// **'Vertical flip'**
  String get effect_flip_vertical;

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

  /// No description provided for @effect_rotate_down.
  ///
  /// In en, this message translates to:
  /// **'Rotate down'**
  String get effect_rotate_down;

  /// No description provided for @effect_rotate_up.
  ///
  /// In en, this message translates to:
  /// **'Rotate up'**
  String get effect_rotate_up;

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

  /// No description provided for @effect_mosaic_fade.
  ///
  /// In en, this message translates to:
  /// **'Mosaic fade'**
  String get effect_mosaic_fade;

  /// No description provided for @effect_mosaic_tl_fade.
  ///
  /// In en, this message translates to:
  /// **'Mosaic from top left'**
  String get effect_mosaic_tl_fade;

  /// No description provided for @effect_mosaic_br_fade.
  ///
  /// In en, this message translates to:
  /// **'Mosaic from bottom right'**
  String get effect_mosaic_br_fade;

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
  /// **'Zoom over'**
  String get effect_zoom_over;

  /// No description provided for @effect_mosaic_tr_fade.
  ///
  /// In en, this message translates to:
  /// **'Mosaic from top right'**
  String get effect_mosaic_tr_fade;

  /// No description provided for @effect_mosaic_bl_fade.
  ///
  /// In en, this message translates to:
  /// **'Mosaic from bottom left'**
  String get effect_mosaic_bl_fade;

  /// No description provided for @effect_wipe_left.
  ///
  /// In en, this message translates to:
  /// **'Wipe left'**
  String get effect_wipe_left;

  /// No description provided for @effect_wipe_right.
  ///
  /// In en, this message translates to:
  /// **'Wipe right'**
  String get effect_wipe_right;

  /// No description provided for @effect_wipe_up.
  ///
  /// In en, this message translates to:
  /// **'Wipe up'**
  String get effect_wipe_up;

  /// No description provided for @effect_wipe_down.
  ///
  /// In en, this message translates to:
  /// **'Wipe down'**
  String get effect_wipe_down;

  /// No description provided for @effect_curtain_horizontal.
  ///
  /// In en, this message translates to:
  /// **'Horizontal curtain'**
  String get effect_curtain_horizontal;

  /// No description provided for @effect_curtain_vertical.
  ///
  /// In en, this message translates to:
  /// **'Vertical curtain'**
  String get effect_curtain_vertical;

  /// No description provided for @effect_diagonal_top_left.
  ///
  /// In en, this message translates to:
  /// **'Diagonal from top left'**
  String get effect_diagonal_top_left;

  /// No description provided for @effect_diagonal_top_right.
  ///
  /// In en, this message translates to:
  /// **'Diagonal from top right'**
  String get effect_diagonal_top_right;

  /// No description provided for @effect_diagonal_bottom_left.
  ///
  /// In en, this message translates to:
  /// **'Diagonal from bottom left'**
  String get effect_diagonal_bottom_left;

  /// No description provided for @effect_diagonal_bottom_right.
  ///
  /// In en, this message translates to:
  /// **'Diagonal from bottom right'**
  String get effect_diagonal_bottom_right;

  /// No description provided for @effect_iris.
  ///
  /// In en, this message translates to:
  /// **'Iris'**
  String get effect_iris;

  /// No description provided for @effect_fade_through_black.
  ///
  /// In en, this message translates to:
  /// **'Fade through black'**
  String get effect_fade_through_black;

  /// No description provided for @effect_fade_through_white.
  ///
  /// In en, this message translates to:
  /// **'Fade through white'**
  String get effect_fade_through_white;

  /// No description provided for @effect_push_right.
  ///
  /// In en, this message translates to:
  /// **'Push right'**
  String get effect_push_right;

  /// No description provided for @effect_push_up.
  ///
  /// In en, this message translates to:
  /// **'Push up'**
  String get effect_push_up;

  /// No description provided for @effect_push_down.
  ///
  /// In en, this message translates to:
  /// **'Push down'**
  String get effect_push_down;

  /// No description provided for @effect_cover_right.
  ///
  /// In en, this message translates to:
  /// **'Cover right'**
  String get effect_cover_right;

  /// No description provided for @effect_cover_up.
  ///
  /// In en, this message translates to:
  /// **'Cover up'**
  String get effect_cover_up;

  /// No description provided for @effect_cover_down.
  ///
  /// In en, this message translates to:
  /// **'Cover down'**
  String get effect_cover_down;

  /// No description provided for @effect_reveal_left.
  ///
  /// In en, this message translates to:
  /// **'Reveal left'**
  String get effect_reveal_left;

  /// No description provided for @effect_reveal_right.
  ///
  /// In en, this message translates to:
  /// **'Reveal right'**
  String get effect_reveal_right;

  /// No description provided for @effect_reveal_up.
  ///
  /// In en, this message translates to:
  /// **'Reveal up'**
  String get effect_reveal_up;

  /// No description provided for @effect_reveal_down.
  ///
  /// In en, this message translates to:
  /// **'Reveal down'**
  String get effect_reveal_down;

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
