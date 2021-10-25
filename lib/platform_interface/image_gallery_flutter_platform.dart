import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:native_image_picker_view/platform_interface/types/album.dart';
import 'package:native_image_picker_view/platform_interface/types/media.dart';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'events/gallery_events.dart';
import 'method_channel/method_channel_image_gallery_flutter.dart';

abstract class ImageGalleryFlutterPlatform extends PlatformInterface {
  ImageGalleryFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static ImageGalleryFlutterPlatform _instance =
      MethodChannelIMageGalleryFlutter();

  /// The default instance of [GoogleMapsFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelGoogleMapsFlutter].
  static ImageGalleryFlutterPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [GoogleMapsFlutterPlatform] when they register themselves.
  static set instance(ImageGalleryFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// /// Initializes the platform interface with [id].
  ///
  /// This method is called when the plugin is first initialized.
  Future<void> init(int gridId) {
    throw UnimplementedError('init() has not been implemented.');
  }

  /// Updates configuration options of the map user interface.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> updateImageGalleryOptions(
    Map<String, dynamic> optionsUpdate, {
    required int pickerId,
  }) {
    throw UnimplementedError('updateMapOptions() has not been implemented.');
  }

  Future<void> reloadAlbum(String albumId,
      {List<MediaType>? types, required int pickerId}) {
    throw UnimplementedError('takeSnapshot() has not been implemented.');
  }

  Future<List<Album>> getAlbumList({required int pickerId}) {
    throw UnimplementedError('takeSnapshot() has not been implemented.');
  }

  Future<void> selectAll({required int pickerId}) {
    throw UnimplementedError('takeSnapshot() has not been implemented.');
  }

  Future<void> selectNone({required int pickerId}) {
    throw UnimplementedError('takeSnapshot() has not been implemented.');
  }

  Future<List<MediaData>?> getSelectedMedia({
    required int pickerId,
  }) {
    throw UnimplementedError('takeSnapshot() has not been implemented.');
  }

  Stream<SelectionEvent> onSelectionChange({required int pickerId}) {
    throw UnimplementedError('onCameraMoveStarted() has not been implemented.');
  }

  /// Dispose of whatever resources the `gridId` is holding on to.
  void dispose({required int pickerId}) {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  /// Returns a widget displaying the map view
  Widget buildView(
    int creationId,
    PlatformViewCreatedCallback onPlatformViewCreated, {
    Map<String, dynamic> galleryOptions = const <String, dynamic>{},
  }) {
    throw UnimplementedError('buildView() has not been implemented.');
  }

  Future<void> openAlbumsList(bool open, {required int pickerId}) {
    throw UnimplementedError('buildView() has not been implemented.');
  }
}
