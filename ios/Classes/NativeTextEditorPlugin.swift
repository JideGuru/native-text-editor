import Flutter
import UIKit
import Aztec
import WordPressEditor
import Foundation

class NativeTextEditorViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return NativeTextEditorView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class NativeTextEditorView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.green
        //let editorView = Aztec.EditorView(
                    //defaultFont: Constants.defaultContentFont,
                    //defaultHTMLFont: defaultHTMLFont,
                    //defaultParagraphStyle: .default,
                    //defaultMissingImage: Constants.defaultMissingImage
                    //coder: aDecoder
                    //)

                //editorView?.clipsToBounds = false
        //let nativeLabel = UILabel()
        //nativeLabel.text = "Native text from iOS"
        //nativeLabel.textColor = UIColor.white
        //nativeLabel.textAlignment = .center
        //nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        _view.addSubview(editorView)
    }
    fileprivate(set) lazy var editorView: Aztec.EditorView = {
            let defaultHTMLFont: UIFont

            // defaultHTMLFont = UIFontMetrics.default.scaledFont(for: Constants.defaultContentFont)

            let editorView = Aztec.EditorView(
                //defaultFont: Constants.defaultContentFont,
                //defaultHTMLFont: defaultHTMLFont,
                //defaultParagraphStyle: .default,
                //defaultMissingImage: Constants.defaultMissingImage
                )

            editorView.clipsToBounds = false
            //setupHTMLTextView(editorView.htmlTextView)
            //setupRichTextView(editorView.richTextView)

            return editorView
        }()

    override init() {
            super.init()
        }

        required init?(coder aDecoder: NSCoder) {
                //sampleHTML = nil
                //wordPressMode = false

                super.init(coder: aDecoder)
            }
}