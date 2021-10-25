part of native_image_picker_view;

enum Theme { light, dark }

typedef void ImageTappedCallback(int count, List<MediaData> selectedMedias);
typedef void AlbumChangedCallback(Album album);

class ImagePicker extends StatefulWidget {
  final String? albumId;
  final int? maxImages;
  final int? maxSize;
  final String fileNamePrefix;
  final List<MediaData>? selections;
  final List<MediaType> types;
  final Color itemColor;
  final String theme;
  final PickerCreatedCallback? onPickerCreated;
  final ImageTappedCallback? onSelectionChange;
  final AlbumChangedCallback? onAlbumChanged;

  ImagePicker({
    Key? key,
    this.onPickerCreated,
    this.maxImages,
    this.itemColor = Colors.white,
    required this.theme,
    this.onSelectionChange,
    this.onAlbumChanged,
    this.albumId,
    this.maxSize,
    this.selections,
    required this.fileNamePrefix,
    required this.types,
  });

  @override
  State<StatefulWidget> createState() => _PickerState();
}

typedef void PickerCreatedCallback(ImagePickerController controller);

int _nextPickerCreationId = 0;

class _PickerState extends State<ImagePicker> {
  final _pickerId = _nextPickerCreationId++;

  final Completer<ImagePickerController> _controller =
      Completer<ImagePickerController>();
  late PickerOptions _pickerOptions;
  late List<MediaType> types;

  @override
  Widget build(BuildContext context) {
    return ImageGalleryFlutterPlatform.instance.buildView(
        _pickerId, onPlatformViewCreated,
        galleryOptions: _pickerOptions.toMap());
  }

  @override
  void initState() {
    super.initState();
    types = widget.types;
    _pickerOptions = PickerOptions.fromWidget(widget);
  }

  @override
  void dispose() async {
    super.dispose();
    ImagePickerController controller = await _controller.future;
    controller.dispose();
  }

  Future<void> onPlatformViewCreated(int id) async {
    final ImagePickerController controller = await ImagePickerController.init(
      id,
      this,
    );
    _controller.complete(controller);

    final PickerCreatedCallback? onPickerCreated = widget.onPickerCreated;
    if (onPickerCreated != null) {
      onPickerCreated(controller);
    }
  }

  @override
  void didUpdateWidget(ImagePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    types = widget.types;
    _updateOptions();
  }

  void _updateOptions() async {
    final PickerOptions newOptions = PickerOptions.fromWidget(widget);
    final Map<String, dynamic> updates = _pickerOptions.updatesMap(newOptions);
    if (updates.isEmpty) {
      return;
    }
    final ImagePickerController controller = await _controller.future;
    // ignore: unawaited_futures
    controller.updateImageGalleryOptions(updates);
    _pickerOptions = newOptions;
  }
}

class PickerOptions {
  PickerOptions.fromWidget(ImagePicker picker)
      : albumId = picker.albumId,
        maxImages = picker.maxImages,
        maxSize = picker.maxSize,
        fileNamePrefix = picker.fileNamePrefix,
        itemColor = picker.itemColor,
        theme = picker.theme,
        selections = picker.selections,
        types = picker.types;

  final String? albumId;
  final int? maxImages;
  final int? maxSize;
  final String fileNamePrefix;
  final Color itemColor;
  final String theme;
  final List<MediaData>? selections;
  final List<MediaType> types;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'albumId': albumId,
      'maxImage': maxImages,
      'maxSize': maxSize,
      'fileNamePrefix': fileNamePrefix,
      'itemColor': itemColor,
      'theme': theme,
      "selections": selections == null
          ? null
          : selections!.map((imageData) => imageData.toMap()).toList(),
      'types': types
          .map((e) => e.toString().replaceAll("MediaType.", "").toUpperCase())
          .join("-"),
    };
  }

  Map<String, dynamic> updatesMap(PickerOptions newOptions) {
    final Map<String, dynamic> prevOptionsMap = toMap();

    return newOptions.toMap()
      ..removeWhere(
          (String key, dynamic value) => prevOptionsMap[key] == value);
  }
}
