
import UIKit

@UIApplicationMain
open class AppDelegate: UIResponder, UIApplicationDelegate {

    open var window : UIWindow?

    fileprivate static var _mainStoryboard : UIStoryboard!
    fileprivate static var _mainNavigationController : UINavigationController!

    fileprivate static var _apnsToken : String?

    open static func getMainNavigationController() -> UINavigationController {
        return _mainNavigationController
    }

    open static func getMainStoryboard() -> UIStoryboard {
        return _mainStoryboard
    }

    open static func getApnsToken() -> String? {
        return _apnsToken
    }

    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        AppDelegate._mainStoryboard = mainStoryboard
        AppDelegate._mainNavigationController = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController

        self.window!.rootViewController = AppDelegate._mainNavigationController
        self.window!.makeKeyAndVisible()

        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        application.registerForRemoteNotifications()

        return true
    }

    open func applicationWillResignActive(_ application: UIApplication) { }

    open func applicationDidEnterBackground(_ application: UIApplication) { }

    open func applicationWillEnterForeground(_ application: UIApplication) { }

    open func applicationDidBecomeActive(_ application: UIApplication) { }

    open func applicationWillTerminate(_ application: UIApplication) { }

    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let apnsToken: String = (deviceToken.description as NSString)
            .trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            .replacingOccurrences( of: " ", with: "") as String

        if ((apnsToken as NSString).length() > 0) {
            AppDelegate._apnsToken = apnsToken

            let apnsTokenRegistrar : AutomaticApnsTokenRegistrar = AutomaticApnsTokenRegistrar.getInstance()
            apnsTokenRegistrar.setApnsToken(apnsToken)
        }
    }

    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register device w/ APNS: \(error)")
    }
}
