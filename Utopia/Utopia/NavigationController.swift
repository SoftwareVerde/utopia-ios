
import Foundation
import UIKit

open class NavigationController {
    fileprivate static var _instance : NavigationController!
    open static func getInstance() -> NavigationController {
        if (_instance == nil) {
            _instance = NavigationController()
        }

        return _instance
    }

    public enum ViewControllerId : String {
        case LOGIN  = "LoginViewController"
        case PROVINCE = "ProvinceTabViewController"
        case THRONE = "ThroneViewController"
    }


    fileprivate let _uiStoryboard : UIStoryboard
    fileprivate let _uiNavigationController : UINavigationController
    fileprivate let _session : Session

    fileprivate init() {
        _session = Session.getInstance()
        _uiStoryboard = AppDelegate.getMainStoryboard()
        _uiNavigationController = AppDelegate.getMainNavigationController()

        if (_session.hasIntelSyncEnabled() && !_session.isIntelSyncLoggedIn()) {
            _session.intelSyncLogin(nil)
        }

        if (_session.hasVerdeIntelSyncEnabled() && !_session.isVerdeIntelSyncLoggedIn()) {
            _session.verdeIntelSyncLogin();
        }

        _session.setOnBadAccessCallback({
            (badAccessType: BadAccessType) -> Void in
                self._setViewController(NavigationController.ViewControllerId.LOGIN)

                switch(badAccessType) {
                    case .unverified_EMAIL:

                        let alertController : UIAlertController = UIAlertController(
                            title: "Invalid Account",
                            message: "Your email address must be verified before you can continue. Please check your email for the verification link.",
                            preferredStyle: UIAlertControllerStyle.alert
                        )

                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                        self._uiNavigationController.present(alertController, animated: true, completion: nil)
                        break

                    case .no_PROVINCE:

                        let alertController : UIAlertController = UIAlertController(
                            title: "Invalid Province",
                            message: "Your province has not been created yet. Please create your province through the website before continuing.",
                            preferredStyle: UIAlertControllerStyle.alert
                        )

                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {
                            (alertAction: UIAlertAction) -> Void in
                                UIApplication.shared.openURL(URL(string: ComSoftwareverdeUtopiaSettings.getCreateProvinceUrl())!)
                        }))

                        self._uiNavigationController.present(alertController, animated: true, completion: nil)
                        break

                    case .dead_PROVINCE:

                        let alertController : UIAlertController = UIAlertController(
                            title: "Dead Province",
                            message: "Your province has been destroyed. You'll need to recreate your province through the website before continuing.",
                            preferredStyle: UIAlertControllerStyle.alert
                        )

                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: {
                            (alertAction: UIAlertAction) -> Void in
                                UIApplication.shared.openURL(URL(string: ComSoftwareverdeUtopiaSettings.getCreateProvinceUrl())!)
                        }))

                        self._uiNavigationController.present(alertController, animated: true, completion: nil)
                        break

                    case .none:
                        break
                }
        })
    }

    fileprivate func _setViewController(_ viewControllerStoryboardId: ViewControllerId) {
        let viewController : UIViewController! = _uiStoryboard.instantiateViewController(withIdentifier: viewControllerStoryboardId.rawValue)
        _uiNavigationController.setViewControllers([viewController], animated: true)
    }

    open func pushViewController(_ viewControllerStoryboardId: ViewControllerId) {
        let viewController : UIViewController! = _uiStoryboard.instantiateViewController(withIdentifier: viewControllerStoryboardId.rawValue)
        _uiNavigationController.pushViewController(viewController, animated: true)
    }

    open func presentModal(_ viewController: UIViewController) {
        _uiNavigationController.present(viewController, animated: true, completion: nil)
    }

    open func setViewController(_ viewControllerStoryboardId: ViewControllerId) {
        _setViewController(viewControllerStoryboardId)
    }

    open func setTitleBarVisible(_ shouldShow: Bool) {
        _uiNavigationController.isNavigationBarHidden = !shouldShow
    }
}
