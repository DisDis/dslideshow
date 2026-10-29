// The fixture delegates real asynchronous filesystem operations.
// ignore_for_file: avoid_slow_async_io
import 'dart:io';

/// Real filesystem access with watcher hints disabled for catalog regressions.
class NoWatchDirectory implements Directory {
  final Directory delegate;
  NoWatchDirectory(Directory directory) : delegate = directory.absolute;

  @override
  String get path => delegate.path;
  @override
  Directory get absolute => this;
  @override
  Future<bool> exists() => delegate.exists();
  @override
  Future<Directory> create({bool recursive = false}) =>
      delegate.create(recursive: recursive);
  @override
  Future<String> resolveSymbolicLinks() => delegate.resolveSymbolicLinks();
  @override
  Stream<FileSystemEvent> watch({
    int events = FileSystemEvent.all,
    bool recursive = false,
  }) => const Stream.empty();
  @override
  Stream<FileSystemEntity> list({
    bool recursive = false,
    bool followLinks = true,
  }) => delegate.list(recursive: recursive, followLinks: followLinks);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
