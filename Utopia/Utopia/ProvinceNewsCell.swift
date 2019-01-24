
import Foundation
import UIKit

open class ProvinceNewsCell : TableViewCell {
    fileprivate static let STORYBOARD_ID = "ProvinceNewsCell"

    open override static func newInstance() -> ProvinceNewsCell {
        return UINib(nibName: STORYBOARD_ID, bundle: nil).instantiate(withOwner: nil, options: nil).first as! ProvinceNewsCell
    }

    @IBOutlet
    internal weak var _dateTextView : UILabel!

    @IBOutlet
    internal weak var _newsTextView : UILabel!

    open func setNews(_ newsContent: String) {
        _newsTextView.text = newsContent
    }

    open func setDate(_ dateString: String) {
        _dateTextView.text = dateString
    }
}
