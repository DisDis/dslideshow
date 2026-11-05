import 'package:config_app/features/config/domain/night_mode_settings_validation.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'wake_settings_cubit.freezed.dart';

@freezed
sealed class WakeSettingsState with _$WakeSettingsState {
  const WakeSettingsState._();

  const factory WakeSettingsState({
    required NightModeConfig config,
    required Map<WakeField, String> inputs,
    @Default({}) Map<WakeField, WakeInputError> errors,
    FrameState? device,
  }) = _WakeSettingsState;

  bool get invalid => errors.isNotEmpty;
}

class WakeSettingsCubit extends Cubit<WakeSettingsState> {
  WakeSettingsCubit(this._draft, {Future<FrameState> Function()? readDevice})
    : super(
        WakeSettingsState(
          config: _draft.nightMode,
          inputs: {
            WakeField.absence: _draft.hardware.screenPowerOnTimerSec.toString(),
            WakeField.start: NightModeConfig.formatTime(_draft.nightMode.startMinute),
            WakeField.end: NightModeConfig.formatTime(_draft.nightMode.endMinute),
            WakeField.topic: _draft.nightMode.ambientLight.topic,
            WakeField.valueField: _draft.nightMode.ambientLight.valueField,
            WakeField.availabilityTopic: _draft.nightMode.ambientLight.availabilityTopic,
            WakeField.darkBelow: _draft.nightMode.ambientLight.darkBelowLux.toString(),
            WakeField.lightAbove: _draft.nightMode.ambientLight.lightAboveLux.toString(),
            WakeField.maxAge: _draft.nightMode.ambientLight.maxAgeSec.toString(),
          },
        ),
      ) {
    if (readDevice != null) _loadDevice(readDevice);
  }

  static final _log = Logger('WakeSettingsCubit');
  final AppConfig _draft;

  void change(WakeField field, String value) => _commit(state.copyWith(inputs: {...state.inputs, field: value}));
  void enable(bool enabled) => _commit(state.copyWith(config: state.config.copyWith(enabled: enabled)));
  void mode(NightMode mode) => _commit(state.copyWith(config: state.config.copyWith(mode: mode)));
  void enableLight(bool enabled) => _commit(
    state.copyWith(
      config: state.config.copyWith(ambientLight: state.config.ambientLight.copyWith(enabled: enabled)),
    ),
  );

  void _commit(WakeSettingsState candidate) {
    final raw = candidate.inputs;
    final errors = <WakeField, WakeInputError>{};
    final numbers = <WakeField, int>{};
    for (final field in [WakeField.absence, WakeField.darkBelow, WakeField.lightAbove, WakeField.maxAge]) {
      final value = int.tryParse(raw[field]!);
      if (value == null) {
        errors[field] = WakeInputError.integer;
      } else {
        numbers[field] = value;
      }
    }
    final times = <WakeField, int>{};
    for (final field in [WakeField.start, WakeField.end]) {
      try {
        times[field] = NightModeConfig.parseTime(raw[field]!);
      } on FormatException {
        errors[field] = WakeInputError.time;
      }
    }
    if (errors.isNotEmpty) {
      emit(candidate.copyWith(errors: errors));
      return;
    }
    final absence = numbers[WakeField.absence]!;
    if (absence < 0) errors[WakeField.absence] = WakeInputError.nonnegativeInteger;
    final config = candidate.config.copyWith(
      startMinute: times[WakeField.start]!,
      endMinute: times[WakeField.end]!,
      ambientLight: candidate.config.ambientLight.copyWith(
        topic: raw[WakeField.topic]!.trim(),
        valueField: raw[WakeField.valueField]!.trim(),
        availabilityTopic: raw[WakeField.availabilityTopic]!.trim(),
        darkBelowLux: numbers[WakeField.darkBelow]!,
        lightAboveLux: numbers[WakeField.lightAbove]!,
        maxAgeSec: numbers[WakeField.maxAge]!,
      ),
    );
    errors.addAll(config.validationErrors);
    if (errors.isEmpty) {
      _draft.nightMode = config;
      _draft.hardware.screenPowerOnTimerSec = absence;
    }
    // Raw invalid text belongs to the editor; shared settings stay valid.
    emit(candidate.copyWith(config: errors.isEmpty ? config : candidate.config, errors: errors));
  }

  Future<void> _loadDevice(Future<FrameState> Function() read) async {
    _log.info('Wake settings device state requested');
    try {
      final device = await read();
      if (isClosed) {
        _log.info('Wake settings device state cancelled');
        return;
      }
      emit(state.copyWith(device: device));
      _log.info('Wake settings device state received');
    } catch (error, stack) {
      _log.log(isClosed ? Level.FINE : Level.WARNING, 'Wake settings device state failed', error, stack);
    }
  }
}
