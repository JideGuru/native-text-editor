package com.jideguru.native_text_editor

import android.content.Context
import android.graphics.Rect
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.inputmethod.InputMethodManager
import android.widget.RelativeLayout
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.platform.PlatformView
import net.dankito.richtexteditor.android.RichTextEditor
import net.dankito.richtexteditor.android.toolbar.GroupedCommandsEditorToolbar
import net.dankito.richtexteditor.callback.GetCurrentHtmlCallback

class FlutterEditorView internal constructor(context: Context, registrar: Registrar?, id: Int) : PlatformView, MethodCallHandler {
    class MyLayout(context: Context, var containerView: View) : RelativeLayout(context) {
//        private var proxy: ThreadedInputConnectionProxyAdapterView? = null

        init {
            Log.d("HAHAHA", "FlutterEditorView init2")
            setFocusable(true)
            setFocusableInTouchMode(true)
            setClickable(true)
        }

        override fun onFocusChanged(gainFocus: Boolean, direction: Int, previouslyFocusedRect: Rect?) {
            super.onFocusChanged(gainFocus, direction, previouslyFocusedRect)
        }

        override fun checkInputConnectionProxy(view: View): Boolean {
//            proxy = ThreadedInputConnectionProxyAdapterView(containerView, view, view.getHandler())
//            setInputConnectionTarget(proxy!!)
            return super.checkInputConnectionProxy(view)
        }

        fun setInputConnectionTarget(targetView: View) {
            targetView.requestFocus()
            containerView.post(
                    object : Runnable {
                        override fun run() {
                            val imm: InputMethodManager = getContext().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                            // This is a hack to make InputMethodManager believe that the target view now has focus.
                            // As a result, InputMethodManager will think that targetView is focused, and will call
                            // getHandler() of the view when creating input connection.

                            // Step 1: Set targetView as InputMethodManager#mNextServedView. This does not affect
                            // the real window focus.
                            targetView.onWindowFocusChanged(true)

                            // Step 2: Have InputMethodManager focus in on targetView. As a result, IMM will call
                            // onCreateInputConnection() on targetView on the same thread as
                            // targetView.getHandler(). It will also call subsequent InputConnection methods on this
                            // thread. This is the IME thread in cases where targetView is our proxyAdapterView.
                            imm.isActive(containerView)
                        }
                    })
        }
    }

    private val editor: RichTextEditor
    private val bottomGroupedCommandsToolbar: GroupedCommandsEditorToolbar
    //    private val view: View
    private val methodChannel: MethodChannel
//    private var proxy: ThreadedInputConnectionProxyAdapterView? = null
    private val layout = MyLayout(context, registrar!!.view())

    override fun getView(): View{
        Log.d("HAHAHA", "FlutterEditorView getview")
        return layout
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "setHtml" -> setHtml(methodCall, result)
            "getHtml" -> getHtml(methodCall, result)
            else -> result.notImplemented()
        }
    }

    private fun setHtml(methodCall: MethodCall, result: Result) {
        val html = methodCall.arguments as String
        editor.setHtml(html)
        result.success(null)
    }

    private fun getHtml(methodCall: MethodCall, result: Result) {
        editor.getCurrentHtmlAsync(object : GetCurrentHtmlCallback {
            override fun htmlRetrieved(html: String) {
                result.success(html)
            }
        })
    }

    override fun dispose() {}

    init {
        Log.d("HAHAHA", "FlutterEditorView init")
        layout.layoutParams = LayoutInflater.from(registrar!!.activity()).inflate(R.layout.editorlayout, null).layoutParams
        editor = layout.findViewById(R.id.editor)
        bottomGroupedCommandsToolbar = layout.findViewById(R.id.editorToolbar)
        bottomGroupedCommandsToolbar.editor = editor
        methodChannel = MethodChannel(registrar?.messenger(), "editorView_$id")
        methodChannel.setMethodCallHandler(this)
    }
}