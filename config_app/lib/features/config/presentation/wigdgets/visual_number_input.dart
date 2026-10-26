/// Accepts both decimal keyboard separators without accepting grouped or mixed
/// separators. Integer options keep their strict integer syntax.
double? parseVisualNumber(String? text, {bool integer = false}) {
  if (text == null) return null;
  final input = text.trim();
  if (integer && !RegExp(r'^[+-]?[0-9]+$').hasMatch(input)) return null;
  final value = integer
      ? int.tryParse(input)?.toDouble()
      : double.tryParse(input.replaceAll(',', '.'));
  return value != null && value.isFinite ? value : null;
}
