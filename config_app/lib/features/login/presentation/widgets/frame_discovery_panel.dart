import 'package:config_app/features/login/presentation/bloc/frame_discovery_bloc.dart';
import 'package:config_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_common/frame_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class FrameDiscoveryPanel extends StatelessWidget {
  const FrameDiscoveryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.localizations;
    return BlocBuilder<FrameDiscoveryBloc, FrameDiscoveryState>(
      builder: (context, discovery) {
        return BlocBuilder<LoginBloc, LoginState>(
          builder: (context, login) {
            final theme = Theme.of(context);
            final busy = discovery.status == FrameDiscoveryStatus.searching;
            final submitting = login.status.isInProgress;
            final partial = discovery.limited || discovery.unresolved > 0;
            final message = switch (discovery.status) {
              FrameDiscoveryStatus.unavailable => text.frame_discovery_unavailable,
              FrameDiscoveryStatus.failure => text.frame_discovery_failure,
              FrameDiscoveryStatus.searching when discovery.frames.isEmpty => text.frame_discovery_searching,
              FrameDiscoveryStatus.completed when discovery.frames.isEmpty && partial => text.frame_discovery_failure,
              FrameDiscoveryStatus.completed when discovery.frames.isEmpty => text.frame_discovery_empty,
              _ when partial && !busy => text.frame_discovery_partial,
              _ => null,
            };
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OverflowBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  overflowAlignment: OverflowBarAlignment.center,
                  children: [
                    Text(text.frame_discovery_title, textAlign: TextAlign.center, style: theme.textTheme.titleMedium),
                    TextButton.icon(
                      key: const Key('frame-discovery-retry'),
                      onPressed: busy || submitting
                          ? null
                          : () => context.read<FrameDiscoveryBloc>().add(const FrameDiscoveryEvent.search()),
                      icon: const Icon(Icons.refresh),
                      label: Text(text.frame_discovery_retry),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (busy)
                  const Padding(padding: EdgeInsets.only(bottom: 12), child: LinearProgressIndicator(minHeight: 2)),
                if (discovery.frames.isNotEmpty)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 260),
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: discovery.frames.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final frame = discovery.frames[index];
                        return _FrameCard(
                          frame: frame,
                          selected: login.connectUri.value == frame.connectUri.toString(),
                          onSelected: submitting
                              ? null
                              : () =>
                                    context.read<LoginBloc>().add(LoginConnectUriSelected(frame.connectUri.toString())),
                        );
                      },
                    ),
                  ),
                if (message != null) _DiscoveryMessage(message),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 12),
                  child: Text(
                    text.frame_discovery_manual,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _FrameCard extends StatelessWidget {
  const _FrameCard({required this.frame, required this.selected, required this.onSelected});

  final DiscoveredFrame frame;
  final bool selected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = context.localizations;
    return Semantics(
      key: ValueKey('frame-${frame.serviceKey}'),
      selected: selected,
      enabled: onSelected != null,
      child: Material(
        color: selected ? colors.primary.withValues(alpha: 0.10) : colors.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: selected ? colors.primary : colors.outlineVariant, width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onSelected,
          excludeFromSemantics: true,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.panorama_outlined, size: 28, color: colors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tooltip(
                        message: frame.hostname,
                        child: Text(
                          frame.hostname,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${frame.address}:${frame.port}',
                        textDirection: TextDirection.ltr,
                        style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  tooltip: selected ? text.frame_discovery_selected : text.frame_discovery_select,
                  onPressed: onSelected,
                  icon: Icon(selected ? Icons.check_circle : Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DiscoveryMessage extends StatelessWidget {
  const _DiscoveryMessage(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
      ),
    );
  }
}
