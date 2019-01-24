
import Foundation
import UIKit

open class DraftRateDialog : UIViewController {
    public typealias OnSubmitCallback_t = ((_ draftRate: DraftRate) -> Void)

    open static let STORYBOARD_ID = "DraftRateDialog"

    open static func newInstance() -> DraftRateDialog {
        return UIStoryboard(name: "Dialogs", bundle: nil).instantiateViewController(withIdentifier: DraftRateDialog.STORYBOARD_ID) as! DraftRateDialog
    }

    @IBOutlet
    open weak var _currentDraftRateTextView : UILabel!

    @IBOutlet
    open weak var _draftRatePicker : UIPickerView!

    fileprivate var _availableDraftRates : Array<DraftRate>!
    fileprivate var _currentDraftRate : DraftRate!
    fileprivate var _onSubmitCallback : OnSubmitCallback_t!
    fileprivate var _pickerViewAdapter : PickerViewAdapter<DraftRate>!

    fileprivate func _updateView() {
        _currentDraftRateTextView.text = _currentDraftRate.getName()

        _pickerViewAdapter.setSelectedItem(displayName: _currentDraftRate.getName())
    }

    open func setAvailableDraftRates(_ draftRates : Array<DraftRate>) {
        _availableDraftRates = draftRates
    }

    open func setCurrentDraftRate(_ draftRate : DraftRate) {
        _currentDraftRate = draftRate
    }

    open func setOnSubmitCallback(_ onSubmitCallback : OnSubmitCallback_t?) {
        _onSubmitCallback = onSubmitCallback
    }

    @IBAction
    open func onUpdateButtonClicked() {
        let draftRate : DraftRate! = _pickerViewAdapter.getSelectedItem()

        self.dismiss(animated: true, completion: {
            () -> Void in
                self._onSubmitCallback?(draftRate)
        })
    }

    @IBAction
    open func onCancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        _pickerViewAdapter = PickerViewAdapter<DraftRate>(pickerView: _draftRatePicker)

        for draftRate : DraftRate in _availableDraftRates {
            _pickerViewAdapter.appendItem(displayName: draftRate.getName(), value: draftRate)
        }

        _draftRatePicker.dataSource = _pickerViewAdapter
        _draftRatePicker.delegate = _pickerViewAdapter
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
