abstract class FileSettings {
  static const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];

  static const videoExtensions = ['.mp4', '.avi', '.mov'];

  static const List<String> supportFileExtensions = [
    ...imageExtensions,
    ...videoExtensions,
  ];

  static bool isVideo(String ext) {
    return videoExtensions.contains(ext.toLowerCase());
  }
  static bool isImage(String ext) {
    return imageExtensions.contains(ext.toLowerCase());
  }
  static bool isSupportFile(String ext) {
    return supportFileExtensions.contains(ext.toLowerCase());
  }
}
