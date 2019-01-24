
import Foundation
import UIKit

open class TableViewCellFactory<T> {
    fileprivate let _rowHeight : Float = 50.0

    open func createCell(_ data: T) -> TableViewCell {
        return TableViewCell.newInstance()
    }

    open func getCellHeight(data: T, cell: TableViewCell?) -> Float {
        return _rowHeight;
    }
}

open class TableViewAdapter<T> : NSObject, UITableViewDataSource, UITableViewDelegate {
    public typealias SortFunction_t = (T, T) -> Bool
    public typealias OnItemClickedCallback_t = (_ itemSelected : T) -> Void

    fileprivate var _cellFactory : TableViewCellFactory<T> = TableViewCellFactory()
    fileprivate var _dataset : Array<T> = Array<T>()
    fileprivate var _onItemClickedCallback : OnItemClickedCallback_t?
    fileprivate var _cells : Dictionary<Int, TableViewCell> = Dictionary<Int, TableViewCell>()
    fileprivate var _sortFunction : SortFunction_t? = nil

    fileprivate func _findSortedItemLocation(_ newItem: T) -> Int {
        var low : Int = 0
        var hi : Int = _dataset.count - 1
        while (low <= hi) {
            let mid : Int = (low + hi) / 2
            if (_sortFunction!(_dataset[mid], newItem)) {
                low = mid + 1
            }
            else if (_sortFunction!(newItem, _dataset[mid])) {
                hi = mid - 1
            }
            else {
                return mid
            }
        }
        return low
    }

    fileprivate func _resortDataset() {
        let unsortedItems : Array<T> = _dataset
        _dataset = Array<T>()
        
        for item : T in unsortedItems {
            _dataset.insert(item, at: _findSortedItemLocation(item))
        }
    }

    open func clearData() {
        _dataset.removeAll()
    }

    open func appendData(_ data: T) {
        if (_sortFunction != nil) {
            _dataset.insert(data, at: _findSortedItemLocation(data))
        }
        else {
            _dataset.append(data)
        }
    }

    open func getCount() -> Int {
        return _dataset.count
    }

    open func setCellFactory(_ cellFactory : TableViewCellFactory<T>) {
        _cellFactory = cellFactory
    }

    open func setOnItemClickedCallback(_ onItemClickedCallback : OnItemClickedCallback_t?) {
        _onItemClickedCallback = onItemClickedCallback
    }

    open func setSortFunction(_ sortFunction: SortFunction_t?) {
        _sortFunction = sortFunction

        if (_sortFunction != nil && !_dataset.isEmpty) {
            _resortDataset()
        }
    }

    // Begin UITableView functions...

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _dataset.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data : T = _dataset[indexPath.row]
        let tableViewCell : TableViewCell = _cellFactory.createCell(data)
        _cells[indexPath.row] = tableViewCell
        return tableViewCell
    }

    @objc
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    @objc
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    @objc
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }

    @objc
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    @objc
    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    @objc
    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }

    @objc
    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 0
    }

    @objc
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) { }

    @objc
    open func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { }

    @objc
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { }

    @objc
    open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) { }

    @objc
    open func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) { }

    @objc
    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) { }

    @objc
    open func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) { }

    @objc
    open func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) { }

    @objc
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(_cellFactory.getCellHeight(data: _dataset[indexPath.row], cell: _cells[indexPath.row]))
    }

    @objc
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    @objc
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    @objc
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(_cellFactory.getCellHeight(data: _dataset[indexPath.row], cell: _cells[indexPath.row]))
    }

    @objc
    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    @objc
    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    @objc
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    @objc
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    @objc
    open func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) { }

    @objc
    open func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return (_onItemClickedCallback != nil ? true : false)
    }

    @objc
    open func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) { }

    @objc
    open func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) { }

    @objc
    open func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return (_onItemClickedCallback != nil ? indexPath : nil)
    }

    @objc
    open func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    @objc
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data : T = _dataset[indexPath.row]
        _onItemClickedCallback?(data)
    }

    @objc
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }

    @objc
    open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }

    @objc
    open func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return nil
    }

    @objc
    open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return nil
    }

    @objc
    open func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    @objc
    open func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) { }

    @objc
    open func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) { }

    @objc
    open func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return sourceIndexPath
    }

    @objc
    open func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 0
    }

    @objc
    open func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    @objc
    open func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    @objc
    open func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) { }

    @objc
    open func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    @objc
    open func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return false
    }

    @objc
    open func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) { }

    @objc
    open func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        return nil
    }
}
