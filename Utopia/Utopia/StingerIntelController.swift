
import Foundation
import UIKit

open class StingerIntelController : GenericIntelController {
    open static let STORYBOARD_ID : String = "StingerIntelController"

    open override func viewDidLoad() {
        super.viewDidLoad()

        _intelSyncType = IntelSyncType.stinger
    }
}
