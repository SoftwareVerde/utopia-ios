
import Foundation
import UIKit

open class UmunkIntelController : GenericIntelController {
    open static let STORYBOARD_ID : String = "UmunkIntelController"

    open override func viewDidLoad() {
        super.viewDidLoad()

        _intelSyncType = IntelSyncType.umunk
    }
}
