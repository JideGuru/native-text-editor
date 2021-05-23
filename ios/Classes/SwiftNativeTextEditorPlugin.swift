import Flutter
import UIKit

public class SwiftNativeTextEditorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    //let channel = FlutterMethodChannel(name: "native_text_editor", binaryMessenger: registrar.messenger())
    //let instance = SwiftNativeTextEditorPlugin()
    //registrar.addMethodCallDelegate(instance, channel: channel)

    let factory = NativeTextEditorViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "native_text_editor_view")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
