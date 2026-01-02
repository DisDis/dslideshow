import 'package:flutter/material.dart';

// Группировка настроек в карточку
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final IconData? icon;

  const SettingsSection({
    Key? key,
    required this.title,
    required this.children,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (icon != null) ...[Icon(icon, color: Theme.of(context).primaryColor), const SizedBox(width: 8)],
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }
}

// Поле ввода текста/чисел
class SettingsTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final bool isNumber;

  const SettingsTextField({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.isNumber = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        initialValue: initialValue,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

// Переключатель (bool)
class SettingsSwitch extends StatefulWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitch({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

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
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.label),
      value: _currentValue,
      onChanged: (val) {
        setState(() => _currentValue = val);
        widget.onChanged(val);
      },
    );
  }
}

// Навигационный элемент для открытия детальных настроек
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(title),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

// Выбор одного значения из списка (Dropdown)
class SettingsDropdown<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T item)? itemLabelBuilder;

  const SettingsDropdown({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemLabelBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          onChanged: onChanged,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemLabelBuilder != null 
                    ? itemLabelBuilder!(item) 
                    : item.toString().split('.').last, // Дефолт для Enum
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Выбор нескольких значений (Dialog с чекбоксами)
class SettingsMultiSelect<T> extends StatelessWidget {
  final String label;
  final List<T> allItems;
  final List<T> selectedItems;
  final ValueChanged<List<T>> onChanged;
  final String Function(T item)? itemLabelBuilder;

  const SettingsMultiSelect({
    Key? key,
    required this.label,
    required this.allItems,
    required this.selectedItems,
    required this.onChanged,
    this.itemLabelBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = selectedItems.length;
    final summary = count == 0
        ? 'None'
        : count == allItems.length
            ? 'All selected'
            : '$count items selected';

    return ListTile(
      title: Text(label),
      subtitle: Text(summary, style: TextStyle(color: Theme.of(context).primaryColor)),
      trailing: const Icon(Icons.list),
      onTap: () async {
        final result = await showDialog<List<T>>(
          context: context,
          builder: (ctx) => _MultiSelectDialog<T>(
            items: allItems,
            initialSelected: selectedItems,
            itemLabelBuilder: itemLabelBuilder,
          ),
        );
        if (result != null) {
          onChanged(result);
        }
      },
    );
  }
}

// Внутренний диалог для мульти-выбора
class _MultiSelectDialog<T> extends StatefulWidget {
  final List<T> items;
  final List<T> initialSelected;
  final String Function(T)? itemLabelBuilder;

  const _MultiSelectDialog({
    Key? key,
    required this.items,
    required this.initialSelected,
    this.itemLabelBuilder,
  }) : super(key: key);

  @override
  State<_MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<_MultiSelectDialog<T>> {
  late List<T> _tempSelected;

  @override
  void initState() {
    super.initState();
    _tempSelected = List.from(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select items'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            final isChecked = _tempSelected.contains(item);
            final label = widget.itemLabelBuilder != null
                ? widget.itemLabelBuilder!(item)
                : item.toString();
            
            return CheckboxListTile(
              value: isChecked,
              title: Text(label),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? checked) {
                setState(() {
                  if (checked == true) {
                    _tempSelected.add(item);
                  } else {
                    _tempSelected.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Cancel (null result)
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _tempSelected), // OK
          child: const Text('OK'),
        ),
      ],
    );
  }
}