/// Thrown when an archive cannot be read or written.
class ArchiverException implements Exception {
  final String message;

  const ArchiverException(this.message);

  @override
  String toString() => 'ArchiverException: $message';
}
