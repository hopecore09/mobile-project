import 'archiver_error.dart';
import 'archiver_exception.dart';

/// Lets the caller stop a running pack or unpack.
///
/// The token lives in the isolate that runs the archiver. To cancel from
/// another isolate (for example the UI), send a message to that isolate
/// and call [cancel] there.
class CancellationToken {
  bool _cancelled = false;

  /// Whether [cancel] has been called.
  bool get isCancelled => _cancelled;

  /// Requests cancellation. Calling it again has no effect.
  void cancel() => _cancelled = true;

  /// Throws [ArchiverException] with [ArchiverError.cancelled] if
  /// cancellation was requested.
  void throwIfCancelled() {
    if (_cancelled) {
      throw const ArchiverException(
        ArchiverError.cancelled,
        'Operation was cancelled',
      );
    }
  }
}
