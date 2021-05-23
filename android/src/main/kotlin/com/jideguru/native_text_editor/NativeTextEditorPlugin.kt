package com.jideguru.native_text_editor

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry.Registrar

/** NativeTextEditorPlugin */
class NativeTextEditorPlugin : FlutterPlugin, ActivityAware {
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding
  }


  companion object {
    var myRegistrar: Registrar? = null
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      Log.d("HAHAHA", "RegisterWith")
      myRegistrar = registrar
      registrar
              .platformViewRegistry()
              .registerViewFactory(
                      "editorView", EditorViewFactory(registrar))
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    Log.d("HAHAHA", "Attached "+myRegistrar.toString())
    flutterPluginBinding
            .platformViewRegistry
            .registerViewFactory(
                    "editorView",
                    EditorViewFactory(myRegistrar))
  }

  override fun onDetachedFromActivity() {}

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }
}