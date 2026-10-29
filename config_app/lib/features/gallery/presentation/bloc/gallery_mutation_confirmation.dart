import 'package:dslideshow_common/gallery.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_mutation_confirmation.freezed.dart';

const galleryConfirmationNameLimit = 10;

enum GalleryMutationScope { selection, allTrash }

@freezed
abstract class GalleryMutationConfirmation with _$GalleryMutationConfirmation {
  const factory GalleryMutationConfirmation({
    required int token,
    required GalleryMutation action,
    required List<GalleryMediaRef> items,
    required List<String> names,
    int? sizeBytes,
    @Default(GalleryMutationScope.selection) GalleryMutationScope scope,
  }) = _GalleryMutationConfirmation;
}
