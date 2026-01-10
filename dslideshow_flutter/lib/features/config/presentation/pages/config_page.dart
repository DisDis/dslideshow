import 'dart:async';

import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/debug_widget.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';
import 'package:dslideshow_flutter/src/extension/network_info_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  static final Logger _log = Logger('_ConfigPageState');
  bool isReady = false;
  String _urlData = '';
  final AppConfig _appConfig = injector.get<AppConfig>();
  final FrontendService _frontendService = injector.get<FrontendService>();
  // ignore: constant_identifier_names
  static const INIT_CODE = r'_$_$_';

  String _accessCode = INIT_CODE;
  StreamSubscription? _onPushSubscription;
  SystemInfo? _systemInfo;

  // Цвета для дизайна
  final Color _backgroundColor = ThemeColors.configBackgroundColor;
  final Color _cardColor = ThemeColors.configCardColor;
  final Color _accentColor = ThemeColors.configAccentColor;

  void createUrl() async {
    if (_systemInfo == null || _accessCode == INIT_CODE) {
      return;
    }
    try {
      final interface = _systemInfo!.networkInfo.getCurrentInterface();
      _urlData = 'http://${interface.ip4}:${_appConfig.webServer.port}';
      // Небольшая задержка для плавности UI
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          isReady = true;
        });
      }
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    _log.info('initState');
    _frontendService.startWebServer().then((value) {
      if (mounted) {
        setState(() {
          _accessCode = value;
        });
        createUrl();
      }
    });

    _frontendService.getSystemInfo().then((value) {
      if (mounted) {
        _systemInfo = value;
        createUrl();
      }
    });
    _onPushSubscription = _frontendService.onButtonEvent.listen(_pushButton);
  }

  @override
  void dispose() {
    _frontendService.stopWebServer();
    _onPushSubscription?.cancel();
    _onPushSubscription = null;
    super.dispose();
  }

  void _pushButton(ButtonEvent event) {
    if (event.event == ButtonEventType.released && event.button == ButtonType.button0) {
      context.read<RouteBloc>().add(ChangePageEvent(RoutePage.slideshow));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: isReady ? _buildConfigContent() : Center(child: CircularProgressIndicator(color: _accentColor)),
              ),
            ],
          ),
          const CommonHeaderWidget(),
          // 2. DEBUG СЛОЙ (поверх основного)
          if (!isLinuxEmbedded)
            BlocBuilder<SlideshowStatusBloc, SlideshowStatusState>(
              builder: (context, state) {
                return DebugWidget(_frontendService, _appConfig);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildConfigContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Левая часть - QR
        Expanded(flex: 4, child: Padding(
          padding: const EdgeInsets.fromLTRB(0,100.0,0,100.0),
          child: Center(child: _buildQrCode()),
        )),
        // Правая часть - Информация
        Expanded(
          flex: 2,
          child: Padding(padding: const EdgeInsets.only(right: 32.0), child: _buildInfoPanel()),
        ),
      ],
    );
  }

  Widget _buildQrCode() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeColors.QRCodeBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color:
        ThemeColors.QRCodeShadow
         , blurRadius: 15, offset: const Offset(0, 10))],
      ),
      child: QrImageView(data: _urlData, version: QrVersions.auto, backgroundColor: ThemeColors.QRCodeBackground),
    );
  }

  Widget _buildInfoPanel() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ThemeColors.configInputBorderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Device Setup",
            style: TextStyle(color: ThemeColors.configHeaderTextColor, fontSize: ThemeSettings.configHeaderTextSize, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildStepRow(Icons.qr_code_scanner, "1. Scan the QR code to open settings"),
          const SizedBox(height: 12),
          _buildStepRow(Icons.wifi, "2. Make sure you are on the same Wi-Fi"),

          const Divider(height: 40, color: Colors.white24),

          Text(
            "Manual Connection",
            style: TextStyle(
              color: ThemeColors.configSubheaderTextColor,
              fontSize: ThemeSettings.configSubheaderTextSize,
              // uppercase: true,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            _urlData,
            style: TextStyle(color: _accentColor, fontSize: ThemeSettings.configLinkSize, decoration: TextDecoration.underline),
          ),

          const SizedBox(height: 24),

          Text(
            "Access Code",
            style: TextStyle(
              color: ThemeColors.configSubheaderTextColor,
              fontSize: ThemeSettings.configSubheaderTextSize ,
              // uppercase: true,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ThemeColors.configAccessCodeBgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ThemeColors.configAccessCodeBorderColor),
            ),
            child: Text(
              _accessCode,
              style: const TextStyle(
                color: ThemeColors.configNormalTextColor,
                fontSize: ThemeSettings.configAccessCodeSize,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                fontFamily: 'Courier', // Моноширинный шрифт для кода
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: _accentColor, size: ThemeSettings.configManualIconSize),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: TextStyle(color: ThemeColors.configNormalTextColor, fontSize: ThemeSettings.configManualTextSize)),
        ),
      ],
    );
  }
}
