import 'package:dslideshow_backend/src/service/gallery/gallery_tool_runner.dart';

typedef GalleryToolCallback = Future<GalleryToolResult> Function(
  String executable,
  List<String> arguments, {
  Duration? timeout,
  Future<void>? cancellation,
  Map<String, String>? environment,
  bool discardStdout,
  int maxOutputBytes,
});

class CallbackGalleryToolRunner implements GalleryToolRunner {
  final GalleryToolCallback callback;
  int closeCount = 0;
  CallbackGalleryToolRunner(this.callback);

  @override
  Future<GalleryToolResult> run(
    String executable,
    List<String> arguments, {
    Duration? timeout,
    Future<void>? cancellation,
    Map<String, String>? environment,
    bool discardStdout = false,
    int maxOutputBytes = 4 * 1024 * 1024,
  }) => callback(
    executable,
    arguments,
    timeout: timeout,
    cancellation: cancellation,
    environment: environment,
    discardStdout: discardStdout,
    maxOutputBytes: maxOutputBytes,
  );

  @override
  Future<void> close() async {
    closeCount++;
  }
}
