
import Foundation
import UIKit

open class TableViewCell : UITableViewCell {
    fileprivate static let STORYBOARD_ID = "TableViewCell"

    open class func newInstance() -> TableViewCell {
        return UINib(nibName: STORYBOARD_ID, bundle: nil).instantiate(withOwner: nil, options: nil).first as! TableViewCell
    }

    @IBOutlet
    internal weak var _textView : UILabel!
}
