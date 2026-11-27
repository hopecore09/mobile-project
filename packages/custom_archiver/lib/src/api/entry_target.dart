import 'dart:async';

import 'entry_header.dart';
import 'entry_type.dart';

/// Receives files and directories restored from an archive.
abstract interface class EntryTarget {
  /// Returns a sink for the content of the file described by [header].
  ///
  /// Called only for [EntryType.file] entries. The unpacker writes the
  /// restored chunks into it and closes it when the entry is finished.
  StreamSink<List<int>> create(EntryHeader header);

  /// Creates the directory described by [header].
  ///
  /// Called only for [EntryType.directory] entries.
  Future<void> createDirectory(EntryHeader header);
}
