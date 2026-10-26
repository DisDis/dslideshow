part of 'gallery_bloc.dart';

@immutable
@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState.uninitialized() = UninitializedGalleryState;
  const factory GalleryState.error(String errorMessage) = ErrorGalleryState;
  const factory GalleryState.loaded({
    required List<GalleryItem> items,
    @Default(false) bool refreshing,
    @Default(false) bool refreshFailed,
  }) = LoadedGalleryState;
}
