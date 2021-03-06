import 'package:native_image_picker_view/platform_interface/types/media.dart';

class VideoData extends MediaData {
  final int durationMs;

  VideoData({
    required String? albumId,
    required String assetId,
    required String? uri,
    required this.durationMs,
  }) : super(
            albumId: albumId,
            assetId: assetId,
            uri: uri,
            type: MediaType.video);

  static VideoData fromJson(Map json) {
    return VideoData(
      albumId: json['albumId'] as String?,
      assetId: json['assetId'] as String,
      uri: json['uri'] as String?,
      durationMs: int.tryParse(json['duration'] as String) ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = super.toMap();

    result.putIfAbsent("duration", () => durationMs);

    return result;
  }
}
