import 'dart:async';

import 'package:config_app/features/user/domain/entities/avatarUrl.dart';
import 'package:config_app/features/user/domain/repository/user_repository.dart';
import 'package:config_app/features/user/domain/entities/user.dart';

class UserRepositoryImpl implements UserRepository {
  User? _user;

  @override
  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(
        firstName: "Frame User ${DateTime.now().millisecondsSinceEpoch.toString()}",
        lastName: "",
        id: "0",
        avatarUrl: AvatarUrl.empty,
      ),
    );
  }

  @override
  void clear() {
    _user = null;
  }
}
