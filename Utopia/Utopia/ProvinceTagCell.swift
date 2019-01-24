
import Foundation
import UIKit

open class ProvinceTagCell : TableViewCell {
    fileprivate static let STORYBOARD_ID = "ProvinceTagCell"

    open override class func newInstance() -> ProvinceTagCell {
        return UINib(nibName: STORYBOARD_ID, bundle: nil).instantiate(withOwner: nil, options: nil).first as! ProvinceTagCell
    }

    open func setProvinceTag(_ string: String) {
        _textView.text = string
    }
}
