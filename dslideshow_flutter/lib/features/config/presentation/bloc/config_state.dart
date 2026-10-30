import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_state.freezed.dart';

enum ConfigPhase {
  preparing,
  preparingAddress,
  ready,
  addressUnavailable,
  failure,
  closing,
  closeFailure,
  exited,
}

enum ConfigAccessStatus { preparing, ready, failed }

enum ConfigNetworkStatus { preparing, ready, unavailable, failed }

enum ConfigExitStatus { active, closing, failed, done }

enum ConfigOperation { start, network, stop }

enum ConfigFailureKind { server, network, timeout, unknown }

@freezed
abstract class ConfigState with _$ConfigState {
  const ConfigState._();
  const factory ConfigState({
    @Default(ConfigAccessStatus.preparing) ConfigAccessStatus access,
    @Default(ConfigNetworkStatus.preparing) ConfigNetworkStatus network,
    @Default(ConfigExitStatus.active) ConfigExitStatus exit,
    String? code,
    Uri? address,
    ConfigFailureKind? startFailure,
    ConfigFailureKind? networkFailure,
    ConfigFailureKind? stopFailure,
    @Default(<ConfigOperation>{}) Set<ConfigOperation> pending,
  }) = _ConfigState;

  ConfigPhase get phase {
    switch (exit) {
      case ConfigExitStatus.closing:
        return ConfigPhase.closing;
      case ConfigExitStatus.failed:
        return ConfigPhase.closeFailure;
      case ConfigExitStatus.done:
        return ConfigPhase.exited;
      case ConfigExitStatus.active:
        break;
    }
    if (access == ConfigAccessStatus.failed) return ConfigPhase.failure;
    if (access == ConfigAccessStatus.preparing) return ConfigPhase.preparing;
    return switch (network) {
      ConfigNetworkStatus.preparing => ConfigPhase.preparingAddress,
      ConfigNetworkStatus.ready => ConfigPhase.ready,
      ConfigNetworkStatus.unavailable => ConfigPhase.addressUnavailable,
      ConfigNetworkStatus.failed => ConfigPhase.failure,
    };
  }

  ConfigFailureKind? get failure => switch (phase) {
    ConfigPhase.closeFailure => stopFailure,
    ConfigPhase.failure =>
      access == ConfigAccessStatus.failed ? startFailure : networkFailure,
    _ => null,
  };
  bool get canRetry => switch (phase) {
    ConfigPhase.failure => !pending.contains(
      access == ConfigAccessStatus.failed
          ? ConfigOperation.start
          : ConfigOperation.network,
    ),
    ConfigPhase.closeFailure => !pending.contains(ConfigOperation.stop),
    ConfigPhase.ready || ConfigPhase.addressUnavailable => !pending.contains(
      ConfigOperation.network,
    ),
    _ => false,
  };
  bool get refreshing =>
      exit == ConfigExitStatus.active &&
      network != ConfigNetworkStatus.preparing &&
      pending.contains(ConfigOperation.network);
}
