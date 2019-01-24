
import Foundation
import UIKit

open class MilitaryWagesDialog : UIViewController {
    public typealias OnSubmitCallback_t = ((_ wagePercentAsInt: Int) -> Void)

    open static let STORYBOARD_ID = "MilitaryWagesDialog"

    open static func newInstance() -> MilitaryWagesDialog {
        return UIStoryboard(name: "Dialogs", bundle: nil).instantiateViewController(withIdentifier: MilitaryWagesDialog.STORYBOARD_ID) as! MilitaryWagesDialog
    }

    @IBOutlet
    open weak var _currentWagesPercentTextView : UILabel!

    @IBOutlet
    open weak var _wagesInputEditText : UITextField!

    fileprivate var _currentWages : Int = 0
    fileprivate var _onSubmitCallback : OnSubmitCallback_t?

    fileprivate func _updateView() {
        _currentWagesPercentTextView.text = "\(_currentWages)%"
    }

    open func setCurrentWages(_ currentPercentAsInt : Int) {
        _currentWages = currentPercentAsInt
    }

    open func setOnSubmitCallback(_ onSubmitCallback : OnSubmitCallback_t?) {
        _onSubmitCallback = onSubmitCallback
    }

    @IBAction
    open func onWagesChanged() {
        // Nothing.
    }

    @IBAction
    open func onUpdateButtonClicked() {
        let newPercent : Int = (Int((_wagesInputEditText.text ?? "")) ?? 0)
        self.dismiss(animated: true, completion: {
            () -> Void in
                self._onSubmitCallback?(newPercent)
        })
    }

    @IBAction
    open func onCancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction
    open func onNewWagesBlurred() {
        _wagesInputEditText.endEditing(false)
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
