import 'entry_type.dart';

/// Something that should be added to an archive: a [FileSource] or a
/// [DirectorySource].
///
/// The archiver does not touch the file system itself: the caller
/// decides where bytes come from (disk, memory, network).
sealed class PackSource {
  const PackSource();

  /// Relative path the entry will have inside the archive.
  String get path;

  /// Kind of the entry written for this source.
  EntryType get type;
}

/// A file whose content is read as a stream of chunks.
abstract class FileSource extends PackSource {
  const FileSource();

  @override
  EntryType get type => EntryType.file;

  /// Exact size of the content in bytes.
  int get length;

  /// Opens the content as a stream of chunks. Called once per pack.
  Stream<List<int>> open();
}

/// A directory. It has no content and is stored so that empty
/// directories survive archiving.
final class DirectorySource extends PackSource {
  @override
  final String path;

  const DirectorySource(this.path);

  @override
  EntryType get type => EntryType.directory;
}
