import 'dart:convert';

import 'archiver_exception.dart';

/// Rules for entry paths stored in an archive (see FORMAT.md, "Пути записей").
abstract final class ArchivePaths {
  /// Maximum length of a path in UTF-8 bytes (the `pathLength` field is uint16).
  static const int maxLengthInBytes = 0xFFFF;

  static final RegExp _drivePrefix = RegExp(r'^[A-Za-z]:');

  /// Returns [path] unchanged if it is a safe relative archive path.
  ///
  /// Throws [ArchiverException] if the path is empty, too long, absolute,
  /// has empty, `.` or `..` segments, contains `\` or control characters.
  /// Unpackers call this before `EntryTarget.create`.
  static String validate(String path) {
    if (path.isEmpty) {
      throw _unsafe(path, 'path is empty');
    }
    if (utf8.encode(path).length > maxLengthInBytes) {
      throw _unsafe(path, 'path is longer than $maxLengthInBytes bytes');
    }
    _checkCharacters(path);
    if (path.startsWith('/')) {
      throw _unsafe(path, 'path is absolute');
    }
    if (_drivePrefix.hasMatch(path)) {
      throw _unsafe(path, 'path starts with a drive letter');
    }
    _checkSegments(path);
    return path;
  }

  static void _checkCharacters(String path) {
    for (final unit in path.codeUnits) {
      if (unit < 0x20 || unit == 0x7F) {
        throw _unsafe(path, 'path contains a control character');
      }
      if (unit == 0x5C) {
        throw _unsafe(path, r'path contains "\"');
      }
    }
  }

  static void _checkSegments(String path) {
    for (final segment in path.split('/')) {
      if (segment.isEmpty) {
        throw _unsafe(path, 'path has an empty segment');
      }
      if (segment == '.' || segment == '..') {
        throw _unsafe(path, 'path has a "$segment" segment');
      }
    }
  }

  static ArchiverException _unsafe(String path, String reason) =>
      ArchiverException('Unsafe entry path ${jsonEncode(path)}: $reason');
}
