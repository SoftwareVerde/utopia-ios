
import Foundation
import UIKit

open class CollectionViewCell : UICollectionViewCell {
    public typealias OnClickListener_t = () -> Void
    fileprivate static let STORYBOARD_ID = "CollectionViewCell"

    open class func getStoryboardId() -> String {
        return STORYBOARD_ID
    }

    open class func getNib() -> UINib {
        return UINib(nibName: getStoryboardId(), bundle: nil)
    }

    open class func newInstance() -> CollectionViewCell {
        return UINib(nibName: getStoryboardId(), bundle: nil).instantiate(withOwner: nil, options: nil).first as! CollectionViewCell
    }

    open class func getMinimumHeight() -> Float? { return nil }

    @IBOutlet
    internal weak var _textView : UILabel!

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open func setText(_ text: String) {
        _textView?.text = text
    }
}
