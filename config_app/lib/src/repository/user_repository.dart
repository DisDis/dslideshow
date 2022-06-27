import 'dart:async';

import 'package:config_app/src/service/client_service.dart';
import 'package:config_app/src/state/user_state.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  User? _user;
  ClientService? client;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(const Uuid().v4(), client),
    );
  }

  void setClient(ClientService client) {
    this.client = client;
  }
}
