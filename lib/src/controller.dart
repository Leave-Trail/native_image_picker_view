part of native_image_picker_view;

/// Callback function taking a single argument.
typedef void ArgumentCallback<T>(T argument);

class ImagePickerController {
  final int pickerId;
  final _PickerState _pickerState;

  ImagePickerController._(
    this._pickerState, {
    required this.pickerId,
  }) {
    _connectStreams(pickerId);
  }

  static Future<ImagePickerController> init(
    int id,
    _PickerState pickerState,
  ) async {
    await ImageGalleryFlutterPlatform.instance.init(id);
    return ImagePickerController._(
      pickerState,
      pickerId: id,
    );
  }

  void _connectStreams(int pickerId) {
    if (_pickerState.widget.onSelectionChange != null) {
      ImageGalleryFlutterPlatform.instance
          .onSelectionChange(pickerId: pickerId)
          .listen((event) {
        _pickerState.widget.onSelectionChange!(
            event.value.selectedItemsCount, event.value.media);
      });
    }
  }

  Future<void> updateImageGalleryOptions(Map<String, dynamic> optionsUpdate) {
    return ImageGalleryFlutterPlatform.instance
        .updateImageGalleryOptions(optionsUpdate, pickerId: pickerId);
  }

  Future<void> selectAll() {
    return ImageGalleryFlutterPlatform.instance.selectAll(pickerId: pickerId);
  }

  Future<void> selectNone() {
    return ImageGalleryFlutterPlatform.instance.selectNone(pickerId: pickerId);
  }

  Future<void> openAlbumsList(bool open) {
    return ImageGalleryFlutterPlatform.instance
        .openAlbumsList(open, pickerId: pickerId);
  }

  Future<void> reloadAlbum(String albumId, {List<MediaType>? types}) {
    return ImageGalleryFlutterPlatform.instance
        .reloadAlbum(albumId, types: types, pickerId: pickerId);
  }

  Future<List<Album>> getAlbumList() {
    return ImageGalleryFlutterPlatform.instance
        .getAlbumList(pickerId: pickerId);
  }

  Future<List<MediaData>?> getSelectedMedia() {
    return ImageGalleryFlutterPlatform.instance
        .getSelectedMedia(pickerId: pickerId);
  }

  void dispose() {
    ImageGalleryFlutterPlatform.instance.dispose(pickerId: pickerId);
  }
}
