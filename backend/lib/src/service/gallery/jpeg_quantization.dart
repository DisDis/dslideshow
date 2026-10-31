import 'package:dslideshow_common/gallery.dart';

import 'gallery_catalog_service.dart';

/// Matches JPEG DQT values to the standard IJG quality scale without decoding pixels.
class JpegQuantization {
  // ITU-T T.81 Annex K tables in natural order; DQT stores them in zigzag order.
  static const _luminance = [
    16,
    11,
    10,
    16,
    24,
    40,
    51,
    61,
    12,
    12,
    14,
    19,
    26,
    58,
    60,
    55,
    14,
    13,
    16,
    24,
    40,
    57,
    69,
    56,
    14,
    17,
    22,
    29,
    51,
    87,
    80,
    62,
    18,
    22,
    37,
    56,
    68,
    109,
    103,
    77,
    24,
    35,
    55,
    64,
    81,
    104,
    113,
    92,
    49,
    64,
    78,
    87,
    103,
    121,
    120,
    101,
    72,
    92,
    95,
    98,
    112,
    100,
    103,
    99,
  ];
  static const _chrominance = [
    17,
    18,
    24,
    47,
    99,
    99,
    99,
    99,
    18,
    21,
    26,
    66,
    99,
    99,
    99,
    99,
    24,
    26,
    56,
    99,
    99,
    99,
    99,
    99,
    47,
    66,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
    99,
  ];
  static const _zigzag = [
    0,
    1,
    8,
    16,
    9,
    2,
    3,
    10,
    17,
    24,
    32,
    25,
    18,
    11,
    4,
    5,
    12,
    19,
    26,
    33,
    40,
    48,
    41,
    34,
    27,
    20,
    13,
    6,
    7,
    14,
    21,
    28,
    35,
    42,
    49,
    56,
    57,
    50,
    43,
    36,
    29,
    22,
    15,
    23,
    30,
    37,
    44,
    51,
    58,
    59,
    52,
    45,
    38,
    31,
    39,
    46,
    53,
    60,
    61,
    54,
    47,
    55,
    62,
    63,
  ];
  final Map<int, List<int>> _tables = {};
  final Map<int, int> _limits = {};

  /// Accepts one complete DQT payload, including multiple or redefined tables.
  void add(List<int> bytes) {
    if (bytes.isEmpty) _invalid();
    var offset = 0;
    while (offset < bytes.length) {
      final descriptor = bytes[offset++];
      final precision = descriptor >> 4, id = descriptor & 15;
      if (precision > 1 || id > 3 || offset + 64 * (precision + 1) > bytes.length) _invalid();
      final values = <int>[];
      for (var i = 0; i < 64; i++) {
        final value = precision == 0 ? bytes[offset++] : (bytes[offset++] << 8) | bytes[offset++];
        if (value == 0) _invalid();
        values.add(value);
      }
      _tables[id] = values;
      _limits[id] = precision == 0 ? 255 : 65535;
    }
  }

  /// Returns a unique standard factor, or null for unsupported or custom tables.
  int? quality({required int precision, required int frameMarker, required List<int> selectors}) {
    if (precision != 8 ||
        !const [0xc0, 0xc1, 0xc2].contains(frameMarker) ||
        selectors.length != 1 && selectors.length != 3)
      return null;
    int? matched;
    for (var quality = 1; quality <= 100; quality++) {
      final scale = quality < 50 ? 5000 ~/ quality : 200 - 2 * quality;
      var same = true;
      for (var component = 0; component < selectors.length && same; component++) {
        final table = _tables[selectors[component]];
        if (table == null) return null;
        final base = component == 0 ? _luminance : _chrominance;
        final limit = _limits[selectors[component]]!;
        for (var i = 0; i < 64; i++) {
          final expected = ((base[_zigzag[i]] * scale + 50) ~/ 100).clamp(1, limit);
          if (table[i] != expected) {
            same = false;
            break;
          }
        }
      }
      if (same) {
        if (matched != null) return null;
        matched = quality;
      }
    }
    return matched;
  }

  static Never _invalid() => throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
}
