import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../theme/presentation/extensions/build_context_ext.dart';

enum GalleryDuplicateSearchChoice {
  exact,
  similar,
  both;

  Set<GalleryDuplicateMode> get modes => switch (this) {
    exact => {GalleryDuplicateMode.exact},
    similar => {GalleryDuplicateMode.similar},
    both => GalleryDuplicateMode.values.toSet(),
  };

  static GalleryDuplicateSearchChoice fromModes(
    Set<GalleryDuplicateMode> modes,
  ) => modes.length == 1
      ? (modes.contains(GalleryDuplicateMode.exact) ? exact : similar)
      : both;
}

class _SearchChoiceCubit extends Cubit<GalleryDuplicateSearchChoice> {
  _SearchChoiceCubit(super.initialState) {
    _log.fine(() => 'event=searchOptionsOpened mode=${state.name}');
  }
  static final _log = Logger('GalleryDuplicateSearch');
  bool _confirmed = false;

  void choose(GalleryDuplicateSearchChoice? choice) {
    if (choice != null) emit(choice);
  }

  GalleryDuplicateSearchChoice confirm() {
    _confirmed = true;
    _log.fine(() => 'event=searchOptionsConfirmed mode=${state.name}');
    return state;
  }

  @override
  Future<void> close() {
    if (!_confirmed) _log.fine('event=searchOptionsCancelled');
    return super.close();
  }
}

Future<GalleryDuplicateSearchChoice?> showGalleryDuplicateSearchDialog(
  BuildContext context, {
  required Set<GalleryDuplicateMode> initialModes,
}) => showDialog<GalleryDuplicateSearchChoice>(
  context: context,
  builder: (_) => BlocProvider(
    create: (_) => _SearchChoiceCubit(
      GalleryDuplicateSearchChoice.fromModes(initialModes),
    ),
    child: const _SearchDialog(),
  ),
);

class _SearchDialog extends StatelessWidget {
  const _SearchDialog();

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    return BlocBuilder<_SearchChoiceCubit, GalleryDuplicateSearchChoice>(
      builder: (context, choice) => AlertDialog(
        title: Text(l.gallery_search_dialog_title),
        scrollable: true,
        content: SizedBox(
          width: 440,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.gallery_search_choose_mode),
              const SizedBox(height: 12),
              RadioGroup<GalleryDuplicateSearchChoice>(
                groupValue: choice,
                onChanged: context.read<_SearchChoiceCubit>().choose,
                child: Column(
                  children: [
                    for (final value in GalleryDuplicateSearchChoice.values)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: RadioListTile<GalleryDuplicateSearchChoice>(
                          value: value,
                          selected: value == choice,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: value == choice
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                        .colorScheme
                                        .outlineVariant,
                            ),
                          ),
                          title: Text(switch (value) {
                            GalleryDuplicateSearchChoice.exact =>
                              l.gallery_exact_copies,
                            GalleryDuplicateSearchChoice.similar =>
                              l.gallery_similar_images,
                            GalleryDuplicateSearchChoice.both =>
                              l.gallery_search_both,
                          }),
                          subtitle: Text(switch (value) {
                            GalleryDuplicateSearchChoice.exact =>
                              l.gallery_search_exact_description,
                            GalleryDuplicateSearchChoice.similar =>
                              l.gallery_search_similar_description,
                            GalleryDuplicateSearchChoice.both =>
                              l.gallery_search_both_description,
                          }),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l.gallery_search_preserve_results,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(
              context,
              context.read<_SearchChoiceCubit>().confirm(),
            ),
            icon: const Icon(Icons.search),
            label: Text(l.gallery_search_start),
          ),
        ],
      ),
    );
  }
}
