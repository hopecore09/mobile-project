import 'dart:async';

import 'pack_source.dart';

/// Compresses files into one archive, chunk by chunk.
abstract interface class ArchivePacker {
  /// Writes an archive with all [sources] into [output].
  ///
  /// A [FileSource] becomes a file entry, a [DirectorySource] becomes a
  /// directory entry without content.
  ///
  /// [output] is not closed: its owner is responsible for that.
  Future<void> pack(List<PackSource> sources, StreamSink<List<int>> output);
}
