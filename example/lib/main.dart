import 'package:flutter/material.dart';
import 'package:native_text_editor/native_text_editor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: NativeTextEditorView(
            onEditorViewCreated: _onTextViewCreated,
          ),
        ),
      ),
    );
  }

  void _onTextViewCreated(EditorViewController controller) {
    controller.setHtml('''<!DOCTYPE html>
        <html>
        <body>
        <h1>Heading 1</h1>
        <h2>Heading 2</h2>
        <h3>Heading 3</h3>
        <h4>Heading 4</h4>
        <h5>Heading 5</h5>
        <h6>Heading 6</h6>
        </body>
        </html>
        ''');
  }

}
