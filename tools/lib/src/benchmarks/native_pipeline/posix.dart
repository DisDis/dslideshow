import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

import '../json_io.dart' show encodeReportJson;

final _spaces = RegExp(r'\s+');

/// Obtain Linux inode/device and nanosecond timestamps without assuming stat ABI.
List<String> fileIdentity(String path) {
  final result = Process.runSync('stat', ['-L', '--printf=%d|%i|%s|%y|%z', '--', path], environment: {'LC_ALL': 'C'});
  if (result.exitCode != 0) {
    final message = result.stderr.toString();
    throw FileSystemException(
      'stat failed',
      path,
      OSError('stat failed', message.contains('No such file or directory') ? 2 : 13),
    );
  }
  return result.stdout.toString().split('|');
}

int inode(String path) => int.parse(fileIdentity(path)[1]);
int deviceMajor(int device) => ((device >> 8) & 0xfff) | ((device >> 32) & ~0xfff);
int deviceMinor(int device) => (device & 0xff) | ((device >> 12) & ~0xff);

(Uint8List, List<String>) snapshot(String path) {
  final before = fileIdentity(path);
  final bytes = File(path).readAsBytesSync();
  final after = fileIdentity(path);
  if (!sameIdentity(before, after)) throw StateError('File changed while reading: $path');
  return (bytes, after);
}

bool sameIdentity(List<String> a, List<String> b) =>
    a.length == b.length && Iterable<int>.generate(a.length).every((i) => a[i] == b[i]);

String hashFile(String path) {
  final (bytes, _) = snapshot(path);
  return sha256.convert(bytes).toString();
}

void assertProcessAbsent(String process) {
  try {
    fileIdentity(process);
  } on FileSystemException catch (error) {
    if (error.osError?.errorCode == 2) return;
    rethrow;
  }
  throw StateError('Native process PID still exists; refusing finalization');
}

void writeExclusive(String path, Object? value) {
  final temporary = '$path.$pid.${DateTime.now().microsecondsSinceEpoch}.exclusive';
  final destination = File(temporary)..createSync(exclusive: true);
  try {
    final permission = Process.runSync('chmod', ['0600', '--', temporary]);
    if (permission.exitCode != 0) throw FileSystemException('chmod failed', path);
    destination.writeAsStringSync('${encodeReportJson(value, indent: '  ')}\n', flush: true);
    // Publishing a hard link is atomic and refuses every existing destination,
    // including a symlink. No create-then-reopen of an attacker-chosen output.
    final linked = Process.runSync('ln', ['--', temporary, path]);
    if (linked.exitCode != 0) throw FileSystemException('Exclusive publication failed', path);
  } finally {
    destination.deleteSync();
  }
}

void writeJson(String path, Object? value, {bool exclusive = false}) {
  if (exclusive) return writeExclusive(path, value);
  final temporary = '$path.${pid}_${DateTime.now().microsecondsSinceEpoch}.tmp';
  try {
    writeExclusive(temporary, value);
    File(temporary).renameSync(path);
  } finally {
    if (File(temporary).existsSync()) File(temporary).deleteSync();
  }
}

String safePath(String value) {
  if (!p.isAbsolute(value) || p.normalize(value) != value || p.dirname(value) == value) {
    throw ArgumentError('Use an absolute, non-symlink path: $value');
  }
  // Resolve every existing ancestor, including when the final output does not exist.
  var ancestor = value;
  final tail = <String>[];
  while (FileSystemEntity.typeSync(ancestor, followLinks: false) == FileSystemEntityType.notFound) {
    tail.insert(0, p.basename(ancestor));
    ancestor = p.dirname(ancestor);
  }
  final resolved = File(ancestor).resolveSymbolicLinksSync();
  if (p.joinAll([resolved, ...tail]) != value) throw ArgumentError('Use an absolute, non-symlink path: $value');
  return value;
}

int processStartTicks(String directory) {
  final text = File(p.join(directory, 'stat')).readAsStringSync();
  return int.parse(text.substring(text.lastIndexOf(')') + 2).split(_spaces)[19]);
}
