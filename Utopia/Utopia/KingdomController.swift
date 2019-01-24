
import Foundation
import UIKit

open class KingdomCellRenderer : CollectionViewCellRenderer<Province, KingdomProvinceCell> {
    open override func renderCell(data province: Province, cell: KingdomProvinceCell) {
        cell.setProvinceName(province.getName())
        cell.setProvinceRace(province.getRace())
        cell.setProvinceAcres(province.getAcres())
        cell.setProvinceNetworth(province.getNetworth())
    }
}

open class KingdomController : UIViewController {
    open static let STORYBOARD_ID : String = "KingdomController"
    fileprivate static let KINGDOM_CALLBACK_IDENTIFIER : String = "KingdomController.downloadKingdomIdentifier"

    fileprivate var _session : Session!
    fileprivate var _kingdomAdapter : CollectionAdapter<Province, KingdomProvinceCell>!
    fileprivate var _kingdomCellRenderer : KingdomCellRenderer!
    fileprivate var _kingdomIdentifier : KingdomIdentifier!
    fileprivate var _focusedProvince : Province?

    @IBOutlet
    internal weak var _kingdomCollection : UICollectionView!

    @IBOutlet
    internal weak var _selectedItemOverlay : UIView!

    @IBOutlet
    internal weak var _selectedItemContainerOverlay : UIView!

    @IBOutlet
    internal weak var _selectedItemButtonsOverlay : UIView!

    @IBOutlet
    internal weak var _kingdomIdEditText : UITextField!

    @IBOutlet
    internal weak var _islandIdEditText : UITextField!

    @IBOutlet
    internal weak var _kingdomIncrementControl : UIStepper!

    @IBOutlet
    internal weak var _kingdomNameTextView : UILabel!

    @IBOutlet
    internal weak var _kingdomNetworthTextView : UILabel!

    @IBOutlet
    internal weak var _kingdomStanceTextView : UILabel!

    @IBOutlet
    internal weak var _attackButton : UIView!

    @IBOutlet
    internal weak var _magicButton : UIView!

    @IBOutlet
    internal weak var _thieveryButton : UIView!

    @IBOutlet
    internal weak var _viewButton : UIView!
    
    @IBOutlet
    internal weak var _aidButton : UIView!

    @IBAction
    open func onInputBlur() {
        _kingdomIdEditText.endEditing(false)
        _islandIdEditText.endEditing(false)

        let kingdomId : Int = Int(_kingdomIdEditText.text!)!
        let islandId : Int = Int(_islandIdEditText.text!)!

        if ((kingdomId > 0 && islandId > 0) && (kingdomId != _kingdomIdentifier.getKingdomId() || islandId != _kingdomIdentifier.getIslandId())) {
            let loadingDialog : LoadingDialog = LoadingDialog.newInstance()
            loadingDialog.show(self.view)

            let kingdomIdentifier : KingdomIdentifier = KingdomIdentifier(kingdomId: kingdomId, islandId: islandId)
            _session.downloadKingdom(kingdomIdentifier: kingdomIdentifier, callback: DownloadKingdomCallback({
                (response: UtopiaSessionResponse, kingdomIdentifier: KingdomIdentifier) -> Void in
                    self._kingdomIdentifier = kingdomIdentifier
                    self._updateView()
                    loadingDialog.hide()
            }))
        }
    }

    @IBAction
    open func onOverlayClicked() {
        _hideOverlay()
    }

    @IBAction
    open func onIncrementClicked() {
        let newValue : Int = Int(_kingdomIncrementControl.value)

        let loadingDialog : LoadingDialog = LoadingDialog.newInstance()
        loadingDialog.show(self.view)

        if (newValue > 0) {
            _session.downloadNextKingdom(currentKingdomIdentifier: _kingdomIdentifier, callback: DownloadKingdomCallback({
                (response: UtopiaSessionResponse, kingdomIdentifier: KingdomIdentifier) -> Void in
                    self._kingdomIdentifier = kingdomIdentifier
                    self._updateView()
                    loadingDialog.hide()
            }))
        }
        else if (newValue < 0) {
            _session.downloadPreviousKingdom(currentKingdomIdentifier: _kingdomIdentifier, callback: DownloadKingdomCallback({
                (response: UtopiaSessionResponse, kingdomIdentifier: KingdomIdentifier) -> Void in
                    self._kingdomIdentifier = kingdomIdentifier
                    self._updateView()
                    loadingDialog.hide()
            }))
        }
        else {
            loadingDialog.hide()
        }

        _kingdomIncrementControl.value = 0
    }

    @IBAction
    open func onViewButtonClicked() {
        let readOnlyThroneViewController : ReadOnlyThroneViewController = ReadOnlyThroneViewController.newInstance()
        readOnlyThroneViewController.setProvince(_focusedProvince!)
        NavigationController.getInstance().presentModal(readOnlyThroneViewController)
    }

    @IBAction
    open func onMagicButtonClicked() {
        let offensiveSpellsController : OffensiveSpellsController = OffensiveSpellsController.newInstance()
        offensiveSpellsController.setTargetProvince(_focusedProvince!)
        NavigationController.getInstance().presentModal(offensiveSpellsController)
    }

    fileprivate func _updateView() {
        let kingdom : Kingdom = _session.getKingdom(_kingdomIdentifier)

        _kingdomIdEditText.text = String(_kingdomIdentifier.getKingdomId())
        _islandIdEditText.text = String(_kingdomIdentifier.getIslandId())
        _kingdomNameTextView.text = kingdom.getName()
        _kingdomNetworthTextView.text = String(kingdom.getNetworth())
        _kingdomStanceTextView.text = kingdom.getStance()

        _kingdomAdapter.clearData()
        for province : Province in _session.getKingdom(_kingdomIdentifier).getProvinces() {
            _kingdomAdapter.appendData(province)
        }
        _kingdomCollection.reloadData()
    }

    fileprivate func _hideOverlay() {
        _selectedItemOverlay.isUserInteractionEnabled = false
        _selectedItemOverlay.alpha = 0.0

        for view in _selectedItemContainerOverlay.subviews {
            view.removeFromSuperview()
        }
    }

    fileprivate func _showOverlay(province: Province, cellOffset: CGPoint, cellDimensions: CGSize) {
        _selectedItemOverlay.isUserInteractionEnabled = true
        _selectedItemContainerOverlay.isUserInteractionEnabled = false

        _selectedItemOverlay.alpha = 1.0

        let kingdomProvinceCell : KingdomProvinceCell = KingdomProvinceCell.newInstance()
        _kingdomCellRenderer.renderCell(data: province, cell: kingdomProvinceCell)

        _selectedItemContainerOverlay.addSubview(kingdomProvinceCell)

        var cellFrame : CGRect = kingdomProvinceCell.frame
        cellFrame.origin.x = cellOffset.x
        cellFrame.origin.y = cellOffset.y
        cellFrame.size.width = cellDimensions.width
        cellFrame.size.height = cellDimensions.height
        kingdomProvinceCell.frame = cellFrame

        _selectedItemOverlay.bringSubview(toFront: _selectedItemButtonsOverlay)

        _aidButton.alpha = 0.33
        _thieveryButton.alpha = 0.33
        _attackButton.alpha = 0.33
    }

    open override func viewDidLoad() {
        _session = Session.getInstance()
        _kingdomIdentifier = _session.getKingdom().getIdentifier()

        _kingdomAdapter = CollectionAdapter<Province, KingdomProvinceCell>(uiCollectionView: _kingdomCollection)
        _kingdomCellRenderer = KingdomCellRenderer()
        _kingdomAdapter.setCellRenderer(_kingdomCellRenderer)
        _kingdomAdapter.setColumnCount(3)

        _kingdomAdapter.setSortFunction({
            (lhs: Province, rhs: Province) -> Bool in
                return (rhs.getNetworth() < lhs.getNetworth())
        })

        _hideOverlay()
        _focusedProvince = nil

        _kingdomAdapter.setOnItemClickedCallback({
            (itemSelected: Province, cell: KingdomProvinceCell) -> Void in
                var offsetPoint : CGPoint = cell.frame.origin
                offsetPoint.x += self._kingdomCollection.frame.origin.x - self._kingdomCollection.contentOffset.x + self._selectedItemOverlay.frame.origin.x
                offsetPoint.y += self._kingdomCollection.frame.origin.y - self._kingdomCollection.contentOffset.y + self._selectedItemOverlay.frame.origin.y

                let cellDimensions : CGSize = CGSize(width: cell.frame.width, height: cell.frame.height)

                self._focusedProvince = itemSelected
                self._showOverlay(province: itemSelected, cellOffset: offsetPoint, cellDimensions: cellDimensions)
        })

        _session.addOnKingdomDownloadCallback(uniqueIdentifier: KingdomController.KINGDOM_CALLBACK_IDENTIFIER, callback: {
            (kingdomIdentifier: KingdomIdentifier) -> Void in
                self._session.setFocusedKingdom(kingdomIdentifier)
                self._kingdomIdentifier = kingdomIdentifier
        })

        _updateView()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _kingdomAdapter.updateViewSizes()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        _updateView()
    }
}
