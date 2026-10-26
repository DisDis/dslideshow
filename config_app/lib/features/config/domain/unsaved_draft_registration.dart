import 'package:flutter/foundation.dart';

/// Registers a live dirty check and returns an idempotent cleanup callback.
typedef RegisterUnsavedDraft = VoidCallback Function(
  ValueGetter<bool> hasChanges,
);
