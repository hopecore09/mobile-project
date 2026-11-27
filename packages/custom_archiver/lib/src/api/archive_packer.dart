import 'dart:async';

import 'archive_progress.dart';
import 'cancellation_token.dart';
import 'pack_source.dart';

/// Compresses files into one archive, chunk by chunk.
abstract interface class ArchivePacker {
  /// Writes an archive with all [sources] into [output].
  ///
  /// A [FileSource] becomes a file entry, a [DirectorySource] becomes a
  /// directory entry without content.
  ///
  /// [output] is not closed: its owner is responsible for that.
  ///
  /// [onProgress] is called after every block and every entry.
  /// Implementations check [cancellationToken] between entries and
  /// between blocks. When cancelled or failed, they stop writing and
  /// complete with an error (`ArchiverException` with
  /// `ArchiverError.cancelled` on cancellation), so a partial archive is
  /// never reported as a success; the caller deletes the output.
  Future<void> pack(
    List<PackSource> sources,
    StreamSink<List<int>> output, {
    ArchiveProgressCallback? onProgress,
    CancellationToken? cancellationToken,
  });
}
