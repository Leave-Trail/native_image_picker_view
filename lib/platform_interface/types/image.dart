import 'package:native_image_picker_view/platform_interface/types/media.dart';

class ImageData extends MediaData {
  ImageData({
    required String? albumId,
    required String assetId,
    required String? uri,
  }) : super(
            albumId: albumId,
            assetId: assetId,
            uri: uri,
            type: MediaType.image);

  static ImageData fromJson(Map json) {
    return ImageData(
      albumId: json['albumId'] as String?,
      assetId: json['assetId'] as String,
      uri: json['uri'] as String?,
    );
  }
}
