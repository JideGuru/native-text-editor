import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_text_editor/native_text_editor.dart';

void main() {
  const MethodChannel channel = MethodChannel('native_text_editor');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NativeTextEditor.platformVersion, '42');
  });
}
