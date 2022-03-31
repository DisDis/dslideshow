import 'package:dslideshow_backend/command.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ota_event.freezed.dart';

@freezed
class OtaEvent with _$OtaEvent {
  const factory OtaEvent.initialization() = OtaInitializationEvent;
  const factory OtaEvent.updateInfo(OTAInfo info) = OtaUpdateInfoEvent;
  const factory OtaEvent.ready() = OtaReadyEvent;
  const factory OtaEvent.exit() = OtaExitEvent;
  const factory OtaEvent.terminalUpdate() = OtaTerminalUpdateEvent;
}
