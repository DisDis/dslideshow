// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ota_commands.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OTAStatus _$disabled = const OTAStatus._('disabled');
const OTAStatus _$ready = const OTAStatus._('ready');
const OTAStatus _$uploading = const OTAStatus._('uploading');
const OTAStatus _$instaling = const OTAStatus._('instaling');
const OTAStatus _$finished = const OTAStatus._('finished');
const OTAStatus _$issue = const OTAStatus._('issue');
const OTAStatus _$preReboot = const OTAStatus._('preReboot');

OTAStatus _$valueOTAStatusOf(String name) {
  switch (name) {
    case 'disabled':
      return _$disabled;
    case 'ready':
      return _$ready;
    case 'uploading':
      return _$uploading;
    case 'instaling':
      return _$instaling;
    case 'finished':
      return _$finished;
    case 'issue':
      return _$issue;
    case 'preReboot':
      return _$preReboot;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<OTAStatus> _$valuesOTAStatus =
    new BuiltSet<OTAStatus>(const <OTAStatus>[
  _$disabled,
  _$ready,
  _$uploading,
  _$instaling,
  _$finished,
  _$issue,
  _$preReboot,
]);

Serializer<OTAReadyCommand> _$oTAReadyCommandSerializer =
    new _$OTAReadyCommandSerializer();
Serializer<OTAGetInfoCommand> _$oTAGetInfoCommandSerializer =
    new _$OTAGetInfoCommandSerializer();
Serializer<OTAGetInfoCommandResult> _$oTAGetInfoCommandResultSerializer =
    new _$OTAGetInfoCommandResultSerializer();
Serializer<OTAOutputCommand> _$oTAOutputCommandSerializer =
    new _$OTAOutputCommandSerializer();
Serializer<OTAInfo> _$oTAInfoSerializer = new _$OTAInfoSerializer();
Serializer<OTAStatus> _$oTAStatusSerializer = new _$OTAStatusSerializer();

class _$OTAReadyCommandSerializer
    implements StructuredSerializer<OTAReadyCommand> {
  @override
  final Iterable<Type> types = const [OTAReadyCommand, _$OTAReadyCommand];
  @override
  final String wireName = 'OTAReadyCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, OTAReadyCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'ready',
      serializers.serialize(object.ready, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  OTAReadyCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OTAReadyCommandBuilder();

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
        case 'ready':
          result.ready = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$OTAGetInfoCommandSerializer
    implements StructuredSerializer<OTAGetInfoCommand> {
  @override
  final Iterable<Type> types = const [OTAGetInfoCommand, _$OTAGetInfoCommand];
  @override
  final String wireName = 'OTAGetInfoCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, OTAGetInfoCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.info;
    if (value != null) {
      result
        ..add('info')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(OTAInfo)));
    }
    return result;
  }

  @override
  OTAGetInfoCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OTAGetInfoCommandBuilder();

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
        case 'info':
          result.info.replace(serializers.deserialize(value,
              specifiedType: const FullType(OTAInfo))! as OTAInfo);
          break;
      }
    }

    return result.build();
  }
}

class _$OTAGetInfoCommandResultSerializer
    implements StructuredSerializer<OTAGetInfoCommandResult> {
  @override
  final Iterable<Type> types = const [
    OTAGetInfoCommandResult,
    _$OTAGetInfoCommandResult
  ];
  @override
  final String wireName = 'OTAGetInfoCommandResult';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, OTAGetInfoCommandResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'info',
      serializers.serialize(object.info,
          specifiedType: const FullType(OTAInfo)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  OTAGetInfoCommandResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OTAGetInfoCommandResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'info':
          result.info.replace(serializers.deserialize(value,
              specifiedType: const FullType(OTAInfo))! as OTAInfo);
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

class _$OTAOutputCommandSerializer
    implements StructuredSerializer<OTAOutputCommand> {
  @override
  final Iterable<Type> types = const [OTAOutputCommand, _$OTAOutputCommand];
  @override
  final String wireName = 'OTAOutputCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, OTAOutputCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'output',
      serializers.serialize(object.output,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  OTAOutputCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OTAOutputCommandBuilder();

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
        case 'output':
          result.output = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OTAInfoSerializer implements StructuredSerializer<OTAInfo> {
  @override
  final Iterable<Type> types = const [OTAInfo, _$OTAInfo];
  @override
  final String wireName = 'OTAInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, OTAInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(OTAStatus)),
      'uploadingPercent',
      serializers.serialize(object.uploadingPercent,
          specifiedType: const FullType(double)),
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.exitCode;
    if (value != null) {
      result
        ..add('exitCode')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.errorText;
    if (value != null) {
      result
        ..add('errorText')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  OTAInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OTAInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(OTAStatus)) as OTAStatus;
          break;
        case 'uploadingPercent':
          result.uploadingPercent = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'exitCode':
          result.exitCode = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'errorText':
          result.errorText = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$OTAStatusSerializer implements PrimitiveSerializer<OTAStatus> {
  @override
  final Iterable<Type> types = const <Type>[OTAStatus];
  @override
  final String wireName = 'OTAStatus';

  @override
  Object serialize(Serializers serializers, OTAStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  OTAStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OTAStatus.valueOf(serialized as String);
}

class _$OTAReadyCommand extends OTAReadyCommand {
  @override
  final int id;
  @override
  final bool ready;

  factory _$OTAReadyCommand([void Function(OTAReadyCommandBuilder)? updates]) =>
      (new OTAReadyCommandBuilder()..update(updates)).build();

  _$OTAReadyCommand._({required this.id, required this.ready}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'OTAReadyCommand', 'id');
    BuiltValueNullFieldError.checkNotNull(ready, 'OTAReadyCommand', 'ready');
  }

  @override
  OTAReadyCommand rebuild(void Function(OTAReadyCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OTAReadyCommandBuilder toBuilder() =>
      new OTAReadyCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OTAReadyCommand && id == other.id && ready == other.ready;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), ready.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OTAReadyCommand')
          ..add('id', id)
          ..add('ready', ready))
        .toString();
  }
}

class OTAReadyCommandBuilder
    implements Builder<OTAReadyCommand, OTAReadyCommandBuilder> {
  _$OTAReadyCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  bool? _ready;
  bool? get ready => _$this._ready;
  set ready(bool? ready) => _$this._ready = ready;

  OTAReadyCommandBuilder();

  OTAReadyCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _ready = $v.ready;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OTAReadyCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OTAReadyCommand;
  }

  @override
  void update(void Function(OTAReadyCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OTAReadyCommand build() {
    final _$result = _$v ??
        new _$OTAReadyCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'OTAReadyCommand', 'id'),
            ready: BuiltValueNullFieldError.checkNotNull(
                ready, 'OTAReadyCommand', 'ready'));
    replace(_$result);
    return _$result;
  }
}

class _$OTAGetInfoCommand extends OTAGetInfoCommand {
  @override
  final int id;
  @override
  final OTAInfo? info;

  factory _$OTAGetInfoCommand(
          [void Function(OTAGetInfoCommandBuilder)? updates]) =>
      (new OTAGetInfoCommandBuilder()..update(updates)).build();

  _$OTAGetInfoCommand._({required this.id, this.info}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'OTAGetInfoCommand', 'id');
  }

  @override
  OTAGetInfoCommand rebuild(void Function(OTAGetInfoCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OTAGetInfoCommandBuilder toBuilder() =>
      new OTAGetInfoCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OTAGetInfoCommand && id == other.id && info == other.info;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), info.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OTAGetInfoCommand')
          ..add('id', id)
          ..add('info', info))
        .toString();
  }
}

class OTAGetInfoCommandBuilder
    implements Builder<OTAGetInfoCommand, OTAGetInfoCommandBuilder> {
  _$OTAGetInfoCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  OTAInfoBuilder? _info;
  OTAInfoBuilder get info => _$this._info ??= new OTAInfoBuilder();
  set info(OTAInfoBuilder? info) => _$this._info = info;

  OTAGetInfoCommandBuilder();

  OTAGetInfoCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _info = $v.info?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OTAGetInfoCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OTAGetInfoCommand;
  }

  @override
  void update(void Function(OTAGetInfoCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OTAGetInfoCommand build() {
    _$OTAGetInfoCommand _$result;
    try {
      _$result = _$v ??
          new _$OTAGetInfoCommand._(
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'OTAGetInfoCommand', 'id'),
              info: _info?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'info';
        _info?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OTAGetInfoCommand', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$OTAGetInfoCommandResult extends OTAGetInfoCommandResult {
  @override
  final OTAInfo info;
  @override
  final int id;

  factory _$OTAGetInfoCommandResult(
          [void Function(OTAGetInfoCommandResultBuilder)? updates]) =>
      (new OTAGetInfoCommandResultBuilder()..update(updates)).build();

  _$OTAGetInfoCommandResult._({required this.info, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        info, 'OTAGetInfoCommandResult', 'info');
    BuiltValueNullFieldError.checkNotNull(id, 'OTAGetInfoCommandResult', 'id');
  }

  @override
  OTAGetInfoCommandResult rebuild(
          void Function(OTAGetInfoCommandResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OTAGetInfoCommandResultBuilder toBuilder() =>
      new OTAGetInfoCommandResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OTAGetInfoCommandResult &&
        info == other.info &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, info.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OTAGetInfoCommandResult')
          ..add('info', info)
          ..add('id', id))
        .toString();
  }
}

class OTAGetInfoCommandResultBuilder
    implements
        Builder<OTAGetInfoCommandResult, OTAGetInfoCommandResultBuilder> {
  _$OTAGetInfoCommandResult? _$v;

  OTAInfoBuilder? _info;
  OTAInfoBuilder get info => _$this._info ??= new OTAInfoBuilder();
  set info(OTAInfoBuilder? info) => _$this._info = info;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  OTAGetInfoCommandResultBuilder();

  OTAGetInfoCommandResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _info = $v.info.toBuilder();
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OTAGetInfoCommandResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OTAGetInfoCommandResult;
  }

  @override
  void update(void Function(OTAGetInfoCommandResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OTAGetInfoCommandResult build() {
    _$OTAGetInfoCommandResult _$result;
    try {
      _$result = _$v ??
          new _$OTAGetInfoCommandResult._(
              info: info.build(),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'OTAGetInfoCommandResult', 'id'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'info';
        info.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OTAGetInfoCommandResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$OTAOutputCommand extends OTAOutputCommand {
  @override
  final int id;
  @override
  final String output;

  factory _$OTAOutputCommand(
          [void Function(OTAOutputCommandBuilder)? updates]) =>
      (new OTAOutputCommandBuilder()..update(updates)).build();

  _$OTAOutputCommand._({required this.id, required this.output}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'OTAOutputCommand', 'id');
    BuiltValueNullFieldError.checkNotNull(output, 'OTAOutputCommand', 'output');
  }

  @override
  OTAOutputCommand rebuild(void Function(OTAOutputCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OTAOutputCommandBuilder toBuilder() =>
      new OTAOutputCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OTAOutputCommand &&
        id == other.id &&
        output == other.output;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), output.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OTAOutputCommand')
          ..add('id', id)
          ..add('output', output))
        .toString();
  }
}

class OTAOutputCommandBuilder
    implements Builder<OTAOutputCommand, OTAOutputCommandBuilder> {
  _$OTAOutputCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _output;
  String? get output => _$this._output;
  set output(String? output) => _$this._output = output;

  OTAOutputCommandBuilder();

  OTAOutputCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _output = $v.output;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OTAOutputCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OTAOutputCommand;
  }

  @override
  void update(void Function(OTAOutputCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OTAOutputCommand build() {
    final _$result = _$v ??
        new _$OTAOutputCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'OTAOutputCommand', 'id'),
            output: BuiltValueNullFieldError.checkNotNull(
                output, 'OTAOutputCommand', 'output'));
    replace(_$result);
    return _$result;
  }
}

class _$OTAInfo extends OTAInfo {
  @override
  final OTAStatus status;
  @override
  final double uploadingPercent;
  @override
  final String code;
  @override
  final int? exitCode;
  @override
  final String? errorText;

  factory _$OTAInfo([void Function(OTAInfoBuilder)? updates]) =>
      (new OTAInfoBuilder()..update(updates)).build();

  _$OTAInfo._(
      {required this.status,
      required this.uploadingPercent,
      required this.code,
      this.exitCode,
      this.errorText})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(status, 'OTAInfo', 'status');
    BuiltValueNullFieldError.checkNotNull(
        uploadingPercent, 'OTAInfo', 'uploadingPercent');
    BuiltValueNullFieldError.checkNotNull(code, 'OTAInfo', 'code');
  }

  @override
  OTAInfo rebuild(void Function(OTAInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OTAInfoBuilder toBuilder() => new OTAInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OTAInfo &&
        status == other.status &&
        uploadingPercent == other.uploadingPercent &&
        code == other.code &&
        exitCode == other.exitCode &&
        errorText == other.errorText;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, status.hashCode), uploadingPercent.hashCode),
                code.hashCode),
            exitCode.hashCode),
        errorText.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OTAInfo')
          ..add('status', status)
          ..add('uploadingPercent', uploadingPercent)
          ..add('code', code)
          ..add('exitCode', exitCode)
          ..add('errorText', errorText))
        .toString();
  }
}

class OTAInfoBuilder implements Builder<OTAInfo, OTAInfoBuilder> {
  _$OTAInfo? _$v;

  OTAStatus? _status;
  OTAStatus? get status => _$this._status;
  set status(OTAStatus? status) => _$this._status = status;

  double? _uploadingPercent;
  double? get uploadingPercent => _$this._uploadingPercent;
  set uploadingPercent(double? uploadingPercent) =>
      _$this._uploadingPercent = uploadingPercent;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  int? _exitCode;
  int? get exitCode => _$this._exitCode;
  set exitCode(int? exitCode) => _$this._exitCode = exitCode;

  String? _errorText;
  String? get errorText => _$this._errorText;
  set errorText(String? errorText) => _$this._errorText = errorText;

  OTAInfoBuilder();

  OTAInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _uploadingPercent = $v.uploadingPercent;
      _code = $v.code;
      _exitCode = $v.exitCode;
      _errorText = $v.errorText;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OTAInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OTAInfo;
  }

  @override
  void update(void Function(OTAInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OTAInfo build() {
    final _$result = _$v ??
        new _$OTAInfo._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, 'OTAInfo', 'status'),
            uploadingPercent: BuiltValueNullFieldError.checkNotNull(
                uploadingPercent, 'OTAInfo', 'uploadingPercent'),
            code:
                BuiltValueNullFieldError.checkNotNull(code, 'OTAInfo', 'code'),
            exitCode: exitCode,
            errorText: errorText);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
