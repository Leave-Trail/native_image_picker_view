import 'package:native_image_picker_view/platform_interface/types/media.dart';
import 'package:native_image_picker_view/platform_interface/types/selected_media.dart';

class GalleryEvent<T> {
  /// The ID of the Map this event is associated to.
  final int galleryId;

  /// The value wrapped by this event
  final T value;

  /// Build a Map Event, that relates a mapId with a given value.
  ///
  /// The `mapId` is the id of the map that triggered the event.
  /// `value` may be `null` in events that don't transport any meaningful data.
  GalleryEvent(this.galleryId, this.value);
}

class SelectionEvent extends GalleryEvent<SelectedMedia> {
  SelectionEvent(int galleryId, SelectedMedia selectedMedia)
      : super(galleryId, selectedMedia);
}
