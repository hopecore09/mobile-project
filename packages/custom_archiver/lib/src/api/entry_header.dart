import 'entry_type.dart';

/// Metadata of one file or directory stored in an archive.
class EntryHeader {
  /// Relative path inside the archive, always with `/` separators.
  final String path;

  /// Whether the entry is a file or a directory.
  final EntryType type;

  /// Size of the original (uncompressed) file in bytes.
  ///
  /// Always `0` for a directory.
  final int originalSize;

  /// Header of a file with [originalSize] bytes of content.
  const EntryHeader.file({required this.path, required this.originalSize})
      : type = EntryType.file;

  /// Header of a directory; it has no content.
  const EntryHeader.directory({required this.path})
      : type = EntryType.directory,
        originalSize = 0;
}
