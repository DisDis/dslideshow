import 'package:config_app/features/user/domain/entities/avatarUrl.dart';

class User {
  static const String idEmpty = '-EMPTY-USER-';
  const User({required this.id, required this.firstName, required this.lastName, required this.avatarUrl});

  final String id;
  final String firstName;
  final String lastName;

  final AvatarUrl avatarUrl;

  ///TODO: Optimize it!
  /*String? _username;*/
  String get username => /*_username ??= */ "$firstName $lastName";

  static const empty = User(id: idEmpty, firstName: '-', lastName: '-', avatarUrl: AvatarUrl.empty);
}
