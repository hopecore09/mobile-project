import 'archive_progress.dart';
import 'cancellation_token.dart';
import 'entry_target.dart';

/// Restores files from an archive, chunk by chunk.
abstract interface class ArchiveUnpacker {
  /// Reads an archive from [input] and passes every file and directory
  /// to [target].
  ///
  /// Completes with an `ArchiverException` if the archive is damaged.
  ///
  /// [onProgress] is called after every block and every entry.
  /// Implementations check [cancellationToken] between entries and
  /// between blocks. On cancellation the current file is aborted through
  /// [EntryTarget.abort] and the call completes with `ArchiverException`
  /// with `ArchiverError.cancelled`.
  Future<void> unpack(
    Stream<List<int>> input,
    EntryTarget target, {
    ArchiveProgressCallback? onProgress,
    CancellationToken? cancellationToken,
  });
}
