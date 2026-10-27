import 'package:config_app/features/config/domain/unsaved_draft_registration.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

/// Invalid raw input is still an edit when the typed config keeps its last valid
/// value. The main settings route supplies its own exit confirmation.
class DraftEditorForm extends StatefulWidget {
  const DraftEditorForm({
    super.key,
    required this.child,
    this.registerDraft,
    this.onChanged,
    this.hasInvalidInput,
    this.confirmInvalidOnBack = true,
  });
  final Widget child;
  final RegisterUnsavedDraft? registerDraft;
  final VoidCallback? onChanged;
  final ValueGetter<bool>? hasInvalidInput;
  final bool confirmInvalidOnBack;

  @override
  State<DraftEditorForm> createState() => _DraftEditorFormState();
}

class _DraftEditorFormState extends State<DraftEditorForm> {
  final _form = GlobalKey<FormState>();
  VoidCallback? _unregister;
  DialogRoute<bool>? _dialog;
  bool _allowPop = false;

  @override
  void initState() {
    super.initState();
    _unregister = widget.registerDraft?.call(_hasInvalidInput);
  }

  bool _hasInvalidInput() =>
      widget.hasInvalidInput?.call() == true ||
      (_form.currentState?.fields.any(
            (field) => field.hasInteractedByUser && !field.isValid,
          ) ??
          false);

  void _changed() {
    setState(() {});
    widget.onChanged?.call();
  }

  Future<void> _confirmBack() async {
    if (_dialog != null || !mounted || !_hasInvalidInput()) return;
    final dialog = DialogRoute<bool>(
      context: context,
      builder: (context) {
        final l = context.localizations;
        return AlertDialog(
          title: Text(l.config_unsaved_changes),
          content: Text(l.invalid_editor_leave_warning),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l.config_keep_editing),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l.discard_invalid_input),
            ),
          ],
        );
      },
    );
    _dialog = dialog;
    final discard = await Navigator.of(context).push(dialog) ?? false;
    if (identical(_dialog, dialog)) _dialog = null;
    if (!discard || !mounted) return;
    setState(() => _allowPop = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _unregister?.call();
    final dialog = _dialog;
    final navigator = dialog?.navigator;
    if (dialog != null && navigator != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (navigator.mounted && dialog.isActive) {
          navigator.removeRoute(dialog, false);
        }
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !widget.confirmInvalidOnBack || _allowPop || !_hasInvalidInput(),
    onPopInvokedWithResult: (didPop, result) {
      if (!didPop && widget.confirmInvalidOnBack) _confirmBack();
    },
    child: Form(
      key: _form,
      onChanged: _changed,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: widget.child,
    ),
  );
}
