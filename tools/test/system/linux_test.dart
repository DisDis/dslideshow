import 'dart:io';

import 'package:dslideshow_tools/src/repository.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  final repository = findRepository();
  for (final package in ['dslideshow_flutter', 'config_app']) {
    group(package, () {
      late Directory root;
      late Directory pc;
      setUp(() async {
        root = await Directory.systemTemp.createTemp('linux-fixture-');
        pc = await Directory(p.join(root.path, 'pkgconfig')).create();
        final dependencies = p.join(repository.path, package, 'linux/cmake/LinuxDependencies.cmake');
        await File(p.join(root.path, 'CMakeLists.txt')).writeAsString('''cmake_minimum_required(VERSION 3.13)
project(dependency_check LANGUAGES NONE)
include("$dependencies")
file(GENERATE OUTPUT "\${CMAKE_BINARY_DIR}/includes.txt" CONTENT "\$<TARGET_PROPERTY:PkgConfig::GTK,INTERFACE_INCLUDE_DIRECTORIES>")
foreach(prefix mpv epoxy)
if(TARGET PkgConfig::\${prefix})
file(GENERATE OUTPUT "\${CMAKE_BINARY_DIR}/\${prefix}.txt" CONTENT "\$<TARGET_PROPERTY:PkgConfig::\${prefix},INTERFACE_INCLUDE_DIRECTORIES>\\n\$<TARGET_PROPERTY:PkgConfig::\${prefix},INTERFACE_LINK_LIBRARIES>")
endif()
endforeach()
''');
      });
      tearDown(() => root.delete(recursive: true));
      Future<void> packages(String headers, {bool video = false}) async {
        for (final module in ['gtk+-3.0', 'glib-2.0', 'gio-2.0', 'mpv', 'epoxy']) {
          final library = video && ['mpv', 'epoxy'].contains(module);
          if (library) await File(p.join(headers, 'libfixture_$module.so')).writeAsString('');
          await File(p.join(pc.path, '$module.pc')).writeAsString(
            'Name: $module\nDescription: fixture\nVersion: 3.0.0\nCflags: -I$headers\nLibs: ${library ? '-L$headers -lfixture_$module' : ''}\n',
          );
        }
      }

      Future<ProcessResult> configure() => Process.run(
        'cmake',
        ['-S', root.path, '-B', p.join(root.path, 'build')],
        environment: {'PKG_CONFIG_PATH': '', 'PKG_CONFIG_LIBDIR': pc.path, 'PKG_CONFIG_SYSROOT_DIR': ''},
      );
      String output(ProcessResult result) => '${result.stdout}${result.stderr}';
      test('missing GTK has actionable package instructions', () async {
        final result = await configure();
        expect(result.exitCode, isNonZero);
        expect(output(result), contains('Missing Linux development dependency: gtk+-3.0'));
        expect(output(result), contains('libgtk-3-dev'));
      });
      test('invalid headers fail and reconfigure refreshes cache', () async {
        final old = Directory(p.join(root.path, 'old-headers'));
        await packages(old.path);
        final broken = await configure();
        expect(broken.exitCode, isNonZero);
        expect(output(broken), contains('pkg-config reports a missing include directory'));
        await old.create();
        expect((await configure()).exitCode, 0);
        final fresh = await old.rename(p.join(root.path, 'new-headers'));
        await packages(fresh.path);
        expect((await configure()).exitCode, 0);
        final includes = await File(p.join(root.path, 'build/includes.txt')).readAsString();
        expect(includes, contains(fresh.path));
        expect(includes, isNot(contains(old.path)));
      });
      if (package == 'config_app') {
        test('video requirements and cached libraries track installed packages', () async {
          final old = await Directory(p.join(root.path, 'old-video')).create();
          await packages(old.path, video: true);
          expect((await configure()).exitCode, 0);
          final fresh = await old.rename(p.join(root.path, 'new-video'));
          await packages(fresh.path, video: true);
          expect((await configure()).exitCode, 0);
          for (final module in ['mpv', 'epoxy']) {
            final result = await File(p.join(root.path, 'build/$module.txt')).readAsString();
            expect(result, contains(p.join(fresh.path, 'libfixture_$module.so')));
            expect(result, isNot(contains(old.path)));
            await File(p.join(pc.path, '$module.pc')).delete();
            final missing = await configure();
            expect(missing.exitCode, isNonZero);
            expect(output(missing), contains('Missing Linux development dependency: $module'));
            expect(output(missing), contains('libmpv-dev libepoxy-dev'));
            await packages(fresh.path, video: true);
          }
        });
      }
      test('real C++ host environment keeps custom paths and restores Snap paths idempotently', () async {
        const gtk = [
          'GSETTINGS_SCHEMA_DIR',
          'GTK_PATH',
          'GTK_EXE_PREFIX',
          'GTK_IM_MODULE_FILE',
          'GDK_PIXBUF_MODULE_FILE',
          'GDK_PIXBUF_MODULEDIR',
        ];
        const keys = [...gtk, 'XDG_DATA_DIRS', 'XDG_DATA_DIRS_VSCODE_SNAP_ORIG', 'GDK_BACKEND'];
        final source = File(p.join(root.path, 'check.cc'));
        await source.writeAsString('''#include "host_environment.h"
#include <glib.h>
int main() { configure_host_gtk_environment(); configure_host_gtk_environment();
const char* keys[] = {${keys.map((key) => '"$key"').join(',')}};
for (const char* key : keys) { const char* value = g_getenv(key); if(value) g_print("%s=%s\\n", key, value); }
}
''');
        final flags = await Process.run('pkg-config', ['--cflags', '--libs', 'glib-2.0']);
        expect(flags.exitCode, 0);
        final binary = p.join(root.path, 'check');
        final compile = await Process.run('clang++', [
          '-std=c++14',
          '-Wall',
          '-Wextra',
          '-Werror',
          '-I',
          p.join(repository.path, package, 'linux/runner'),
          source.path,
          p.join(repository.path, package, 'linux/runner/host_environment.cc'),
          '-o',
          binary,
          ...'${flags.stdout}'.trim().split(' ').where((value) => value.isNotEmpty),
        ]);
        expect(compile.exitCode, 0, reason: output(compile));
        Future<Map<String, String>> run(Map<String, String> values) async {
          final env = Map<String, String>.of(Platform.environment)..removeWhere((key, _) => keys.contains(key));
          env.addAll(values);
          final result = await Process.run(binary, [], environment: env, includeParentEnvironment: false);
          expect(result.exitCode, 0);
          return {
            for (final line in '${result.stdout}'.trim().split('\n').where((line) => line.isNotEmpty))
              line.substring(0, line.indexOf('=')): line.substring(line.indexOf('=') + 1),
          };
        }

        final custom = {
          for (final key in gtk) key: '/custom/$key',
          'XDG_DATA_DIRS': '/custom/data:/usr/share',
          'GDK_BACKEND': 'wayland',
        };
        expect(await run(custom), custom);
        final empty = {
          'XDG_DATA_DIRS_VSCODE_SNAP_ORIG': '',
          'XDG_DATA_DIRS': '/custom/data',
          'GSETTINGS_SCHEMA_DIR': '/custom/schemas',
        };
        expect(await run(empty), empty);
        expect(
          await run({
            for (final key in gtk) key: '/snap/code/271/$key',
            'XDG_DATA_DIRS': '/snap/code/271/usr/share:/usr/share',
            'XDG_DATA_DIRS_VSCODE_SNAP_ORIG': '/usr/local/share:/usr/share',
            'GDK_BACKEND': 'wayland',
          }),
          {'XDG_DATA_DIRS': '/usr/local/share:/usr/share', 'GDK_BACKEND': 'wayland'},
        );
      });
    });
  }
}
