/// Metadata of one file stored in an archive.
class EntryHeader {
  /// Relative path inside the archive, always with `/` separators.
  final String path;

  /// Size of the original (uncompressed) file in bytes.
  final int originalSize;

  const EntryHeader({required this.path, required this.originalSize});
}
