import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/wifi_config/config/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static void route(BuildContext context) {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    // Получаем ID пользователя через Bloc
    final userId = context.select(
      (AuthenticationBloc bloc) => bloc.state.user.id,
    );

    return Scaffold(
      // Используем drawer, так что AppBar нужен для кнопки "гамбургер"
      // Но сделаем его прозрачным/сливающимся с фоном для современности
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.localizations.home_page_name),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Если фон хедера темный, иконки делаем светлыми, иначе наоборот
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: const ConfigAppNavigationBar(),
      body: Container(
        // Легкий градиент на фоне для глубины
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // 1. Приветственный блок
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20), // Отступ под AppBar
                      Text(
                        "Welcome back,",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      Text(
                        "User #$userId", // Используем ID из блока
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Manage your device settings and updates.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Сетка навигации
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid.count(
                  crossAxisCount: 2, // 2 карточки в ряд
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.5, // Чуть шире чем квадрат
                  children: [
                    _DashboardCard(
                      title: "WiFi Setup",
                      subtitle: "Manage connections",
                      icon: Icons.wifi,
                      color: Colors.blueAccent,
                      onTap: () => context.go(WiFiConfigPages.main.value),
                    ),
                    _DashboardCard(
                      title: "Configuration",
                      subtitle: "System settings",
                      icon: Icons.settings,
                      color: Colors.orangeAccent,
                      onTap: () => context.go('/config'),
                    ),
                    _DashboardCard(
                      title: "OTA Update",
                      subtitle: "Firmware upgrade",
                      icon: Icons.system_update,
                      color: Colors.purpleAccent,
                      onTap: () => context.go('/ota'),
                    ),
                    // Добавил Галерею, так как мы её делали ранее (для примера)
                    _DashboardCard(
                      title: "Gallery",
                      subtitle: "View media",
                      icon: Icons.photo_library,
                      color: Colors.green,
                      onTap: () => context.go('/gallery'), // Если такой роут есть
                    ),
                  ],
                ),
              ),

              // 3. Кнопка выхода (Внизу списка)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Center(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      icon: const Icon(Icons.logout),
                      label: Text(
                        context.localizations.home_page_logout_button,
                        style: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(const AuthenticationLogoutRequested());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- ВИДЖЕТ КАРТОЧКИ ---

class _DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias, // Чтобы ripple effect не вылезал
      child: InkWell(
        onTap: onTap,
        splashColor: color.withOpacity(0.1),
        highlightColor: color.withOpacity(0.05),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).cardColor,
                Theme.of(context).cardColor,
                // Легкий оттенок цвета в углу
                color.withOpacity(0.05),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Иконка в кружочке
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              
              // Тексты
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}