
import Foundation
import UIKit

open class KingdomProvinceCell : CollectionViewCell {
    fileprivate static let STORYBOARD_ID = "KingdomProvinceCell"

    open override class func getStoryboardId() -> String {
        return STORYBOARD_ID
    }

    open override class func getMinimumHeight() -> Float? {
        return 150.0
    }

    open override class func newInstance() -> KingdomProvinceCell {
        return super.newInstance() as! KingdomProvinceCell
    }

    @IBOutlet
    internal weak var _provinceNameTextView : UILabel!

    @IBOutlet
    internal weak var _provinceRaceIcon : UIImageView!

    @IBOutlet
    internal weak var _provinceNetworthTextView : UILabel!

    @IBOutlet
    internal weak var _provinceAcresTextView : UILabel!

    open func setProvinceName(_ provinceName: String) {
        _provinceNameTextView.text = provinceName
    }

    open func setProvinceRace(_ race: Race) {
        let uiTheme : UiTheme = UiTheme(race: race)
        _provinceRaceIcon.image = uiTheme.getRaceIcon()
    }

    open func setProvinceNetworth(_ networth: Int) {
        _provinceNetworthTextView.text = String(networth)
    }

    open func setProvinceAcres(_ acres: Int) {
        _provinceAcresTextView.text = String(acres)
    }
}
