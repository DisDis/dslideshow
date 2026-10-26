part of 'gallery_bloc.dart';

@immutable
@freezed
abstract class GalleryEvent with _$GalleryEvent {
  const factory GalleryEvent.load({
    @Default(false) bool scan,
    Completer<void>? completion,
  }) = GalleryLoadEvent;
}
