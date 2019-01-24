
import Foundation
import UIKit

open class DeployedArmyTableViewCell : TableViewCell {
    fileprivate static let STORYBOARD_ID = "DeployedArmyTableViewCell"

    open override class func newInstance() -> DeployedArmyTableViewCell {
        return UINib(nibName: STORYBOARD_ID, bundle: nil).instantiate(withOwner: nil, options: nil).first as! DeployedArmyTableViewCell
    }

    @IBOutlet
    internal weak var _generalsDeployedTextView : UILabel!

    @IBOutlet
    internal weak var _acresCapturedTextView : UILabel!

    @IBOutlet
    internal weak var _returnTimeTextView : UILabel!

    @IBOutlet
    internal weak var _progressBar : UIProgressView!

    open func setGeneralsDeployed(_ count: Int) {
        _generalsDeployedTextView.text = "\(count) general\(count > 1 ? "s" : "") deployed"
    }

    open func setAcresCaptured(_ count: Int) {
        _acresCapturedTextView.text = "\(count) acre\(count > 1 ? "s" : "")"
    }

    open func setReturnTime(_ returnTime: Int) {
        let hours : Int = Int(Double(returnTime) / 60.0 / 60.0)
        let minutes : Int = Int(((Double(returnTime) / 60.0 / 60.0) - Double(hours)) * 60.0)

        _returnTimeTextView.text = "\(hours)h \(minutes)m"

        var percent : Float = Float(returnTime) / 57600.0
        if (percent > 1.0) { percent = 1.0 }
        _progressBar.setProgress(percent, animated: false)
    }
}
