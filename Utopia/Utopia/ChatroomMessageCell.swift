
import Foundation
import UIKit

open class ChatroomMessageCell : TableViewCell {
    fileprivate static let STORYBOARD_ID = "ChatroomMessageCell"

    open override class func newInstance() -> ChatroomMessageCell {
        return UINib(nibName: STORYBOARD_ID, bundle: nil).instantiate(withOwner: nil, options: nil).first as! ChatroomMessageCell
    }

    @IBOutlet
    internal weak var _provinceName : UILabel!

    @IBOutlet
    internal weak var _timestamp : UILabel!

    @IBOutlet
    internal weak var _messageContent : UILabel!

    open func setProvinceName(_ provinceName: String) {
        _provinceName.text = provinceName
    }

    open func setTimestamp(_ timestamp: Int) {
        let date : Date = Date(timeIntervalSince1970: Double(timestamp))

        let dayTimePeriodFormatter : DateFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "YYYY-mm-dd HH:mm:ss"

        let dateString : String = dayTimePeriodFormatter.string(from: date)
        _timestamp.text = dateString
    }

    open func setMessage(_ messageContent: String) {
        _messageContent.text = messageContent
    }
}
