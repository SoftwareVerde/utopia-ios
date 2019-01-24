
import Foundation
import UIKit

open class ReadOnlyThroneViewController : ThroneViewController {
    open override class func newInstance() -> ReadOnlyThroneViewController {
        let instance = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: STORYBOARD_ID) as? ThroneViewController)!
        object_setClass(instance, ReadOnlyThroneViewController.self)

        return (instance as! ReadOnlyThroneViewController)
    }

    open func setProvince(_ province: Province) {
        super._province = province
    }

    internal override func _downloadData() {
        let loadingDialog : LoadingDialog = LoadingDialog.newInstance()
        loadingDialog.show(self.view)

        _session.downloadProvinceIntel(province: _province, callback: {
            (response: SessionResponse) -> Void in
                loadingDialog.hide()
                self._updateViews()
        })
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        _showNavigationBar("Back")
    }

    open override func onNavigationButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    open override func onSoldiersButtonClicked() { }
    
    open override func onDefenseUnitsButtonClicked() { }
    
    open override func onOffenseUnitsButtonClicked() { }
    
    open override func onElitesButtonClicked() { }
    
    open override func onThievesButtonClicked() { }
    
    open override func onWagesButtonClicked() { }
    
    open override func onDraftRateButtonClicked() { }
    
    open override func onDraftTargetDrag(_ view: UIView, event: UIEvent) { }
    
    open override func onDraftTargetDragComplete() { }
}
