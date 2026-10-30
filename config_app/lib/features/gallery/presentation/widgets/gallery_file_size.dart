import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/presentation/extensions/build_context_ext.dart';

class GalleryFileSize extends StatelessWidget {
  const GalleryFileSize({
    super.key,
    required this.bytes,
    this.showLabel = false,
    this.selectable = false,
  });

  final int bytes;
  final bool showLabel;
  final bool selectable;

  static String formatMegabytes(BuildContext context, int bytes) {
    final small = bytes > 0 && bytes < 10000;
    final number = NumberFormat.decimalPatternDigits(
      locale: Localizations.localeOf(context).toString(),
      decimalDigits: 2,
    ).format(small ? 0.01 : bytes / 1000000);
    return context.localizations.gallery_size_megabytes(
      small ? '< $number' : number,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final value = formatMegabytes(context, bytes);
    final text = showLabel ? '${l.gallery_file_size}: $value' : value;
    return Tooltip(
      message: l.gallery_size_bytes(bytes),
      child: selectable ? SelectableText(text) : Text(text),
    );
  }
}
