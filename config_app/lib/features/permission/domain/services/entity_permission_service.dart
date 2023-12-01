// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:config_app/features/permission/domain/entities/permission.dart';
import 'package:config_app/features/permission/domain/entities/scope.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';

class EntityPermissionService {
  final PermissionService globalPermissionService;
  EntityPermissionService({
    required this.globalPermissionService,
  });
  final List<int> _permissionIds = <int>[];
  clear() {
    _permissionIds.clear();
  }

  setAll(Scope scope) {
    clear();
    for (var element in Permission.values) {
      if (element.scope.id == scope.id) {
        _permissionIds.add(element.id);
      }
    }
  }

  loadData(Iterable<int> permissionIds) {
    clear();
    _permissionIds.addAll(permissionIds);
  }

  loadDataByScopeId(Map<int, List<int>> permissionIdsByScopeId) {
    clear();
    permissionIdsByScopeId.values.forEach(_permissionIds.addAll);
  }

  bool checkById(int permissionId) {
    return _permissionIds.contains(permissionId) && globalPermissionService.checkById(permissionId);
  }

  bool check(Permission permission) {
    return _permissionIds.contains(permission.id) && globalPermissionService.checkById(permission.id);
  }

  @override
  String toString() {
    final sb = StringBuffer();
    for (var pId in _permissionIds) {
      sb.writeln(Permission.byId(pId));
    }
    return sb.toString();
  }
}
