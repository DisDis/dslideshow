import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:dslideshow_common/serializers.dart';
import 'package:source_gen/source_gen.dart';

class RpcSerializersGenerator extends GeneratorForAnnotation<RpcSerializers> {
  const RpcSerializersGenerator() : super(inPackage: 'dslideshow_common');

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! TopLevelVariableElement ||
        (!element.isFinal && !element.isConst) ||
        !const TypeChecker.typeNamed(
          Serializers,
          inPackage: 'dslideshow_common',
        ).isExactlyType(element.type)) {
      throw InvalidGenerationSourceError(
        '@RpcSerializers requires a top-level final Serializers variable.',
        element: element,
      );
    }

    final library = element.library;
    final types = <InterfaceType>[];
    final references = <String>[];
    final names = <String>{};
    for (final entry in annotation.read('types').listValue) {
      final type = entry.toTypeValue();
      if (type is! InterfaceType ||
          type.element is! ClassElement ||
          type.element.typeParameters.isNotEmpty ||
          type.nullabilitySuffix != NullabilitySuffix.none ||
          type.alias != null) {
        throw InvalidGenerationSourceError(
          'Invalid RPC type $type. Register non-nullable, non-generic classes directly; '
          'typedefs and other Type values are not supported.',
          element: element,
        );
      }
      final name = type.element.name!;
      if (!names.add(name)) {
        throw InvalidGenerationSourceError(
          'Duplicate RPC wire tag "$name". '
          'Register each class once and use distinct class names.',
          element: element,
        );
      }
      for (final previous in types) {
        if (library.typeSystem.isSubtypeOf(type, previous) ||
            library.typeSystem.isSubtypeOf(previous, type)) {
          throw InvalidGenerationSourceError(
            'Overlapping RPC types ${previous.element.name} and $name: '
            'register independent payload classes, not both a base and subtype.',
            element: element,
          );
        }
      }
      _validateJson(type, library, element);
      types.add(type);
      references.add(_referenceFor(type.element, library, element));
    }

    final serializers = element.type as InterfaceType;
    final interface = _referenceFor(serializers.element, library, element);
    final variable = element.name!;
    final implementation = '_\$${variable}RpcSerializers';
    final output = StringBuffer('''
const $interface _\$$variable = $implementation();

class $implementation implements $interface {
  const $implementation();

  @override
  Object? serialize<T>(T object) {
''');
    for (var index = 0; index < types.length; index++) {
      final tag = _wireTag(types[index]);
      output.writeln(
        'if (object is ${references[index]}) '
        'return [$tag, object.toJson()];',
      );
    }
    output.write(r'''
    throw ArgumentError('Not found serializer for "$T"');
  }

  @override
  Object? deserialize(Object? object) {
    if (object is List) {
      return _deserializeByType(object[0], object[1]);
    }
    throw ArgumentError('Not found deserialize for "$object"');
  }

  Object? _deserializeByType(String typeName, Map<String, dynamic> object) {
    switch (typeName) {
''');
    for (var index = 0; index < types.length; index++) {
      final tag = _wireTag(types[index]);
      output.writeln(
        'case $tag: return ${references[index]}.fromJson(object);',
      );
    }
    output.write(r'''
      default:
        throw ArgumentError('Not found deserialize for "$typeName"');
    }
  }
}
''');
    return output.toString();
  }

  void _validateJson(
    InterfaceType type,
    LibraryElement library,
    Element target,
  ) {
    final name = type.element.name;
    final map = library.typeProvider.mapType(
      library.typeProvider.stringType,
      library.typeProvider.dynamicType,
    );
    final toJson = type.lookUpMethod('toJson', library);
    if (toJson == null ||
        toJson.isStatic ||
        toJson.typeParameters.isNotEmpty ||
        toJson.formalParameters.any((parameter) => parameter.isRequired) ||
        toJson.returnType is! InterfaceType ||
        !library.typeSystem.isSubtypeOf(toJson.returnType, map)) {
      throw InvalidGenerationSourceError(
        '$name must expose an instance toJson() returning Map<String, dynamic>.',
        element: target,
      );
    }

    final constructor = type.element.getNamedConstructor('fromJson');
    final method = type.getMethod('fromJson');
    final ExecutableElement? fromJson =
        constructor ?? (method != null && method.isStatic ? method : null);
    if (fromJson == null ||
        (constructor != null &&
            !constructor.isFactory &&
            (type.element as ClassElement).isAbstract) ||
        fromJson.typeParameters.isNotEmpty ||
        fromJson.formalParameters.isEmpty ||
        !fromJson.formalParameters.first.isPositional ||
        !library.typeSystem.isSubtypeOf(
          map,
          fromJson.formalParameters.first.type,
        ) ||
        fromJson.formalParameters
            .skip(1)
            .any((parameter) => parameter.isRequired) ||
        !library.typeSystem.isSubtypeOf(fromJson.returnType, type)) {
      throw InvalidGenerationSourceError(
        '$name must expose a fromJson(Map<String, dynamic>) constructor or '
        'static method returning $name, without other required arguments.',
        element: target,
      );
    }
  }

  String _wireTag(InterfaceType type) =>
      jsonEncode(type.element.name).replaceAll(r'$', r'\$');

  String _referenceFor(
    InterfaceElement type,
    LibraryElement library,
    Element target,
  ) {
    final name = type.name!;
    final fragment = library.firstFragment;
    if (fragment.scope.lookup(name).getter == type) return name;
    for (final prefix in fragment.prefixes) {
      if (prefix.scope.lookup(name).getter == type) {
        return '${prefix.name}.$name';
      }
    }
    throw InvalidGenerationSourceError(
      'Import $name into the registry library so generated code can reference it.',
      element: target,
    );
  }
}
