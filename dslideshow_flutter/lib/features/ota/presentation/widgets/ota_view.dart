import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_ready_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/debug_widget.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xterm/xterm.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';

// Цвета из OtaReadyWidget для консистентности
// Цвета определены в ThemeColors

class OTAView extends StatelessWidget {
  final Terminal terminal;

  const OTAView({super.key, required this.terminal});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OtaBloc>().state;

    // 1. READY STATE (использует свой отдельный виджет)
    if (state is OtaReadyState) {
      return OtaReadyWidget(state: state);
    }

    // 2. ОСТАЛЬНЫЕ СОСТОЯНИЯ (Progress, Error, Success)
    // Оборачиваем их в общий Shell
    return Stack(
      children: [Column(
          children: [
            const CommonHeaderWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                child: _buildStateContent(context, state),
              ),
            ),
          ],
        ),
        // 2. DEBUG СЛОЙ (поверх основного)
        if (!environment.isLinuxEmbedded)
          BlocBuilder<SlideshowStatusBloc, SlideshowStatusState>(
            builder: (context, state) {
              return DebugWidget(injector(), injector());
            },
          ),
        ]
    );
  }

  Widget _buildStateContent(BuildContext context, OtaState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ЛЕВАЯ ЧАСТЬ: Статус / Иконки / Прогресс
        Expanded(
          flex: 5,
          child: _StatusPanel(state: state),
        ),
        
        const SizedBox(width: 24),
        
        // ПРАВАЯ ЧАСТЬ: Терминал (лог)
        Expanded(
          flex: 4,
          child: _TerminalPanel(terminal: terminal),
        ),
      ],
    );
  }
}

// --- ЛЕВАЯ ПАНЕЛЬ: СТАТУС ---

class _StatusPanel extends StatelessWidget {
  final OtaState state;

  const _StatusPanel({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ThemeColors.otaCardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ThemeColors.otaReadyInputBorderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state is OtaInitialState)
            const CircularProgressIndicator(color: ThemeColors.otaAccentColor),

          if (state is OtaProgressState)
            _buildProgress(state as OtaProgressState),

          if (state is OtaFailureState)
            _buildFailure(state as OtaFailureState),

          if (state is OtaSuccessState)
            _buildSuccess(),
            
           if (state is OtaExitState)
             const Column(
               children: [
                 CircularProgressIndicator(color: ThemeColors.otaAccentColor),
                 SizedBox(height: 20),
                 Text("Rebooting system...", style: TextStyle(color: ThemeColors.otaRebootTextColor)),
               ],
             )
        ],
      ),
    );
  }

  Widget _buildProgress(OtaProgressState state) {
    final isUploading = state.info.status == OTAStatus.uploading;
    final percent = state.info.uploadingPercent;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Иконка
        Icon(
          isUploading ? Icons.cloud_upload_outlined : Icons.system_update_alt,
          size: 80,
          color: ThemeColors.otaProgressIconColor,
        ),
        const SizedBox(height: 24),
        
        // Текст статуса
        Text(
          isUploading ? "Uploading Firmware" : "Installing Update",
          style: const TextStyle(color: ThemeColors.otaProgressTextColor, fontSize: ThemeSettings.otaProgressTitleSize, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          isUploading ? "Please do not turn off the device" : "This may take a few minutes",
          style: const TextStyle(color: ThemeColors.otaProgressSubtextColor, fontSize: ThemeSettings.otaProgressSubtitleSize),
        ),
        
        const SizedBox(height: 40),

        // Проценты
        Text(
          "${percent.toStringAsFixed(0)}%",
          style: const TextStyle(
            color: ThemeColors.otaProgressPercentColor,
            fontSize: ThemeSettings.otaProgressPercentSize,
            fontWeight: FontWeight.w900,
            fontFamily: 'Courier',
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Прогресс бар
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percent / 100,
            minHeight: ThemeSettings.otaProgressBarHeight,
            backgroundColor: ThemeColors.otaProgressBgColor,
            color: ThemeColors.otaProgressIconColor,
          ),
        ),

        // Кнопка для теста (только в дебаге)
        if (!environment.isLinuxEmbedded) ...[
          const SizedBox(height: 20),
          const TestConfigButton(),
        ]
      ],
    );
  }

  Widget _buildFailure(OtaFailureState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline, size: ThemeSettings.otaProgressIconSize, color: ThemeColors.otaErrorIconColor),
        const SizedBox(height: 24),
        Text(
          "Update Failed",
          style: TextStyle(color: ThemeColors.otaErrorTextColor, fontSize: ThemeSettings.otaErrorTitleSize, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeColors.otaErrorBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ThemeColors.otaErrorBorderColor),
          ),
          child: Text(
            state.info.errorText ?? "Unknown error occurred",
            textAlign: TextAlign.center,
            style: const TextStyle(color: ThemeColors.otaProgressTextColor, fontSize: ThemeSettings.otaErrorMessageSize),
          ),
        ),
        const SizedBox(height: 24),
        Text("Check the terminal log for details.", style: TextStyle(color: ThemeColors.otaTerminalHeaderTextColor)),
      ],
    );
  }

  Widget _buildSuccess() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle_outline, size: ThemeSettings.otaSuccessIconSize, color: ThemeColors.otaSuccessIconColor),
        SizedBox(height: 24),
        Text(
          "Update Complete",
          style: TextStyle(color: ThemeColors.otaSuccessTextColor, fontSize: ThemeSettings.otaSuccessTitleSize, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          "The system is rebooting...",
          style: TextStyle(color: ThemeColors.otaRebootTextColor, fontSize: ThemeSettings.otaRebootTextSize),
        ),
      ],
    );
  }
}

// --- ПРАВАЯ ПАНЕЛЬ: ТЕРМИНАЛ ---

class _TerminalPanel extends StatelessWidget {
  final Terminal terminal;

  const _TerminalPanel({required this.terminal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Заголовок консоли (для красоты)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: ThemeColors.otaTerminalHeaderBgColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            children: [
              Icon(Icons.terminal, color: ThemeColors.otaTerminalHeaderIconColor, size: ThemeSettings.otaTerminalHeaderIconSize),
              const SizedBox(width: 8),
              Text("SYSTEM LOG", style: TextStyle(color: ThemeColors.otaTerminalHeaderTextColor, fontSize: ThemeSettings.otaTerminalHeaderSize, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              const Spacer(),
              // Фейковые кнопки окна (просто для стиля)
              Row(
                children: [ThemeColors.otaTerminalBorderColor, ThemeColors.otaTerminalBorderAmberColor, ThemeColors.otaTerminalBorderGreenColor]
                    .map((c) => Container(margin: const EdgeInsets.only(left: 6), width: ThemeSettings.otaTerminalDotSize, height: ThemeSettings.otaTerminalDotSize, decoration: BoxDecoration(color: c, shape: BoxShape.circle)))
                    .toList(),
              )
            ],
          ),
        ),
        // Сам терминал
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: ThemeColors.otaTerminalBgColor, // Черный фон внутри консоли
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(4), // Небольшой отступ от краев
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              child: TerminalView(
                terminal,
                deleteDetection: true,
                readOnly: true,
                autofocus: false,
                textStyle: TerminalStyle(
                   fontSize: ThemeSettings.otaTerminalFontSize,
                   fontFamily: 'Cascadia Mono',
                   fontFamilyFallback: ['Courier New', 'monospace'],
                ),
                theme: ThemeColors.terminaTheme,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TestConfigButton extends StatelessWidget {
  const TestConfigButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(foregroundColor: ThemeColors.otaDevButtonColor),
      onPressed: () {
        context.read<RouteBloc>().add(ChangePageEvent(RoutePage.config));
      },
      icon: const Icon(Icons.settings),
      label: const Text('Dev: Go to Config'),
    );
  }
}