// Cloud downloads use asynchronous filesystem operations.
// ignore_for_file: avoid_slow_async_io
import 'package:crypto/crypto.dart';
import 'package:dslideshow_common/file_settings.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/storage_status.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import '../../command/drive_command.dart';
import '../upload/streaming_upload.dart';
import 'cloud_storage_transfer.dart';
import 'disk/disk_storage.dart';
import 'storage_type.dart' as media;

/// A storage provider with account and source setup available before activation.
///
/// Only the selected provider receives [init] for playback and synchronization.
/// [release] also frees resources acquired by commands before initialization.
abstract class CloudStorage extends DiskStorage {
  CloudStorage(super.config, {super.folder, super.hidden, super.random});

  static final _log = Logger('CloudStorage');
  static final _md5 = RegExp(r'^[a-fA-F0-9]{32}$');
  static final _sha256 = RegExp(r'^[a-fA-F0-9]{64}$');
  final _receiver = StreamingUploadReceiver(limits: const UploadLimits(maxBytes: 1 << 60));

  @override
  final media.StorageType type = media.StorageType.remote;

  /// Handles account setup and controls for this provider.
  ///
  /// Account authorization and source browsing are available before [init].
  /// Commands that control synchronization require an active provider.
  Future<RpcResult> executeDriveCommand(DriveCommand command);

  @override
  Future<void> init() async {
    try {
      await super.init();
    } catch (_) {
      updateStatus(StorageStatusEnum.off);
      rethrow;
    }
  }

  /// Stages a download, verifies its contents, and publishes it locally.
  ///
  /// Returns `false` if [relativePath] already exists in the library or hidden
  /// section. Throws [CloudStorageException] on failure. The temporary file is
  /// cleaned up after publication, a duplicate, or a failure.
  /// Providers check [mediaExists] before requesting a network download; this
  /// method handles the stream of a file that actually needs downloading.
  /// An accepted stream finishes verification and publication even when its
  /// provider pauses, disconnects an account, or releases storage.
  Future<bool> publishDownloadedMedia(
    Stream<List<int>> stream,
    String relativePath, {
    int? expectedBytes,
    int? contentLength,
    String? expectedMd5,
    String? expectedSha256,
  }) async {
    _log.fine('Media publication started');
    StagedUploadFile? staged;
    try {
      if (!FileSettings.isSupportFile(path.posix.extension(relativePath))) {
        throw const CloudStorageException(DriveFailure.invalidRequest);
      }
      if ((expectedMd5 != null && !_md5.hasMatch(expectedMd5)) ||
          (expectedSha256 != null && !_sha256.hasMatch(expectedSha256))) {
        throw const CloudStorageException(DriveFailure.invalidResponse);
      }
      final exists = await mediaExists(relativePath);
      if (exists) {
        _log.fine('Media publication skipped reason=existing');
        return false;
      }
      final md5Result = _DigestResult();
      final shaResult = _DigestResult();
      final md5Input = expectedMd5 == null ? null : md5.startChunkedConversion(md5Result);
      final shaInput = expectedSha256 == null ? null : sha256.startChunkedConversion(shaResult);
      var received = 0;
      Stream<List<int>> checkedStream() async* {
        try {
          await for (final bytes in stream) {
            received += bytes.length;
            md5Input?.add(bytes);
            shaInput?.add(bytes);
            yield bytes;
          }
          md5Input?.close();
          shaInput?.close();
        } catch (error, stack) {
          _log.warning('Cloud media transfer failed', error, stack);
          throw const UploadFailure(502, 'Cloud media transfer failed');
        }
      }

      staged = await _receiver.receiveStream(
        checkedStream(),
        filename: path.posix.basename(relativePath),
        destination: path.join(folder.path, relativePath),
        contentLength: contentLength,
      );
      if ((expectedBytes != null && received != expectedBytes) ||
          (expectedMd5 != null && md5Result.value != expectedMd5.toLowerCase()) ||
          (expectedSha256 != null && shaResult.value != expectedSha256.toLowerCase())) {
        throw const CloudStorageException(DriveFailure.checksum);
      }
      final nowExists = await mediaExists(relativePath);
      if (nowExists) {
        _log.fine('Media publication skipped reason=existing');
        return false;
      }
      await staged.publish();
      _log.fine('Media publication completed');
      return true;
    } catch (error, stack) {
      final failure = error is CloudStorageException
          ? error.code
          : error is FormatException || error is ArgumentError
          ? DriveFailure.invalidRequest
          : error is UploadFailure
          ? switch (error.statusCode) {
              408 || 502 => DriveFailure.network,
              400 => DriveFailure.checksum,
              _ => DriveFailure.storage,
            }
          : DriveFailure.storage;
      _log.fine('Media publication failed reason=${failure.name}', error, stack);
      throw CloudStorageException(failure);
    } finally {
      await staged?.cleanup();
    }
  }
}

class _DigestResult implements Sink<Digest> {
  String? value;
  @override
  void add(Digest data) => value = data.toString();
  @override
  void close() {}
}
