package com.jideguru.native_text_editor;

import android.content.Context
import android.util.Log
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory


class EditorViewFactory(private val registrar: Registrar?) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, o: Any?): PlatformView {
        Log.d("HAHAHA", "EditorViewFactory create")
        return FlutterEditorView(context, registrar, id)
    }
}
