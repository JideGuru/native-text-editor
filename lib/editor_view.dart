import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
typedef void EditorViewCreatedCallback(EditorViewController controller);

class NativeTextEditorView extends StatelessWidget {
  final EditorViewCreatedCallback onEditorViewCreated;

  NativeTextEditorView({this.onEditorViewCreated});

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    final String viewType = 'native_text_editor_view';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'editorView',
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError("Unsupported platform view");
    }
  }
  void _onPlatformViewCreated(int id) {
    if (onEditorViewCreated == null) {
      return;
    }
//    MethodChannel textInput = OptionalMethodChannel(
//      'editorView',
//      JSONMethodCodec(),
//    );
//    textInput.setMethodCallHandler(handler)
    onEditorViewCreated(new EditorViewController._(id));
  }
}

class EditorViewController {
  EditorViewController._(int id)
      : _channel = new MethodChannel('editorView_$id');

  final MethodChannel _channel;

  Future<void> setHtml(String html) async {
    assert(html != null);
    return _channel.invokeMethod('setHtml', html);
  }

  Future<String> getHtml() async {
    return _channel.invokeMethod('getHtml');
  }
}
