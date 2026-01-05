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

// Цвета из OtaReadyWidget для консистентности
const Color _kCardColor = Color(0xFF2C2C2C);
const Color _kAccentColor = Color(0xFF64B5F6);

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
        color: _kCardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state is OtaInitialState)
            const CircularProgressIndicator(color: _kAccentColor),

          if (state is OtaProgressState)
            _buildProgress(state as OtaProgressState),

          if (state is OtaFailureState)
            _buildFailure(state as OtaFailureState),

          if (state is OtaSuccessState)
            _buildSuccess(),
            
           if (state is OtaExitState)
             const Column(
               children: [
                 CircularProgressIndicator(color: _kAccentColor),
                 SizedBox(height: 20),
                 Text("Rebooting system...", style: TextStyle(color: Colors.white70)),
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
          color: _kAccentColor,
        ),
        const SizedBox(height: 24),
        
        // Текст статуса
        Text(
          isUploading ? "Uploading Firmware" : "Installing Update",
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          isUploading ? "Please do not turn off the device" : "This may take a few minutes",
          style: const TextStyle(color: Colors.white54, fontSize: 14),
        ),
        
        const SizedBox(height: 40),

        // Проценты
        Text(
          "${percent.toStringAsFixed(0)}%",
          style: const TextStyle(
            color: _kAccentColor, 
            fontSize: 64, 
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
            minHeight: 12,
            backgroundColor: Colors.black26,
            color: _kAccentColor,
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
        const Icon(Icons.error_outline, size: 80, color: Colors.redAccent),
        const SizedBox(height: 24),
        const Text(
          "Update Failed",
          style: TextStyle(color: Colors.redAccent, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.withAlpha((255.0 * 0.1).round()),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.withAlpha((255.0 * 0.3).round())),
          ),
          child: Text(
            state.info.errorText ?? "Unknown error occurred",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        const SizedBox(height: 24),
        const Text("Check the terminal log for details.", style: TextStyle(color: Colors.white38)),
      ],
    );
  }

  Widget _buildSuccess() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle_outline, size: 90, color: Colors.greenAccent),
        SizedBox(height: 24),
        Text(
          "Update Complete",
          style: TextStyle(color: Colors.greenAccent, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          "The system is rebooting...",
          style: TextStyle(color: Colors.white70, fontSize: 18),
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
            color: Color(0xFF1E1E1E), // Чуть темнее карточки
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            children: [
              const Icon(Icons.terminal, color: Colors.white38, size: 16),
              const SizedBox(width: 8),
              const Text("SYSTEM LOG", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              const Spacer(),
              // Фейковые кнопки окна (просто для стиля)
              Row(
                children: [Colors.red, Colors.amber, Colors.green]
                    .map((c) => Container(margin: const EdgeInsets.only(left: 6), width: 8, height: 8, decoration: BoxDecoration(color: c.withAlpha((255.0 * 0.5).round()), shape: BoxShape.circle)))
                    .toList(),
              )
            ],
          ),
        ),
        // Сам терминал
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black, // Черный фон внутри консоли
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
                   fontSize: 12,
                   fontFamily: 'Cascadia Mono',
                   fontFamilyFallback: ['Courier New', 'monospace'],
                ),
                theme: const TerminalTheme(
                  cursor: Colors.transparent, // Скрываем курсор, так как readOnly
                  selection: Color(0xFF264F78),
                  foreground: Color(0xFFCCCCCC),
                  background: Colors.black,
                  
                  // Обычные цвета (ANSI 0-7)
                  black: Color(0xFF000000),
                  red: Color(0xFFCD3131),
                  green: Color(0xFF0DBC79),
                  yellow: Color(0xFFE5E510),
                  blue: Color(0xFF2472C8),
                  magenta: Color(0xFFBC3FBC),
                  cyan: Color(0xFF11A8CD),
                  white: Color(0xFFE5E5E5),
                  
                  // Яркие цвета (ANSI 8-15)
                  brightBlack: Color(0xFF666666),
                  brightRed: Color(0xFFF14C4C),
                  brightGreen: Color(0xFF23D18B),
                  brightYellow: Color(0xFFF5F543),
                  brightBlue: Color(0xFF3B8EEA),
                  brightMagenta: Color(0xFFD670D6),
                  brightCyan: Color(0xFF29B8DB),
                  brightWhite: Color(0xFFFFFFFF),
                  
                  // Цвета поиска (обязательные поля)
                  searchHitBackground: Color(0xFFF8C18C),
                  searchHitBackgroundCurrent: Color(0xFF314365),
                  searchHitForeground: Color(0xFF000000),
                ),
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
      style: TextButton.styleFrom(foregroundColor: Colors.white38),
      onPressed: () {
        context.read<RouteBloc>().add(ChangePageEvent(RoutePage.config));
      },
      icon: const Icon(Icons.settings),
      label: const Text('Dev: Go to Config'),
    );
  }
}