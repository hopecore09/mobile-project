/// Kind of failure reported by [ArchiverException].
///
/// Lets callers (for example the UI) react to an error without parsing
/// its message.
enum ArchiverError {
  /// The input does not start with the `HPA1` magic.
  invalidMagic,

  /// The archive version is not supported by this implementation.
  unsupportedVersion,

  /// The input ended before the archive was complete.
  truncatedData,

  /// A block or file CRC-32 does not match the restored data.
  crcMismatch,

  /// An entry path breaks the path rules of the format.
  unsafePath,

  /// Block lengths do not add up to the entry's `originalSize`.
  sizeMismatch,

  /// Any other violation of the format: unknown marker, entry type or
  /// method, invalid Huffman table, bad padding and so on.
  invalidFormat,

  /// The operation was cancelled through a cancellation token.
  cancelled,
}
