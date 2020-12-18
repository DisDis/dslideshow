// GENERATED CODE - DO NOT MODIFY BY HAND

part of rpc.error;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<ErrorResult> _$errorResultSerializer = new _$ErrorResultSerializer();

class _$ErrorResultSerializer implements StructuredSerializer<ErrorResult> {
  @override
  final Iterable<Type> types = const [ErrorResult, _$ErrorResult];
  @override
  final String wireName = 'ErrorResult';

  @override
  Iterable serialize(Serializers serializers, ErrorResult object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'error',
      serializers.serialize(object.error,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  ErrorResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ErrorResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
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

  factory _$ErrorResult([void updates(ErrorResultBuilder b)?]) =>
      (new ErrorResultBuilder()..update(updates)).build();

  _$ErrorResult._({this.error, this.id}) : super._() {
    if (error == null)
      throw new BuiltValueNullFieldError('ErrorResult', 'error');
    if (id == null) throw new BuiltValueNullFieldError('ErrorResult', 'id');
  }

  @override
  ErrorResult rebuild(void updates(ErrorResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorResultBuilder toBuilder() => new ErrorResultBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ErrorResult) return false;
    return error == other.error && id == other.id;
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
  _$ErrorResult _$v;

  String _error;
  String get error => _$this._error;
  set error(String error) => _$this._error = error;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  ErrorResultBuilder();

  ErrorResultBuilder get _$this {
    if (_$v != null) {
      _error = _$v.error;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorResult other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ErrorResult;
  }

  @override
  void update(void updates(ErrorResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ErrorResult build() {
    final _$result = _$v ?? new _$ErrorResult._(error: error, id: id);
    replace(_$result);
    return _$result;
  }
}
