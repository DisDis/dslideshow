// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EmptyResult> _$emptyResultSerializer = new _$EmptyResultSerializer();

class _$EmptyResultSerializer implements StructuredSerializer<EmptyResult> {
  @override
  final Iterable<Type> types = const [EmptyResult, _$EmptyResult];
  @override
  final String wireName = 'EmptyResult';

  @override
  Iterable<Object?> serialize(Serializers serializers, EmptyResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  EmptyResult deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EmptyResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$EmptyResult extends EmptyResult {
  @override
  final int id;

  factory _$EmptyResult([void Function(EmptyResultBuilder)? updates]) =>
      (new EmptyResultBuilder()..update(updates))._build();

  _$EmptyResult._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'EmptyResult', 'id');
  }

  @override
  EmptyResult rebuild(void Function(EmptyResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmptyResultBuilder toBuilder() => new EmptyResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmptyResult && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EmptyResult')..add('id', id))
        .toString();
  }
}

class EmptyResultBuilder implements Builder<EmptyResult, EmptyResultBuilder> {
  _$EmptyResult? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  EmptyResultBuilder();

  EmptyResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmptyResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$EmptyResult;
  }

  @override
  void update(void Function(EmptyResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EmptyResult build() => _build();

  _$EmptyResult _build() {
    final _$result = _$v ??
        new _$EmptyResult._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'EmptyResult', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
