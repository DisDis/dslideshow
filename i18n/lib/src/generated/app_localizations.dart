import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

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
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
