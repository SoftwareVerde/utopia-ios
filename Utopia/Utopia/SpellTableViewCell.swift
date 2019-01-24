
import Foundation
import UIKit

open class SpellTableViewCell : TableViewCell {
    fileprivate static let STORYBOARD_ID = "SpellTableViewCell"

    open override static func newInstance() -> SpellTableViewCell {
        return UINib(nibName: STORYBOARD_ID, bundle: nil).instantiate(withOwner: nil, options: nil).first as! SpellTableViewCell
    }

    @IBOutlet
    internal weak var _spellNameTextView : UILabel!

    @IBOutlet
    internal weak var _spellCostTextView : UILabel!

    @IBOutlet
    internal weak var _spellDurationTextView : UILabel!

    open func setSpellName(_ string: String) {
        _spellNameTextView.text = string
    }

    open func setSpellCost(_ cost: Int) {
        _spellCostTextView.text = String(cost)
    }

    open func setSpellDuration(hours: Int, minutes: Int) {
        if (hours > 0 || minutes > 0) {
            let minutesString : String = (minutes < 10 ? "0\(minutes)" : "\(minutes)")
            _spellDurationTextView.text = "\(hours)h \(minutesString)m"
        }
        else {
            _spellDurationTextView.text = ""
        }
    }
}
