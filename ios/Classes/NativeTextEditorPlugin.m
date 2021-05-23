#import "NativeTextEditorPlugin.h"
#if __has_include(<native_text_editor/native_text_editor-Swift.h>)
#import <native_text_editor/native_text_editor-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_text_editor-Swift.h"
#endif

@implementation NativeTextEditorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeTextEditorPlugin registerWithRegistrar:registrar];
}
@end
