// ignore_for_file: file_names

class AvatarUrl {
  final String small;

  final String medium;

  final String large;

  const AvatarUrl({required this.small, required this.medium, required this.large});

  //TODO: set default urls
  static const empty = AvatarUrl(
    small: "https://image.emojisky.com/975/1932975-middle.png",
    medium: "https://image.emojisky.com/975/1932975-middle.png",
    large: "https://image.emojisky.com/975/1932975-middle.png",
  );
}
