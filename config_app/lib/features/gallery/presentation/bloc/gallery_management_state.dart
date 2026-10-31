part of 'gallery_management_bloc.dart';

enum GallerySection { published, hidden, duplicates, trash }

enum GalleryManagementLoadStatus { loading, ready, failed }

enum GalleryManagementNotice {
  none,
  trashed,
  hidden,
  unhidden,
  restored,
  purged,
  partialFailure,
  failed,
  unknownOutcome,
  confirmationChanged,
}

/// One immutable indexed catalog value is shared by selection-only states, so
/// generated state equality does not walk the whole library on every click.
@freezed
abstract class GalleryManagementSnapshot with _$GalleryManagementSnapshot {
  const factory GalleryManagementSnapshot({
    @Default([]) List<GalleryItem> items,
    @Default({}) Map<String, GalleryItem> bySelectionIdentity,
    @Default({}) Map<String, GalleryItem> byMediaId,
    @Default({}) Map<String, GalleryEntry> entriesById,
  }) = _GalleryManagementSnapshot;
}

/// A confirmed active snapshot. Batch identifiers correlate transient requests;
/// progress changes never rebuild this large indexed snapshot or refs list.
@freezed
abstract class GalleryManagementOperationPlan with _$GalleryManagementOperationPlan {
  const factory GalleryManagementOperationPlan({
    required GalleryMutation action,
    required GalleryManagementSnapshot snapshot,
    required List<GalleryMediaRef> items,
    required List<GalleryOperationRequest> requests,
  }) = _GalleryManagementOperationPlan;
}

@freezed
abstract class GalleryManagementState with _$GalleryManagementState {
  const GalleryManagementState._();
  const factory GalleryManagementState({
    @Default(GallerySection.published) GallerySection section,
    @Default(GalleryManagementSnapshot()) GalleryManagementSnapshot snapshot,
    @Default({}) Set<String> selectedIds,
    @Default({}) Set<GalleryCapability> capabilities,
    @Default(GalleryManagementLoadStatus.loading) GalleryManagementLoadStatus catalogStatus,
    @Default(false) bool catalogRefreshing,
    @Default(false) bool catalogRefreshFailed,
    GalleryCatalog? trash,
    GalleryCatalog? hidden,
    @Default(false) bool hiddenLoading,
    @Default(false) bool hiddenFailed,
    @Default(false) bool trashLoading,
    @Default(false) bool trashFailed,
    @Default(false) bool busy,
    GalleryMutationConfirmation? confirmation,
    GalleryOperationRequest? pendingOperation,
    GalleryManagementOperationPlan? operationPlan,
    @Default(0) int completedBatches,
    @Default(0) int processedItems,
    @Default(0) int succeededItems,
    GalleryOperationResult? lastResult,
    @Default([]) List<GalleryOperationItemResult> failures,
    GalleryManagementSnapshot? failureSnapshot,
    @Default(GalleryManagementNotice.none) GalleryManagementNotice notice,
    @Default(0) int noticeSerial,
    GalleryErrorCode? error,
  }) = _GalleryManagementState;

  List<GalleryItem> get items => snapshot.items;
  List<GalleryItem> get selectedItems => [
    for (final identity in selectedIds)
      if (snapshot.bySelectionIdentity[identity] case final GalleryItem item)
        if (!item.isFolder) item,
  ];
  int get selectedMediaBytes =>
      selectedItems.fold<int>(0, (sum, item) => sum + (snapshot.entriesById[item.mediaId]?.sizeBytes ?? 0));
  bool get isTrash => section == GallerySection.trash;
  bool get isHidden => section == GallerySection.hidden;
  bool get isStored => isTrash || isHidden;
  int get operationTotal => operationPlan?.items.length ?? processedItems;
  bool get initialLoading => isHidden
      ? hiddenLoading && hidden == null
      : isTrash
      ? trashLoading && trash == null
      : catalogStatus == GalleryManagementLoadStatus.loading;
  bool get initialFailed => isHidden
      ? hiddenFailed && hidden == null
      : isTrash
      ? trashFailed && trash == null
      : catalogStatus == GalleryManagementLoadStatus.failed;
  bool get refreshing =>
      busy ||
      (isHidden
          ? hiddenLoading
          : isTrash
          ? trashLoading
          : catalogRefreshing);
  bool get refreshFailed => isHidden
      ? hiddenFailed
      : isTrash
      ? trashFailed
      : catalogRefreshFailed;
  bool get needsMutationRefresh => notice == GalleryManagementNotice.unknownOutcome && refreshFailed;
  List<String> get undoMediaIds =>
      lastResult?.items
          .where((item) => item.state == GalleryItemOperationState.succeeded && item.destination?.mediaId != null)
          .map((item) => item.destination!.mediaId)
          .toList(growable: false) ??
      const [];
}
