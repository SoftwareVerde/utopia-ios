
import Foundation
import UIKit

open class WebViewDelegate : NSObject, UIWebViewDelegate {
    fileprivate var _shouldOpenLinksInWebView : Bool = true

    open func setShouldOpenLinksInWebView(_ shouldOpenLinksInWebView: Bool) {
        _shouldOpenLinksInWebView = shouldOpenLinksInWebView
    }

    open func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if (_shouldOpenLinksInWebView) { return true }

        if (navigationType == .linkClicked) {
            UIApplication.shared.openURL(request.url!)
            return false
        }
        return true
    }
}
