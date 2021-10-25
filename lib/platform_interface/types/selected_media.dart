import 'package:native_image_picker_view/platform_interface/types/media.dart';

enum SelectionType { selected, unselected }

class SelectedMedia {
  int selectedItemsCount;
  List<MediaData> media;

  SelectedMedia({required this.media, required this.selectedItemsCount});
}
