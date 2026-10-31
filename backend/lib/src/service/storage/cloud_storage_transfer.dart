import '../../command/drive_command.dart';

/// A cloud transfer failure that exposes only a safe failure code.
class CloudStorageException implements Exception {
  const CloudStorageException(this.code);
  final DriveFailure code;
  @override
  String toString() => 'CloudStorageException(${code.name})';
}
