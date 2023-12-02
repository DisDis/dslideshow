import 'dart:async';

import 'package:config_app/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUser();
  void clear();
}
