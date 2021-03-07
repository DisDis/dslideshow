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
  Iterable<Object> serialize(Serializers serializers, UpdateInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'cpuLoad1',
      serializers.serialize(object.cpuLoad1,
          specifiedType: const FullType(double)),
      'cpuLoad15',
      serializers.serialize(object.cpuLoad15,
          specifiedType: const FullType(double)),
      'cpuLoad5',
      serializers.serialize(object.cpuLoad5,
          specifiedType: const FullType(double)),
      'diskAvailable',
      serializers.serialize(object.diskAvailable,
          specifiedType: const FullType(int)),
      'diskUsed',
      serializers.serialize(object.diskUsed,
          specifiedType: const FullType(int)),
      'diskUsedPercent',
      serializers.serialize(object.diskUsedPercent,
          specifiedType: const FullType(int)),
      'lastUpdate',
      serializers.serialize(object.lastUpdate,
          specifiedType: const FullType(int)),
      'memTotal',
      serializers.serialize(object.memTotal,
          specifiedType: const FullType(int)),
      'memUsed',
      serializers.serialize(object.memUsed, specifiedType: const FullType(int)),
      'sensors',
      serializers.serialize(object.sensors,
          specifiedType:
              const FullType(BuiltList, const [const FullType(SensorInfo)])),
      'swapTotal',
      serializers.serialize(object.swapTotal,
          specifiedType: const FullType(int)),
      'swapUsed',
      serializers.serialize(object.swapUsed,
          specifiedType: const FullType(int)),
      'uptime',
      serializers.serialize(object.uptime,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  UpdateInfo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UpdateInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'cpuLoad1':
          result.cpuLoad1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'cpuLoad15':
          result.cpuLoad15 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'cpuLoad5':
          result.cpuLoad5 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'diskAvailable':
          result.diskAvailable = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'diskUsed':
          result.diskUsed = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'diskUsedPercent':
          result.diskUsedPercent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'lastUpdate':
          result.lastUpdate = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'memTotal':
          result.memTotal = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'memUsed':
          result.memUsed = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'sensors':
          result.sensors.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SensorInfo)]))
              as BuiltList<dynamic>);
          break;
        case 'swapTotal':
          result.swapTotal = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'swapUsed':
          result.swapUsed = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'uptime':
          result.uptime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UpdateInfo extends UpdateInfo {
  @override
  final double cpuLoad1;
  @override
  final double cpuLoad15;
  @override
  final double cpuLoad5;
  @override
  final int diskAvailable;
  @override
  final int diskUsed;
  @override
  final int diskUsedPercent;
  @override
  final int lastUpdate;
  @override
  final int memTotal;
  @override
  final int memUsed;
  @override
  final BuiltList<SensorInfo> sensors;
  @override
  final int swapTotal;
  @override
  final int swapUsed;
  @override
  final String uptime;

  factory _$UpdateInfo([void Function(UpdateInfoBuilder)? updates]) =>
      (new UpdateInfoBuilder()..update(updates)).build();

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
      : super._() {
    if (cpuLoad1 == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'cpuLoad1');
    }
    if (cpuLoad15 == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'cpuLoad15');
    }
    if (cpuLoad5 == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'cpuLoad5');
    }
    if (diskAvailable == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'diskAvailable');
    }
    if (diskUsed == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'diskUsed');
    }
    if (diskUsedPercent == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'diskUsedPercent');
    }
    if (lastUpdate == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'lastUpdate');
    }
    if (memTotal == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'memTotal');
    }
    if (memUsed == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'memUsed');
    }
    if (sensors == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'sensors');
    }
    if (swapTotal == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'swapTotal');
    }
    if (swapUsed == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'swapUsed');
    }
    if (uptime == null) {
      throw new BuiltValueNullFieldError('UpdateInfo', 'uptime');
    }
  }

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
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc($jc(0, cpuLoad1.hashCode),
                                                    cpuLoad15.hashCode),
                                                cpuLoad5.hashCode),
                                            diskAvailable.hashCode),
                                        diskUsed.hashCode),
                                    diskUsedPercent.hashCode),
                                lastUpdate.hashCode),
                            memTotal.hashCode),
                        memUsed.hashCode),
                    sensors.hashCode),
                swapTotal.hashCode),
            swapUsed.hashCode),
        uptime.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UpdateInfo')
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
  _$UpdateInfo _$v;

  double _cpuLoad1;
  double get cpuLoad1 => _$this._cpuLoad1;
  set cpuLoad1(double cpuLoad1) => _$this._cpuLoad1 = cpuLoad1;

  double _cpuLoad15;
  double get cpuLoad15 => _$this._cpuLoad15;
  set cpuLoad15(double cpuLoad15) => _$this._cpuLoad15 = cpuLoad15;

  double _cpuLoad5;
  double get cpuLoad5 => _$this._cpuLoad5;
  set cpuLoad5(double cpuLoad5) => _$this._cpuLoad5 = cpuLoad5;

  int _diskAvailable;
  int get diskAvailable => _$this._diskAvailable;
  set diskAvailable(int diskAvailable) => _$this._diskAvailable = diskAvailable;

  int _diskUsed;
  int get diskUsed => _$this._diskUsed;
  set diskUsed(int diskUsed) => _$this._diskUsed = diskUsed;

  int _diskUsedPercent;
  int get diskUsedPercent => _$this._diskUsedPercent;
  set diskUsedPercent(int diskUsedPercent) =>
      _$this._diskUsedPercent = diskUsedPercent;

  int _lastUpdate;
  int get lastUpdate => _$this._lastUpdate;
  set lastUpdate(int lastUpdate) => _$this._lastUpdate = lastUpdate;

  int _memTotal;
  int get memTotal => _$this._memTotal;
  set memTotal(int memTotal) => _$this._memTotal = memTotal;

  int _memUsed;
  int get memUsed => _$this._memUsed;
  set memUsed(int memUsed) => _$this._memUsed = memUsed;

  ListBuilder<SensorInfo> _sensors;
  ListBuilder<SensorInfo> get sensors =>
      _$this._sensors ??= new ListBuilder<SensorInfo>();
  set sensors(ListBuilder<SensorInfo> sensors) => _$this._sensors = sensors;

  int _swapTotal;
  int get swapTotal => _$this._swapTotal;
  set swapTotal(int swapTotal) => _$this._swapTotal = swapTotal;

  int _swapUsed;
  int get swapUsed => _$this._swapUsed;
  set swapUsed(int swapUsed) => _$this._swapUsed = swapUsed;

  String _uptime;
  String get uptime => _$this._uptime;
  set uptime(String uptime) => _$this._uptime = uptime;

  UpdateInfoBuilder();

  UpdateInfoBuilder get _$this {
    if (_$v != null) {
      _cpuLoad1 = _$v.cpuLoad1;
      _cpuLoad15 = _$v.cpuLoad15;
      _cpuLoad5 = _$v.cpuLoad5;
      _diskAvailable = _$v.diskAvailable;
      _diskUsed = _$v.diskUsed;
      _diskUsedPercent = _$v.diskUsedPercent;
      _lastUpdate = _$v.lastUpdate;
      _memTotal = _$v.memTotal;
      _memUsed = _$v.memUsed;
      _sensors = _$v.sensors?.toBuilder();
      _swapTotal = _$v.swapTotal;
      _swapUsed = _$v.swapUsed;
      _uptime = _$v.uptime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UpdateInfo;
  }

  @override
  void update(void Function(UpdateInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UpdateInfo build() {
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
              sensors: sensors.build(),
              swapTotal: swapTotal,
              swapUsed: swapUsed,
              uptime: uptime);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'sensors';
        sensors.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UpdateInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
