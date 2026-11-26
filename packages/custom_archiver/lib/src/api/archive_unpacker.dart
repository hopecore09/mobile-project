import 'entry_target.dart';

/// Restores files from an archive, chunk by chunk.
abstract interface class ArchiveUnpacker {
  /// Reads an archive from [input] and passes every file to [target].
  ///
  /// Completes with an [ArchiverException] if the archive is damaged.
  Future<void> unpack(Stream<List<int>> input, EntryTarget target);
}
