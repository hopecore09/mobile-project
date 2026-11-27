import 'dart:async';

import 'archive_paths.dart';
import 'entry_header.dart';
import 'entry_type.dart';

/// Receives files and directories restored from an archive.
///
/// Contract for unpackers:
/// * the entry path is checked with [ArchivePaths.validate] before
///   [create] or [createDirectory] is called;
/// * if unpacking a file fails after [create] has completed (damaged
///   data, CRC mismatch, failed write, cancellation), the unpacker calls
///   [abort] for that entry and then completes with the error;
/// * if [create] was never called or did not complete, [abort] is not
///   called.
abstract interface class EntryTarget {
  /// Opens a sink for the content of the file described by [header].
  ///
  /// Called only for [EntryType.file] entries. The unpacker writes the
  /// restored chunks into the sink and closes it when the entry is
  /// finished and its CRC has been checked.
  Future<StreamSink<List<int>>> create(EntryHeader header);

  /// Creates the directory described by [header].
  ///
  /// Called only for [EntryType.directory] entries.
  Future<void> createDirectory(EntryHeader header);

  /// Discards the partially written file described by [header].
  ///
  /// Implementations delete the incomplete file. Must be safe to call
  /// when the sink from [create] is already closed or a write to it has
  /// failed.
  Future<void> abort(EntryHeader header);
}
