
import Foundation
import UIKit

open class VerdeIntelController : UIViewController {
    open static let STORYBOARD_ID : String = "VerdeIntelController"

    fileprivate var _session : Session!

    fileprivate func _updateView() {

    }

    @IBOutlet
    internal weak var _inAppSyncToggle : UISwitch!

    @IBAction
    open func onInAppIntelSyncToggled() {
        let shouldBeEnabled : Bool = _inAppSyncToggle.isOn
        _session.setVerdeIntelSyncEnabled(shouldBeEnabled)

        if (shouldBeEnabled) {
            if (!_session.isVerdeIntelSyncLoggedIn()) {
                _session.verdeIntelSyncLogin()
            }
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        _session = Session.getInstance()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        _updateView()
    }

}
