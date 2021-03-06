import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_image_picker_view/native_image_picker_view.dart';

void main() {
  const MethodChannel channel = MethodChannel('native_image_picker_view');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
