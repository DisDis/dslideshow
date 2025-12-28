import 'package:dslideshow_common/core/resources/data_exception_type.dart';

class DataException implements Exception {
  DataException({
    this.type = DataExceptionType.unknown,
    this.error,
    StackTrace? stackTrace,
    this.message,
  }) : stackTrace = identical(stackTrace, StackTrace.empty) ? StackTrace.current : stackTrace ?? StackTrace.current;
  DataExceptionType type;

  /// The original error/exception object;
  /// It's usually not null when `type` is [DataExceptionType.unknown].
  //ignore: no-object-declaration
  final Object? error;

  /// The stacktrace of the original error/exception object;
  /// It's usually not null when `type` is [DataExceptionType.unknown].
  final StackTrace stackTrace;

  /// The error message
  final String? message;

  @override
  String toString() {
    String msg = 'DataException [${type.toPrettyDescription()}]: $message';
    if (error != null) {
      msg += '\nError: $error';
    }
    return msg;
  }
}

extension _DataExceptionTypeExtension on DataExceptionType {
  String toPrettyDescription() {
    switch (this) {
      case DataExceptionType.connectionTimeout:
        return 'connection timeout';
      case DataExceptionType.sendTimeout:
        return 'send timeout';
      case DataExceptionType.receiveTimeout:
        return 'receive timeout';
      case DataExceptionType.badCertificate:
        return 'bad certificate';
      case DataExceptionType.badResponse:
        return 'bad response';
      case DataExceptionType.cancel:
        return 'request cancelled';
      case DataExceptionType.connectionError:
        return 'connection error';
      case DataExceptionType.unknown:
        return 'unknown';
    }
  }
}
