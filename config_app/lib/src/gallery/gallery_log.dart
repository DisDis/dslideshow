import 'dart:convert';

import 'package:crypto/crypto.dart';

/// A consistent digest correlates operations without exposing caller-supplied
/// IDs, legacy authenticated media URLs, paths or revisions.
class GalleryLog {
  static String id(String value) => value.isEmpty ? 'none' : source(value);

  static String source(String value) =>
      'id-${sha256.convert(utf8.encode(value)).toString().substring(0, 12)}';
}
