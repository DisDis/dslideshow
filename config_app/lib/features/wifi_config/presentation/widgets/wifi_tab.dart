import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:config_app/features/wifi_config/presentation/widgets/available_network_tile.dart';
import 'package:config_app/features/wifi_config/presentation/widgets/connect_network_form.dart';
import 'package:config_app/features/wifi_config/presentation/widgets/saved_connection_tile.dart';
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
          return Scaffold(
            appBar: AppBar(title: const Text("WiFi Configuration")),
            drawer: const ConfigAppNavigationBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Состояние Ошибки
        if (state is ErrorWifiTabState) {
          return Scaffold(
            appBar: AppBar(title: const Text("WiFi Configuration")),
            drawer: const ConfigAppNavigationBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(state.errorMessage, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => context
                        .read<WifiTabBloc>()
                        .add(const LoadWifiTabEvent()),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reload'),
                  ),
                ],
              ),
            ),
          );
        } else
        // 3. Основное состояние (Список сетей)
        if (state is InWifiTabState) {
          return Scaffold(
            drawer: const ConfigAppNavigationBar(),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<WifiTabBloc>().add(const LoadWifiTabEvent());
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text("WiFi Configuration"),
                    floating: true,
                    pinned: true,
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        tooltip: "Refresh",
                        // Передаем context, так как мы в StatelessWidget
                        onPressed: () => context.read<WifiTabBloc>().add(const LoadWifiTabEvent()),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        tooltip: "Add manually",
                        // Передаем context, так как мы в StatelessWidget
                        onPressed: () => _showConnectBottomSheet(context),
                      )
                    ],
                  ),

                // Секция: Сохраненные сети
                if (state.connections.isNotEmpty) ...[
                  const _SectionHeader(title: "Saved Connections"),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final connection = state.connections.elementAt(index);
                        return SavedConnectionTile(connection: connection);
                      },
                      childCount: state.connections.length,
                    ),
                  ),
                ],

                // Секция: Доступные сети
                const _SectionHeader(title: "Nearby Networks"),

                if (state.availableNetworks.isEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(child: Text("No networks found nearby")),
                    ),
                  ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final network =
                            state.availableNetworks.elementAt(index);
                        return AvailableNetworkTile(
                          network: network,
                          onTap: () => _showConnectBottomSheet(context,
                              ssid: network.SSID),
                        );
                      },
                      childCount: state.availableNetworks.length,
                    ),
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

  void _showConnectBottomSheet(BuildContext parentContext, {String ssid = ''}) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Padding(
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
