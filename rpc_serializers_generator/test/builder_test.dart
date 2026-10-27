import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:rpc_serializers_generator/builder.dart';
import 'package:source_gen/builder.dart';
import 'package:test/test.dart';

const payload = r'''
class EchoCommand {
  final String text;
  EchoCommand(this.text);
  factory EchoCommand.fromJson(Map<String, dynamic> json) =>
      EchoCommand(json['text'] as String);
  Map<String, dynamic> toJson() => {'text': text};
}
''';

String registry(String types, {String declarations = payload}) =>
    '''
import 'package:dslideshow_common/serializers.dart';
part 'registry.g.dart';
@RpcSerializers([$types])
final Serializers serializers = _\$serializers;
$declarations
''';

Future<({TestBuilderResult result, TestReaderWriter assets})> build(
  String source, {
  Map<String, String> libraries = const {},
}) async {
  final assets = TestReaderWriter(rootPackage: 'fixture');
  final result = await testBuilders(
    [rpcSerializersBuilder(BuilderOptions.empty), combiningBuilder()],
    {
      'dslideshow_common|lib/serializers.dart': File(
        '../common/lib/serializers.dart',
      ).readAsStringSync(),
      'fixture|lib/registry.dart': source,
      ...libraries,
    },
    rootPackage: 'fixture',
    readerWriter: assets,
    flattenOutput: true,
  );
  return (result: result, assets: assets);
}

Future<void> runGenerated(
  TestReaderWriter assets,
  Map<String, String> sources,
) async {
  final directory = Directory.systemTemp.createTempSync('rpc-registry-test-');
  addTearDown(() => directory.deleteSync(recursive: true));
  for (final entry in sources.entries) {
    File('${directory.path}/${entry.key}')
      ..parent.createSync(recursive: true)
      ..writeAsStringSync(entry.value);
  }
  File('${directory.path}/lib/registry.g.dart').writeAsStringSync(
    assets.testing.readString(AssetId('fixture', 'lib/registry.g.dart')),
  );
  final configUri = (await Isolate.packageConfig)!;
  final config = jsonDecode(
    File.fromUri(configUri).readAsStringSync(),
  ) as Map<String, dynamic>;
  for (final package in config['packages'] as List) {
    package['rootUri'] = configUri
        .resolve(package['rootUri'] as String)
        .toString();
  }
  (config['packages'] as List).add({
    'name': 'fixture',
    'rootUri': directory.uri.toString(),
    'packageUri': 'lib/',
    'languageVersion': '3.13',
  });
  final configFile = File('${directory.path}/package_config.json')
    ..writeAsStringSync(jsonEncode(config));
  final result = await Process.run(Platform.resolvedExecutable, [
    '--packages=${configFile.path}',
    '${directory.path}/lib/registry.dart',
  ]);
  expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
}

void main() {
  test(
    'generated codec uses declared names and compiles prefixed imports',
    () async {
      final source = r'''
import 'dart:convert';
import 'package:dslideshow_common/serializers.dart' as rpc;
import 'payload.dart' as commands;
part 'registry.g.dart';
@rpc.RpcSerializers([commands.EchoCommand, commands.Result$Value])
final rpc.Serializers serializers = _$serializers;
void main() {
  final Object command = commands.EchoCommand('hello');
  final wire = jsonDecode(jsonEncode(serializers.serialize<Object>(command)));
  if (jsonEncode(wire) != '["EchoCommand",{"text":"hello"}]') {
    throw StateError('Unexpected wire tag: $wire');
  }
  final decoded = serializers.deserialize(wire) as commands.EchoCommand;
  if (decoded.text != 'hello') throw StateError('Lost payload');
  final result = serializers.serialize(commands.Result$Value());
  if ((result as List).first != r'Result$Value') throw StateError('Wrong tag');
  if (serializers.deserialize(result) is! commands.Result$Value) {
    throw StateError('Wrong decoded type');
  }
}
''';
      final models =
          payload +
          r'''
class Result$Value {
  Result$Value();
  static Result$Value fromJson(Map<String, dynamic> json) => Result$Value();
  Map<String, dynamic> toJson() => {};
}
''';
      final output = await build(
        source,
        libraries: {'fixture|lib/payload.dart': models},
      );
      expect(
        output.result.succeeded,
        isTrue,
        reason: output.result.errors.join('\n'),
      );
      await runGenerated(output.assets, {
        'lib/registry.dart': source,
        'lib/payload.dart': models,
      });
    },
  );

  test('supports redirecting factories and inherited toJson', () async {
    final source = registry(
      'EchoCommand',
      declarations: r'''
abstract class JsonPayload {
  Map<String, dynamic> toJson() => {'text': 'redirected'};
}
abstract class EchoCommand extends JsonPayload {
  EchoCommand();
  factory EchoCommand.fromJson(Map<String, dynamic> json) = _EchoCommand;
}
class _EchoCommand extends EchoCommand {
  _EchoCommand(Map<String, dynamic> json);
}
void main() {
  final value = serializers.deserialize(['EchoCommand', <String, dynamic>{}]);
  if (value is! EchoCommand) throw StateError('Factory failed');
  final wire = serializers.serialize<Object?>(value) as List;
  if (wire.first != 'EchoCommand') throw StateError('Used runtime type');
}
''',
    );
    final output = await build(source);
    expect(
      output.result.succeeded,
      isTrue,
      reason: output.result.errors.join('\n'),
    );
    await runGenerated(output.assets, {'lib/registry.dart': source});
  });

  test('empty registry builds and rejects unregistered values', () async {
    final source = registry(
      '',
      declarations: r'''
void main() {
  try { serializers.serialize(42); } on ArgumentError { return; }
  throw StateError('Unregistered value was accepted');
}
''',
    );
    final output = await build(source);
    expect(
      output.result.succeeded,
      isTrue,
      reason: output.result.errors.join('\n'),
    );
    await runGenerated(output.assets, {'lib/registry.dart': source});
  });

  test('regeneration follows a changed type list', () async {
    final withType = await build(registry('EchoCommand'));
    final withoutType = await build(registry(''));
    expect(withType.result.succeeded, isTrue);
    expect(withoutType.result.succeeded, isTrue);
    final id = AssetId('fixture', 'lib/registry.g.dart');
    expect(
      withType.assets.testing.readString(id),
      contains('EchoCommand.fromJson'),
    );
    expect(
      withoutType.assets.testing.readString(id),
      isNot(contains('EchoCommand')),
    );
  });

  test(
    'multiple registries use their own variable and implementation names',
    () async {
      final source =
          registry('EchoCommand') +
          r'''
@RpcSerializers([])
const Serializers empty = _$empty;
void main() {
  final wire = serializers.serialize(EchoCommand('hello')) as List;
  if (wire.first != 'EchoCommand') throw StateError('Wrong registry');
  try { empty.serialize(EchoCommand('hello')); } on ArgumentError { return; }
  throw StateError('Registries share registrations');
}
''';
      final output = await build(source);
      expect(
        output.result.succeeded,
        isTrue,
        reason: output.result.errors.join('\n'),
      );
      await runGenerated(output.assets, {'lib/registry.dart': source});
    },
  );

  final invalid = <String, (String, String)>{
    'duplicate type': (
      registry('EchoCommand, EchoCommand'),
      'Duplicate RPC wire tag',
    ),
    'generic class': (registry('List'), 'non-generic classes'),
    'non-class Type': (registry('dynamic'), 'non-generic classes'),
    'typedef': (
      registry('Alias', declarations: '$payload\ntypedef Alias = EchoCommand;'),
      'typedefs',
    ),
    'missing toJson': (
      registry(
        'EchoCommand',
        declarations: payload.replaceFirst('toJson()', 'asJson()'),
      ),
      'instance toJson()',
    ),
    'static toJson': (
      registry(
        'EchoCommand',
        declarations: '''
class EchoCommand {
  EchoCommand.fromJson(Map<String, dynamic> json);
  static Map<String, dynamic> toJson() => {};
}
''',
      ),
      'instance toJson()',
    ),
    'wrong toJson return': (
      registry(
        'EchoCommand',
        declarations: payload.replaceFirst(
          "Map<String, dynamic> toJson() => {'text': text};",
          "String toJson() => text;",
        ),
      ),
      'instance toJson()',
    ),
    'missing fromJson': (
      registry(
        'EchoCommand',
        declarations: payload.replaceFirst(
          'EchoCommand.fromJson',
          'EchoCommand.fromMap',
        ),
      ),
      'fromJson(Map<String, dynamic>)',
    ),
    'wrong fromJson parameter': (
      registry(
        'EchoCommand',
        declarations: '''
class EchoCommand {
  EchoCommand.fromJson(String value);
  Map<String, dynamic> toJson() => {};
}
''',
      ),
      'fromJson(Map<String, dynamic>)',
    ),
    'extra required fromJson argument': (
      registry(
        'EchoCommand',
        declarations: '''
class EchoCommand {
  EchoCommand.fromJson(Map<String, dynamic> json, {required int version});
  Map<String, dynamic> toJson() => {};
}
''',
      ),
      'fromJson(Map<String, dynamic>)',
    ),
    'wrong static fromJson result': (
      registry(
        'EchoCommand',
        declarations: '''
class EchoCommand {
  static String fromJson(Map<String, dynamic> json) => 'wrong';
  Map<String, dynamic> toJson() => {};
}
''',
      ),
      'fromJson(Map<String, dynamic>)',
    ),
    'instance fromJson': (
      registry(
        'EchoCommand',
        declarations: '''
class EchoCommand {
  EchoCommand fromJson(Map<String, dynamic> json) => this;
  Map<String, dynamic> toJson() => {};
}
''',
      ),
      'fromJson(Map<String, dynamic>)',
    ),
    'abstract generative constructor': (
      registry(
        'EchoCommand',
        declarations: '''
abstract class EchoCommand {
  EchoCommand.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson() => {};
}
''',
      ),
      'fromJson(Map<String, dynamic>)',
    ),
    'required toJson parameter': (
      registry(
        'EchoCommand',
        declarations: payload.replaceFirst('toJson()', 'toJson(int required)'),
      ),
      'instance toJson()',
    ),
    'wrong variable type': (
      registry('EchoCommand').replaceFirst(
        'final Serializers serializers',
        'final Object serializers',
      ),
      'top-level final Serializers',
    ),
    'mutable variable': (
      registry('EchoCommand').replaceFirst('final Serializers', 'Serializers'),
      'top-level final Serializers',
    ),
    'overlapping classes': (
      registry(
        'EchoCommand, Derived',
        declarations:
            '''
$payload
class Derived extends EchoCommand {
  Derived.fromJson(Map<String, dynamic> json) : super(json['text'] as String);
}
''',
      ),
      'Overlapping RPC types',
    ),
  };
  for (final entry in invalid.entries) {
    test('reports ${entry.key} during generation', () async {
      final output = await build(entry.value.$1);
      expect(output.result.succeeded, isFalse);
      expect(output.result.errors.join('\n'), contains(entry.value.$2));
      expect(
        output.assets.testing.exists(AssetId('fixture', 'lib/registry.g.dart')),
        isFalse,
      );
    });
  }

  test('same class names in different libraries are rejected', () async {
    final output = await build(
      registry('a.EchoCommand, b.EchoCommand', declarations: '').replaceFirst(
        "part 'registry.g.dart';",
        "import 'a.dart' as a;\nimport 'b.dart' as b;\npart 'registry.g.dart';",
      ),
      libraries: {'fixture|lib/a.dart': payload, 'fixture|lib/b.dart': payload},
    );
    expect(output.result.succeeded, isFalse);
    expect(
      output.result.errors.join('\n'),
      contains('Duplicate RPC wire tag "EchoCommand"'),
    );
  });
}
