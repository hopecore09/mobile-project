import 'archiver_error.dart';

/// Thrown when an archive cannot be read or written.
///
/// I/O errors of the caller's streams and sinks are not swallowed: they
/// propagate unchanged, or are wrapped only with the original error kept
/// in [cause].
class ArchiverException implements Exception {
  /// Kind of the failure.
  final ArchiverError code;

  /// Human-readable description for logs.
  final String message;

  /// Original error that led to this exception, if any.
  final Object? cause;

  const ArchiverException(this.code, this.message, {this.cause});

  @override
  String toString() {
    final text = 'ArchiverException(${code.name}): $message';
    return cause == null ? text : '$text (cause: $cause)';
  }
}
