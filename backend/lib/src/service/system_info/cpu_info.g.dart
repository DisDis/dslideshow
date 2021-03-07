// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cpu_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CpuInfo> _$cpuInfoSerializer = new _$CpuInfoSerializer();

class _$CpuInfoSerializer implements StructuredSerializer<CpuInfo> {
  @override
  final Iterable<Type> types = const [CpuInfo, _$CpuInfo];
  @override
  final String wireName = 'CpuInfo';

  @override
  Iterable<Object> serialize(Serializers serializers, CpuInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'cores',
      serializers.serialize(object.cores, specifiedType: const FullType(int)),
      'hardware',
      serializers.serialize(object.hardware,
          specifiedType: const FullType(String)),
      'model',
      serializers.serialize(object.model,
          specifiedType: const FullType(String)),
      'revision',
      serializers.serialize(object.revision,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  CpuInfo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CpuInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'cores':
          result.cores = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'hardware':
          result.hardware = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'model':
          result.model = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'revision':
          result.revision = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CpuInfo extends CpuInfo {
  @override
  final int cores;
  @override
  final String hardware;
  @override
  final String model;
  @override
  final String revision;

  factory _$CpuInfo([void Function(CpuInfoBuilder)? updates]) =>
      (new CpuInfoBuilder()..update(updates)).build();

  _$CpuInfo._({this.cores, this.hardware, this.model, this.revision})
      : super._() {
    if (cores == null) {
      throw new BuiltValueNullFieldError('CpuInfo', 'cores');
    }
    if (hardware == null) {
      throw new BuiltValueNullFieldError('CpuInfo', 'hardware');
    }
    if (model == null) {
      throw new BuiltValueNullFieldError('CpuInfo', 'model');
    }
    if (revision == null) {
      throw new BuiltValueNullFieldError('CpuInfo', 'revision');
    }
  }

  @override
  CpuInfo rebuild(void Function(CpuInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CpuInfoBuilder toBuilder() => new CpuInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CpuInfo &&
        cores == other.cores &&
        hardware == other.hardware &&
        model == other.model &&
        revision == other.revision;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, cores.hashCode), hardware.hashCode), model.hashCode),
        revision.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CpuInfo')
          ..add('cores', cores)
          ..add('hardware', hardware)
          ..add('model', model)
          ..add('revision', revision))
        .toString();
  }
}

class CpuInfoBuilder implements Builder<CpuInfo, CpuInfoBuilder> {
  _$CpuInfo _$v;

  int _cores;
  int get cores => _$this._cores;
  set cores(int cores) => _$this._cores = cores;

  String _hardware;
  String get hardware => _$this._hardware;
  set hardware(String hardware) => _$this._hardware = hardware;

  String _model;
  String get model => _$this._model;
  set model(String model) => _$this._model = model;

  String _revision;
  String get revision => _$this._revision;
  set revision(String revision) => _$this._revision = revision;

  CpuInfoBuilder();

  CpuInfoBuilder get _$this {
    if (_$v != null) {
      _cores = _$v.cores;
      _hardware = _$v.hardware;
      _model = _$v.model;
      _revision = _$v.revision;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CpuInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CpuInfo;
  }

  @override
  void update(void Function(CpuInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CpuInfo build() {
    final _$result = _$v ??
        new _$CpuInfo._(
            cores: cores, hardware: hardware, model: model, revision: revision);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
