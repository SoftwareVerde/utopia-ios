
import Foundation
import UIKit

private class CollectionViewCellFactory<C : CollectionViewCell> {
    fileprivate let _uiCollectionView : UICollectionView

    init(uiCollectionView: UICollectionView) {
        _uiCollectionView = uiCollectionView
        _uiCollectionView.register(C.getNib(), forCellWithReuseIdentifier: C.getStoryboardId())
    }

    func createCell(_ indexPath: IndexPath) -> C {
        return _uiCollectionView.dequeueReusableCell(withReuseIdentifier: C.getStoryboardId(), for: indexPath) as! C
    }
}

open class CollectionViewCellRenderer<T, C : CollectionViewCell> {
    open func renderCell(data : T, cell: C) { }

    // public func getCellWidth() -> Float { return 100.0 }
    // public func getCellHeight() -> Float { return 100.0 }
}

open class CollectionAdapter<T, C : CollectionViewCell> : NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    public typealias OnItemClickedCallback_t = (_ itemSelected : T, _ cell: C) -> Void
    public typealias SortFunction_t = (T, T) -> Bool

    fileprivate var _uiCollectionView : UICollectionView
    fileprivate var _cellFactory : CollectionViewCellFactory<C>
    fileprivate var _dataset : Array<T> = Array<T>()
    fileprivate var _cells : Dictionary<Int, C> = Dictionary<Int, C>()

    fileprivate var _onItemClickedCallback : OnItemClickedCallback_t?
    fileprivate var _cellRenderer : CollectionViewCellRenderer<T, C> = CollectionViewCellRenderer<T, C>()

    fileprivate var _columnCount : Int = 1
    fileprivate var _cellMargin : Float = 1.0

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

    fileprivate func _setItemSize(width: Float, height: Float) {
        let cellMargin : CGFloat = CGFloat(_cellMargin)
        let flowLayout : UICollectionViewFlowLayout? = _uiCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.minimumInteritemSpacing = cellMargin
        flowLayout?.minimumLineSpacing = cellMargin * 2.0
        flowLayout?.itemSize = CGSize(width: CGFloat(width), height: CGFloat(height))
    }

    fileprivate func _calculateColumnWidth() -> Float {
        let columnCount : Float = Float(_columnCount)
        let containerWidth : Float = Float(_uiCollectionView.bounds.width)
        let itemWidth : Float = (containerWidth / columnCount) - (_cellMargin * (columnCount - 1.0))
        return itemWidth
        // _setItemSize(width: itemWidth, height: itemWidth)
    }

    fileprivate func _autoSetItemSize() {
        let columnWidth : Float = _calculateColumnWidth()
        var rowHeight : Float? = C.getMinimumHeight()
        if (rowHeight == nil) {
            rowHeight = columnWidth
        }

        _setItemSize(width: columnWidth, height: rowHeight!)
    }

    public init(uiCollectionView: UICollectionView) {
        _uiCollectionView = uiCollectionView
        _cellFactory = CollectionViewCellFactory<C>(uiCollectionView: _uiCollectionView)

        super.init()

        _autoSetItemSize()

        _uiCollectionView.dataSource = self
        _uiCollectionView.delegate = self
    }

    // NOTE: Invoke after views have been laid out or have changed sizes.
    open func updateViewSizes() {
        _autoSetItemSize()
    }

    open func setSortFunction(_ sortFunction: SortFunction_t?) {
        _sortFunction = sortFunction

        if (!_dataset.isEmpty && _sortFunction != nil) {
            _resortDataset()
        }
    }

    open func setColumnCount(_ columnCount: Int) {
        _columnCount = columnCount

        _autoSetItemSize()
    }

    open func setCellRenderer(_ cellRenderer : CollectionViewCellRenderer<T, C>) {
        _cellRenderer = cellRenderer
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

    open func setOnItemClickedCallback(_ onItemClickedCallback : OnItemClickedCallback_t?) {
        _onItemClickedCallback = onItemClickedCallback
    }

    // Begin UICollectionView functions...

    @objc
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _dataset.count
    }

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @objc
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data : T = _dataset[indexPath.item]
        let collectionViewCell : C = _cellFactory.createCell(indexPath)

        _cells[indexPath.row] = collectionViewCell

        _cellRenderer.renderCell(data: data, cell: collectionViewCell)

        return collectionViewCell
    }

    @objc
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    @objc
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data : T = _dataset[indexPath.item]
        let cell : C = _cells[indexPath.item]!
        _onItemClickedCallback?(data, cell)
    }

}
