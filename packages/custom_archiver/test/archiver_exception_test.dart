import 'package:custom_archiver/custom_archiver.dart';
import 'package:test/test.dart';

void main() {
  test('toString includes code and message', () {
    const error = ArchiverException(ArchiverError.crcMismatch, 'block 3');
    expect(error.toString(), 'ArchiverException(crcMismatch): block 3');
    expect(error.cause, isNull);
  });

  test('toString includes cause when present', () {
    final cause = StateError('disk full');
    final error = ArchiverException(
      ArchiverError.truncatedData,
      'input ended',
      cause: cause,
    );
    expect(error.cause, same(cause));
    expect(error.toString(), contains('cause: Bad state: disk full'));
  });
}
