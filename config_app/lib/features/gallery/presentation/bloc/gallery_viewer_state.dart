part of 'gallery_viewer_bloc.dart';

enum GalleryViewerMetadataStatus { idle, loading, ready, failed }

enum GalleryViewerOperation { idle, rotating, trashing, restoring, purging }

@freezed
abstract class GalleryViewerConfiguration with _$GalleryViewerConfiguration {
  const factory GalleryViewerConfiguration({
    required GalleryItem item,
    GalleryManagementRepository? management,
    @Default({}) Set<GalleryCapability> capabilities,
    GalleryTrashEntry? trashEntry,
    Stream<GalleryItem?>? itemUpdates,
    GalleryItem? Function()? currentItem,
  }) = _GalleryViewerConfiguration;
}

@freezed
sealed class GalleryViewerEffect with _$GalleryViewerEffect {
  const factory GalleryViewerEffect.mutationConfirmation(
    GalleryMutationConfirmation confirmation,
  ) = ViewerConfirmMutation;
  const factory GalleryViewerEffect.confirmationChanged() =
      ViewerConfirmationChanged;
  const factory GalleryViewerEffect.operationFailed(
    GalleryErrorCode code, {
    @Default(false) bool refreshCatalog,
  }) = ViewerOperationFailed;
  const factory GalleryViewerEffect.rotationApplied() = ViewerRotationApplied;
  const factory GalleryViewerEffect.mutationApplied({
    required GalleryMutation action,
    @Default([]) List<String> trashIds,
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
    GalleryTrashEntry? trashEntry,
    @Default({}) Set<String> supersededRevisions,
    @Default(GalleryViewerMetadataStatus.idle)
    GalleryViewerMetadataStatus metadataStatus,
    GalleryMetadata? metadata,
    GalleryErrorCode? metadataError,
    @Default(GalleryViewerOperation.idle) GalleryViewerOperation operation,
    GalleryOperationRequest? mutationRequest,
    GalleryErrorCode? operationError,
    GalleryMutationConfirmation? confirmation,
    @Default(0) int effectId,
    GalleryViewerEffect? effect,
  }) = _GalleryViewerState;

  bool get busy => operation != GalleryViewerOperation.idle;
  bool get trash => trashEntry != null;
  bool get metadataLoading =>
      metadataStatus == GalleryViewerMetadataStatus.loading;
  bool get metadataFailed =>
      metadataStatus == GalleryViewerMetadataStatus.failed;
  bool get canReadMetadata =>
      managementAvailable &&
      !missing &&
      capabilities.contains(GalleryCapability.metadata);
  bool get canRotate =>
      managementAvailable &&
      !missing &&
      !trash &&
      item.kind == GalleryEntryKind.image &&
      capabilities.contains(GalleryCapability.rotation) &&
      const {'.jpg', '.jpeg', '.png'}.any(item.uri.path.toLowerCase().endsWith);
  bool canMutate(GalleryMutation action) =>
      managementAvailable &&
      !missing &&
      !item.isFolder &&
      capabilities.contains(GalleryCapability.mutations) &&
      (action == GalleryMutation.trash
          ? !trash
          : trash && capabilities.contains(GalleryCapability.trash));
}
