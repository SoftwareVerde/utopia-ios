
import Foundation
import UIKit

open class TrainUnitsDialog : UIViewController {
    public typealias OnSubmitCallback_t = ((_ count: Int, _ isExpedited: Bool) -> Void)

    open static let STORYBOARD_ID = "TrainUnitsDialog"

    open static func newInstance() -> TrainUnitsDialog {
        return UIStoryboard(name: "Dialogs", bundle: nil).instantiateViewController(withIdentifier: TrainUnitsDialog.STORYBOARD_ID) as! TrainUnitsDialog
    }

    @IBOutlet
    internal weak var _titleTextView : UILabel!

    @IBOutlet
    internal weak var _newQuantityEditText : UITextField!

    @IBOutlet
    internal weak var _currentValueTextView : UILabel!

    @IBOutlet
    internal weak var _inProgressValueTextView : UILabel!

    @IBOutlet
    internal weak var _totalValueTextView : UILabel!

    @IBOutlet
    internal weak var _shouldExpediteToggle : UISwitch!

    @IBOutlet
    internal weak var _trainingOrReleasingLabel : UILabel!

    @IBOutlet
    internal weak var _trainingOrReleasingTextView : UILabel!

    @IBOutlet
    internal weak var _costTextView : UILabel!

    fileprivate var _title : String = "Train/Release Troops"
    fileprivate var _currentQuantity : Int = 0
    fileprivate var _inProgressQuantity : Int = 0
    fileprivate var _baseTrainingCost : Int = 0
    fileprivate var _onSubmitCallback : OnSubmitCallback_t?

    fileprivate func _updateView() {
        _titleTextView.text = _title

        _currentValueTextView.text = String(_currentQuantity)
        _inProgressValueTextView.text = String(_inProgressQuantity)
        _totalValueTextView.text = String(_currentQuantity + _inProgressQuantity)

        let isExpedited : Bool = _shouldExpediteToggle.isOn

        let inputValue : Int = (Int((_newQuantityEditText.text ?? "")) ?? 0)
        _trainingOrReleasingLabel.text = ((inputValue < 0) ? "Releasing" : "Training")
        _trainingOrReleasingLabel.textColor = ((inputValue >= 0) ? Util.parseColor("#000000") : Util.parseColor("#990000"))

        let totalCost : Int = inputValue * _baseTrainingCost * (isExpedited ? 2 : 1)
        _costTextView.textColor = ((totalCost > 0) ? Util.parseColor("#990000") : Util.parseColor("#000000"))
        _costTextView.text = "(\(totalCost) gc)"

        _trainingOrReleasingTextView.text = String(abs(inputValue))
    }

    open func setDialogTitle(_ title : String) {
        _title = title
    }

    open func setCurrentQuantity(_ currentQuantity : Int) {
        _currentQuantity = currentQuantity
    }

    open func setInProgressQuantity(_ inProgressQuantity : Int) {
        _inProgressQuantity = inProgressQuantity
    }

    open func setBaseTrainingCost(_ baseTrainingCost : Int) {
        _baseTrainingCost = baseTrainingCost
    }

    open func setOnSubmitCallback(_ callback: OnSubmitCallback_t?) {
        _onSubmitCallback = callback
    }

    @IBAction
    open func onNewQuantityChanged() {
        _updateView()
    }

    @IBAction
    open func onTrainButtonClicked() {
        let unitCount : Int = (Int((_newQuantityEditText.text ?? "")) ?? 0)
        let isExpedited : Bool = _shouldExpediteToggle.isOn

        self.dismiss(animated: true, completion: {
            () -> Void in
                self._onSubmitCallback?(unitCount, isExpedited)
        })
    }

    @IBAction
    open func onCancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction
    open func onExpediteToggleChanged() {
        _updateView()
    }

    @IBAction
    open func onNewQuantityBlurred() {
        _newQuantityEditText.endEditing(false)
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
