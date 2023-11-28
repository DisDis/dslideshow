// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UpdateInfo> _$updateInfoSerializer = new _$UpdateInfoSerializer();

class _$UpdateInfoSerializer implements StructuredSerializer<UpdateInfo> {
  @override
  final Iterable<Type> types = const [UpdateInfo, _$UpdateInfo];
  @override
  final String wireName = 'UpdateInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, UpdateInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.cpuLoad1;
    if (value != null) {
      result
        ..add('cpuLoad1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.cpuLoad15;
    if (value != null) {
      result
        ..add('cpuLoad15')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.cpuLoad5;
    if (value != null) {
      result
        ..add('cpuLoad5')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.diskAvailable;
    if (value != null) {
      result
        ..add('diskAvailable')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.diskUsed;
    if (value != null) {
      result
        ..add('diskUsed')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.diskUsedPercent;
    if (value != null) {
      result
        ..add('diskUsedPercent')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.lastUpdate;
    if (value != null) {
      result
        ..add('lastUpdate')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.memTotal;
    if (value != null) {
      result
        ..add('memTotal')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.memUsed;
    if (value != null) {
      result
        ..add('memUsed')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.sensors;
    if (value != null) {
      result
        ..add('sensors')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(SensorInfo)])));
    }
    value = object.swapTotal;
    if (value != null) {
      result
        ..add('swapTotal')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.swapUsed;
    if (value != null) {
      result
        ..add('swapUsed')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.uptime;
    if (value != null) {
      result
        ..add('uptime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UpdateInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UpdateInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'cpuLoad1':
          result.cpuLoad1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'cpuLoad15':
          result.cpuLoad15 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'cpuLoad5':
          result.cpuLoad5 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'diskAvailable':
          result.diskAvailable = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'diskUsed':
          result.diskUsed = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'diskUsedPercent':
          result.diskUsedPercent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'lastUpdate':
          result.lastUpdate = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'memTotal':
          result.memTotal = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'memUsed':
          result.memUsed = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'sensors':
          result.sensors.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SensorInfo)]))!
              as BuiltList<Object?>);
          break;
        case 'swapTotal':
          result.swapTotal = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'swapUsed':
          result.swapUsed = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'uptime':
          result.uptime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$UpdateInfo extends UpdateInfo {
  @override
  final double? cpuLoad1;
  @override
  final double? cpuLoad15;
  @override
  final double? cpuLoad5;
  @override
  final int? diskAvailable;
  @override
  final int? diskUsed;
  @override
  final int? diskUsedPercent;
  @override
  final int? lastUpdate;
  @override
  final int? memTotal;
  @override
  final int? memUsed;
  @override
  final BuiltList<SensorInfo>? sensors;
  @override
  final int? swapTotal;
  @override
  final int? swapUsed;
  @override
  final String? uptime;

  factory _$UpdateInfo([void Function(UpdateInfoBuilder)? updates]) =>
      (new UpdateInfoBuilder()..update(updates))._build();

  _$UpdateInfo._(
      {this.cpuLoad1,
      this.cpuLoad15,
      this.cpuLoad5,
      this.diskAvailable,
      this.diskUsed,
      this.diskUsedPercent,
      this.lastUpdate,
      this.memTotal,
      this.memUsed,
      this.sensors,
      this.swapTotal,
      this.swapUsed,
      this.uptime})
      : super._();

  @override
  UpdateInfo rebuild(void Function(UpdateInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateInfoBuilder toBuilder() => new UpdateInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateInfo &&
        cpuLoad1 == other.cpuLoad1 &&
        cpuLoad15 == other.cpuLoad15 &&
        cpuLoad5 == other.cpuLoad5 &&
        diskAvailable == other.diskAvailable &&
        diskUsed == other.diskUsed &&
        diskUsedPercent == other.diskUsedPercent &&
        lastUpdate == other.lastUpdate &&
        memTotal == other.memTotal &&
        memUsed == other.memUsed &&
        sensors == other.sensors &&
        swapTotal == other.swapTotal &&
        swapUsed == other.swapUsed &&
        uptime == other.uptime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cpuLoad1.hashCode);
    _$hash = $jc(_$hash, cpuLoad15.hashCode);
    _$hash = $jc(_$hash, cpuLoad5.hashCode);
    _$hash = $jc(_$hash, diskAvailable.hashCode);
    _$hash = $jc(_$hash, diskUsed.hashCode);
    _$hash = $jc(_$hash, diskUsedPercent.hashCode);
    _$hash = $jc(_$hash, lastUpdate.hashCode);
    _$hash = $jc(_$hash, memTotal.hashCode);
    _$hash = $jc(_$hash, memUsed.hashCode);
    _$hash = $jc(_$hash, sensors.hashCode);
    _$hash = $jc(_$hash, swapTotal.hashCode);
    _$hash = $jc(_$hash, swapUsed.hashCode);
    _$hash = $jc(_$hash, uptime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateInfo')
          ..add('cpuLoad1', cpuLoad1)
          ..add('cpuLoad15', cpuLoad15)
          ..add('cpuLoad5', cpuLoad5)
          ..add('diskAvailable', diskAvailable)
          ..add('diskUsed', diskUsed)
          ..add('diskUsedPercent', diskUsedPercent)
          ..add('lastUpdate', lastUpdate)
          ..add('memTotal', memTotal)
          ..add('memUsed', memUsed)
          ..add('sensors', sensors)
          ..add('swapTotal', swapTotal)
          ..add('swapUsed', swapUsed)
          ..add('uptime', uptime))
        .toString();
  }
}

class UpdateInfoBuilder implements Builder<UpdateInfo, UpdateInfoBuilder> {
  _$UpdateInfo? _$v;

  double? _cpuLoad1;
  double? get cpuLoad1 => _$this._cpuLoad1;
  set cpuLoad1(double? cpuLoad1) => _$this._cpuLoad1 = cpuLoad1;

  double? _cpuLoad15;
  double? get cpuLoad15 => _$this._cpuLoad15;
  set cpuLoad15(double? cpuLoad15) => _$this._cpuLoad15 = cpuLoad15;

  double? _cpuLoad5;
  double? get cpuLoad5 => _$this._cpuLoad5;
  set cpuLoad5(double? cpuLoad5) => _$this._cpuLoad5 = cpuLoad5;

  int? _diskAvailable;
  int? get diskAvailable => _$this._diskAvailable;
  set diskAvailable(int? diskAvailable) =>
      _$this._diskAvailable = diskAvailable;

  int? _diskUsed;
  int? get diskUsed => _$this._diskUsed;
  set diskUsed(int? diskUsed) => _$this._diskUsed = diskUsed;

  int? _diskUsedPercent;
  int? get diskUsedPercent => _$this._diskUsedPercent;
  set diskUsedPercent(int? diskUsedPercent) =>
      _$this._diskUsedPercent = diskUsedPercent;

  int? _lastUpdate;
  int? get lastUpdate => _$this._lastUpdate;
  set lastUpdate(int? lastUpdate) => _$this._lastUpdate = lastUpdate;

  int? _memTotal;
  int? get memTotal => _$this._memTotal;
  set memTotal(int? memTotal) => _$this._memTotal = memTotal;

  int? _memUsed;
  int? get memUsed => _$this._memUsed;
  set memUsed(int? memUsed) => _$this._memUsed = memUsed;

  ListBuilder<SensorInfo>? _sensors;
  ListBuilder<SensorInfo> get sensors =>
      _$this._sensors ??= new ListBuilder<SensorInfo>();
  set sensors(ListBuilder<SensorInfo>? sensors) => _$this._sensors = sensors;

  int? _swapTotal;
  int? get swapTotal => _$this._swapTotal;
  set swapTotal(int? swapTotal) => _$this._swapTotal = swapTotal;

  int? _swapUsed;
  int? get swapUsed => _$this._swapUsed;
  set swapUsed(int? swapUsed) => _$this._swapUsed = swapUsed;

  String? _uptime;
  String? get uptime => _$this._uptime;
  set uptime(String? uptime) => _$this._uptime = uptime;

  UpdateInfoBuilder();

  UpdateInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cpuLoad1 = $v.cpuLoad1;
      _cpuLoad15 = $v.cpuLoad15;
      _cpuLoad5 = $v.cpuLoad5;
      _diskAvailable = $v.diskAvailable;
      _diskUsed = $v.diskUsed;
      _diskUsedPercent = $v.diskUsedPercent;
      _lastUpdate = $v.lastUpdate;
      _memTotal = $v.memTotal;
      _memUsed = $v.memUsed;
      _sensors = $v.sensors?.toBuilder();
      _swapTotal = $v.swapTotal;
      _swapUsed = $v.swapUsed;
      _uptime = $v.uptime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdateInfo;
  }

  @override
  void update(void Function(UpdateInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateInfo build() => _build();

  _$UpdateInfo _build() {
    _$UpdateInfo _$result;
    try {
      _$result = _$v ??
          new _$UpdateInfo._(
              cpuLoad1: cpuLoad1,
              cpuLoad15: cpuLoad15,
              cpuLoad5: cpuLoad5,
              diskAvailable: diskAvailable,
              diskUsed: diskUsed,
              diskUsedPercent: diskUsedPercent,
              lastUpdate: lastUpdate,
              memTotal: memTotal,
              memUsed: memUsed,
              sensors: _sensors?.build(),
              swapTotal: swapTotal,
              swapUsed: swapUsed,
              uptime: uptime);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sensors';
        _sensors?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UpdateInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
