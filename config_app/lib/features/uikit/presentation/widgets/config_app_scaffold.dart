import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:flutter/material.dart';

/// The same destinations stay visible on desktop and become a drawer on phones.
class ConfigAppScaffold extends StatefulWidget {
  const ConfigAppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.onLogoutRequested,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Future<bool> Function()? onLogoutRequested;

  @override
  State<ConfigAppScaffold> createState() => _ConfigAppScaffoldState();
}

class _ConfigAppScaffoldState extends State<ConfigAppScaffold> {
  final _bodyKey = GlobalKey();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final wide = constraints.maxWidth >= 1100;
      final body = KeyedSubtree(key: _bodyKey, child: widget.body);
      return Scaffold(
        appBar: widget.appBar,
        drawer: wide
            ? null
            : ConfigAppNavigationBar(
                onLogoutRequested: widget.onLogoutRequested,
              ),
        floatingActionButton: widget.floatingActionButton,
        body: wide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 248,
                    child: ConfigAppNavigationBar(
                      embedded: true,
                      onLogoutRequested: widget.onLogoutRequested,
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(child: body),
                ],
              )
            : body,
        bottomNavigationBar: widget.bottomNavigationBar,
      );
    },
  );
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key, required this.child, this.maxWidth = 1040});
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}
