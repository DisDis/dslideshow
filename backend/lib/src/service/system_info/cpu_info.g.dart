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
  Iterable<Object?> serialize(Serializers serializers, CpuInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
  CpuInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CpuInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'cores':
          result.cores = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'hardware':
          result.hardware = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'model':
          result.model = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'revision':
          result.revision = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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
      (new CpuInfoBuilder()..update(updates))._build();

  _$CpuInfo._(
      {required this.cores,
      required this.hardware,
      required this.model,
      required this.revision})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(cores, r'CpuInfo', 'cores');
    BuiltValueNullFieldError.checkNotNull(hardware, r'CpuInfo', 'hardware');
    BuiltValueNullFieldError.checkNotNull(model, r'CpuInfo', 'model');
    BuiltValueNullFieldError.checkNotNull(revision, r'CpuInfo', 'revision');
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
    var _$hash = 0;
    _$hash = $jc(_$hash, cores.hashCode);
    _$hash = $jc(_$hash, hardware.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, revision.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CpuInfo')
          ..add('cores', cores)
          ..add('hardware', hardware)
          ..add('model', model)
          ..add('revision', revision))
        .toString();
  }
}

class CpuInfoBuilder implements Builder<CpuInfo, CpuInfoBuilder> {
  _$CpuInfo? _$v;

  int? _cores;
  int? get cores => _$this._cores;
  set cores(int? cores) => _$this._cores = cores;

  String? _hardware;
  String? get hardware => _$this._hardware;
  set hardware(String? hardware) => _$this._hardware = hardware;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  String? _revision;
  String? get revision => _$this._revision;
  set revision(String? revision) => _$this._revision = revision;

  CpuInfoBuilder();

  CpuInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cores = $v.cores;
      _hardware = $v.hardware;
      _model = $v.model;
      _revision = $v.revision;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CpuInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CpuInfo;
  }

  @override
  void update(void Function(CpuInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CpuInfo build() => _build();

  _$CpuInfo _build() {
    final _$result = _$v ??
        new _$CpuInfo._(
            cores: BuiltValueNullFieldError.checkNotNull(
                cores, r'CpuInfo', 'cores'),
            hardware: BuiltValueNullFieldError.checkNotNull(
                hardware, r'CpuInfo', 'hardware'),
            model: BuiltValueNullFieldError.checkNotNull(
                model, r'CpuInfo', 'model'),
            revision: BuiltValueNullFieldError.checkNotNull(
                revision, r'CpuInfo', 'revision'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
