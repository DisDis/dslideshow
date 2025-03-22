// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateInfo {
  double get cpuLoad1;
  double get cpuLoad15;
  double get cpuLoad5;
  int get diskAvailable;
  int get diskUsed;
  int get diskUsedPercent;
  int get lastUpdate;
  int get memTotal;
  int get memUsed;
  List<SensorInfo> get sensors;
  int get swapTotal;
  int get swapUsed;
  String get uptime;

  /// Create a copy of UpdateInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateInfoCopyWith<UpdateInfo> get copyWith =>
      _$UpdateInfoCopyWithImpl<UpdateInfo>(this as UpdateInfo, _$identity);

  /// Serializes this UpdateInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateInfo &&
            (identical(other.cpuLoad1, cpuLoad1) ||
                other.cpuLoad1 == cpuLoad1) &&
            (identical(other.cpuLoad15, cpuLoad15) ||
                other.cpuLoad15 == cpuLoad15) &&
            (identical(other.cpuLoad5, cpuLoad5) ||
                other.cpuLoad5 == cpuLoad5) &&
            (identical(other.diskAvailable, diskAvailable) ||
                other.diskAvailable == diskAvailable) &&
            (identical(other.diskUsed, diskUsed) ||
                other.diskUsed == diskUsed) &&
            (identical(other.diskUsedPercent, diskUsedPercent) ||
                other.diskUsedPercent == diskUsedPercent) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            (identical(other.memTotal, memTotal) ||
                other.memTotal == memTotal) &&
            (identical(other.memUsed, memUsed) || other.memUsed == memUsed) &&
            const DeepCollectionEquality().equals(other.sensors, sensors) &&
            (identical(other.swapTotal, swapTotal) ||
                other.swapTotal == swapTotal) &&
            (identical(other.swapUsed, swapUsed) ||
                other.swapUsed == swapUsed) &&
            (identical(other.uptime, uptime) || other.uptime == uptime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cpuLoad1,
      cpuLoad15,
      cpuLoad5,
      diskAvailable,
      diskUsed,
      diskUsedPercent,
      lastUpdate,
      memTotal,
      memUsed,
      const DeepCollectionEquality().hash(sensors),
      swapTotal,
      swapUsed,
      uptime);

  @override
  String toString() {
    return 'UpdateInfo(cpuLoad1: $cpuLoad1, cpuLoad15: $cpuLoad15, cpuLoad5: $cpuLoad5, diskAvailable: $diskAvailable, diskUsed: $diskUsed, diskUsedPercent: $diskUsedPercent, lastUpdate: $lastUpdate, memTotal: $memTotal, memUsed: $memUsed, sensors: $sensors, swapTotal: $swapTotal, swapUsed: $swapUsed, uptime: $uptime)';
  }
}

/// @nodoc
abstract mixin class $UpdateInfoCopyWith<$Res> {
  factory $UpdateInfoCopyWith(
          UpdateInfo value, $Res Function(UpdateInfo) _then) =
      _$UpdateInfoCopyWithImpl;
  @useResult
  $Res call(
      {double cpuLoad1,
      double cpuLoad15,
      double cpuLoad5,
      int diskAvailable,
      int diskUsed,
      int diskUsedPercent,
      int lastUpdate,
      int memTotal,
      int memUsed,
      List<SensorInfo> sensors,
      int swapTotal,
      int swapUsed,
      String uptime});
}

/// @nodoc
class _$UpdateInfoCopyWithImpl<$Res> implements $UpdateInfoCopyWith<$Res> {
  _$UpdateInfoCopyWithImpl(this._self, this._then);

  final UpdateInfo _self;
  final $Res Function(UpdateInfo) _then;

  /// Create a copy of UpdateInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cpuLoad1 = null,
    Object? cpuLoad15 = null,
    Object? cpuLoad5 = null,
    Object? diskAvailable = null,
    Object? diskUsed = null,
    Object? diskUsedPercent = null,
    Object? lastUpdate = null,
    Object? memTotal = null,
    Object? memUsed = null,
    Object? sensors = null,
    Object? swapTotal = null,
    Object? swapUsed = null,
    Object? uptime = null,
  }) {
    return _then(_self.copyWith(
      cpuLoad1: null == cpuLoad1
          ? _self.cpuLoad1
          : cpuLoad1 // ignore: cast_nullable_to_non_nullable
              as double,
      cpuLoad15: null == cpuLoad15
          ? _self.cpuLoad15
          : cpuLoad15 // ignore: cast_nullable_to_non_nullable
              as double,
      cpuLoad5: null == cpuLoad5
          ? _self.cpuLoad5
          : cpuLoad5 // ignore: cast_nullable_to_non_nullable
              as double,
      diskAvailable: null == diskAvailable
          ? _self.diskAvailable
          : diskAvailable // ignore: cast_nullable_to_non_nullable
              as int,
      diskUsed: null == diskUsed
          ? _self.diskUsed
          : diskUsed // ignore: cast_nullable_to_non_nullable
              as int,
      diskUsedPercent: null == diskUsedPercent
          ? _self.diskUsedPercent
          : diskUsedPercent // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdate: null == lastUpdate
          ? _self.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as int,
      memTotal: null == memTotal
          ? _self.memTotal
          : memTotal // ignore: cast_nullable_to_non_nullable
              as int,
      memUsed: null == memUsed
          ? _self.memUsed
          : memUsed // ignore: cast_nullable_to_non_nullable
              as int,
      sensors: null == sensors
          ? _self.sensors
          : sensors // ignore: cast_nullable_to_non_nullable
              as List<SensorInfo>,
      swapTotal: null == swapTotal
          ? _self.swapTotal
          : swapTotal // ignore: cast_nullable_to_non_nullable
              as int,
      swapUsed: null == swapUsed
          ? _self.swapUsed
          : swapUsed // ignore: cast_nullable_to_non_nullable
              as int,
      uptime: null == uptime
          ? _self.uptime
          : uptime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UpdateInfo implements UpdateInfo {
  const _UpdateInfo(
      {required this.cpuLoad1,
      required this.cpuLoad15,
      required this.cpuLoad5,
      required this.diskAvailable,
      required this.diskUsed,
      required this.diskUsedPercent,
      required this.lastUpdate,
      required this.memTotal,
      required this.memUsed,
      required final List<SensorInfo> sensors,
      required this.swapTotal,
      required this.swapUsed,
      required this.uptime})
      : _sensors = sensors;
  factory _UpdateInfo.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoFromJson(json);

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
  final List<SensorInfo> _sensors;
  @override
  List<SensorInfo> get sensors {
    if (_sensors is EqualUnmodifiableListView) return _sensors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sensors);
  }

  @override
  final int swapTotal;
  @override
  final int swapUsed;
  @override
  final String uptime;

  /// Create a copy of UpdateInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateInfoCopyWith<_UpdateInfo> get copyWith =>
      __$UpdateInfoCopyWithImpl<_UpdateInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateInfo &&
            (identical(other.cpuLoad1, cpuLoad1) ||
                other.cpuLoad1 == cpuLoad1) &&
            (identical(other.cpuLoad15, cpuLoad15) ||
                other.cpuLoad15 == cpuLoad15) &&
            (identical(other.cpuLoad5, cpuLoad5) ||
                other.cpuLoad5 == cpuLoad5) &&
            (identical(other.diskAvailable, diskAvailable) ||
                other.diskAvailable == diskAvailable) &&
            (identical(other.diskUsed, diskUsed) ||
                other.diskUsed == diskUsed) &&
            (identical(other.diskUsedPercent, diskUsedPercent) ||
                other.diskUsedPercent == diskUsedPercent) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            (identical(other.memTotal, memTotal) ||
                other.memTotal == memTotal) &&
            (identical(other.memUsed, memUsed) || other.memUsed == memUsed) &&
            const DeepCollectionEquality().equals(other._sensors, _sensors) &&
            (identical(other.swapTotal, swapTotal) ||
                other.swapTotal == swapTotal) &&
            (identical(other.swapUsed, swapUsed) ||
                other.swapUsed == swapUsed) &&
            (identical(other.uptime, uptime) || other.uptime == uptime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cpuLoad1,
      cpuLoad15,
      cpuLoad5,
      diskAvailable,
      diskUsed,
      diskUsedPercent,
      lastUpdate,
      memTotal,
      memUsed,
      const DeepCollectionEquality().hash(_sensors),
      swapTotal,
      swapUsed,
      uptime);

  @override
  String toString() {
    return 'UpdateInfo(cpuLoad1: $cpuLoad1, cpuLoad15: $cpuLoad15, cpuLoad5: $cpuLoad5, diskAvailable: $diskAvailable, diskUsed: $diskUsed, diskUsedPercent: $diskUsedPercent, lastUpdate: $lastUpdate, memTotal: $memTotal, memUsed: $memUsed, sensors: $sensors, swapTotal: $swapTotal, swapUsed: $swapUsed, uptime: $uptime)';
  }
}

/// @nodoc
abstract mixin class _$UpdateInfoCopyWith<$Res>
    implements $UpdateInfoCopyWith<$Res> {
  factory _$UpdateInfoCopyWith(
          _UpdateInfo value, $Res Function(_UpdateInfo) _then) =
      __$UpdateInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double cpuLoad1,
      double cpuLoad15,
      double cpuLoad5,
      int diskAvailable,
      int diskUsed,
      int diskUsedPercent,
      int lastUpdate,
      int memTotal,
      int memUsed,
      List<SensorInfo> sensors,
      int swapTotal,
      int swapUsed,
      String uptime});
}

/// @nodoc
class __$UpdateInfoCopyWithImpl<$Res> implements _$UpdateInfoCopyWith<$Res> {
  __$UpdateInfoCopyWithImpl(this._self, this._then);

  final _UpdateInfo _self;
  final $Res Function(_UpdateInfo) _then;

  /// Create a copy of UpdateInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cpuLoad1 = null,
    Object? cpuLoad15 = null,
    Object? cpuLoad5 = null,
    Object? diskAvailable = null,
    Object? diskUsed = null,
    Object? diskUsedPercent = null,
    Object? lastUpdate = null,
    Object? memTotal = null,
    Object? memUsed = null,
    Object? sensors = null,
    Object? swapTotal = null,
    Object? swapUsed = null,
    Object? uptime = null,
  }) {
    return _then(_UpdateInfo(
      cpuLoad1: null == cpuLoad1
          ? _self.cpuLoad1
          : cpuLoad1 // ignore: cast_nullable_to_non_nullable
              as double,
      cpuLoad15: null == cpuLoad15
          ? _self.cpuLoad15
          : cpuLoad15 // ignore: cast_nullable_to_non_nullable
              as double,
      cpuLoad5: null == cpuLoad5
          ? _self.cpuLoad5
          : cpuLoad5 // ignore: cast_nullable_to_non_nullable
              as double,
      diskAvailable: null == diskAvailable
          ? _self.diskAvailable
          : diskAvailable // ignore: cast_nullable_to_non_nullable
              as int,
      diskUsed: null == diskUsed
          ? _self.diskUsed
          : diskUsed // ignore: cast_nullable_to_non_nullable
              as int,
      diskUsedPercent: null == diskUsedPercent
          ? _self.diskUsedPercent
          : diskUsedPercent // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdate: null == lastUpdate
          ? _self.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as int,
      memTotal: null == memTotal
          ? _self.memTotal
          : memTotal // ignore: cast_nullable_to_non_nullable
              as int,
      memUsed: null == memUsed
          ? _self.memUsed
          : memUsed // ignore: cast_nullable_to_non_nullable
              as int,
      sensors: null == sensors
          ? _self._sensors
          : sensors // ignore: cast_nullable_to_non_nullable
              as List<SensorInfo>,
      swapTotal: null == swapTotal
          ? _self.swapTotal
          : swapTotal // ignore: cast_nullable_to_non_nullable
              as int,
      swapUsed: null == swapUsed
          ? _self.swapUsed
          : swapUsed // ignore: cast_nullable_to_non_nullable
              as int,
      uptime: null == uptime
          ? _self.uptime
          : uptime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
