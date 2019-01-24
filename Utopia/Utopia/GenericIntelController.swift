
import Foundation
import UIKit

open class GenericIntelController : UIViewController {
    fileprivate var _session : Session!

    @IBOutlet
    internal var _statusText : UILabel!

    @IBOutlet
    internal var _subDomainEditText : UITextField?

    @IBOutlet
    internal var _usernameEditText : UITextField!

    @IBOutlet
    internal var _passwordEditText : UITextField!

    @IBOutlet
    internal var _deactivateButton : UIButton!

    var _intelSyncType: IntelSyncType! = nil // NOTE: Can't be private.

    fileprivate func _updateView() {
        let intelSyncIsActive : Bool = (_session.hasIntelSyncEnabled() && _session.isIntelSyncLoggedIn())
        let activeTypeIsCurrentView : Bool = (_session.getIntelSyncType() == _intelSyncType)

        _statusText.text = (intelSyncIsActive && activeTypeIsCurrentView ? "Intel Sync is currently Active." : "")
        _deactivateButton.alpha = (intelSyncIsActive && activeTypeIsCurrentView ? 1.0 : 0.0)
        _deactivateButton.isEnabled = (intelSyncIsActive && activeTypeIsCurrentView ? true : false)
    }

    open func updateView() {
        _updateView()
    }

    @IBAction
    open func onSubmitButtonClicked() {
        let subDomain : String = (_subDomainEditText?.text ?? "")
        let username : String = _usernameEditText.text!
        let password : String = _passwordEditText.text!

        _session.intelSyncAuthenticate(intelSyncType: _intelSyncType, subDomain: subDomain, username: username, password: password, sessionCallback: {
            (sessionResponse: SessionResponse) -> Void in
            self._session.intelSyncLogin({
                (sessionResponse: SessionResponse) -> Void in
                self._updateView()

                if (sessionResponse.getWasSuccess()) {
                    self._usernameEditText.text = ""
                    self._passwordEditText.text = ""
                }
            })
        })
    }

    @IBAction
    open func onDeactivateButtonClicked() {
        _session.clearIntelSyncCredentials()
        _updateView()
    }

    @IBAction
    open func onInputsBlurred() {
        _subDomainEditText?.endEditing(false)
        _usernameEditText.endEditing(false)
        _passwordEditText.endEditing(false)
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
