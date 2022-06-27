import 'package:config_app/src/service/client_service.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final ClientService? client;
  const User(this.id, this.client);

  final String id;

  @override
  List<Object> get props => [id];

  static const empty = User('-', null);
}
