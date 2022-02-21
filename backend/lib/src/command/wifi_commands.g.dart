// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_commands.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WiFiScanCommand> _$wiFiScanCommandSerializer =
    new _$WiFiScanCommandSerializer();
Serializer<WiFiScanResult> _$wiFiScanResultSerializer =
    new _$WiFiScanResultSerializer();
Serializer<WiFiNetworkInfo> _$wiFiNetworkInfoSerializer =
    new _$WiFiNetworkInfoSerializer();
Serializer<WiFiStoredNetworkInfo> _$wiFiStoredNetworkInfoSerializer =
    new _$WiFiStoredNetworkInfoSerializer();
Serializer<WiFiRemoveCommand> _$wiFiRemoveCommandSerializer =
    new _$WiFiRemoveCommandSerializer();
Serializer<WiFiAddCommand> _$wiFiAddCommandSerializer =
    new _$WiFiAddCommandSerializer();
Serializer<WiFiGetStoredCommand> _$wiFiGetStoredCommandSerializer =
    new _$WiFiGetStoredCommandSerializer();
Serializer<WiFiGetStoredResult> _$wiFiGetStoredResultSerializer =
    new _$WiFiGetStoredResultSerializer();

class _$WiFiScanCommandSerializer
    implements StructuredSerializer<WiFiScanCommand> {
  @override
  final Iterable<Type> types = const [WiFiScanCommand, _$WiFiScanCommand];
  @override
  final String wireName = 'WiFiScanCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, WiFiScanCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WiFiScanCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WiFiScanCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WiFiScanResultSerializer
    implements StructuredSerializer<WiFiScanResult> {
  @override
  final Iterable<Type> types = const [WiFiScanResult, _$WiFiScanResult];
  @override
  final String wireName = 'WiFiScanResult';

  @override
  Iterable<Object?> serialize(Serializers serializers, WiFiScanResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.networks;
    if (value != null) {
      result
        ..add('networks')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(WiFiNetworkInfo)])));
    }
    return result;
  }

  @override
  WiFiScanResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WiFiScanResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'networks':
          result.networks.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(WiFiNetworkInfo)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$WiFiNetworkInfoSerializer
    implements StructuredSerializer<WiFiNetworkInfo> {
  @override
  final Iterable<Type> types = const [WiFiNetworkInfo, _$WiFiNetworkInfo];
  @override
  final String wireName = 'WiFiNetworkInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, WiFiNetworkInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'SSID',
      serializers.serialize(object.SSID, specifiedType: const FullType(String)),
      'signal',
      serializers.serialize(object.signal,
          specifiedType: const FullType(String)),
      'capability',
      serializers.serialize(object.capability,
          specifiedType: const FullType(String)),
      'freq',
      serializers.serialize(object.freq, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WiFiNetworkInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WiFiNetworkInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'SSID':
          result.SSID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'signal':
          result.signal = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'capability':
          result.capability = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'freq':
          result.freq = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WiFiStoredNetworkInfoSerializer
    implements StructuredSerializer<WiFiStoredNetworkInfo> {
  @override
  final Iterable<Type> types = const [
    WiFiStoredNetworkInfo,
    _$WiFiStoredNetworkInfo
  ];
  @override
  final String wireName = 'WiFiStoredNetworkInfo';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WiFiStoredNetworkInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'SSID',
      serializers.serialize(object.SSID, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  WiFiStoredNetworkInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WiFiStoredNetworkInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'SSID':
          result.SSID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$WiFiRemoveCommandSerializer
    implements StructuredSerializer<WiFiRemoveCommand> {
  @override
  final Iterable<Type> types = const [WiFiRemoveCommand, _$WiFiRemoveCommand];
  @override
  final String wireName = 'WiFiRemoveCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, WiFiRemoveCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'wifiId',
      serializers.serialize(object.wifiId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WiFiRemoveCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WiFiRemoveCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'wifiId':
          result.wifiId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WiFiAddCommandSerializer
    implements StructuredSerializer<WiFiAddCommand> {
  @override
  final Iterable<Type> types = const [WiFiAddCommand, _$WiFiAddCommand];
  @override
  final String wireName = 'WiFiAddCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, WiFiAddCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'SSID',
      serializers.serialize(object.SSID, specifiedType: const FullType(String)),
      'psk',
      serializers.serialize(object.psk, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  WiFiAddCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WiFiAddCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'SSID':
          result.SSID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'psk':
          result.psk = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$WiFiGetStoredCommandSerializer
    implements StructuredSerializer<WiFiGetStoredCommand> {
  @override
  final Iterable<Type> types = const [
    WiFiGetStoredCommand,
    _$WiFiGetStoredCommand
  ];
  @override
  final String wireName = 'WiFiGetStoredCommand';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WiFiGetStoredCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WiFiGetStoredCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WiFiGetStoredCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WiFiGetStoredResultSerializer
    implements StructuredSerializer<WiFiGetStoredResult> {
  @override
  final Iterable<Type> types = const [
    WiFiGetStoredResult,
    _$WiFiGetStoredResult
  ];
  @override
  final String wireName = 'WiFiGetStoredResult';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WiFiGetStoredResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.networks;
    if (value != null) {
      result
        ..add('networks')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(WiFiStoredNetworkInfo)])));
    }
    return result;
  }

  @override
  WiFiGetStoredResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WiFiGetStoredResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'networks':
          result.networks.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(WiFiStoredNetworkInfo)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$WiFiScanCommand extends WiFiScanCommand {
  @override
  final int id;

  factory _$WiFiScanCommand([void Function(WiFiScanCommandBuilder)? updates]) =>
      (new WiFiScanCommandBuilder()..update(updates)).build();

  _$WiFiScanCommand._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'WiFiScanCommand', 'id');
  }

  @override
  WiFiScanCommand rebuild(void Function(WiFiScanCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WiFiScanCommandBuilder toBuilder() =>
      new WiFiScanCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WiFiScanCommand && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(0, id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WiFiScanCommand')..add('id', id))
        .toString();
  }
}

class WiFiScanCommandBuilder
    implements Builder<WiFiScanCommand, WiFiScanCommandBuilder> {
  _$WiFiScanCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WiFiScanCommandBuilder() {
    WiFiScanCommand._setDefaults(this);
  }

  WiFiScanCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WiFiScanCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WiFiScanCommand;
  }

  @override
  void update(void Function(WiFiScanCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WiFiScanCommand build() {
    final _$result = _$v ??
        new _$WiFiScanCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'WiFiScanCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WiFiScanResult extends WiFiScanResult {
  @override
  final int id;
  @override
  final BuiltList<WiFiNetworkInfo>? networks;

  factory _$WiFiScanResult([void Function(WiFiScanResultBuilder)? updates]) =>
      (new WiFiScanResultBuilder()..update(updates)).build();

  _$WiFiScanResult._({required this.id, this.networks}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'WiFiScanResult', 'id');
  }

  @override
  WiFiScanResult rebuild(void Function(WiFiScanResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WiFiScanResultBuilder toBuilder() =>
      new WiFiScanResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WiFiScanResult &&
        id == other.id &&
        networks == other.networks;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), networks.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WiFiScanResult')
          ..add('id', id)
          ..add('networks', networks))
        .toString();
  }
}

class WiFiScanResultBuilder
    implements Builder<WiFiScanResult, WiFiScanResultBuilder> {
  _$WiFiScanResult? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ListBuilder<WiFiNetworkInfo>? _networks;
  ListBuilder<WiFiNetworkInfo> get networks =>
      _$this._networks ??= new ListBuilder<WiFiNetworkInfo>();
  set networks(ListBuilder<WiFiNetworkInfo>? networks) =>
      _$this._networks = networks;

  WiFiScanResultBuilder();

  WiFiScanResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _networks = $v.networks?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WiFiScanResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WiFiScanResult;
  }

  @override
  void update(void Function(WiFiScanResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WiFiScanResult build() {
    _$WiFiScanResult _$result;
    try {
      _$result = _$v ??
          new _$WiFiScanResult._(
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'WiFiScanResult', 'id'),
              networks: _networks?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'networks';
        _networks?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WiFiScanResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$WiFiNetworkInfo extends WiFiNetworkInfo {
  @override
  final String SSID;
  @override
  final String signal;
  @override
  final String capability;
  @override
  final int freq;

  factory _$WiFiNetworkInfo([void Function(WiFiNetworkInfoBuilder)? updates]) =>
      (new WiFiNetworkInfoBuilder()..update(updates)).build();

  _$WiFiNetworkInfo._(
      {required this.SSID,
      required this.signal,
      required this.capability,
      required this.freq})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(SSID, 'WiFiNetworkInfo', 'SSID');
    BuiltValueNullFieldError.checkNotNull(signal, 'WiFiNetworkInfo', 'signal');
    BuiltValueNullFieldError.checkNotNull(
        capability, 'WiFiNetworkInfo', 'capability');
    BuiltValueNullFieldError.checkNotNull(freq, 'WiFiNetworkInfo', 'freq');
  }

  @override
  WiFiNetworkInfo rebuild(void Function(WiFiNetworkInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WiFiNetworkInfoBuilder toBuilder() =>
      new WiFiNetworkInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WiFiNetworkInfo &&
        SSID == other.SSID &&
        signal == other.signal &&
        capability == other.capability &&
        freq == other.freq;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, SSID.hashCode), signal.hashCode), capability.hashCode),
        freq.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WiFiNetworkInfo')
          ..add('SSID', SSID)
          ..add('signal', signal)
          ..add('capability', capability)
          ..add('freq', freq))
        .toString();
  }
}

class WiFiNetworkInfoBuilder
    implements Builder<WiFiNetworkInfo, WiFiNetworkInfoBuilder> {
  _$WiFiNetworkInfo? _$v;

  String? _SSID;
  String? get SSID => _$this._SSID;
  set SSID(String? SSID) => _$this._SSID = SSID;

  String? _signal;
  String? get signal => _$this._signal;
  set signal(String? signal) => _$this._signal = signal;

  String? _capability;
  String? get capability => _$this._capability;
  set capability(String? capability) => _$this._capability = capability;

  int? _freq;
  int? get freq => _$this._freq;
  set freq(int? freq) => _$this._freq = freq;

  WiFiNetworkInfoBuilder() {
    WiFiNetworkInfo._setDefaults(this);
  }

  WiFiNetworkInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _SSID = $v.SSID;
      _signal = $v.signal;
      _capability = $v.capability;
      _freq = $v.freq;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WiFiNetworkInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WiFiNetworkInfo;
  }

  @override
  void update(void Function(WiFiNetworkInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WiFiNetworkInfo build() {
    final _$result = _$v ??
        new _$WiFiNetworkInfo._(
            SSID: BuiltValueNullFieldError.checkNotNull(
                SSID, 'WiFiNetworkInfo', 'SSID'),
            signal: BuiltValueNullFieldError.checkNotNull(
                signal, 'WiFiNetworkInfo', 'signal'),
            capability: BuiltValueNullFieldError.checkNotNull(
                capability, 'WiFiNetworkInfo', 'capability'),
            freq: BuiltValueNullFieldError.checkNotNull(
                freq, 'WiFiNetworkInfo', 'freq'));
    replace(_$result);
    return _$result;
  }
}

class _$WiFiStoredNetworkInfo extends WiFiStoredNetworkInfo {
  @override
  final int id;
  @override
  final String SSID;

  factory _$WiFiStoredNetworkInfo(
          [void Function(WiFiStoredNetworkInfoBuilder)? updates]) =>
      (new WiFiStoredNetworkInfoBuilder()..update(updates)).build();

  _$WiFiStoredNetworkInfo._({required this.id, required this.SSID})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'WiFiStoredNetworkInfo', 'id');
    BuiltValueNullFieldError.checkNotNull(
        SSID, 'WiFiStoredNetworkInfo', 'SSID');
  }

  @override
  WiFiStoredNetworkInfo rebuild(
          void Function(WiFiStoredNetworkInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WiFiStoredNetworkInfoBuilder toBuilder() =>
      new WiFiStoredNetworkInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WiFiStoredNetworkInfo &&
        id == other.id &&
        SSID == other.SSID;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), SSID.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WiFiStoredNetworkInfo')
          ..add('id', id)
          ..add('SSID', SSID))
        .toString();
  }
}

class WiFiStoredNetworkInfoBuilder
    implements Builder<WiFiStoredNetworkInfo, WiFiStoredNetworkInfoBuilder> {
  _$WiFiStoredNetworkInfo? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _SSID;
  String? get SSID => _$this._SSID;
  set SSID(String? SSID) => _$this._SSID = SSID;

  WiFiStoredNetworkInfoBuilder();

  WiFiStoredNetworkInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _SSID = $v.SSID;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WiFiStoredNetworkInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WiFiStoredNetworkInfo;
  }

  @override
  void update(void Function(WiFiStoredNetworkInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WiFiStoredNetworkInfo build() {
    final _$result = _$v ??
        new _$WiFiStoredNetworkInfo._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'WiFiStoredNetworkInfo', 'id'),
            SSID: BuiltValueNullFieldError.checkNotNull(
                SSID, 'WiFiStoredNetworkInfo', 'SSID'));
    replace(_$result);
    return _$result;
  }
}

class _$WiFiRemoveCommand extends WiFiRemoveCommand {
  @override
  final int id;
  @override
  final int wifiId;

  factory _$WiFiRemoveCommand(
          [void Function(WiFiRemoveCommandBuilder)? updates]) =>
      (new WiFiRemoveCommandBuilder()..update(updates)).build();

  _$WiFiRemoveCommand._({required this.id, required this.wifiId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'WiFiRemoveCommand', 'id');
    BuiltValueNullFieldError.checkNotNull(
        wifiId, 'WiFiRemoveCommand', 'wifiId');
  }

  @override
  WiFiRemoveCommand rebuild(void Function(WiFiRemoveCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WiFiRemoveCommandBuilder toBuilder() =>
      new WiFiRemoveCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WiFiRemoveCommand &&
        id == other.id &&
        wifiId == other.wifiId;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), wifiId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WiFiRemoveCommand')
          ..add('id', id)
          ..add('wifiId', wifiId))
        .toString();
  }
}

class WiFiRemoveCommandBuilder
    implements Builder<WiFiRemoveCommand, WiFiRemoveCommandBuilder> {
  _$WiFiRemoveCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _wifiId;
  int? get wifiId => _$this._wifiId;
  set wifiId(int? wifiId) => _$this._wifiId = wifiId;

  WiFiRemoveCommandBuilder() {
    WiFiRemoveCommand._setDefaults(this);
  }

  WiFiRemoveCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _wifiId = $v.wifiId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WiFiRemoveCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WiFiRemoveCommand;
  }

  @override
  void update(void Function(WiFiRemoveCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WiFiRemoveCommand build() {
    final _$result = _$v ??
        new _$WiFiRemoveCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'WiFiRemoveCommand', 'id'),
            wifiId: BuiltValueNullFieldError.checkNotNull(
                wifiId, 'WiFiRemoveCommand', 'wifiId'));
    replace(_$result);
    return _$result;
  }
}

class _$WiFiAddCommand extends WiFiAddCommand {
  @override
  final int id;
  @override
  final String SSID;
  @override
  final String psk;

  factory _$WiFiAddCommand([void Function(WiFiAddCommandBuilder)? updates]) =>
      (new WiFiAddCommandBuilder()..update(updates)).build();

  _$WiFiAddCommand._({required this.id, required this.SSID, required this.psk})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'WiFiAddCommand', 'id');
    BuiltValueNullFieldError.checkNotNull(SSID, 'WiFiAddCommand', 'SSID');
    BuiltValueNullFieldError.checkNotNull(psk, 'WiFiAddCommand', 'psk');
  }

  @override
  WiFiAddCommand rebuild(void Function(WiFiAddCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WiFiAddCommandBuilder toBuilder() =>
      new WiFiAddCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WiFiAddCommand &&
        id == other.id &&
        SSID == other.SSID &&
        psk == other.psk;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), SSID.hashCode), psk.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WiFiAddCommand')
          ..add('id', id)
          ..add('SSID', SSID)
          ..add('psk', psk))
        .toString();
  }
}

class WiFiAddCommandBuilder
    implements Builder<WiFiAddCommand, WiFiAddCommandBuilder> {
  _$WiFiAddCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _SSID;
  String? get SSID => _$this._SSID;
  set SSID(String? SSID) => _$this._SSID = SSID;

  String? _psk;
  String? get psk => _$this._psk;
  set psk(String? psk) => _$this._psk = psk;

  WiFiAddCommandBuilder() {
    WiFiAddCommand._setDefaults(this);
  }

  WiFiAddCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _SSID = $v.SSID;
      _psk = $v.psk;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WiFiAddCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WiFiAddCommand;
  }

  @override
  void update(void Function(WiFiAddCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WiFiAddCommand build() {
    final _$result = _$v ??
        new _$WiFiAddCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'WiFiAddCommand', 'id'),
            SSID: BuiltValueNullFieldError.checkNotNull(
                SSID, 'WiFiAddCommand', 'SSID'),
            psk: BuiltValueNullFieldError.checkNotNull(
                psk, 'WiFiAddCommand', 'psk'));
    replace(_$result);
    return _$result;
  }
}

class _$WiFiGetStoredCommand extends WiFiGetStoredCommand {
  @override
  final int id;

  factory _$WiFiGetStoredCommand(
          [void Function(WiFiGetStoredCommandBuilder)? updates]) =>
      (new WiFiGetStoredCommandBuilder()..update(updates)).build();

  _$WiFiGetStoredCommand._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'WiFiGetStoredCommand', 'id');
  }

  @override
  WiFiGetStoredCommand rebuild(
          void Function(WiFiGetStoredCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WiFiGetStoredCommandBuilder toBuilder() =>
      new WiFiGetStoredCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WiFiGetStoredCommand && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(0, id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WiFiGetStoredCommand')..add('id', id))
        .toString();
  }
}

class WiFiGetStoredCommandBuilder
    implements Builder<WiFiGetStoredCommand, WiFiGetStoredCommandBuilder> {
  _$WiFiGetStoredCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WiFiGetStoredCommandBuilder() {
    WiFiGetStoredCommand._setDefaults(this);
  }

  WiFiGetStoredCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WiFiGetStoredCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WiFiGetStoredCommand;
  }

  @override
  void update(void Function(WiFiGetStoredCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WiFiGetStoredCommand build() {
    final _$result = _$v ??
        new _$WiFiGetStoredCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'WiFiGetStoredCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WiFiGetStoredResult extends WiFiGetStoredResult {
  @override
  final int id;
  @override
  final BuiltList<WiFiStoredNetworkInfo>? networks;

  factory _$WiFiGetStoredResult(
          [void Function(WiFiGetStoredResultBuilder)? updates]) =>
      (new WiFiGetStoredResultBuilder()..update(updates)).build();

  _$WiFiGetStoredResult._({required this.id, this.networks}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'WiFiGetStoredResult', 'id');
  }

  @override
  WiFiGetStoredResult rebuild(
          void Function(WiFiGetStoredResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WiFiGetStoredResultBuilder toBuilder() =>
      new WiFiGetStoredResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WiFiGetStoredResult &&
        id == other.id &&
        networks == other.networks;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), networks.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WiFiGetStoredResult')
          ..add('id', id)
          ..add('networks', networks))
        .toString();
  }
}

class WiFiGetStoredResultBuilder
    implements Builder<WiFiGetStoredResult, WiFiGetStoredResultBuilder> {
  _$WiFiGetStoredResult? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ListBuilder<WiFiStoredNetworkInfo>? _networks;
  ListBuilder<WiFiStoredNetworkInfo> get networks =>
      _$this._networks ??= new ListBuilder<WiFiStoredNetworkInfo>();
  set networks(ListBuilder<WiFiStoredNetworkInfo>? networks) =>
      _$this._networks = networks;

  WiFiGetStoredResultBuilder();

  WiFiGetStoredResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _networks = $v.networks?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WiFiGetStoredResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WiFiGetStoredResult;
  }

  @override
  void update(void Function(WiFiGetStoredResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WiFiGetStoredResult build() {
    _$WiFiGetStoredResult _$result;
    try {
      _$result = _$v ??
          new _$WiFiGetStoredResult._(
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'WiFiGetStoredResult', 'id'),
              networks: _networks?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'networks';
        _networks?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WiFiGetStoredResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
