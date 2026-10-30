import 'dart:io';

import 'package:dslideshow_tools/src/benchmarks/gallery_http.dart';
import 'package:dslideshow_tools/src/process/supervisor.dart';

Future<void> main(List<String> args) async {
  try {
    await galleryTrial(File(args[0]), Directory(args[1]), 0, [File(args[2])], [1], 1);
  } on ProcessJobFailure catch (error) {
    exitCode = error.exitCode;
  }
}
