import 'package:dslideshow_backend/src/service/gallery/gallery_tool_runner.dart';

typedef GalleryToolCallback = Future<GalleryToolResult> Function(
  String executable,
  List<String> arguments,
  Future<void>? cancellation,
  Map<String, String>? environment,
);

class GalleryToolStub implements GalleryToolRunner {
  GalleryToolStub(this.callback);
  final GalleryToolCallback callback;
  final List<List<String>> calls = [];
  bool closed = false;

  @override
  Future<GalleryToolResult> run(
    String executable,
    List<String> arguments, {
    Duration? timeout,
    Future<void>? cancellation,
    Map<String, String>? environment,
    bool discardStdout = false,
    int maxOutputBytes = 4 * 1024 * 1024,
  }) {
    if (arguments.length == 1 && arguments.single == '--version') {
      return Future.value(
        const GalleryToolResult(
          exitCode: 0,
          stdout: 'czkawka 12.0.2',
          stderr: '',
        ),
      );
    }
    calls.add(List.of(arguments));
    return callback(executable, arguments, cancellation, environment);
  }

  @override
  Future<void> close() async {
    closed = true;
  }
}
