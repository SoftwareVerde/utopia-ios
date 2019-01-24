
import Foundation
import UIKit

open class UpoopuIntelController : GenericIntelController {
    open static let STORYBOARD_ID : String = "UpoopuIntelController"

    open override func viewDidLoad() {
        super.viewDidLoad()

        _intelSyncType = IntelSyncType.upoopu
    }
}
