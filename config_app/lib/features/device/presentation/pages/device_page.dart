import 'package:config_app/features/device/data/device_repository.dart';
import 'package:config_app/features/device/presentation/device_bloc.dart';
import 'package:config_app/features/device/presentation/device_state.dart';
import 'package:config_app/features/device/presentation/widgets/device_status_card.dart';
import 'package:config_app/features/device/presentation/widgets/rpc_telemetry_section.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

enum DeviceSection { telemetry, controls }

class DevicePage extends StatelessWidget {
  const DevicePage({super.key, required this.section});
  final DeviceSection section;

  String _number(BuildContext context, num value, {int decimals = 1}) => NumberFormat.decimalPatternDigits(
    locale: Localizations.localeOf(context).toLanguageTag(),
    decimalDigits: decimals,
  ).format(value);

  String _time(BuildContext context, DateTime value) =>
      '${DateFormat.yMd(Localizations.localeOf(context).toLanguageTag()).add_Hms().format(value.toUtc())} UTC';

  String _presence(BuildContext context, FramePresence value) {
    final l = context.localizations;
    return switch (value) {
      FramePresence.present => l.device_presence_present,
      FramePresence.absent => l.device_presence_absent,
      FramePresence.unknown => l.device_presence_unknown,
    };
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<DeviceBloc, DeviceState>(
    builder: (context, state) {
      final bloc = context.read<DeviceBloc>();
      final l = context.localizations;
      final telemetry = section == DeviceSection.telemetry;
      final frame = state.frame;
      final metrics = state.metrics;
      return ConfigAppScaffold(
        appBar: AppBar(
          title: Text(telemetry ? l.device_telemetry_title : l.device_controls_title),
          actions: [
            IconButton(
              key: const ValueKey('device-refresh'),
              tooltip: l.device_refresh,
              onPressed: state.loading || state.commandInFlight || !state.connected ? null : bloc.refresh,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: SettingsContent(
          child: ListView(
            key: const ValueKey('device-content'),
            padding: const EdgeInsets.all(24),
            children: [
              if (state.loading && frame == null) const Center(child: CircularProgressIndicator()),
              if (frame == null && state.failure != null)
                _Notice(
                  text: state.failure!.kind == DeviceFailureKind.disconnected
                      ? l.device_disconnected
                      : l.device_load_failed,
                  isError: true,
                ),
              if (frame != null) ...[
                if (telemetry)
                  _Grid(
                    children: [
                      _statusCard(context, state),
                      _presenceCard(context, frame),
                      _displayCard(context, frame),
                    ],
                  )
                else ...[
                  _statusCard(context, state),
                  const SizedBox(height: 16),
                  _presenceCard(context, frame),
                ],
              ],
              if (telemetry) ...[
                if (state.metricsFailure != null) _Notice(text: l.device_metrics_failed, isError: true),
                if (state.metricsStale && metrics != null) _Notice(text: l.device_stale),
                if (metrics != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    '${l.device_metrics_time}: ${_time(context, state.metricsSampledAt!)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  _metrics(context, metrics),
                ],
                const SizedBox(height: 24),
                RpcTelemetrySection(
                  snapshot: state.rpc,
                  stale: state.rpcStale,
                  rates: bloc.rpcRates,
                  webSocketTimeouts: state.webSocketTimeouts,
                ),
              ],
            ],
          ),
        ),
      );
    },
  );

  Widget _statusCard(BuildContext context, DeviceState state) {
    final bloc = context.read<DeviceBloc>();
    return DeviceStatusCard(
      frame: state.frame!,
      stale: state.stale,
      failure: state.failure?.kind,
      canControl: state.canControl,
      pendingControl: state.pendingControl,
      detailsExpanded: state.detailsExpanded,
      onDetailsChanged: bloc.setDetailsExpanded,
      onControl: section == DeviceSection.controls ? bloc.setControl : null,
    );
  }

  Widget _presenceCard(BuildContext context, FrameState frame) {
    final l = context.localizations;
    return _MetricCard(
      title: l.device_presence,
      icon: Icons.person_outline,
      children: [
        Text(
          _presence(context, frame.presence),
          key: const ValueKey('device-presence'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (frame.presenceObservedAt != null)
          _Detail(l.device_presence_time, _time(context, frame.presenceObservedAt!)),
      ],
    );
  }

  Widget _displayCard(BuildContext context, FrameState frame) {
    final l = context.localizations;
    final frontend = frame.frontend;
    final display = frontend?.display;
    return _MetricCard(
      title: l.device_versions_display,
      icon: Icons.monitor,
      children: [
        _Detail(l.device_backend_version, frame.backendVersion),
        _Detail(l.device_frontend_version, frontend?.frontendVersion ?? l.device_no_data),
        if (display == null)
          _Detail(l.device_screen, l.device_no_data)
        else ...[
          _Detail(
            l.device_physical_size,
            l.device_pixels(
              _number(context, display.physicalWidth, decimals: 0),
              _number(context, display.physicalHeight, decimals: 0),
            ),
          ),
          _Detail(
            l.device_logical_size,
            l.device_logical_pixels(_number(context, display.logicalWidth), _number(context, display.logicalHeight)),
          ),
          _Detail(l.device_pixel_ratio, _number(context, display.pixelRatio, decimals: 2)),
        ],
      ],
    );
  }

  Widget _metrics(BuildContext context, SystemInfo model) {
    final l = context.localizations;
    final update = model.updateInfo;
    String memory(int used, int total) =>
        '${l.device_mib(_number(context, used / 1024))} / ${l.device_mib(_number(context, total / 1024))}';
    return _Grid(
      children: [
        _MetricCard(
          title: l.device_cpu,
          icon: Icons.developer_board,
          children: [
            _Detail(l.device_cpu_model, model.cpuInfo.model),
            _Detail(l.device_cpu_hardware, model.cpuInfo.hardware),
            _Detail(l.device_cpu_revision, model.cpuInfo.revision),
            _Detail(l.device_cpu_cores, _number(context, model.cpuInfo.cores, decimals: 0)),
            _Detail(
              l.device_cpu_load,
              '${_number(context, update.cpuLoad1, decimals: 2)} / ${_number(context, update.cpuLoad5, decimals: 2)} / ${_number(context, update.cpuLoad15, decimals: 2)}',
            ),
          ],
        ),
        _MetricCard(
          title: l.device_os,
          icon: Icons.computer,
          children: [_Detail(l.device_os, model.osInfo.name), _Detail(l.device_uptime, update.uptime.trim())],
        ),
        _MetricCard(
          title: l.device_memory,
          icon: Icons.memory,
          children: [
            _Detail(l.device_ram, memory(update.memUsed, update.memTotal)),
            _Usage(used: update.memUsed, total: update.memTotal),
            _Detail(l.device_swap, memory(update.swapUsed, update.swapTotal)),
            _Usage(used: update.swapUsed, total: update.swapTotal),
          ],
        ),
        _MetricCard(
          title: l.device_disk,
          icon: Icons.storage,
          children: [
            _Detail(l.device_disk_usage, memory(update.diskUsed, update.diskUsed + update.diskAvailable)),
            _Detail(
              l.device_disk_percent,
              NumberFormat.percentPattern(Localizations.localeOf(context).toLanguageTag())
                  .format(update.diskUsedPercent / 100),
            ),
            _Usage(used: update.diskUsed, total: update.diskUsed + update.diskAvailable),
          ],
        ),
        _MetricCard(
          title: l.device_network,
          icon: Icons.lan_outlined,
          children: [
            _Detail(l.device_internet, model.networkInfo.hasInternet ? l.device_online : l.device_offline),
            for (final interface in model.networkInfo.interfaces ?? <NetworkInterfaceInfo>[]) ...[
              const Divider(),
              _Detail(
                interface.name,
                interface.status == NetworkInterfaceStatus.running
                    ? l.device_interface_running
                    : l.device_interface_offline,
              ),
              if (interface.ip4.isNotEmpty) SelectableText(interface.ip4),
              if (interface.ip6.isNotEmpty) SelectableText(interface.ip6),
            ],
            _Detail(
              l.device_network_time,
              _time(context, DateTime.fromMillisecondsSinceEpoch(model.networkInfo.lastUpdate, isUtc: true)),
            ),
          ],
        ),
        _MetricCard(
          title: l.device_sensors,
          icon: Icons.sensors,
          children: [
            if (update.sensors.isEmpty) Text(l.device_no_data),
            for (final sensor in update.sensors) _Detail(sensor.name, sensor.value),
          ],
        ),
      ],
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, size) {
      final columns = size.maxWidth >= 680 ? 2 : 1;
      final width = (size.maxWidth - (columns - 1) * 16) / columns;
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [for (final child in children) SizedBox(width: width, child: child)],
      );
    },
  );
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.title, required this.icon, required this.children});
  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    ),
  );
}

class _Detail extends StatelessWidget {
  const _Detail(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 2),
        SelectableText(value.isEmpty ? context.localizations.device_no_data : value),
      ],
    ),
  );
}

class _Usage extends StatelessWidget {
  const _Usage({required this.used, required this.total});
  final int used;
  final int total;

  @override
  Widget build(BuildContext context) => total <= 0
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: LinearProgressIndicator(value: (used / total).clamp(0, 1)),
        );
}

class _Notice extends StatelessWidget {
  const _Notice({required this.text, this.isError = false});
  final String text;
  final bool isError;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isError ? Icons.error_outline : Icons.info_outline,
          color: isError ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
