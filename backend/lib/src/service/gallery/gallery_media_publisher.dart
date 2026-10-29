import 'dart:io';

import 'package:path/path.dart' as path;

import '../upload/streaming_upload.dart';

/// Shared, closed-before-rename publication for managed remote media.
/// Reuses the staging format already excluded by DiskStorage.
class GalleryMediaPublisher {
  final Directory originals;
  final StreamingUploadReceiver _receiver;
  GalleryMediaPublisher({
    required this.originals,
    StreamingUploadReceiver? receiver,
  }) : _receiver =
           receiver ??
           StreamingUploadReceiver(
             limits: const UploadLimits(maxBytes: 1 << 60),
           );

  Future<File> publish(
    Stream<List<int>> stream,
    String filename, {
    int? contentLength,
    UploadCancellationToken? cancellation,
  }) async {
    final destination = path.join(originals.path, filename);
    final staged = await _receiver.receiveStream(
      stream,
      filename: filename,
      destination: destination,
      contentLength: contentLength,
      cancellation: cancellation,
    );
    try {
      if (cancellation?.isCancelled == true)
        throw const UploadFailure(503, 'Publication cancelled');
      final published = await staged.publish();
      return published;
    } finally {
      await staged.cleanup();
    }
  }
}
