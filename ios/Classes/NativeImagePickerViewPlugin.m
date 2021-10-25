#import "NativeImagePickerViewPlugin.h"
#if __has_include(<native_image_picker_view/native_image_picker_view-Swift.h>)
#import <native_image_picker_view/native_image_picker_view-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_image_picker_view-Swift.h"
#endif

@implementation NativeImagePickerViewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeImagePickerViewPlugin registerWithRegistrar:registrar];
}
@end
