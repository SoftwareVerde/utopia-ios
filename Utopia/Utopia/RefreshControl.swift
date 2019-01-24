
import Foundation
import UIKit

private extension Selector {
    static let OnRefresh : Selector = #selector(RefreshControl.onRefresh)
}

open class RefreshControl {
    public typealias ShouldHide_t = Bool
    public typealias OnRefreshCallback_t = () -> ShouldHide_t

    fileprivate let _refreshControl : UIRefreshControl
    fileprivate var _onRefreshCallback : OnRefreshCallback_t? = nil
    fileprivate var _onCompleteText : String = "Pull Down To Refresh"
    fileprivate var _view : UIView? = nil

    fileprivate func _setTitleText(_ string: String) {
        _refreshControl.attributedTitle = NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName : Util.parseColor("#FFFFFF")])
    }

    fileprivate func _onRefreshFinished() {
        _refreshControl.endRefreshing()
        _setTitleText(_onCompleteText)
    }

    public init() {
        _refreshControl = UIRefreshControl()

        _refreshControl.backgroundColor = Util.parseColor("#333333")
        _refreshControl.tintColor = Util.parseColor("#FFFFFF")
        _refreshControl.addTarget(self, action: .OnRefresh, for: .valueChanged)

        _setTitleText(_onCompleteText)
    }

    open func setTitleText(_ string: String) {
        _setTitleText(string)
    }

    open func setOnCompleteText(_ string: String) {
        _onCompleteText = string
    }

    open func setOnRefresh(_ onRefreshCallback : OnRefreshCallback_t?) {
        _onRefreshCallback = onRefreshCallback
    }

    open func applyToView(_ view: UIView) {
        view.addSubview(_refreshControl)
    }

    open func removeFromView(_ view: UIView) {
        _refreshControl.removeFromSuperview()
    }

    open func show() {
        _refreshControl.beginRefreshing()

        let contentOffset : CGPoint = CGPoint(x: 0, y: -_refreshControl.frame.size.height)
        (_view as? UIScrollView)?.setContentOffset(contentOffset, animated: true)
        (_view as? UITableView)?.setContentOffset(contentOffset, animated: true)

        // _refreshControl.sendActionsForControlEvents(.ValueChanged)
    }

    open func hide() {
        _onRefreshFinished()
    }

    @objc
    open func onRefresh() {
        let isFinished : Bool = (_onRefreshCallback?() ?? true)

        if (isFinished) {
            _onRefreshFinished()
        }
    }
}
