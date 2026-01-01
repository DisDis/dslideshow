import 'package:config_app/features/permission/domain/entities/permission.dart';

class PermissionService {
  final List<int> _permissionIds = <int>[];
  void clear() {
    _permissionIds.clear();
  }

  void loadData(List<int> permissionIds) {
    clear();
    _permissionIds.addAll(permissionIds);
  }

  void loadDataByScopeId(Map<int, List<int>> permissionIdsByScopeId) {
    clear();
    permissionIdsByScopeId.values.forEach(_permissionIds.addAll);
  }

  bool checkById(int permissionId) {
    return _permissionIds.contains(permissionId);
  }

  bool check(Permission permission) {
    return _permissionIds.contains(permission.id);
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
