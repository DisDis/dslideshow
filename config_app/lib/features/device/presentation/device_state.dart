import 'package:config_app/features/device/data/device_repository.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_state.freezed.dart';

@freezed
abstract class DeviceState with _$DeviceState {
  const DeviceState._();

  const factory DeviceState({
    FrameState? frame,
    SystemInfo? metrics,
    RpcTelemetrySnapshot? rpc,
    DateTime? metricsSampledAt,
    int? webSocketTimeouts,
    DeviceFailure? failure,
    DeviceFailure? metricsFailure,
    FrameControl? pendingControl,
    @Default(false) bool started,
    @Default(true) bool active,
    @Default(true) bool connected,
    @Default(false) bool commandInFlight,
    @Default(false) bool loading,
    @Default(true) bool stale,
    @Default(true) bool metricsStale,
    @Default(true) bool rpcStale,
    @Default(false) bool detailsExpanded,
  }) = _DeviceState;

  bool get canControl => started && active && connected && frame != null && !stale && !commandInFlight;
}
