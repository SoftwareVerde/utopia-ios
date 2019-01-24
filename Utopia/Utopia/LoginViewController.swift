
import Foundation
import UIKit

open class LoginViewController: UIViewController {
    open static let STORYBOARD_ID : String = "LoginViewController"

    @IBOutlet
    internal weak var _errorTextView: UILabel!

    @IBOutlet
    internal weak var _usernameField: UITextField!

    @IBOutlet
    internal weak var _passwordField: UITextField!

    @IBOutlet
    internal weak var _loginButton: UIButton!

    fileprivate var _session : Session!
    fileprivate var _navigationController : NavigationController!

    @IBAction
    open func loginButtonClickedCallback() {
        _session.login(username: _usernameField.text!, password: _passwordField.text!, callback: {
            (sessionResponse : SessionResponse) -> Void in
                if (sessionResponse.getWasSuccess()) {
                    self._navigationController.pushViewController(NavigationController.ViewControllerId.PROVINCE)
                }
                else {
                    self._errorTextView.text = sessionResponse.getErrorMessage()
                }
        })
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        _session = Session.getInstance()
        _navigationController = NavigationController.getInstance()

        if (_session.hasSavedCredentials()) {
            _session.resume(Runnable({
                () -> Void in
                    self._session.autoLogin({
                        (sessionResponse : SessionResponse) -> Void in
                            if (sessionResponse.getWasSuccess()) {
                                self._navigationController.setViewController(NavigationController.ViewControllerId.PROVINCE)
                                self._navigationController.setTitleBarVisible(false);
                            }
                            else {
                                self._errorTextView.text = sessionResponse.getErrorMessage()
                            }
                    })

            }))
        }
    }

}

