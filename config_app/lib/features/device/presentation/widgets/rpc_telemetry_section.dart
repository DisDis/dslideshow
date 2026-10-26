import 'package:config_app/features/device/presentation/rpc_rates.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RpcTelemetrySection extends StatelessWidget {
  final RpcTelemetrySnapshot? snapshot;
  final bool stale;
  final RpcRates rates;
  final int? webSocketTimeouts;
  const RpcTelemetrySection({
    super.key,
    required this.snapshot,
    required this.stale,
    required this.rates,
    this.webSocketTimeouts,
  });

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    String nodeLabel(RpcNode node) => switch (node) {
      RpcNode.frontend => l.rpc_node_frontend,
      RpcNode.backend => l.rpc_node_backend,
      RpcNode.web => l.rpc_node_web,
      RpcNode.ota => l.rpc_node_ota,
      RpcNode.unknown => l.unknown_state,
    };
    String number(num value) => NumberFormat.decimalPatternDigits(
      locale: Localizations.localeOf(context).toLanguageTag(),
      decimalDigits: 1,
    ).format(value);
    String duration(num micros) => l.rpc_milliseconds(number(micros / 1000));
    String timing(RpcDurationSnapshot value) => value.count == 0
        ? '—'
        : l.rpc_duration_summary(
            duration(value.meanMicros),
            duration(value.maxMicros),
          );
    String oldest(RpcPendingSnapshot? value) => value == null
        ? l.rpc_no_pending
        : l.rpc_pending_value(
            value.commandType ?? l.rpc_unknown_command,
            duration(value.ageMicros),
          );
    RpcNodeSnapshot? findNode(RpcNode node) {
      for (final value in snapshot?.nodes ?? const <RpcNodeSnapshot>[]) {
        if (value.node == node) return value;
      }
      return null;
    }

    final children = <Widget>[
      Text(l.rpc_title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      Text(l.rpc_description),
      if (stale && snapshot != null) Text(l.device_stale),
      if (webSocketTimeouts != null)
        _Line(l.rpc_ws_timeouts, '$webSocketTimeouts'),
    ];
    for (final node in RpcNode.values.where(
      (node) => node != RpcNode.unknown,
    )) {
      final local = findNode(node);
      if (local == null) {
        children.add(_Line(nodeLabel(node), l.rpc_unavailable));
        continue;
      }
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            nodeLabel(node),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
      final sampled = DateFormat.yMd(
        Localizations.localeOf(context).toLanguageTag(),
      ).add_Hms().format(local.sampledAt.toUtc());
      children.add(Text('${l.device_sample_time}: $sampled UTC'));
      if (local.stale) children.add(Text(l.device_stale));
      for (final connection in local.connections) {
        final outgoing = connection.outgoing;
        final rate = (stale || local.stale)
            ? null
            : rates.forConnection(node, connection.peer);
        final receiver = findNode(connection.peer);
        RpcHandlerSnapshot? handlers;
        for (final reverse
            in receiver?.connections ?? const <RpcConnectionSnapshot>[]) {
          if (reverse.peer == node) handlers = reverse.incoming;
        }
        final details = <Widget>[
          _Line(l.rpc_peak_inflight, '${outgoing.maxInFlight}'),
          _Line(l.rpc_peak_queued, '${outgoing.maxQueued}'),
          _Line(l.rpc_submitted, '${outgoing.submitted}'),
          _Line(l.rpc_sent, '${outgoing.sent}'),
          _Line(l.rpc_responses, '${outgoing.responses}'),
          _Line(
            l.rpc_errors,
            '${outgoing.transportErrors + outgoing.responseErrors}',
          ),
          _Line(l.rpc_slot_wait, timing(outgoing.slotWait)),
          _Line(l.rpc_response_wait, timing(outgoing.responseWait)),
          _Line(l.rpc_oldest_queued, oldest(outgoing.oldestQueued)),
          _Line(l.rpc_oldest_inflight, oldest(outgoing.oldestInFlight)),
          if (handlers != null) ...[
            if (receiver!.stale) Text(l.rpc_receiver_stale),
            _Line(l.rpc_handlers_active, '${handlers.active}'),
            _Line(l.rpc_handlers_completed, '${handlers.completed}'),
            _Line(l.rpc_handlers_errors, '${handlers.errors}'),
            _Line(l.rpc_handler_duration, timing(handlers.duration)),
          ] else
            Text(l.rpc_receiver_unavailable),
        ];
        children.add(
          Card(
            child: ExpansionTile(
              key: ValueKey('rpc-${node.name}-${connection.peer.name}'),
              title: Text('${nodeLabel(node)} → ${nodeLabel(connection.peer)}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.rpc_occupancy(
                      outgoing.inFlight,
                      outgoing.capacity,
                      outgoing.queued,
                    ),
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: outgoing.capacity <= 0
                        ? 0
                        : (outgoing.inFlight / outgoing.capacity)
                              .clamp(0, 1)
                              .toDouble(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l.rpc_rate_summary(
                      rate == null ? '—' : number(rate.sent),
                      rate == null ? '—' : number(rate.responses),
                    ),
                  ),
                ],
              ),
              childrenPadding: const EdgeInsets.all(16),
              children: details,
            ),
          ),
        );
      }
    }
    return Column(
      key: const ValueKey('rpc-telemetry'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}

class _Line extends StatelessWidget {
  final String label, value;
  const _Line(this.label, this.value);
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 16,
        children: [Text(label), Text(value)],
      ),
    ),
  );
}
