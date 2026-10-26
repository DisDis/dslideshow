import 'package:config_app/features/config/domain/unsaved_draft_registration.dart';
import 'package:config_app/features/config/presentation/wigdgets/draft_editor_form.dart';
import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/config/presentation/wigdgets/visual_number_input.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/welcome/presrntation/widgets/animated_logo.dart';
import 'package:flutter/material.dart';

class WelcomeEditorPage extends StatefulWidget {
  final WelcomeConfig config;
  final RegisterUnsavedDraft? registerDraft;
  const WelcomeEditorPage({
    super.key,
    required this.config,
    this.registerDraft,
  });

  @override
  State<WelcomeEditorPage> createState() => _WelcomeEditorPageState();
}

class _WelcomeEditorPageState extends State<WelcomeEditorPage> {
  final _invalid = <String>{};

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final config = widget.config;
    return Scaffold(
      appBar: AppBar(title: Text(l.welcome_settings_title)),
      body: DraftEditorForm(
        registerDraft: widget.registerDraft,
        child: PreviewEditorLayout(
          hasInvalidInput: _invalid.isNotEmpty,
          help: '${l.preview_device_scale}\n${l.welcome_animation_help}',
          previewBuilder: (_) => WelcomePreview(config: config),
          editor: SettingsSection(
            title: l.welcome_settings_title,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  key: const ValueKey('welcome-text'),
                  initialValue: config.text,
                  maxLines: 3,
                  decoration: InputDecoration(labelText: l.welcome_text),
                  onChanged: (value) => setState(() => config.text = value),
                ),
              ),
              _number(
                'welcome-size',
                l.welcome_text_size,
                config.size,
                (value) => config.size = value,
                max: 1600,
              ),
              _number(
                'welcome-delay',
                l.welcome_delay_ms,
                config.delayMs,
                (value) => config.delayMs = value.toInt(),
                integer: true,
                max: 3600000,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _number(
    String key,
    String label,
    num value,
    ValueChanged<double> change, {
    bool integer = false,
    double max = 3600000,
  }) {
    bool valid(String? text) {
      final n = parseVisualNumber(text, integer: integer);
      return n != null &&
          n.isFinite &&
          n > 0 &&
          n <= max &&
          (!integer || n == n.roundToDouble());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        key: ValueKey(key),
        initialValue: value.toString(),
        keyboardType: TextInputType.numberWithOptions(decimal: !integer),
        decoration: InputDecoration(labelText: label),
        validator: (text) =>
            valid(text) ? null : context.localizations.special_invalid_number,
        onChanged: (text) => setState(() {
          if (valid(text)) {
            _invalid.remove(key);
            change(parseVisualNumber(text, integer: integer)!);
          } else {
            _invalid.add(key);
          }
        }),
      ),
    );
  }
}

/// Uses the photoframe's own welcome renderer on a scaled device canvas.
class WelcomePreview extends StatefulWidget {
  final WelcomeConfig config;
  const WelcomePreview({super.key, required this.config});
  @override
  State<WelcomePreview> createState() => _WelcomePreviewState();
}

class _WelcomePreviewState extends State<WelcomePreview>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;
  late int _delay;

  @override
  void initState() {
    super.initState();
    _delay = widget.config.delayMs;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _delay.clamp(1, 3600000)),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed && mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(covariant WelcomePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_delay != widget.config.delayMs) {
      _delay = widget.config.delayMs;
      _controller.duration = Duration(milliseconds: _delay.clamp(1, 3600000));
      _controller.forward(from: 0);
    }
  }

  void _replay() {
    _controller.forward(from: 0);
    setState(() {});
  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      DevicePreviewViewport(
        child: ColoredBox(
          // This is the production welcome content, independent of UI theme.
          color: Colors.black,
          child: AnimatedLogo(
            widget.config.text,
            widget.config.size,
            // Keep the text inspectable after the real fade-in/out finishes.
            animation: _controller.isDismissed
                ? const AlwaysStoppedAnimation(1.0)
                : _animation,
          ),
        ),
      ),
      const SizedBox(height: 12),
      OutlinedButton.icon(
        key: const ValueKey('welcome-replay'),
        onPressed: _replay,
        icon: const Icon(Icons.replay),
        label: Text(context.localizations.welcome_replay),
      ),
    ],
  );
}
