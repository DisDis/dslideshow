import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// Keeps incomplete ARGB input in the form, while the model keeps its last color.
class ArgbColorField extends StatefulWidget {
  const ArgbColorField({
    super.key,
    this.fieldKey,
    required this.label,
    required this.value,
    required this.onChanged,
    this.onValidityChanged,
    this.controller,
    this.border,
  });

  final Key? fieldKey;
  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final ValueChanged<bool>? onValidityChanged;
  final TextEditingController? controller;
  final InputBorder? border;

  @override
  State<ArgbColorField> createState() => _ArgbColorFieldState();
}

class _ArgbColorFieldState extends State<ArgbColorField> {
  static final _argbPattern = RegExp(r'^[0-9a-fA-F]{8}$');
  late final TextEditingController _ownedController;
  TextEditingController get _controller =>
      widget.controller ?? _ownedController;
  DialogRoute<int>? _dialog;

  static String _hex(int color) => color.toRadixString(16).padLeft(8, '0');

  @override
  void initState() {
    super.initState();
    _ownedController = TextEditingController(text: _hex(widget.value));
  }

  @override
  void didUpdateWidget(covariant ArgbColorField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value &&
        int.tryParse(_controller.text, radix: 16) != widget.value) {
      _controller.text = _hex(widget.value);
    }
  }

  void _input(String text) {
    final valid = _argbPattern.hasMatch(text);
    widget.onValidityChanged?.call(valid);
    if (valid) widget.onChanged(int.parse(text, radix: 16));
  }

  Future<void> _choose() async {
    if (_dialog != null) return;
    var chosen = Color(widget.value);
    var chosenHsv = HSVColor.fromColor(chosen);
    final dialog = DialogRoute<int>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, update) {
          final l = context.localizations;
          final width = (MediaQuery.sizeOf(context).width - 112).clamp(
            160.0,
            300.0,
          );
          return AlertDialog(
            title: Text(widget.label),
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColorPicker(
                      pickerColor: chosen,
                      pickerHsvColor: chosenHsv,
                      onColorChanged: (color) => update(() {
                        chosen = color;
                        chosenHsv = HSVColor.fromColor(color);
                      }),
                      onHsvColorChanged: (hsv) => update(() => chosenHsv = hsv),
                      colorPickerWidth: width,
                      pickerAreaHeightPercent: .65,
                      portraitOnly: true,
                      enableAlpha: true,
                      labelTypes: const [],
                      displayThumbColor: true,
                    ),
                    Text(
                      _hex(chosen.toARGB32()),
                      key: const ValueKey('color-picker-argb'),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(l.cancel_button),
              ),
              FilledButton(
                onPressed: () =>
                    Navigator.of(dialogContext).pop(chosen.toARGB32()),
                child: Text(l.color_apply),
              ),
            ],
          );
        },
      ),
    );
    _dialog = dialog;
    final result = await Navigator.of(context).push(dialog);
    if (identical(_dialog, dialog)) _dialog = null;
    if (!mounted || result == null) return;
    _controller.text = _hex(result);
    widget.onValidityChanged?.call(true);
    widget.onChanged(result);
  }

  @override
  void dispose() {
    _ownedController.dispose();
    final dialog = _dialog;
    final navigator = dialog?.navigator;
    if (dialog != null && navigator != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (navigator.mounted && dialog.isActive) navigator.removeRoute(dialog);
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
    key: widget.fieldKey,
    controller: _controller,
    decoration: InputDecoration(
      labelText: widget.label,
      border: widget.border,
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Color(widget.value),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          IconButton(
            tooltip: context.localizations.color_choose,
            onPressed: _choose,
            icon: const Icon(Icons.palette_outlined),
          ),
        ],
      ),
    ),
    validator: (text) => _argbPattern.hasMatch(text ?? '')
        ? null
        : context.localizations.special_invalid_color,
    onChanged: _input,
  );
}
