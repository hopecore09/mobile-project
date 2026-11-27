/// Kind of an archive entry, stored as the `entryType` byte.
enum EntryType {
  /// A regular file with content (`entryType = 0`).
  file(0),

  /// A directory without content (`entryType = 1`).
  directory(1);

  /// Value of the `entryType` byte in the archive.
  final int code;

  const EntryType(this.code);
}
