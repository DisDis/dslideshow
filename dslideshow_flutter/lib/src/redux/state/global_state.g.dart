// GENERATED CODE - DO NOT MODIFY BY HAND

part of dslideshow.global.state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const StorageStatusEnum _$download = const StorageStatusEnum._('download');
const StorageStatusEnum _$off = const StorageStatusEnum._('off');
const StorageStatusEnum _$done = const StorageStatusEnum._('done');

StorageStatusEnum _$valueOf(String name) {
  switch (name) {
    case 'download':
      return _$download;
    case 'off':
      return _$off;
    case 'done':
      return _$done;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<StorageStatusEnum> _$values =
    new BuiltSet<StorageStatusEnum>(const <StorageStatusEnum>[
  _$download,
  _$off,
  _$done,
]);

Serializer<GlobalState> _$globalStateSerializer = new _$GlobalStateSerializer();
Serializer<StorageStatusEnum> _$storageStatusEnumSerializer =
    new _$StorageStatusEnumSerializer();

class _$GlobalStateSerializer implements StructuredSerializer<GlobalState> {
  @override
  final Iterable<Type> types = const [GlobalState, _$GlobalState];
  @override
  final String wireName = 'GlobalState';

  @override
  Iterable<Object> serialize(Serializers serializers, GlobalState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'delayBetweenItems',
      serializers.serialize(object.delayBetweenItems,
          specifiedType: const FullType(Duration)),
      'hasInternet',
      serializers.serialize(object.hasInternet,
          specifiedType: const FullType(bool)),
      'isScreenLock',
      serializers.serialize(object.isScreenLock,
          specifiedType: const FullType(bool)),
      'isDebug',
      serializers.serialize(object.isDebug,
          specifiedType: const FullType(bool)),
      'isPaused',
      serializers.serialize(object.isPaused,
          specifiedType: const FullType(bool)),
      'storageStatus',
      serializers.serialize(object.storageStatus,
          specifiedType: const FullType(StorageStatusEnum)),
    ];
    if (object.beginTimePowerButtonPress != null) {
      result
        ..add('beginTimePowerButtonPress')
        ..add(serializers.serialize(object.beginTimePowerButtonPress,
            specifiedType: const FullType(DateTime)));
    }
    if (object.currentMediaFile != null) {
      result
        ..add('currentMediaFile')
        ..add(serializers.serialize(object.currentMediaFile,
            specifiedType: const FullType(String)));
    }
    if (object.nextMediaFile != null) {
      result
        ..add('nextMediaFile')
        ..add(serializers.serialize(object.nextMediaFile,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GlobalState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GlobalStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'beginTimePowerButtonPress':
          result.beginTimePowerButtonPress = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'currentMediaFile':
          result.currentMediaFile = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'delayBetweenItems':
          result.delayBetweenItems = serializers.deserialize(value,
              specifiedType: const FullType(Duration)) as Duration;
          break;
        case 'hasInternet':
          result.hasInternet = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isScreenLock':
          result.isScreenLock = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isDebug':
          result.isDebug = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isPaused':
          result.isPaused = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'nextMediaFile':
          result.nextMediaFile = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'storageStatus':
          result.storageStatus = serializers.deserialize(value,
                  specifiedType: const FullType(StorageStatusEnum))
              as StorageStatusEnum;
          break;
      }
    }

    return result.build();
  }
}

class _$StorageStatusEnumSerializer
    implements PrimitiveSerializer<StorageStatusEnum> {
  @override
  final Iterable<Type> types = const <Type>[StorageStatusEnum];
  @override
  final String wireName = 'StorageStatusEnum';

  @override
  Object serialize(Serializers serializers, StorageStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  StorageStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      StorageStatusEnum.valueOf(serialized as String);
}

class _$GlobalState extends GlobalState {
  @override
  final DateTime beginTimePowerButtonPress;
  @override
  final String currentMediaFile;
  @override
  final Duration delayBetweenItems;
  @override
  final bool hasInternet;
  @override
  final bool isScreenLock;
  @override
  final bool isDebug;
  @override
  final bool isPaused;
  @override
  final String nextMediaFile;
  @override
  final StorageStatusEnum storageStatus;

  factory _$GlobalState([void Function(GlobalStateBuilder) updates]) =>
      (new GlobalStateBuilder()..update(updates)).build();

  _$GlobalState._(
      {this.beginTimePowerButtonPress,
      this.currentMediaFile,
      this.delayBetweenItems,
      this.hasInternet,
      this.isScreenLock,
      this.isDebug,
      this.isPaused,
      this.nextMediaFile,
      this.storageStatus})
      : super._() {
    if (delayBetweenItems == null) {
      throw new BuiltValueNullFieldError('GlobalState', 'delayBetweenItems');
    }
    if (hasInternet == null) {
      throw new BuiltValueNullFieldError('GlobalState', 'hasInternet');
    }
    if (isScreenLock == null) {
      throw new BuiltValueNullFieldError('GlobalState', 'isScreenLock');
    }
    if (isDebug == null) {
      throw new BuiltValueNullFieldError('GlobalState', 'isDebug');
    }
    if (isPaused == null) {
      throw new BuiltValueNullFieldError('GlobalState', 'isPaused');
    }
    if (storageStatus == null) {
      throw new BuiltValueNullFieldError('GlobalState', 'storageStatus');
    }
  }

  @override
  GlobalState rebuild(void Function(GlobalStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GlobalStateBuilder toBuilder() => new GlobalStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GlobalState &&
        beginTimePowerButtonPress == other.beginTimePowerButtonPress &&
        currentMediaFile == other.currentMediaFile &&
        delayBetweenItems == other.delayBetweenItems &&
        hasInternet == other.hasInternet &&
        isScreenLock == other.isScreenLock &&
        isDebug == other.isDebug &&
        isPaused == other.isPaused &&
        nextMediaFile == other.nextMediaFile &&
        storageStatus == other.storageStatus;
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
                                $jc($jc(0, beginTimePowerButtonPress.hashCode),
                                    currentMediaFile.hashCode),
                                delayBetweenItems.hashCode),
                            hasInternet.hashCode),
                        isScreenLock.hashCode),
                    isDebug.hashCode),
                isPaused.hashCode),
            nextMediaFile.hashCode),
        storageStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GlobalState')
          ..add('beginTimePowerButtonPress', beginTimePowerButtonPress)
          ..add('currentMediaFile', currentMediaFile)
          ..add('delayBetweenItems', delayBetweenItems)
          ..add('hasInternet', hasInternet)
          ..add('isScreenLock', isScreenLock)
          ..add('isDebug', isDebug)
          ..add('isPaused', isPaused)
          ..add('nextMediaFile', nextMediaFile)
          ..add('storageStatus', storageStatus))
        .toString();
  }
}

class GlobalStateBuilder implements Builder<GlobalState, GlobalStateBuilder> {
  _$GlobalState _$v;

  DateTime _beginTimePowerButtonPress;
  DateTime get beginTimePowerButtonPress => _$this._beginTimePowerButtonPress;
  set beginTimePowerButtonPress(DateTime beginTimePowerButtonPress) =>
      _$this._beginTimePowerButtonPress = beginTimePowerButtonPress;

  String _currentMediaFile;
  String get currentMediaFile => _$this._currentMediaFile;
  set currentMediaFile(String currentMediaFile) =>
      _$this._currentMediaFile = currentMediaFile;

  Duration _delayBetweenItems;
  Duration get delayBetweenItems => _$this._delayBetweenItems;
  set delayBetweenItems(Duration delayBetweenItems) =>
      _$this._delayBetweenItems = delayBetweenItems;

  bool _hasInternet;
  bool get hasInternet => _$this._hasInternet;
  set hasInternet(bool hasInternet) => _$this._hasInternet = hasInternet;

  bool _isScreenLock;
  bool get isScreenLock => _$this._isScreenLock;
  set isScreenLock(bool isScreenLock) => _$this._isScreenLock = isScreenLock;

  bool _isDebug;
  bool get isDebug => _$this._isDebug;
  set isDebug(bool isDebug) => _$this._isDebug = isDebug;

  bool _isPaused;
  bool get isPaused => _$this._isPaused;
  set isPaused(bool isPaused) => _$this._isPaused = isPaused;

  String _nextMediaFile;
  String get nextMediaFile => _$this._nextMediaFile;
  set nextMediaFile(String nextMediaFile) =>
      _$this._nextMediaFile = nextMediaFile;

  StorageStatusEnum _storageStatus;
  StorageStatusEnum get storageStatus => _$this._storageStatus;
  set storageStatus(StorageStatusEnum storageStatus) =>
      _$this._storageStatus = storageStatus;

  GlobalStateBuilder();

  GlobalStateBuilder get _$this {
    if (_$v != null) {
      _beginTimePowerButtonPress = _$v.beginTimePowerButtonPress;
      _currentMediaFile = _$v.currentMediaFile;
      _delayBetweenItems = _$v.delayBetweenItems;
      _hasInternet = _$v.hasInternet;
      _isScreenLock = _$v.isScreenLock;
      _isDebug = _$v.isDebug;
      _isPaused = _$v.isPaused;
      _nextMediaFile = _$v.nextMediaFile;
      _storageStatus = _$v.storageStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GlobalState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GlobalState;
  }

  @override
  void update(void Function(GlobalStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GlobalState build() {
    final _$result = _$v ??
        new _$GlobalState._(
            beginTimePowerButtonPress: beginTimePowerButtonPress,
            currentMediaFile: currentMediaFile,
            delayBetweenItems: delayBetweenItems,
            hasInternet: hasInternet,
            isScreenLock: isScreenLock,
            isDebug: isDebug,
            isPaused: isPaused,
            nextMediaFile: nextMediaFile,
            storageStatus: storageStatus);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
