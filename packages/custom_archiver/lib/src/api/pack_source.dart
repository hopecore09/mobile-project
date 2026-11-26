/// A file that should be added to an archive.
///
/// The archiver does not touch the file system itself: the caller
/// decides where bytes come from (disk, memory, network).
abstract interface class PackSource {
  /// Relative path the file will have inside the archive.
  String get path;

  /// Exact size of the content in bytes.
  int get length;

  /// Opens the content as a stream of chunks. Called once per pack.
  Stream<List<int>> open();
}
