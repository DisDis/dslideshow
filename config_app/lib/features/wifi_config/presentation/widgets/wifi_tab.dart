import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart'; // Импорт Drawer
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WiFiConfigTab extends StatefulWidget {
  const WiFiConfigTab({super.key});

  @override
  State<WiFiConfigTab> createState() => _WiFiConfigTabState();
}

class _WiFiConfigTabState extends State<WiFiConfigTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WifiTabBloc, WifiTabState>(
      builder: (context, state) {
        // 1. Состояние Загрузки
        if (state is UnWifiTabState) {
          return Scaffold(
            appBar: AppBar(title: const Text("WiFi Config")),
            drawer: const ConfigAppNavigationBar(), // <-- Drawer здесь
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Состояние Ошибки
        if (state is ErrorWifiTabState) {
          return Scaffold(
            appBar: AppBar(title: const Text("WiFi Config")),
            drawer: const ConfigAppNavigationBar(), // <-- Drawer здесь
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
        }

        // 3. Основное состояние (Список сетей)
        if (state is InWifiTabState) {
          return Scaffold(
            // ВАЖНО: Добавляем Drawer в основной Scaffold
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
                        icon: const Icon(Icons.add),
                        tooltip: "Add manually",
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
                          return _SavedConnectionTile(connection: connection);
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
                        final network = state.availableNetworks.elementAt(index);
                        return _AvailableNetworkTile(
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
        // Передаем Блок через parentContext, так как BottomSheet - это новый роут
        child: _ConnectNetworkForm(
          initialSSID: ssid,
          wifiBloc: parentContext.read<WifiTabBloc>(),
        ),
      ),
    );
  }
}

// --- Вспомогательные виджеты UI (остаются теми же) ---

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

class _SavedConnectionTile extends StatelessWidget {
  final WiFiConnectionInfo connection;
  const _SavedConnectionTile({required this.connection});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.withOpacity(0.1),
        child: const Icon(Icons.wifi, color: Colors.green),
      ),
      title: Text(connection.name,
          style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text("Device: ${connection.device} • ${connection.type}"),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}

class _AvailableNetworkTile extends StatelessWidget {
  final WiFiNetworkInfo network;
  final VoidCallback onTap;

  const _AvailableNetworkTile({required this.network, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color signalColor;
    if (network.signal >= 75)
      signalColor = Colors.green;
    else if (network.signal >= 50)
      signalColor = Colors.orange;
    else
      signalColor = Colors.red;

    final is5Ghz = network.channel > 14;
    final isLocked = network.security.toUpperCase() != 'OPEN' &&
        network.security.isNotEmpty;

    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          Icon(Icons.wifi, color: signalColor),
          if (isLocked)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(Icons.lock, size: 10, color: Colors.grey),
              ),
            )
        ],
      ),
      title: Text(network.SSID,
          style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Row(
        children: [
          if (is5Ghz) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.blue.withOpacity(0.3))),
              child: const Text("5G",
                  style: TextStyle(
                      fontSize: 9,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 6),
          ],
          Text("${network.signal}%", style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Text("• Ch: ${network.channel}",
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(8),
            elevation: 0,
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest),
        onPressed: onTap,
        child: const Icon(Icons.add, size: 20),
      ),
    );
  }
}

class _ConnectNetworkForm extends StatefulWidget {
  final String initialSSID;
  final WifiTabBloc wifiBloc;

  const _ConnectNetworkForm(
      {required this.initialSSID, required this.wifiBloc});

  @override
  State<_ConnectNetworkForm> createState() => _ConnectNetworkFormState();
}

class _ConnectNetworkFormState extends State<_ConnectNetworkForm> {
  late TextEditingController _ssidController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ssidController = TextEditingController(text: widget.initialSSID);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.initialSSID.isEmpty ? "Add Network" : "Connect to Network",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ssidController,
              decoration: const InputDecoration(
                labelText: 'SSID (Name)',
                prefixIcon: Icon(Icons.wifi_find),
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.key),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.wifiBloc.add(AddWifiTabEvent(
                          "${_ssidController.text} connection",
                          _ssidController.text,
                          _passwordController.text));
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Connect"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}