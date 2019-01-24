
import Foundation
import UIKit

open class CastSpellDialog : UIViewController {
    public typealias OnSubmitCallback_t = (() -> Void)

    open static let STORYBOARD_ID = "CastSpellDialog"

    open static func newInstance() -> CastSpellDialog {
        return UIStoryboard(name: "Dialogs", bundle: nil).instantiateViewController(withIdentifier: CastSpellDialog.STORYBOARD_ID) as! CastSpellDialog
    }

    @IBOutlet
    internal weak var _spellNameTextView : UILabel!

    @IBOutlet
    internal weak var _currentRunesTextView : UILabel!

    @IBOutlet
    internal weak var _spellCostTextView : UILabel!

    @IBOutlet
    internal weak var _totalRunesRemainingTextView : UILabel!

    fileprivate var _spellName : String = ""
    fileprivate var _currentRunesCount : Int = 0
    fileprivate var _spellCost : Int = 0
    fileprivate var _onSubmitCallback : OnSubmitCallback_t?

    fileprivate func _updateView() {
        _spellNameTextView.text = _spellName

        _currentRunesTextView.text = String(_currentRunesCount)
        _spellCostTextView.text = String(_spellCost)
        _totalRunesRemainingTextView.text = String(_currentRunesCount - _spellCost)
    }

    open func setSpellName(_ spellName: String) {
        _spellName = spellName
    }

    open func setSpellCost(_ spellCostInRunes : Int) {
        _spellCost = spellCostInRunes
    }

    open func setCurrentRuneCount(_ runeCount : Int) {
        _currentRunesCount = runeCount
    }

    open func setOnSubmitCallback(_ callback: OnSubmitCallback_t?) {
        _onSubmitCallback = callback
    }

    @IBAction
    open func onCastButtonClicked() {
        self.dismiss(animated: true, completion: {
            () -> Void in
                self._onSubmitCallback?()
        })
    }

    @IBAction
    open func onCancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        _updateView()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        _updateView()
    }

}
