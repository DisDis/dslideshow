import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

/// Keeps the preview next to a scrollable editor when there is enough room.
/// Hidden previews are unmounted, rather than merely muting their tickers: this
/// also releases camera/video sessions and cancels pending image listeners.
class PreviewEditorLayout extends StatefulWidget {
  final Widget editor;
  final WidgetBuilder previewBuilder;
  final bool hasInvalidInput;
  final String? help;

  const PreviewEditorLayout({
    super.key,
    required this.editor,
    required this.previewBuilder,
    this.hasInvalidInput = false,
    this.help,
  });

  @override
  State<PreviewEditorLayout> createState() => _PreviewEditorLayoutState();
}

class _PreviewEditorLayoutState extends State<PreviewEditorLayout>
    with WidgetsBindingObserver {
  final _editorKey = GlobalKey();
  final _previewKey = GlobalKey();
  bool _expanded = true;
  bool _resumed = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resumed =
        WidgetsBinding.instance.lifecycleState == null ||
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final resumed = state == AppLifecycleState.resumed;
    if (_resumed != resumed) setState(() => _resumed = resumed);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final active =
        _expanded && _resumed && TickerMode.valuesOf(context).enabled;
    final theme = Theme.of(context);
    final l = context.localizations;
    final editor = KeyedSubtree(key: _editorKey, child: widget.editor);
    final preview = Card(
      key: _previewKey,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.preview_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l.preview_title,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  key: const ValueKey('preview-toggle'),
                  tooltip: _expanded ? l.preview_hide : l.preview_show,
                  onPressed: () => setState(() => _expanded = !_expanded),
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                ),
              ],
            ),
            if (active) ...[
              const SizedBox(height: 12),
              if (widget.hasInvalidInput)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    l.preview_last_valid,
                    key: const ValueKey('preview-last-valid'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              widget.previewBuilder(context),
              if (widget.help != null) ...[
                const SizedBox(height: 12),
                Text(widget.help!, style: theme.textTheme.bodySmall),
              ],
            ],
          ],
        ),
      ),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1000) {
          return Row(
            key: const ValueKey('editor-wide-layout'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  primary: false,
                  padding: const EdgeInsets.only(bottom: 24),
                  child: editor,
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * .46,
                child: SingleChildScrollView(primary: false, child: preview),
              ),
            ],
          );
        }
        return SingleChildScrollView(
          key: const ValueKey('editor-compact-layout'),
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(children: [preview, editor]),
        );
      },
    );
  }
}

enum PreviewAspectRatio {
  frame(16, 10),
  widescreen(16, 9),
  portrait(9, 16),
  square(1, 1);

  final int width;
  final int height;
  const PreviewAspectRatio(this.width, this.height);
  double get ratio => width / height;
  String get label => '$width:$height';
}

/// A device-sized logical canvas, scaled as a whole. A configured 100px font or
/// 20px blur therefore keeps its relative size in a small preview.
class DevicePreviewViewport extends StatelessWidget {
  final Widget child;
  final double aspectRatio;
  const DevicePreviewViewport({
    super.key,
    required this.child,
    this.aspectRatio = 16 / 10,
  });

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: aspectRatio,
    child: ClipRect(
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 2560,
          height: 2560 / aspectRatio,
          child: MediaQuery.withNoTextScaling(child: child),
        ),
      ),
    ),
  );
}
