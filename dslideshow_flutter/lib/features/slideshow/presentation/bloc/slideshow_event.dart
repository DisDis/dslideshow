import 'package:freezed_annotation/freezed_annotation.dart';

part 'slideshow_event.freezed.dart';

@freezed
class SlideshowEvent with _$SlideshowEvent {
  const factory SlideshowEvent() = _SlideshowEvent;

  const factory SlideshowEvent.changeItem() = SlideshowChageItemEvent;
}
