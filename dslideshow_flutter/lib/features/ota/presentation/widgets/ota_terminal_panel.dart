import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_terminal_session.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';

class OtaTerminalPanel extends StatelessWidget {
  const OtaTerminalPanel({super.key, required this.session, this.emptyMessage});

  final OtaTerminalSession session;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ThemeColors.otaTerminalBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: const BoxDecoration(
              color: ThemeColors.otaTerminalHeaderBgColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: ListenableBuilder(
              listenable: session.following,
              builder: (context, _) => Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 24,
                runSpacing: 8,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.terminal,
                        color: ThemeColors.otaTerminalHeaderIconColor,
                        size: ThemeSettings.otaTerminalHeaderIconSize,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.otaSystemLog,
                        style: const TextStyle(
                          color: ThemeColors.otaTerminalHeaderTextColor,
                          fontSize: ThemeSettings.otaTerminalHeaderSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (session.isFollowing)
                    Text(
                      l10n.otaFollowingOutput,
                      style: const TextStyle(
                        color: ThemeColors.otaAccentColor,
                        fontSize: ThemeSettings.otaReadyNormalTextSize,
                      ),
                    )
                  else
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 16,
                      children: [
                        Text(
                          l10n.otaHistoryPaused,
                          style: const TextStyle(
                            color: ThemeColors.otaTerminalHeaderTextColor,
                            fontSize: ThemeSettings.otaReadyNormalTextSize,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: session.followLatest,
                          icon: const Icon(Icons.vertical_align_bottom),
                          label: Text(l10n.otaLatestLine),
                          style: TextButton.styleFrom(
                            foregroundColor: ThemeColors.otaAccentColor,
                            textStyle: const TextStyle(
                              fontSize: ThemeSettings.otaReadyNormalTextSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  NotificationListener<ScrollMetricsNotification>(
                    onNotification: (_) {
                      session.scheduleScrollStateUpdate();
                      return false;
                    },
                    child: TerminalView(
                      session.terminal,
                      scrollController: session.scrollController,
                      readOnly: true,
                      autofocus: false,
                      padding: const EdgeInsets.all(16),
                      textStyle: const TerminalStyle(
                        fontSize: ThemeSettings.otaTerminalFontSize,
                        fontFamily: 'Cascadia Mono',
                        fontFamilyFallback: ['Courier New', 'monospace'],
                      ),
                      theme: ThemeColors.terminaTheme,
                    ),
                  ),
                  if (emptyMessage != null)
                    ValueListenableBuilder<bool>(
                      valueListenable: session.hasOutput,
                      child: IgnorePointer(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              emptyMessage!,
                              style: const TextStyle(
                                color: ThemeColors.otaProgressSubtextColor,
                                fontSize: ThemeSettings.otaProgressSubtitleSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                      builder: (context, hasOutput, child) =>
                          hasOutput ? const SizedBox.shrink() : child!,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
