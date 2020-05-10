library di.errors;

import 'key.dart';

abstract class BaseError extends Error {
  final String message;
  BaseError(this.message);
  String toString() => message;
}

final List<Key> PRIMITIVE_TYPES = <Key>[
    new Key(num), new Key(int), new Key(double), new Key(String),
    new Key(bool), new Key(dynamic)
];

class DynamicReflectorError extends BaseError {
  DynamicReflectorError(String message) : super(message);
}

abstract class ResolvingError extends Error {

  List<Key> keys;
  ResolvingError(Key key): keys = <Key>[key];

  String get resolveChain {
    StringBuffer buffer = new StringBuffer()
        ..write("(resolving ")
        ..write(keys.reversed.join(" -> "))
        ..write(")");
    return buffer.toString();
  }

  void appendKey(Key key) {
   keys.add(key);
  }

  String toString();
}

class NoProviderError extends ResolvingError {
  NoProviderError(Key key): super(key);

  String toString(){
    var root = keys.first;
    if (PRIMITIVE_TYPES.contains(root)) {
      return "Cannot inject a primitive type of $root! $resolveChain";
    }
    return "No provider found for $root! $resolveChain";
  }
}

class CircularDependencyError extends ResolvingError {
  CircularDependencyError(Key key) : super(key);
  String toString() => "Cannot resolve a circular dependency! $resolveChain";
}

class NoGeneratedTypeFactoryError extends BaseError {
  NoGeneratedTypeFactoryError(Type type): super(type.toString());
  String toString() =>
      "Type '$message' not found in generated typeFactory maps. Is the type's "
      "constructor injectable and annotated for injection?";
}
