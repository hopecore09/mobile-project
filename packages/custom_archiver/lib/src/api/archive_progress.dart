/// Snapshot of a pack or unpack operation, passed to `onProgress`.
class ArchiveProgress {
  /// Number of entries fully written or restored so far.
  final int entriesCompleted;

  /// Total number of entries, or `null` if unknown.
  ///
  /// Known when packing. When unpacking it is `null`: the format has no
  /// entry count before the end of the archive.
  final int? entriesTotal;

  /// Original (uncompressed) bytes processed so far: read from sources
  /// when packing, restored into targets when unpacking.
  final int bytesProcessed;

  /// Total original bytes, or `null` if unknown (always `null` when
  /// unpacking).
  final int? bytesTotal;

  /// Path of the entry being processed, or `null` between entries.
  final String? currentPath;

  const ArchiveProgress({
    required this.entriesCompleted,
    required this.bytesProcessed,
    this.entriesTotal,
    this.bytesTotal,
    this.currentPath,
  });

  /// Share of work done in `0.0..1.0`, or `null` if [bytesTotal] is unknown.
  double? get fraction {
    final total = bytesTotal;
    if (total == null) return null;
    if (total == 0) return entriesCompleted == entriesTotal ? 1.0 : 0.0;
    return bytesProcessed / total;
  }
}

/// Called by the archiver to report how far an operation has got.
typedef ArchiveProgressCallback = void Function(ArchiveProgress progress);
