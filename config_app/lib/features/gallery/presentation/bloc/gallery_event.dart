part of 'gallery_bloc.dart';

@immutable
@freezed
class GalleryEvent with _$GalleryEvent {
  const factory GalleryEvent.load() = GalleryLoadEvent;
}