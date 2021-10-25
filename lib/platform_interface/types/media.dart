import 'package:native_image_picker_view/platform_interface/types/image.dart';
import 'package:native_image_picker_view/platform_interface/types/video.dart';

enum MediaType { image, video }

class MediaData {
  final String? albumId;
  final String assetId;
  final MediaType type;
  final String? uri;

  MediaData({
    required this.albumId,
    required this.assetId,
    required this.uri,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      "albumId": albumId,
      "assetId": assetId,
      "type": type == MediaType.image ? "IMAGE" : "VIDEO",
      "uri": uri,
    };
  }

  static MediaData fromJson(Map json) {
    String? type = json['type'] as String?;

    if (type == "IMAGE") {
      return ImageData.fromJson(json);
    } else {
      return VideoData.fromJson(json);
    }
  }
}
