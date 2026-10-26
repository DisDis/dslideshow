import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final IconData? icon;
  final bool expandable;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
    this.icon,
    this.expandable = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: expandable
          ? ExpansionTile(
              title: Text(title, style: theme.textTheme.titleMedium),
              leading: icon == null ? null : Icon(icon),
              childrenPadding: const EdgeInsets.only(bottom: 12),
              children: children,
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        if (icon != null) ...[
                          Icon(icon, color: theme.colorScheme.primary),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: Text(
                            title,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...children,
                ],
              ),
            ),
    );
  }
}

class SettingsTextField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final bool isNumber;
  final bool obscureText;
  final String? suffixText;
  final String? helperText;
  final FormFieldValidator<String>? validator;
  final int maxLines;

  const SettingsTextField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.isNumber = false,
    this.obscureText = false,
    this.suffixText,
    this.helperText,
    this.validator,
    this.maxLines = 1,
  });

  @override
  State<SettingsTextField> createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<SettingsTextField>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant SettingsTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _obscured = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        initialValue: widget.initialValue,
        keyboardType: widget.isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        obscureText: _obscured,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        autocorrect: !widget.obscureText,
        enableSuggestions: !widget.obscureText,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixText: widget.suffixText,
          helperText: widget.helperText,
          helperMaxLines: 3,
          errorMaxLines: 3,
          suffixIcon: widget.obscureText
              ? IconButton(
                  tooltip: _obscured
                      ? context.localizations.show_secret
                      : context.localizations.hide_secret,
                  icon: Icon(
                    _obscured
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => setState(() => _obscured = !_obscured),
                )
              : null,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

class SettingsSwitch extends StatefulWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SettingsSwitch> createState() => _SettingsSwitchState();
}

class _SettingsSwitchState extends State<SettingsSwitch> {
  late bool _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant SettingsSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) => SwitchListTile(
    title: Text(widget.label),
    value: _currentValue,
    onChanged: (value) {
      setState(() => _currentValue = value);
      widget.onChanged(value);
    },
  );
}

class SettingsTileNavigation extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final IconData icon;

  const SettingsTileNavigation({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
    title: Text(title),
    subtitle: Text(subtitle),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );
}

class SettingsDropdown<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T item)? itemLabelBuilder;

  const SettingsDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: DropdownButtonFormField<T>(
      key: ValueKey((label, value)),
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      items: [
        for (final item in items)
          DropdownMenuItem(
            value: item,
            child: Text(
              itemLabelBuilder?.call(item) ?? item.toString().split('.').last,
            ),
          ),
      ],
    ),
  );
}

class SettingsMultiSelect<T> extends StatelessWidget {
  final String label;
  final List<T> allItems;
  final List<T> selectedItems;
  final ValueChanged<List<T>> onChanged;
  final String Function(T item)? itemLabelBuilder;
  final bool emptySelectionMeansAll;

  const SettingsMultiSelect({
    super.key,
    required this.label,
    required this.allItems,
    required this.selectedItems,
    required this.onChanged,
    this.itemLabelBuilder,
    this.emptySelectionMeansAll = false,
  });

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final count = selectedItems.length;
    final summary = count == 0
        ? emptySelectionMeansAll
              ? l.items_all
              : l.items_none
        : count == allItems.length
        ? l.items_all
        : l.items_selected(count);
    return ListTile(
      title: Text(label),
      subtitle: Text(summary),
      trailing: const Icon(Icons.checklist),
      onTap: () async {
        final result = await showDialog<List<T>>(
          context: context,
          builder: (_) => _MultiSelectDialog<T>(
            items: allItems,
            initialSelected: selectedItems,
            itemLabelBuilder: itemLabelBuilder,
          ),
        );
        if (result != null) onChanged(result);
      },
    );
  }
}

class _MultiSelectDialog<T> extends StatefulWidget {
  final List<T> items;
  final List<T> initialSelected;
  final String Function(T)? itemLabelBuilder;
  const _MultiSelectDialog({
    required this.items,
    required this.initialSelected,
    this.itemLabelBuilder,
  });

  @override
  State<_MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<_MultiSelectDialog<T>> {
  late final List<T> _selected = List.of(widget.initialSelected);

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(context.localizations.select_items_dialog_title),
    content: SizedBox(
      width: 440,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final item in widget.items)
              CheckboxListTile(
                value: _selected.contains(item),
                title: Text(
                  widget.itemLabelBuilder?.call(item) ?? item.toString(),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (checked) => setState(() {
                  if (checked == true) {
                    _selected.add(item);
                  } else {
                    _selected.remove(item);
                  }
                }),
              ),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(context.localizations.cancel_button),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context, _selected),
        child: Text(context.localizations.ok_button),
      ),
    ],
  );
}
