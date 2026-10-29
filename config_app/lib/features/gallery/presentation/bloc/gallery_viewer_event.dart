part of 'gallery_viewer_bloc.dart';

@freezed
sealed class GalleryViewerEvent with _$GalleryViewerEvent {
  const factory GalleryViewerEvent.configured(
    GalleryViewerConfiguration configuration,
  ) = ViewerConfigured;
  const factory GalleryViewerEvent.itemChanged(
    GalleryItem? item,
    int subscriptionGeneration,
  ) = ViewerItemChanged;
  const factory GalleryViewerEvent.infoToggled() = ViewerInfoToggled;
  const factory GalleryViewerEvent.metadataRequested() =
      ViewerMetadataRequested;
  const factory GalleryViewerEvent.metadataCompleted({
    required int generation,
    GalleryMetadata? data,
    GalleryErrorCode? error,
  }) = ViewerMetadataCompleted;
  const factory GalleryViewerEvent.rotationRequested(GalleryRotation rotation) =
      ViewerRotationRequested;
  const factory GalleryViewerEvent.rotationCompleted({
    required int generation,
    GalleryMetadata? data,
    GalleryErrorCode? error,
  }) = ViewerRotationCompleted;
  const factory GalleryViewerEvent.mutationRequested(GalleryMutation action) =
      ViewerMutationRequested;
  const factory GalleryViewerEvent.mutationDecision({
    required int confirmationId,
    required bool confirmed,
  }) = ViewerMutationDecision;
  const factory GalleryViewerEvent.mutationCompleted({
    required int generation,
    GalleryOperationResult? result,
    GalleryErrorCode? error,
  }) = ViewerMutationCompleted;
}
