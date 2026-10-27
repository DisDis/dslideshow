/// Generates a registry for the listed RPC payload classes via build_runner.
///
/// Apply this to a top-level final [Serializers] variable initialized with
/// `_$variableName`. Each class must provide `fromJson` and `toJson`.
/// Its declared class name becomes the wire tag, so renaming a registered
/// class changes the protocol. Import prefixes do not affect the tag.
class RpcSerializers {
  final List<Type> types;

  const RpcSerializers(this.types);
}

abstract class Serializers {
  Object? serialize<T>(T object);
  Object? deserialize(Object? object);
}
