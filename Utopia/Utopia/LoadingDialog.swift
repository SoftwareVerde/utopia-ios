
import Foundation
import UIKit

open class LoadingDialog : UIView {
    fileprivate static let STORYBOARD_ID = "LoadingDialog"

    open static func newInstance() -> LoadingDialog {
        return UINib(nibName: STORYBOARD_ID, bundle: nil).instantiate(withOwner: nil, options: nil).first as! LoadingDialog
    }

    @IBOutlet
    internal weak var _loadingSpinner : UIActivityIndicatorView!

    @IBOutlet
    internal weak var _textView : UILabel!

    open func setText(_ string: String) {
        _textView.text = string
    }

    open func show(_ view: UIView) {
        view.addSubview(self)

        // Voodoo Magick:
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["subview": self]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["subview": self]))
    }

    open func hide() {
        self.removeFromSuperview()
    }
}
