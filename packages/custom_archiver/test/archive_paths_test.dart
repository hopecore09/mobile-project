import 'package:custom_archiver/custom_archiver.dart';
import 'package:test/test.dart';

void main() {
  group('ArchivePaths.validate accepts', () {
    for (final path in [
      'file.txt',
      'docs/report.pdf',
      'a/b/c/d.bin',
      '.hidden',
      'dir/..name',
      'name...',
      'Фото/отпуск 2026.jpg',
      'notes:2026.txt',
    ]) {
      test(path, () => expect(ArchivePaths.validate(path), path));
    }
  });

  group('ArchivePaths.validate rejects', () {
    final rejected = <String, String>{
      'empty path': '',
      'leading slash': '/etc/passwd',
      'trailing slash': 'dir/',
      'double slash': 'a//b',
      'dot segment': 'a/./b',
      'single dot': '.',
      'dot-dot segment': '../evil.txt',
      'dot-dot in the middle': 'a/../../b',
      'dot-dot at the end': 'a/..',
      'drive prefix': 'C:/Windows/system32',
      'drive prefix without slash': 'c:file.txt',
      'UNC with backslashes': r'\\server\share\file',
      'UNC with slashes': '//server/share/file',
      'backslash separator': r'dir\file.txt',
      'NUL character': 'file\u0000.txt',
      'newline': 'file\n.txt',
      'DEL character': 'file\u007F.txt',
      'too long': 'a' * (ArchivePaths.maxLengthInBytes + 1),
    };
    rejected.forEach((name, path) {
      test(name, () {
        expect(
          () => ArchivePaths.validate(path),
          throwsA(isA<ArchiverException>()),
        );
      });
    });
  });
}
