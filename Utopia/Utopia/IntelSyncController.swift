
import Foundation
import UIKit

open class IntelSyncController : UIViewController {
    open static let STORYBOARD_ID : String = "IntelSyncController"

    fileprivate var _session : Session!

    @IBOutlet
    internal var _tabController : UISegmentedControl!

    @IBOutlet
    internal var _inAppIntelContainer : UIView!

    @IBOutlet
    internal var _upoopuIntelContainer : UIView!

    @IBOutlet
    internal var _umunkIntelContainer : UIView!

    @IBOutlet
    internal var _stingerIntelContainer : UIView!

    fileprivate class TabIndexes {
        static let IN_APP : Int = 0
        static let UPOOPU : Int = 1
        static let UMUNK : Int = 2
        static let STINGER : Int = 3
    }

    fileprivate func _updateView() {
        // Nothing.
    }

    @IBAction
    open func onTabChanged() {
        let selectedTabIndex = _tabController.selectedSegmentIndex
        switch (selectedTabIndex) {
            case TabIndexes.IN_APP:
                _inAppIntelContainer.alpha = 1
                _upoopuIntelContainer.alpha = 0
                _umunkIntelContainer.alpha = 0
                _stingerIntelContainer.alpha = 0
            case TabIndexes.UPOOPU:
                _inAppIntelContainer.alpha = 0
                _upoopuIntelContainer.alpha = 1
                _umunkIntelContainer.alpha = 0
                _stingerIntelContainer.alpha = 0
            case TabIndexes.UMUNK:
                _inAppIntelContainer.alpha = 0
                _upoopuIntelContainer.alpha = 0
                _umunkIntelContainer.alpha = 1
                _stingerIntelContainer.alpha = 0
            case TabIndexes.STINGER:
                _inAppIntelContainer.alpha = 0
                _upoopuIntelContainer.alpha = 0
                _umunkIntelContainer.alpha = 0
                _stingerIntelContainer.alpha = 1
            default:
                print("Invalid Tab Option: \(selectedTabIndex)")
        }

        for viewController in self.childViewControllers {
            (viewController as? GenericIntelController)?.onInputsBlurred()
            (viewController as? GenericIntelController)?.updateView()
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
