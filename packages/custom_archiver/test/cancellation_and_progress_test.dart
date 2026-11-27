import 'package:custom_archiver/custom_archiver.dart';
import 'package:test/test.dart';

void main() {
  group('CancellationToken', () {
    test('is not cancelled initially', () {
      final token = CancellationToken();
      expect(token.isCancelled, isFalse);
      expect(token.throwIfCancelled, returnsNormally);
    });

    test('throws cancelled error after cancel', () {
      final token = CancellationToken()..cancel();
      expect(token.isCancelled, isTrue);
      expect(
        token.throwIfCancelled,
        throwsA(
          isA<ArchiverException>().having(
            (e) => e.code,
            'code',
            ArchiverError.cancelled,
          ),
        ),
      );
    });
  });

  group('ArchiveProgress.fraction', () {
    test('is null when total is unknown', () {
      const progress = ArchiveProgress(entriesCompleted: 1, bytesProcessed: 10);
      expect(progress.fraction, isNull);
    });

    test('is the share of processed bytes', () {
      const progress = ArchiveProgress(
        entriesCompleted: 0,
        entriesTotal: 2,
        bytesProcessed: 25,
        bytesTotal: 100,
        currentPath: 'a.txt',
      );
      expect(progress.fraction, 0.25);
    });

    test('handles archives with only empty entries', () {
      const done = ArchiveProgress(
        entriesCompleted: 2,
        entriesTotal: 2,
        bytesProcessed: 0,
        bytesTotal: 0,
      );
      expect(done.fraction, 1.0);
    });
  });
}
