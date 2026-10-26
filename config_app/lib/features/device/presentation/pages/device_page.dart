import 'package:config_app/features/device/data/device_repository.dart';
import 'package:config_app/features/device/presentation/device_monitor.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/injection_container.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DeviceSection { telemetry, controls }

class DevicePage extends StatefulWidget {
  const DevicePage({super.key, required this.section, this.monitor});

  final DeviceSection section;
  final DeviceMonitor? monitor;

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> with WidgetsBindingObserver {
  late final DeviceMonitor _monitor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _monitor =
        widget.monitor ??
        DeviceMonitor(
          DeviceRepository(sl<RealtimeService>()),
          telemetry: widget.section == DeviceSection.telemetry,
        );
    final lifecycle = WidgetsBinding.instance.lifecycleState;
    if (lifecycle != null && lifecycle != AppLifecycleState.resumed) {
      _monitor.setActive(false);
    }
    _monitor.start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _monitor.setActive(state == AppLifecycleState.resumed);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _monitor.dispose();
    super.dispose();
  }

  String _number(num value, {int decimals = 1}) =>
      NumberFormat.decimalPatternDigits(
        locale: Localizations.localeOf(context).toLanguageTag(),
        decimalDigits: decimals,
      ).format(value);

  String _time(DateTime value) =>
      '${DateFormat.yMd(Localizations.localeOf(context).toLanguageTag()).add_Hms().format(value.toUtc())} UTC';

  String _presence(FramePresence value) {
    final l = context.localizations;
    return switch (value) {
      FramePresence.present => l.device_presence_present,
      FramePresence.absent => l.device_presence_absent,
      FramePresence.unknown => l.device_presence_unknown,
    };
  }

  String _phase(FrameScreenPhase phase) {
    final l = context.localizations;
    return switch (phase) {
      FrameScreenPhase.on => l.device_screen_on,
      FrameScreenPhase.off => l.device_screen_off,
      FrameScreenPhase.waitingOff => l.device_screen_waiting,
      FrameScreenPhase.fadingOut => l.device_screen_fading_out,
      FrameScreenPhase.poweringOff => l.device_screen_powering_off,
      FrameScreenPhase.wakingUp => l.device_screen_waking,
      FrameScreenPhase.fadingIn => l.device_screen_fading_in,
      FrameScreenPhase.failed => l.device_screen_failed,
      FrameScreenPhase.unknown => l.unknown_state,
    };
  }

  String _page(FramePage page) {
    final l = context.localizations;
    return switch (page) {
      FramePage.slideshow => l.device_playback,
      FramePage.welcome => l.device_page_welcome,
      FramePage.config => l.device_page_config,
      FramePage.ota => l.device_page_ota,
      FramePage.unknown => l.unknown_state,
    };
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _monitor,
    builder: (context, _) {
      final l = context.localizations;
      final telemetry = widget.section == DeviceSection.telemetry;
      final frame = _monitor.frame;
      final metrics = _monitor.metrics;
      return ConfigAppScaffold(
        appBar: AppBar(
          title: Text(
            telemetry ? l.device_telemetry_title : l.device_controls_title,
          ),
          actions: [
            IconButton(
              key: const ValueKey('device-refresh'),
              tooltip: l.device_refresh,
              onPressed: _monitor.loading || _monitor.busy
                  ? null
                  : _monitor.refresh,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: SettingsContent(
          child: ListView(
            key: const ValueKey('device-content'),
            padding: const EdgeInsets.all(24),
            children: [
              if (_monitor.loading && frame == null && metrics == null)
                const Center(child: CircularProgressIndicator()),
              if (_monitor.failure != null)
                _Notice(
                  text: switch (_monitor.failure!.kind) {
                    DeviceFailureKind.command => l.device_command_failed,
                    DeviceFailureKind.disconnected => l.device_disconnected,
                    _ => l.device_load_failed,
                  },
                  isError: true,
                ),
              if (_monitor.stale && frame != null)
                _Notice(text: l.device_stale),
              if (frame != null) ...[
                Text(
                  '${l.device_sample_time}: ${_time(frame.sampledAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                if (telemetry)
                  _Grid(
                    children: [
                      _presenceCard(frame),
                      _statusCard(frame),
                      _displayCard(frame),
                    ],
                  )
                else
                  _controls(frame),
              ],
              if (telemetry) ...[
                if (_monitor.metricsFailure != null)
                  _Notice(text: l.device_metrics_failed, isError: true),
                if (_monitor.metricsStale && metrics != null)
                  _Notice(text: l.device_stale),
                if (metrics != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    '${l.device_metrics_time}: ${_time(DateTime.fromMillisecondsSinceEpoch(metrics.updateInfo.lastUpdate, isUtc: true))}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  _metrics(metrics),
                ],
              ],
            ],
          ),
        ),
      );
    },
  );

  Widget _presenceCard(FrameState frame) {
    final l = context.localizations;
    return _MetricCard(
      title: l.device_presence,
      icon: Icons.person_outline,
      children: [
        Text(
          _presence(frame.presence),
          key: const ValueKey('device-presence'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (frame.presenceObservedAt != null)
          _Detail(l.device_presence_time, _time(frame.presenceObservedAt!)),
      ],
    );
  }

  Widget _statusCard(FrameState frame) {
    final l = context.localizations;
    final frontend = frame.frontend;
    return _MetricCard(
      title: l.device_controls_title,
      icon: Icons.settings_remote_outlined,
      children: [
        if (frontend == null)
          Text(l.device_frontend_unavailable)
        else ...[
          _Detail(l.device_current_page, _page(frontend.page)),
          _Detail(
            l.device_playback,
            frontend.isPaused ? l.device_paused : l.device_playing,
          ),
          _Detail(
            l.device_menu,
            frontend.isMenu ? l.device_menu_open : l.device_menu_closed,
          ),
        ],
        _Detail(
          l.device_screen,
          frame.isScreenOn == null
              ? l.unknown_state
              : frame.isScreenOn!
              ? l.device_screen_on
              : l.device_screen_off,
        ),
        _Detail(l.device_screen_phase, _phase(frame.screenPhase)),
        _Detail(
          l.device_screen_lock,
          frame.isScreenLocked ? l.enabled_label : l.disabled_label,
        ),
        Text(
          l.device_screen_power_help,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _controls(FrameState frame) {
    final l = context.localizations;
    final frontend = frame.frontend;
    final available = _monitor.canControl && frontend != null;
    final slideshow = available && frontend.page == FramePage.slideshow;
    final turnOn = frame.isScreenLocked || frame.isScreenOn != true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (frontend == null)
          _Notice(text: l.device_frontend_unavailable)
        else if (frontend.page != FramePage.slideshow)
          _Notice(text: l.device_controls_context),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              key: const ValueKey('device-pause'),
              onPressed: slideshow
                  ? () => _monitor.setControl(
                      FrameControl.pause,
                      !frontend.isPaused,
                    )
                  : null,
              icon: _pendingIcon(
                FrameControl.pause,
                frontend?.isPaused == true ? Icons.play_arrow : Icons.pause,
              ),
              label: Text(
                frontend?.isPaused == true ? l.preview_resume : l.preview_pause,
              ),
            ),
            FilledButton.tonalIcon(
              key: const ValueKey('device-menu'),
              onPressed: slideshow
                  ? () =>
                        _monitor.setControl(FrameControl.menu, !frontend.isMenu)
                  : null,
              icon: _pendingIcon(FrameControl.menu, Icons.menu),
              label: Text(
                frontend?.isMenu == true
                    ? l.device_close_menu
                    : l.device_open_menu,
              ),
            ),
            FilledButton.tonalIcon(
              key: const ValueKey('device-screen'),
              onPressed: available
                  ? () => _monitor.setControl(FrameControl.screen, turnOn)
                  : null,
              icon: _pendingIcon(FrameControl.screen, Icons.power_settings_new),
              label: Text(turnOn ? l.device_turn_on : l.device_turn_off),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _Grid(children: [_statusCard(frame), _presenceCard(frame)]),
      ],
    );
  }

  Widget _pendingIcon(FrameControl control, IconData icon) =>
      _monitor.pendingControl == control
      ? const SizedBox.square(
          dimension: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
      : Icon(icon);

  Widget _displayCard(FrameState frame) {
    final l = context.localizations;
    final frontend = frame.frontend;
    final display = frontend?.display;
    return _MetricCard(
      title: l.device_versions_display,
      icon: Icons.monitor,
      children: [
        _Detail(l.device_backend_version, frame.backendVersion),
        _Detail(
          l.device_frontend_version,
          frontend?.frontendVersion ?? l.device_no_data,
        ),
        if (display == null)
          _Detail(l.device_screen, l.device_no_data)
        else ...[
          _Detail(
            l.device_physical_size,
            l.device_pixels(
              _number(display.physicalWidth, decimals: 0),
              _number(display.physicalHeight, decimals: 0),
            ),
          ),
          _Detail(
            l.device_logical_size,
            l.device_logical_pixels(
              _number(display.logicalWidth),
              _number(display.logicalHeight),
            ),
          ),
          _Detail(
            l.device_pixel_ratio,
            _number(display.pixelRatio, decimals: 2),
          ),
        ],
      ],
    );
  }

  Widget _metrics(SystemInfo model) {
    final l = context.localizations;
    final update = model.updateInfo;
    String memory(int used, int total) =>
        '${l.device_mib(_number(used / 1024))} / ${l.device_mib(_number(total / 1024))}';
    return _Grid(
      children: [
        _MetricCard(
          title: l.device_cpu,
          icon: Icons.developer_board,
          children: [
            _Detail(l.device_cpu_model, model.cpuInfo.model),
            _Detail(l.device_cpu_hardware, model.cpuInfo.hardware),
            _Detail(l.device_cpu_revision, model.cpuInfo.revision),
            _Detail(
              l.device_cpu_cores,
              _number(model.cpuInfo.cores, decimals: 0),
            ),
            _Detail(
              l.device_cpu_load,
              '${_number(update.cpuLoad1, decimals: 2)} / ${_number(update.cpuLoad5, decimals: 2)} / ${_number(update.cpuLoad15, decimals: 2)}',
            ),
          ],
        ),
        _MetricCard(
          title: l.device_os,
          icon: Icons.computer,
          children: [
            _Detail(l.device_os, model.osInfo.name),
            _Detail(l.device_uptime, update.uptime.trim()),
          ],
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
            _Detail(
              l.device_disk_usage,
              memory(update.diskUsed, update.diskUsed + update.diskAvailable),
            ),
            _Detail(
              l.device_disk_percent,
              NumberFormat.percentPattern(
                Localizations.localeOf(context).toLanguageTag(),
              ).format(update.diskUsedPercent / 100),
            ),
            _Usage(
              used: update.diskUsed,
              total: update.diskUsed + update.diskAvailable,
            ),
          ],
        ),
        _MetricCard(
          title: l.device_network,
          icon: Icons.lan_outlined,
          children: [
            _Detail(
              l.device_internet,
              model.networkInfo.hasInternet
                  ? l.device_online
                  : l.device_offline,
            ),
            for (final interface
                in model.networkInfo.interfaces ??
                    <NetworkInterfaceInfo>[]) ...[
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
              _time(
                DateTime.fromMillisecondsSinceEpoch(
                  model.networkInfo.lastUpdate,
                  isUtc: true,
                ),
              ),
            ),
          ],
        ),
        _MetricCard(
          title: l.device_sensors,
          icon: Icons.sensors,
          children: [
            if (update.sensors.isEmpty) Text(l.device_no_data),
            for (final sensor in update.sensors)
              _Detail(sensor.name, sensor.value),
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
        children: [
          for (final child in children) SizedBox(width: width, child: child),
        ],
      );
    },
  );
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.icon,
    required this.children,
  });
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
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
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
        SelectableText(
          value.isEmpty ? context.localizations.device_no_data : value,
        ),
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
          color: isError
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
