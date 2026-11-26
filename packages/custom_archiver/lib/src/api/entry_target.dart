import 'dart:async';

import 'entry_header.dart';

/// Receives files restored from an archive.
abstract interface class EntryTarget {
  /// Returns a sink for the content of [header].
  ///
  /// The unpacker writes the restored chunks into it and closes it
  /// when the entry is finished.
  StreamSink<List<int>> create(EntryHeader header);
}
