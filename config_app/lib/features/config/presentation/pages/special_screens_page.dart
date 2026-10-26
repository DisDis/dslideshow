import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'special_screen_editor_page.dart';

enum _ScreenAction { delete }

String specialScreenTypeLabel(BuildContext context, SpecialScreenType type) =>
    switch (type) {
      SpecialScreenType.clock => context.localizations.special_screen_clock,
      SpecialScreenType.cameras => context.localizations.special_screen_cameras,
      _ => '${context.localizations.special_unsupported}: $type',
    };

class SpecialScreensPage extends StatefulWidget {
  final SlideShowConfig config;
  final RegisterUnsavedDraft? registerDraft;
  const SpecialScreensPage({
    super.key,
    required this.config,
    this.registerDraft,
  });
  @override
  State<SpecialScreensPage> createState() => _SpecialScreensPageState();
}

class _SpecialScreensPageState extends State<SpecialScreensPage> {
  Future<void> _edit(SpecialScreenConfig screen, {bool isNew = false}) async {
    final result = await Navigator.of(context).push<SpecialScreenConfig>(
      MaterialPageRoute(
        builder: (_) => SpecialScreenEditorPage(
          config: screen,
          registerDraft: widget.registerDraft,
        ),
      ),
    );
    if (!mounted || result == null) return;
    setState(() {
      if (isNew) {
        widget.config.specialScreens.add(result);
      } else {
        final index = widget.config.specialScreens.indexWhere(
          (s) => s.id == screen.id,
        );
        if (index >= 0) widget.config.specialScreens[index] = result;
      }
    });
  }

  Future<void> _add() async {
    final type = await showModalBottomSheet<SpecialScreenType>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final type in [
              SpecialScreenType.clock,
              SpecialScreenType.cameras,
            ])
              ListTile(
                leading: Icon(
                  type == SpecialScreenType.clock
                      ? Icons.schedule
                      : Icons.videocam,
                ),
                title: Text(specialScreenTypeLabel(context, type)),
                onTap: () => Navigator.pop(context, type),
              ),
          ],
        ),
      ),
    );
    if (!mounted || type == null) return;
    _edit(
      SpecialScreenConfig(id: const Uuid().v4(), type: type, enabled: true),
      isNew: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final screens = widget.config.specialScreens;
    return Scaffold(
      appBar: AppBar(title: Text(l.special_screens_title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _add,
        icon: const Icon(Icons.add),
        label: Text(l.special_add_screen),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l.special_save_hint),
          ),
          Expanded(
            child: screens.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(l.special_empty),
                    ),
                  )
                : ReorderableListView.builder(
                    padding: const EdgeInsets.only(bottom: 96),
                    buildDefaultDragHandles: false,
                    itemCount: screens.length,
                    onReorderItem: (oldIndex, newIndex) => setState(() {
                      screens.insert(newIndex, screens.removeAt(oldIndex));
                    }),
                    itemBuilder: (context, index) {
                      final screen = screens[index];
                      final schedule = screen.schedule;
                      final frequency =
                          schedule.type == SpecialScreenScheduleType.interval
                          ? '${l.special_interval}: ${schedule.intervalMs / 60000} ${l.special_minutes}'
                          : '${l.special_after_slides}: ${schedule.count}';
                      return Card(
                        key: ValueKey(screen.id),
                        child: ListTile(
                          leading: ReorderableDragStartListener(
                            index: index,
                            child: const Icon(Icons.drag_handle),
                          ),
                          title: Text(
                            screen.name.isEmpty
                                ? specialScreenTypeLabel(context, screen.type)
                                : screen.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '$frequency · ${screen.displayTimeMs / 1000} ${l.special_seconds}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: screen.isSupported
                              ? () => _edit(screen)
                              : null,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Switch(
                                value: screen.enabled,
                                onChanged: screen.isSupported
                                    ? (value) =>
                                          setState(() => screen.enabled = value)
                                    : null,
                              ),
                              PopupMenuButton<_ScreenAction>(
                                onSelected: (_) =>
                                    setState(() => screens.removeAt(index)),
                                itemBuilder: (_) => [
                                  PopupMenuItem(
                                    value: _ScreenAction.delete,
                                    child: Text(l.special_delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
