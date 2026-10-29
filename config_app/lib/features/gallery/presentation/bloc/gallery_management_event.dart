part of 'gallery_management_bloc.dart';

@freezed
abstract class GalleryManagementEvent with _$GalleryManagementEvent {
  const factory GalleryManagementEvent.catalogChanged(GalleryState catalog) =
      GalleryManagementCatalogChanged;
  const factory GalleryManagementEvent.sectionChanged(GallerySection section) =
      GalleryManagementSectionChanged;
  const factory GalleryManagementEvent.selectionToggled(
    String selectionIdentity,
  ) = GalleryManagementSelectionToggled;
  const factory GalleryManagementEvent.selectionCleared() =
      GalleryManagementSelectionCleared;
  const factory GalleryManagementEvent.trashSelectionAllRequested() =
      GalleryManagementTrashSelectionAllRequested;
  const factory GalleryManagementEvent.clearTrashRequested() =
      GalleryManagementClearTrashRequested;
  const factory GalleryManagementEvent.trashRequested() =
      GalleryManagementTrashRequested;
  const factory GalleryManagementEvent.mutationRequested(
    GalleryMutation action,
  ) = GalleryManagementMutationRequested;
  const factory GalleryManagementEvent.mutationDecision({
    required int confirmationId,
    required bool confirmed,
  }) = GalleryManagementMutationDecision;
  const factory GalleryManagementEvent.refreshRequested(
    Completer<void> completion,
  ) = GalleryManagementRefreshRequested;
}
