
import Foundation
import UIKit

open class IosJavaScriptExecutor : NSObject, ComSoftwareverdeUtopiaUtilJavaScriptExecutor {
    fileprivate let _webView : UIWebView = UIWebView()

    fileprivate func _appendScriptToWebView(_ javaScript: String) {
        let bytes : Data = ("<script>\(javaScript)</script>" as NSString).data(using: String.Encoding.utf8.rawValue)!
        _webView.load(bytes, mimeType: "text/html", textEncodingName: "Base64", baseURL: URL(string: "http://www.softwareverde.com")!)
    }

    public override init() {
        super.init()

        let iosApiScript : String = "var ios = {}; ios.onJsResult = function(result) { return result; }"
        _appendScriptToWebView(iosApiScript)
    }

    open func loadScript(with javaScript: String) {
        _appendScriptToWebView(javaScript)
    }

    open func executeJavaScript(with javaScript: String, with variableNameOfResult: String, with callback: ComSoftwareverdeUtopiaUtilJavaScriptExecutor_Callback?) {
        DispatchQueue.main.async(execute: {
            let value : String = self._webView.stringByEvaluatingJavaScript(from: javaScript)!
            if (callback != nil) {
                callback?.run(with: value)
            }
        })
    }
}
