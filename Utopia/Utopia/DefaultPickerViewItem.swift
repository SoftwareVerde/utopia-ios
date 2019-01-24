
import Foundation
import UIKit

open class DefaultPickerViewItem : UIView {
    open static let STORYBOARD_ID = "DefaultPickerViewItem"

    open static func newInstance() -> DefaultPickerViewItem {
        return UINib(nibName: STORYBOARD_ID, bundle: nil).instantiate(withOwner: nil, options: nil).first as! DefaultPickerViewItem
    }

    @IBOutlet
    open weak var _textView : UILabel!

    open func setText(_ text : String) {
        _textView.text = text
    }
}
