
import Foundation
import UIKit

open class PickerViewAdapter<T> : NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    fileprivate typealias DisplayString_t = String

    fileprivate let _pickerView : UIPickerView
    fileprivate var _itemsVisibleAtOnce : Int = 5

    fileprivate var _datasetOrder : Array<DisplayString_t> = Array<DisplayString_t>()
    fileprivate var _dataset : Dictionary<DisplayString_t, T> = Dictionary<DisplayString_t, T>()

    fileprivate var _selectedRow : Int = 0

    public init(pickerView : UIPickerView) {
        _pickerView = pickerView
    }

    open func appendItem(displayName: String, value: T) {
        if (_dataset[displayName] != nil) {
            _datasetOrder.remove(at: _datasetOrder.index(of: displayName)!)
        }

        _datasetOrder.append(displayName)
        _dataset[displayName] = value
    }

    open func getSelectedItem() -> T? {
        if (_datasetOrder.count == 0) { return nil; }

        return _dataset[_datasetOrder[_selectedRow]]!
    }

    open func setSelectedItem(displayName: String) {
        let rowIndex : Int? = _datasetOrder.index(of: displayName)
        if (rowIndex == nil) { return }

        _pickerView.selectRow(rowIndex!, inComponent: 0, animated: false)
    }

    /*
        public func setSelectedItem(itemValue itemValue: T) {
            var rowIndex : Int? = nil

            var i : Int = 0
            for displayName : DisplayString_t in _datasetOrder {
                if (_dataset[displayName]! == itemValue) {
                    rowIndex = i
                    break
                }

                ++i
            }

            if (rowIndex == nil) { return }

            _pickerView.selectRow(rowIndex!, inComponent: 0, animated: false)
        }
    */

    @objc
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    @objc
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _dataset.count
    }

    @objc
    open func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.bounds.width
    }

    @objc
    open func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.bounds.height / CGFloat(_itemsVisibleAtOnce)
    }

    @objc
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nil
    }

    @objc
    open func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return nil
    }

    @objc
    open func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerViewItem : DefaultPickerViewItem = DefaultPickerViewItem.newInstance()
        pickerViewItem.setText(_datasetOrder[row])
        return pickerViewItem
    }

    @objc
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _selectedRow = row
    }
}
