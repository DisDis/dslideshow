// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_menu_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MainMenuEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MainMenuEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MainMenuEvent()';
  }
}

/// @nodoc
class $MainMenuEventCopyWith<$Res> {
  $MainMenuEventCopyWith(MainMenuEvent _, $Res Function(MainMenuEvent) __);
}

/// @nodoc

class MainMenuSelectEvent implements MainMenuEvent {
  const MainMenuSelectEvent(this.index);

  final int index;

  /// Create a copy of MainMenuEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MainMenuSelectEventCopyWith<MainMenuSelectEvent> get copyWith =>
      _$MainMenuSelectEventCopyWithImpl<MainMenuSelectEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MainMenuSelectEvent &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @override
  String toString() {
    return 'MainMenuEvent.select(index: $index)';
  }
}

/// @nodoc
abstract mixin class $MainMenuSelectEventCopyWith<$Res>
    implements $MainMenuEventCopyWith<$Res> {
  factory $MainMenuSelectEventCopyWith(
          MainMenuSelectEvent value, $Res Function(MainMenuSelectEvent) _then) =
      _$MainMenuSelectEventCopyWithImpl;
  @useResult
  $Res call({int index});
}

/// @nodoc
class _$MainMenuSelectEventCopyWithImpl<$Res>
    implements $MainMenuSelectEventCopyWith<$Res> {
  _$MainMenuSelectEventCopyWithImpl(this._self, this._then);

  final MainMenuSelectEvent _self;
  final $Res Function(MainMenuSelectEvent) _then;

  /// Create a copy of MainMenuEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? index = null,
  }) {
    return _then(MainMenuSelectEvent(
      null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class MainMenuExecuteEvent implements MainMenuEvent {
  const MainMenuExecuteEvent([this.command]);

  final MenuCommand? command;

  /// Create a copy of MainMenuEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MainMenuExecuteEventCopyWith<MainMenuExecuteEvent> get copyWith =>
      _$MainMenuExecuteEventCopyWithImpl<MainMenuExecuteEvent>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MainMenuExecuteEvent &&
            (identical(other.command, command) || other.command == command));
  }

  @override
  int get hashCode => Object.hash(runtimeType, command);

  @override
  String toString() {
    return 'MainMenuEvent.execute(command: $command)';
  }
}

/// @nodoc
abstract mixin class $MainMenuExecuteEventCopyWith<$Res>
    implements $MainMenuEventCopyWith<$Res> {
  factory $MainMenuExecuteEventCopyWith(MainMenuExecuteEvent value,
          $Res Function(MainMenuExecuteEvent) _then) =
      _$MainMenuExecuteEventCopyWithImpl;
  @useResult
  $Res call({MenuCommand? command});
}

/// @nodoc
class _$MainMenuExecuteEventCopyWithImpl<$Res>
    implements $MainMenuExecuteEventCopyWith<$Res> {
  _$MainMenuExecuteEventCopyWithImpl(this._self, this._then);

  final MainMenuExecuteEvent _self;
  final $Res Function(MainMenuExecuteEvent) _then;

  /// Create a copy of MainMenuEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? command = freezed,
  }) {
    return _then(MainMenuExecuteEvent(
      freezed == command
          ? _self.command
          : command // ignore: cast_nullable_to_non_nullable
              as MenuCommand?,
    ));
  }
}

/// @nodoc
mixin _$MainMenuState {
  int get selectedIndex;

  /// Create a copy of MainMenuState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MainMenuStateCopyWith<MainMenuState> get copyWith =>
      _$MainMenuStateCopyWithImpl<MainMenuState>(
          this as MainMenuState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MainMenuState &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedIndex);

  @override
  String toString() {
    return 'MainMenuState(selectedIndex: $selectedIndex)';
  }
}

/// @nodoc
abstract mixin class $MainMenuStateCopyWith<$Res> {
  factory $MainMenuStateCopyWith(
          MainMenuState value, $Res Function(MainMenuState) _then) =
      _$MainMenuStateCopyWithImpl;
  @useResult
  $Res call({int selectedIndex});
}

/// @nodoc
class _$MainMenuStateCopyWithImpl<$Res>
    implements $MainMenuStateCopyWith<$Res> {
  _$MainMenuStateCopyWithImpl(this._self, this._then);

  final MainMenuState _self;
  final $Res Function(MainMenuState) _then;

  /// Create a copy of MainMenuState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndex = null,
  }) {
    return _then(_self.copyWith(
      selectedIndex: null == selectedIndex
          ? _self.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _MainMenuStateState implements MainMenuState {
  const _MainMenuStateState({required this.selectedIndex});

  @override
  final int selectedIndex;

  /// Create a copy of MainMenuState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MainMenuStateStateCopyWith<_MainMenuStateState> get copyWith =>
      __$MainMenuStateStateCopyWithImpl<_MainMenuStateState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MainMenuStateState &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedIndex);

  @override
  String toString() {
    return 'MainMenuState(selectedIndex: $selectedIndex)';
  }
}

/// @nodoc
abstract mixin class _$MainMenuStateStateCopyWith<$Res>
    implements $MainMenuStateCopyWith<$Res> {
  factory _$MainMenuStateStateCopyWith(
          _MainMenuStateState value, $Res Function(_MainMenuStateState) _then) =
      __$MainMenuStateStateCopyWithImpl;
  @override
  @useResult
  $Res call({int selectedIndex});
}

/// @nodoc
class __$MainMenuStateStateCopyWithImpl<$Res>
    implements _$MainMenuStateStateCopyWith<$Res> {
  __$MainMenuStateStateCopyWithImpl(this._self, this._then);

  final _MainMenuStateState _self;
  final $Res Function(_MainMenuStateState) _then;

  /// Create a copy of MainMenuState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectedIndex = null,
  }) {
    return _then(_MainMenuStateState(
      selectedIndex: null == selectedIndex
          ? _self.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
