import 'package:collection/collection.dart';

/// Remove defaults from fresh JSON maps without modifying the source models.
Map<String, dynamic> stripDefaults(
  Map<String, dynamic> json,
  Map<String, dynamic> defaults,
) {
  final result = Map<String, dynamic>.of(json);
  const deepEq = DeepCollectionEquality();

  for (final key in json.keys) {
    if (!defaults.containsKey(key)) continue;

    final jsonValue = json[key];
    final defaultValue = defaults[key];

    if (jsonValue is Map<String, dynamic> &&
        defaultValue is Map<String, dynamic>) {
      final strippedChild = stripDefaults(jsonValue, defaultValue);
      if (strippedChild.isEmpty) {
        result.remove(key);
      } else {
        result[key] = strippedChild;
      }
    } else if (deepEq.equals(jsonValue, defaultValue)) {
      result.remove(key);
    }
  }
  return result;
}
