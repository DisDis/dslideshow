// ignore_for_file: constant_identifier_names, non_constant_identifier_names

// Java style!, copy from Permission.java

import 'package:config_app/features/permission/domain/entities/scope.dart';

enum Permission {
  NONE(1001, Scope.PHOTOFRAME, ACTIVE, true),
  ;

  static final Map<String, Permission> NAME_IDX =
      Map<String, Permission>.fromIterables(
          Permission.values.map((e) => e.name), Permission.values);

  static final ID_IDX =
      Map<int, Permission>.fromIterables(values.map((e) => e.id), values);

  final int id;
  final Scope scope;
  final BinaryStatus status;
  final bool isApplicableToEntity;

  const Permission(this.id, this.scope, this.status, this.isApplicableToEntity);

  static Permission byName(final String name) {
    final Permission? permission = NAME_IDX[name.toLowerCase()];
    if (permission == null) {
      throw ArgumentError("Not found permission with name $name");
    }
    return permission;
  }

  static Permission byId(final int id) {
    final Permission? permission = ID_IDX[id];
    if (permission == null) {
      throw ArgumentError("Not found permission with id $id");
    }
    return permission;
  }

  @override
  String toString() {
    return "P(id:$id, name:'$name', scope:'${scope.name}', isAToEntity:$isApplicableToEntity)";
  }
}

enum BinaryStatus {
  ACTIVE(1, "active"),
  DISABLED(2, "disabled");

  final int id;
  final String name;
  const BinaryStatus(this.id, this.name);
}

const ACTIVE = BinaryStatus.ACTIVE;
