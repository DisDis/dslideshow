import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/features/gallery/presentation/widgets/metadata_panel.dart';
import 'package:config_app/features/gallery/presentation/widgets/single_image_viewer.dart';
import 'package:config_app/features/gallery/presentation/widgets/single_video_player.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_common/file_settings.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class SingleItemViewerPage extends StatefulWidget {
  final GalleryItem item;

  const SingleItemViewerPage({super.key, required this.item});

  @override
  State<SingleItemViewerPage> createState() => _SingleItemViewerPageState();
}

class _SingleItemViewerPageState extends State<SingleItemViewerPage>
    with SingleTickerProviderStateMixin {
  bool _showControls = true;
  late AnimationController _controlsAnimController;
  late Animation<double> _controlsOpacity;

  @override
  void initState() {
    super.initState();
    // Анимация исчезновения контролов
    _controlsAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controlsOpacity = CurvedAnimation(
      parent: _controlsAnimController,
      curve: Curves.easeInOut,
    );
    _controlsAnimController.value = 1.0; // Сразу показываем
  }

  @override
  void dispose() {
    _controlsAnimController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        _controlsAnimController.forward();
      } else {
        _controlsAnimController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ext = path.extension(widget.item.uri.path);
    final isVideo = FileSettings.isVideo(ext);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.scrim,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. КОНТЕНТ (По центру)
          GestureDetector(
            onTap: _toggleControls, // Тап по пустому месту переключает UI
            behavior: HitTestBehavior.translucent,
            child: Center(
              child: isVideo
                  ? SingleVideoPlayer(
                      uri: widget.item.uri,
                      onContentTap: _toggleControls,
                    )
                  : SingleImageViewer(uri: widget.item.uri),
            ),
          ),

          // 2. ВЕРХНИЙ БАР (AppBar custom)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ExcludeFocus(
              excluding: !_showControls,
              child: IgnorePointer(
                ignoring: !_showControls,
                child: FadeTransition(
                  opacity: _controlsOpacity,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).colorScheme.surface
                              .withValues(alpha: 0.95),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        tooltip: MaterialLocalizations.of(context)
                            .backButtonTooltip,
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      actions: [
                        // Тут можно добавить кнопки "Скачать", "Удалить"
                        IconButton(
                          tooltip: context.localizations.media_info,
                          icon: Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          onPressed: _toggleControls, // Просто акцентируем внимание на инфо
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 3. НИЖНЯЯ ПАНЕЛЬ (Метаданные)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ExcludeFocus(
              excluding: !_showControls,
              child: IgnorePointer(
                ignoring: !_showControls,
                child: FadeTransition(
                  opacity: _controlsOpacity,
                  child: MetadataPanel(item: widget.item),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
