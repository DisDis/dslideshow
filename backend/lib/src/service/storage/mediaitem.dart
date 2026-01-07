import 'package:dslideshow_common/file_settings.dart';
import 'package:path/path.dart' as path;

class MediaItem {
  final String? id;
  final Uri? uri;
  static const empty = const MediaItem(null, null);
  const MediaItem(this.id, this.uri);
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MediaItem &&
            id == other.id &&
            uri == other.uri);
  }

  bool get isVideo =>
      uri == null ? false : FileSettings.isVideo(path.extension(uri!.path));

  int get hashCode => Object.hash(id, uri);
}
