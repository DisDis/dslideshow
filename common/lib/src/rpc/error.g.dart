// GENERATED CODE - DO NOT MODIFY BY HAND

part of rpc.error;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ErrorResult> _$errorResultSerializer = new _$ErrorResultSerializer();

class _$ErrorResultSerializer implements StructuredSerializer<ErrorResult> {
  @override
  final Iterable<Type> types = const [ErrorResult, _$ErrorResult];
  @override
  final String wireName = 'ErrorResult';

  @override
  Iterable<Object?> serialize(Serializers serializers, ErrorResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'error',
      serializers.serialize(object.error,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  ErrorResult deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ErrorResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'error':
          result.error = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ErrorResult extends ErrorResult {
  @override
  final String error;
  @override
  final int id;

  factory _$ErrorResult([void Function(ErrorResultBuilder)? updates]) =>
      (new ErrorResultBuilder()..update(updates)).build();

  _$ErrorResult._({required this.error, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(error, 'ErrorResult', 'error');
    BuiltValueNullFieldError.checkNotNull(id, 'ErrorResult', 'id');
  }

  @override
  ErrorResult rebuild(void Function(ErrorResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorResultBuilder toBuilder() => new ErrorResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorResult && error == other.error && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, error.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ErrorResult')
          ..add('error', error)
          ..add('id', id))
        .toString();
  }
}

class ErrorResultBuilder implements Builder<ErrorResult, ErrorResultBuilder> {
  _$ErrorResult? _$v;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ErrorResultBuilder();

  ErrorResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _error = $v.error;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ErrorResult;
  }

  @override
  void update(void Function(ErrorResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ErrorResult build() {
    final _$result = _$v ??
        new _$ErrorResult._(
            error: BuiltValueNullFieldError.checkNotNull(
                error, 'ErrorResult', 'error'),
            id: BuiltValueNullFieldError.checkNotNull(id, 'ErrorResult', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
