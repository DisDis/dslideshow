import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/upload/streaming_upload.dart';
import 'package:shelf/shelf.dart';
import 'package:logging/logging.dart';

/// Transfers the original configuration independently of the running services.
class OtaConfigTransfer {
  static final _log = Logger('OtaConfigTransfer');
  OtaConfigTransfer({required String filename, StreamingUploadReceiver? uploadReceiver})
    : _filename = filename,
      _uploadReceiver =
          uploadReceiver ??
          StreamingUploadReceiver(limits: const UploadLimits(maxBytes: 20 * 1024 * 1024, maxFiles: 1, maxParts: 2));

  final String _filename;
  final StreamingUploadReceiver _uploadReceiver;

  /// Do not parse: a damaged configuration must remain available for repair.
  Future<List<int>> download() async {
    try {
      return await File(_filename).readAsBytes();
    } on FileSystemException catch (error, stack) {
      _log.warning('Configuration download failed', error, stack);
      throw const UploadFailure(500, 'Could not read configuration');
    }
  }

  Future<void> upload(Request request, {required String code, required UploadCancellationToken cancellation}) async {
    StagedUploadBatch? batch;
    var authorized = false;
    try {
      batch = await _uploadReceiver.receiveMultipart(
        request,
        cancellation: cancellation,
        rejectionPolicy: request.canHijack ? UploadRejectionPolicy.drain : UploadRejectionPolicy.cancel,
        destinationFor: (_) => _filename,
        onField: (name, value) {
          if (name != 'code' || authorized) {
            throw const UploadFailure(400, 'Expected one code and one file');
          }
          if (value != code) {
            throw const UploadFailure(403, 'Incorrect code');
          }
          authorized = true;
        },
      );
      if (!authorized || batch.files.length != 1) {
        throw const UploadFailure(400, 'Expected one code and one file');
      }
      _checkCancellation(cancellation);
      final staged = batch.files.single;
      final content = await staged.temporary.readAsBytes();
      _checkCancellation(cancellation);
      try {
        final json = jsonDecode(utf8.decode(content));
        if (json is! Map<String, dynamic>) {
          throw const FormatException('Expected a JSON object');
        }
        AppConfig.fromJson(json);
      } catch (error, stack) {
        _log.warning('Configuration validation failed', error, stack);
        throw const UploadFailure(400, 'Invalid configuration JSON');
      }
      // Publishing is the commit point. The receiver has flushed and closed the
      // file, and its temporary path shares the destination directory.
      _checkCancellation(cancellation);
      await staged.publish();
    } catch (error, stack) {
      if (error is! UploadFailure) _log.warning('Configuration upload failed', error, stack);
      throw uploadFailureFor(error);
    } finally {
      await batch?.cleanup();
    }
  }

  static void _checkCancellation(UploadCancellationToken cancellation) {
    if (cancellation.isCancelled) {
      throw const UploadFailure(408, 'Upload cancelled');
    }
  }
}
