import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:config_app/features/wifi_config/presentation/widgets/available_network_tile.dart';
import 'package:config_app/features/wifi_config/presentation/widgets/connect_network_form.dart';
import 'package:config_app/features/wifi_config/presentation/widgets/saved_connection_tile.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WiFiConfigTab extends StatelessWidget {
  const WiFiConfigTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WifiTabBloc, WifiTabState>(
      builder: (context, state) {
        // 1. Состояние Загрузки
        if (state is UnWifiTabState) {
          return ConfigAppScaffold(
            appBar: AppBar(
              title: Text(context.localizations.connect_form_title),
            ),

            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Состояние Ошибки
        if (state is ErrorWifiTabState) {
          return ConfigAppScaffold(
            appBar: AppBar(
              title: Text(context.localizations.connect_form_title),
            ),

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(switch (state.kind) {
                    WifiFailureKind.unknown =>
                      context.localizations.wifi_operation_unknown,
                    WifiFailureKind.refresh =>
                      context.localizations.wifi_refresh_failed,
                    WifiFailureKind.rejected => state.errorMessage,
                  }, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => context.read<WifiTabBloc>().add(
                      const LoadWifiTabEvent(),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: Text(context.localizations.try_again_button),
                  ),
                ],
              ),
            ),
          );
        } else
        // 3. Основное состояние (Список сетей)
        if (state is InWifiTabState) {
          return ConfigAppScaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<WifiTabBloc>().add(const LoadWifiTabEvent());
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    title: Text(context.localizations.connect_form_title),
                    floating: true,
                    pinned: true,
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        tooltip: context.localizations.refresh_button,
                        // Передаем context, так как мы в StatelessWidget
                        onPressed: () => context.read<WifiTabBloc>().add(
                          const LoadWifiTabEvent(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        tooltip: context.localizations.add_manually,
                        // Передаем context, так как мы в StatelessWidget
                        onPressed: () => _showConnectBottomSheet(context),
                      ),
                    ],
                  ),

                  // Секция: Сохраненные сети
                  if (state.connections.isNotEmpty) ...[
                    _SectionHeader(
                      title: context.localizations.saved_connections_subtitle,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final connectionItem = state.connections.elementAt(
                          index,
                        );

                        return SavedConnectionTile(
                          connection: connectionItem,
                          onDelete: () {
                            _showDeleteConfirmation(context, connectionItem);
                          },
                        );
                      }, childCount: state.connections.length),
                    ),
                  ],

                  // Секция: Доступные сети
                  _SectionHeader(
                    title: context.localizations.manage_connections_subtitle,
                  ),

                  if (state.availableNetworks.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(
                          child: Text(
                            context.localizations.no_networks_found_nearby,
                          ),
                        ),
                      ),
                    ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final network = state.availableNetworks.elementAt(index);
                      return AvailableNetworkTile(
                        network: network,
                        onTap: () => _showConnectBottomSheet(
                          context,
                          ssid: network.SSID,
                        ),
                      );
                    }, childCount: state.availableNetworks.length),
                  ),

                  const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WiFiConnectionInfo connection,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.localizations.forget_network_title),
        content: Text(
          context.localizations.forget_network_question(connection.name),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.localizations.cancel_button),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () {
              context.read<WifiTabBloc>().add(
                RemoveWifiTabEvent(connection.UUID),
              );
              Navigator.pop(ctx);
            },
            child: Text(context.localizations.delete_button),
          ),
        ],
      ),
    );
  }

  void _showConnectBottomSheet(BuildContext parentContext, {String ssid = ''}) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ConnectNetworkForm(
          initialSSID: ssid,
          // Важно использовать parentContext для доступа к Bloc,
          // так как контекст внутри BottomSheet может быть оторван от провайдера выше
          wifiBloc: parentContext.read<WifiTabBloc>(),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
