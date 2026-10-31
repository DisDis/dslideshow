part of 'gallery_viewer_bloc.dart';

enum GalleryViewerMetadataStatus { idle, loading, ready, failed }

enum GalleryViewerOperation { idle, rotating, trashing, restoring, purging, hiding, unhiding }

@freezed
abstract class GalleryViewerConfiguration with _$GalleryViewerConfiguration {
  const GalleryViewerConfiguration._();
  GalleryMediaSection get mediaSection => item.section;
  const factory GalleryViewerConfiguration({
    required GalleryItem item,
    GalleryManagementRepository? management,
    @Default({}) Set<GalleryCapability> capabilities,
    GalleryEntry? entry,
    Stream<GalleryItem?>? itemUpdates,
    GalleryItem? Function()? currentItem,
  }) = _GalleryViewerConfiguration;
}

@freezed
sealed class GalleryViewerEffect with _$GalleryViewerEffect {
  const factory GalleryViewerEffect.mutationConfirmation(GalleryMutationConfirmation confirmation) =
      ViewerConfirmMutation;
  const factory GalleryViewerEffect.confirmationChanged() = ViewerConfirmationChanged;
  const factory GalleryViewerEffect.operationFailed(GalleryErrorCode code, {@Default(false) bool refreshCatalog}) =
      ViewerOperationFailed;
  const factory GalleryViewerEffect.rotationApplied() = ViewerRotationApplied;
  const factory GalleryViewerEffect.mutationApplied({
    required GalleryMutation action,
    @Default([]) List<String> mediaIds,
  }) = ViewerMutationApplied;
}

@freezed
abstract class GalleryViewerState with _$GalleryViewerState {
  const GalleryViewerState._();
  const factory GalleryViewerState({
    required GalleryItem item,
    @Default(false) bool missing,
    @Default(false) bool showInfo,
    @Default(false) bool managementAvailable,
    @Default({}) Set<GalleryCapability> capabilities,
    GalleryEntry? entry,
    @Default({}) Set<String> supersededRevisions,
    @Default(GalleryViewerMetadataStatus.idle) GalleryViewerMetadataStatus metadataStatus,
    GalleryMetadata? metadata,
    GalleryErrorCode? metadataError,
    @Default(GalleryViewerOperation.idle) GalleryViewerOperation operation,
    GalleryOperationRequest? mutationRequest,
    GalleryErrorCode? operationError,
    GalleryMutationConfirmation? confirmation,
    @Default(0) int effectId,
    GalleryViewerEffect? effect,
  }) = _GalleryViewerState;

  GalleryMediaSection get mediaSection => item.section;
  bool get busy => operation != GalleryViewerOperation.idle;
  bool get hidden => mediaSection == GalleryMediaSection.hidden;
  bool get trash => mediaSection == GalleryMediaSection.trash;
  bool get metadataLoading => metadataStatus == GalleryViewerMetadataStatus.loading;
  bool get metadataFailed => metadataStatus == GalleryViewerMetadataStatus.failed;
  bool get canReadMetadata => managementAvailable && !missing && capabilities.contains(GalleryCapability.metadata);
  bool get canRotate =>
      managementAvailable &&
      !missing &&
      !trash &&
      !hidden &&
      item.kind == GalleryEntryKind.image &&
      capabilities.contains(GalleryCapability.rotation) &&
      const {'.jpg', '.jpeg', '.png'}.any(item.title.toLowerCase().endsWith);
  bool canMutate(GalleryMutation action) =>
      managementAvailable &&
      !missing &&
      !item.isFolder &&
      capabilities.contains(GalleryCapability.mutations) &&
      (switch (action) {
        GalleryMutation.trash => !trash,
        GalleryMutation.restore || GalleryMutation.purge => trash && capabilities.contains(GalleryCapability.trash),
        GalleryMutation.hide => !trash && !hidden && capabilities.contains(GalleryCapability.hidden),
        GalleryMutation.unhide => hidden && capabilities.contains(GalleryCapability.hidden),
      });
}
