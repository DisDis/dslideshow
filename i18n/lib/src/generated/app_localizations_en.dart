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
}
