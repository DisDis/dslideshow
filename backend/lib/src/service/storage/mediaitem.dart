class MediaItem {
  final String? id;
  final Uri? uri;
  static const empty = const MediaItem(null, null);
  const MediaItem(this.id, this.uri);
  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MediaItem && id == other.id && uri == other.uri);
  }

  int get hashCode => Object.hash(id, uri);
}
