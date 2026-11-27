import 'package:custom_archiver/custom_archiver.dart';
import 'package:test/test.dart';

class _MemoryFile extends FileSource {
  @override
  final String path;
  final List<int> bytes;

  const _MemoryFile(this.path, this.bytes);

  @override
  int get length => bytes.length;

  @override
  Stream<List<int>> open() => Stream.value(bytes);
}

String _describe(PackSource source) => switch (source) {
      FileSource(:final path, :final length) => 'file $path $length',
      DirectorySource(:final path) => 'dir $path',
    };

void main() {
  test('entry type codes match the format', () {
    expect(EntryType.file.code, 0);
    expect(EntryType.directory.code, 1);
  });

  test('directory header has no content', () {
    const header = EntryHeader.directory(path: 'photos/empty');
    expect(header.type, EntryType.directory);
    expect(header.originalSize, 0);
  });

  test('file header keeps its size', () {
    const header = EntryHeader.file(path: 'a.txt', originalSize: 42);
    expect(header.type, EntryType.file);
    expect(header.originalSize, 42);
  });

  test('pack sources are distinguished by type', () {
    const sources = <PackSource>[
      _MemoryFile('a.txt', [1, 2, 3]),
      DirectorySource('empty'),
    ];
    expect(sources.map(_describe), ['file a.txt 3', 'dir empty']);
    expect(sources.map((s) => s.type), [EntryType.file, EntryType.directory]);
  });
}
