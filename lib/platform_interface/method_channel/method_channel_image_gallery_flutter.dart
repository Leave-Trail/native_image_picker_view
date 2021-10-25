import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:native_image_picker_view/platform_interface/events/gallery_events.dart';
import 'package:native_image_picker_view/platform_interface/image_gallery_flutter_platform.dart';
import 'package:native_image_picker_view/platform_interface/types/album.dart';
import 'package:native_image_picker_view/platform_interface/types/media.dart';
import 'package:native_image_picker_view/platform_interface/types/selected_media.dart';

class UnknownGalleryIDError extends Error {
  /// Creates an assertion error with the provided [mapId] and optional
  /// [message].
  UnknownGalleryIDError(this.mapId, [this.message]);

  /// The unknown ID.
  final int mapId;

  /// Message describing the assertion error.
  final Object? message;

  String toString() {
    if (message != null) {
      return "Unknown map ID $mapId: ${Error.safeToString(message)}";
    }
    return "Unknown map ID $mapId";
  }
}

class MethodChannelIMageGalleryFlutter extends ImageGalleryFlutterPlatform {
  // Keep a collection of id -> channel
  // Every method call passes the int mapId
  final Map<int, MethodChannel> _channels = {};

  /// Accesses the MethodChannel associated to the passed mapId.
  MethodChannel channel(int mapId) {
    MethodChannel? channel = _channels[mapId];
    if (channel == null) {
      throw UnknownGalleryIDError(mapId);
    }
    return channel;
  }

  /// Returns the channel for [mapId], creating it if it doesn't already exist.
  @visibleForTesting
  MethodChannel ensureChannelInitialized(int mapId) {
    MethodChannel? channel = _channels[mapId];
    if (channel == null) {
      channel = MethodChannel('leavetrails.com/native_image_picker_$mapId');
      channel.setMethodCallHandler(
          (MethodCall call) => _handleMethodCall(call, mapId));
      _channels[mapId] = channel;
    }
    return channel;
  }

  @override
  Future<void> init(int mapId) {
    MethodChannel channel = ensureChannelInitialized(mapId);
    return channel.invokeMethod<void>('gallery#waitForGallery');
  }

  Future<dynamic> _handleMethodCall(MethodCall call, int pickerId) async {
    switch (call.method) {
      case 'media#onSelectionChanged':
        List<MediaData> media =
            await getSelectedMedia(pickerId: pickerId) ?? [];
        _galleryEventStreamController.add(SelectionEvent(
            pickerId,
            SelectedMedia(
                media: media, selectedItemsCount: call.arguments['count'])));
        break;
      default:
        throw MissingPluginException();
    }
  }

  final StreamController<GalleryEvent> _galleryEventStreamController =
      StreamController<GalleryEvent>.broadcast();

  // Returns a filtered view of the events in the _controller, by mapId.
  Stream<GalleryEvent> _events(int galleryId) =>
      _galleryEventStreamController.stream
          .where((event) => event.galleryId == galleryId);

  @override
  Future<void> updateImageGalleryOptions(
    Map<String, dynamic> optionsUpdate, {
    required int pickerId,
  }) {
    return channel(pickerId).invokeMethod<void>(
      'picker#updateOptions',
      optionsUpdate,
    );
  }

  @override
  Future<void> reloadAlbum(String albumId,
      {List<MediaType>? types, required int pickerId}) {
    types ??= [MediaType.image];

    return channel(pickerId)
        .invokeMethod<void>('album#reload', <String, dynamic>{
      'albumId': albumId,
      'types': types
          .map((e) => e.toString().replaceAll("MediaType.", "").toUpperCase())
          .join("-")
    });
  }

  @override
  Future<List<Album>> getAlbumList({required int pickerId}) async {
    return (await channel(pickerId).invokeListMethod<String>('album#getList'))!
        .map((albumId) => Album(albumId: albumId))
        .toList();
  }

  @override
  Future<void> selectAll({required int pickerId}) {
    return channel(pickerId).invokeMethod<void>('media#selectAll');
  }

  @override
  Future<void> selectNone({required int pickerId}) {
    return channel(pickerId).invokeMethod<void>('media#selectNone');
  }

  @override
  Future<List<MediaData>?> getSelectedMedia({
    required int pickerId,
  }) async {
    List<MediaData>? result = (await channel(pickerId)
            .invokeListMethod<Map<String, dynamic>>('media#getSelected'))!
        .map((e) => MediaData.fromJson(e))
        .toList();

    return result;
  }

  @override
  Future<void> openAlbumsList(bool open, {required int pickerId}) async {
    return channel(pickerId).invokeMethod<void>('album#openList');
  }

  @override
  Stream<SelectionEvent> onSelectionChange({required int pickerId}) {
    throw UnimplementedError('onCameraMoveStarted() has not been implemented.');
  }

  @override
  Widget buildView(
    int creationId,
    PlatformViewCreatedCallback onPlatformViewCreated, {
    Map<String, dynamic> galleryOptions = const <String, dynamic>{},
  }) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'leavetrails.com/native_image_picker',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: galleryOptions,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'leavetrails.com/native_image_picker',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: galleryOptions,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the maps plugin');
  }
}
