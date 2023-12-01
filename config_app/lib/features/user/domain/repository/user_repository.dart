import 'dart:async';

import 'package:config_app/features/user/domain/entities/user.dart';
import 'package:config_app/features/realtime/data/services/client_service.dart';

abstract class UserRepository {
  Future<User?> getUser();
  void clear();
}
