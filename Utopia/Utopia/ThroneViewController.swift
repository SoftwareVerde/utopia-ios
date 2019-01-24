
import Foundation
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


open class ThroneViewController: UIViewController {
    open static let STORYBOARD_ID : String = "ThroneViewController"
    fileprivate static let ADVIEW_CALLBACK_IDENTIFIER : String = "THRONE_ADVIEW_CALLBACK"

    open class func newInstance() -> ThroneViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: STORYBOARD_ID) as! ThroneViewController
    }

    public enum UnitType {
        case soldiers, defensive_UNITS, offensive_UNITS, elites, thieves
    }

    fileprivate class DeployedArmyCellFactory : TableViewCellFactory<DeployedArmy> {
        fileprivate let _rowHeight : Float = 50

        override func getCellHeight(data: DeployedArmy, cell: TableViewCell?) -> Float {
            return _rowHeight
        }

        override func createCell(_ deployedArmy: DeployedArmy) -> DeployedArmyTableViewCell {
            let cell : DeployedArmyTableViewCell = DeployedArmyTableViewCell.newInstance()
            cell.setAcresCaptured(deployedArmy.getAcres())
            cell.setGeneralsDeployed(deployedArmy.getGenerals())
            cell.setReturnTime(deployedArmy.getReturnTime())
            return cell
        }
    }

    @IBOutlet
    internal weak var _provinceNameTextView : UILabel!

    @IBOutlet
    internal weak var _rulereNameTextView : UILabel!

    @IBOutlet
    internal weak var _goldCoinsTextView : UILabel!

    @IBOutlet
    internal weak var _foodTextView : UILabel!

    @IBOutlet
    internal weak var _runesTextView : UILabel!

    @IBOutlet
    internal weak var _acresTextView : UILabel!

    @IBOutlet
    internal weak var _networthTextView : UILabel!

    @IBOutlet
    internal weak var _offenseTextView : UILabel!

    @IBOutlet
    internal weak var _defenseTextView : UILabel!

    @IBOutlet
    internal weak var _peasantsPercentContainerView : UIView!

    @IBOutlet
    internal weak var _peasantsPercentView : UIView!

    @IBOutlet
    internal weak var _peasantsTextView : UILabel!

    @IBOutlet
    internal weak var _buildingEfficiencyPercentContainerView : UIView!

    @IBOutlet
    internal weak var _buildingEfficiencyPercentView : UIView!

    @IBOutlet
    internal weak var _buildingEfficiencyTextView : UILabel!

    @IBOutlet
    internal weak var _soldiersTextView : UILabel!

    @IBOutlet
    internal weak var _defenseUnitsTextView : UILabel!

    @IBOutlet
    internal weak var _offenseUnitsTextView : UILabel!

    @IBOutlet
    internal weak var _thievesTextView : UILabel!

    @IBOutlet
    internal weak var _wizardsTextView : UILabel!

    @IBOutlet
    internal weak var _eliteUnitsTextView : UILabel!

    @IBOutlet
    internal weak var _horsesTextView : UILabel!

    @IBOutlet
    internal weak var _prisonersTextView : UILabel!

    @IBOutlet
    internal weak var _scrollView : UIScrollView!

    @IBOutlet
    internal weak var _horsesPercentContainerView : UIView!

    @IBOutlet
    internal weak var _horsesPercentView : UIView!

    @IBOutlet
    internal weak var _prisonersPercentContainerView : UIView!

    @IBOutlet
    internal weak var _prisonersPercentView : UIView!

    @IBOutlet
    internal weak var _militaryPercentContainerView : UIView!

    @IBOutlet
    internal weak var _currentMilitaryPercentView : UIView!

    @IBOutlet
    internal weak var _currentMilitaryTextView : UILabel!

    @IBOutlet
    internal weak var _desiredMilitaryPercentView : UIView!

    @IBOutlet
    internal weak var _desiredMilitaryTextView : UILabel!

    @IBOutlet
    internal weak var _desiredCivilianTextView : UILabel!

    @IBOutlet
    internal weak var _wageRateTextView : UILabel!

    @IBOutlet
    internal weak var _draftRateTextView : UILabel!

    @IBOutlet
    internal weak var _stealthTextView : UILabel!

    @IBOutlet
    internal weak var _manaTextView : UILabel!

    @IBOutlet
    internal weak var _raceIcon : UIImageView!

    @IBOutlet
    internal weak var _stealthResourceBar : UIImageView!

    @IBOutlet
    internal weak var _manaResourceBar : UIImageView!

    @IBOutlet
    internal weak var _stealthResourceContainer : UIView!

    @IBOutlet
    internal weak var _manaResourceContainer : UIView!

    @IBOutlet
    internal weak var _deployedArmiesTableView : UITableView!

    @IBOutlet
    internal weak var _adView : UIWebView!

    @IBOutlet
    internal weak var _navigationContainer : UIView!
    
    @IBOutlet
    internal weak var _navigationButton : UIButton!

    @IBOutlet
    internal weak var _navigationViewHeightConstraint : NSLayoutConstraint!

    internal var _session : Session!
    internal var _province : Province!
    internal var _desiredDraftPercentAsInt : Int?
    internal var _adViewDelegate : WebViewDelegate!
    internal var _lastAdviewLoad : Double = 0
    internal var _refreshControl : RefreshControl!

    internal var _deployedArmyAdapter : TableViewAdapter<DeployedArmy>!

    internal func _hideNavigationBar() {
        self._navigationContainer.alpha = 0
        _navigationViewHeightConstraint.constant = 0
    }

    internal func _showNavigationBar(_ buttonText: String) {
        _navigationViewHeightConstraint.constant = 50
        _navigationButton.setTitle(buttonText, for: UIControlState())
        self._navigationContainer.alpha = 1
    }

    fileprivate func _setViewWidth(view : UIView, width : Float) {
        for constraint in view.constraints {
            if (constraint.firstAttribute == .width || constraint.secondAttribute == .width) {
                view.removeConstraint(constraint)
                break
            }
        }

        let widthConstraint : NSLayoutConstraint = NSLayoutConstraint(
            item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: CGFloat(width)
        )

        view.addConstraint(widthConstraint)
    }

    fileprivate func _setViewHeight(view : UIView, height : Float) {
        for constraint in view.constraints {
            if (constraint.firstAttribute == .height || constraint.secondAttribute == .height) {
                view.removeConstraint(constraint)
                break
            }
        }

        let heightConstraint : NSLayoutConstraint = NSLayoutConstraint(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: CGFloat(height)
        )

        view.addConstraint(heightConstraint)
    }

    fileprivate func _getViewWidth(_ view : UIView) -> Float {
        return Float(view.bounds.width)
    }

    fileprivate func _getViewHeight(_ view : UIView) -> Float {
        return Float(view.bounds.height)
    }

    internal func _updateViews() {
        let province : Province = _province
        let race : Race! = province.getRace()
        if (race == nil) { return }

        let uiTheme : UiTheme = UiTheme(race: race)

        _provinceNameTextView.text = province.getName()
        _rulereNameTextView.text = province.getRulerName()

        let gold : Int? = province.getMoney()
        _goldCoinsTextView.text = (gold != nil ? String(gold!) : "?")

        let food : Int? = province.getFood()
        _foodTextView.text = (food != nil ? String(food!) : "?")

        let runes : Int? = province.getRunes()
        _runesTextView.text = (runes != nil ? String(runes!) : "?")

        _acresTextView.text = String(province.getAcres())

        _networthTextView.text = String(province.getNetworth())

        let offense : Int? = province.getTotalOffense()
        _offenseTextView.text = (offense != nil ? String(offense!) : "?")

        let defense : Int? = province.getTotalDefense()
        _defenseTextView.text = (defense != nil ? String(defense!) : "?")

        let peasants : Int? = province.getPeasants()
        let maxPeasants : Int? = province.getMaxPeasants()
        let peasantPercent : Float = (maxPeasants != nil ? (maxPeasants > 0 ? Float(province.getPeasants()) / Float(maxPeasants!) : 1.0) : 0.0)
        _setViewWidth(view: _peasantsPercentView, width: peasantPercent * _getViewWidth(_peasantsPercentContainerView))
        _peasantsTextView.text = (peasants != nil ? String(peasants!) : "?")

        let buildingEfficiency : Float? = province.getBuildingEfficiency()
        let buildingEfficiencyPercent : Float = (buildingEfficiency != nil ? buildingEfficiency! : 0.0)
        _setViewWidth(view: _buildingEfficiencyPercentView, width: buildingEfficiencyPercent * _getViewWidth(_buildingEfficiencyPercentContainerView))
        _buildingEfficiencyTextView.text = (buildingEfficiency != nil ? "\(buildingEfficiency! * 100.0)%" : "?")

        let soldiers : Int? = province.getSoldiers()
        _soldiersTextView.text = (soldiers != nil ? String(soldiers!) : "?")

        let defensiveUnits : Int? = province.getDefensiveUnits()
        _defenseUnitsTextView.text = (defensiveUnits != nil ? String(defensiveUnits!) : "?")

        let offensiveUnits : Int? = province.getOffensiveUnits()
        _offenseUnitsTextView.text = (offensiveUnits != nil ? String(offensiveUnits!) : "?")

        let elites : Int? = province.getElites()
        _eliteUnitsTextView.text = (elites != nil ? String(elites!) : "?")

        let thieves : Int? = province.getThieves()
        _thievesTextView.text = (thieves != nil ? String(thieves!) : "?")

        let wizards : Int? = province.getWizards()
        _wizardsTextView.text = (wizards != nil ? String(wizards!) : "?")

        let horses : Int? = province.getHorses()
        _horsesTextView.text = (horses != nil ? String(horses!) : "?")

        let prisoners : Int? = province.getPrisoners()
        _prisonersTextView.text = (prisoners != nil ? String(prisoners!) : "?")

        let maxHorses : Int = (province.getMaxHorses() ?? 0)
        let horsesPercent : Float = (maxHorses > 0 ? Float(province.getHorses()) / Float(maxHorses) : 1.0)
        _setViewWidth(view: _horsesPercentView, width: horsesPercent * _getViewWidth(_horsesPercentContainerView))

        let maxPrisoners : Int = (province.getMaxPrisoners() ?? 0)
        let prisonersPercent : Float = (maxPrisoners > 0 ? Float(province.getPrisoners()) / Float(maxPrisoners) : 1.0)
        _setViewWidth(view: _prisonersPercentView, width: prisonersPercent * _getViewWidth(_prisonersPercentContainerView))

        _drawDraftTarget(Float(province.getDraftTarget() ?? 0) / 100.0)

        _wageRateTextView.text = "\(province.getMilitaryWageRate())%"
        _draftRateTextView.text = province.getDraftRate()?.getName() ?? ""

        let mana : Int? = province.getMana()
        _manaTextView.text = (mana != nil ? "\(mana!)%" : "?")

        let stealth : Int? = province.getStealth()
        _stealthTextView.text = (stealth != nil ? "\(stealth!)%" : "?")

        _raceIcon.image = uiTheme.getRaceIcon()

        _setViewHeight(view: _stealthResourceBar, height: _getViewHeight(_stealthResourceContainer) * (Float(province.getStealth() ?? 0) / 100.0))
        _setViewHeight(view: _manaResourceBar, height: _getViewHeight(_manaResourceContainer) * (Float(province.getMana() ?? 0) / 100.0))

        _deployedArmyAdapter.clearData()
        for deployedArmy : DeployedArmy in province.getDeployedArmies() {
            _deployedArmyAdapter.appendData(deployedArmy)
        }
        _deployedArmiesTableView.reloadData()

        _refreshControl.hide()
    }

    fileprivate func _drawDraftTarget(_ desiredPercent : Float) {
        let province : Province = _province

        let maxPopulation : Int = (province.getMaxPopulation() ?? 0)
        let militaryPopulation : Int = (province.getMilitaryPopulation() ?? 0) + (province.getThieves() ?? 0) + (province.getTotalThievesInProgress() ?? 0)
        let currentPercent : Float = (maxPopulation > 0 ? (Float(militaryPopulation) / Float(maxPopulation)) : 1.0)
        let desiredCivilianPercent : Float = 1.0 - desiredPercent

        let displayedMilitaryPercent : Float = (currentPercent > desiredPercent ? desiredPercent : currentPercent)
        let displayedDesiredMilitaryPercent : Float = (desiredPercent > currentPercent ? desiredPercent - currentPercent : 0.0)
        // let displayedCivilianPercent : Float = 1.0 - displayedDesiredMilitaryPercent - displayedMilitaryPercent

        _currentMilitaryTextView.text = "\(round(currentPercent * 100.0))%"
        _desiredMilitaryTextView.text = "\(floor(desiredPercent * 100.0))%"
        _desiredCivilianTextView.text = "\(round(desiredCivilianPercent * 100.0))%"

        _setViewWidth(view: _currentMilitaryPercentView, width: displayedMilitaryPercent * _getViewWidth(_militaryPercentContainerView))
        _setViewWidth(view: _desiredMilitaryPercentView, width: displayedDesiredMilitaryPercent * _getViewWidth(_militaryPercentContainerView))
    }

    fileprivate func _trainArmy(unitCount: Int, unitType: UnitType, isExpedited: Bool, callback: ((_ wasSuccess: Bool) -> Void)?) {
        let province : Province = _province

        let trainArmyData : TrainArmyData = TrainArmyData(race: province.getRace())

        trainArmyData.setWageRate(province.getMilitaryWageRate())
        trainArmyData.setDraftRate(province.getDraftRate())
        trainArmyData.setDraftTarget(province.getDraftTarget())

        switch(unitType) {
            case .soldiers:
                trainArmyData.setSoldiersCount(unitCount)
                break;
            case .defensive_UNITS:
                trainArmyData.setDefensiveUnitsCount(unitCount)
                break;
            case .offensive_UNITS:
                trainArmyData.setOffensiveUnitsCount(unitCount)
                break;
            case .elites:
                trainArmyData.setElitesCount(unitCount)
                break;
            case .thieves:
                trainArmyData.setThievesCount(unitCount)
                break;
        }

        let loadingDialog : LoadingDialog = LoadingDialog.newInstance()
        loadingDialog.show(self.view)
        _session.trainArmy(trainArmyData: trainArmyData, isExpedited: isExpedited, callback: {
            (trainArmyResponse : SessionResponse) -> Void in
                loadingDialog.hide()

                callback?(trainArmyResponse.getWasSuccess())
        })
    }

    internal func _downloadData() {
        let loadingDialog : LoadingDialog = LoadingDialog.newInstance()
        loadingDialog.show(self.view)

        _refreshControl.setTitleText("Downloading Kingdom...")
        self._session.downloadKingdom({
            (kingdomResponse : SessionResponse) -> Void in
                // NOTE: Must continue to download-throne to detect BadAccess.

                self._refreshControl.setTitleText("Downloading Throne...")
                self._session.downloadThrone({
                    (throneResponse : SessionResponse) -> Void in

                        if (!throneResponse.getWasSuccess()) {
                            loadingDialog.hide()
                            return
                        }

                        self._refreshControl.setTitleText("Downloading State Council...")
                        self._session.downloadStateCouncil({
                            (stateCouncilResponse : SessionResponse) -> Void in

                                if (!stateCouncilResponse.getWasSuccess()) {
                                    loadingDialog.hide()
                                    return
                                }

                                self._refreshControl.setTitleText("Downloading Building Council...")
                                self._session.downloadBuildingCouncil({
                                    (buildingCouncilResponse : SessionResponse) -> Void in

                                        if (!buildingCouncilResponse.getWasSuccess()) {
                                            loadingDialog.hide()
                                            return
                                        }

                                        self._refreshControl.setTitleText("Downloading Military Settings...")
                                        self._session.downloadMilitarySettings({
                                            (militarySettingsResponse : SessionResponse) -> Void in

                                                if (!militarySettingsResponse.getWasSuccess()) {
                                                    loadingDialog.hide()
                                                    return
                                                }

                                                self._refreshControl.setTitleText("Downloading Military Council...")
                                                self._session.downloadMilitaryCouncil({
                                                    (militaryCouncilResponse : SessionResponse) -> Void in

                                                        if (!militaryCouncilResponse.getWasSuccess()) {
                                                            loadingDialog.hide()
                                                            return
                                                        }

                                                        self._refreshControl.setTitleText("Loading...")
                                                        loadingDialog.hide()

                                                        let province : Province = self._province
                                                        self._desiredDraftPercentAsInt = province.getDraftTarget()

                                                        self._updateViews()
                                                })
                                        })
                                })
                        })
                })
        })
    }

    open override func viewDidLoad() {
        _session = Session.getInstance()

        _hideNavigationBar()

        if (_province == nil) {
            _province = _session.getProvince()
        }

        _adViewDelegate = WebViewDelegate()
        _adViewDelegate.setShouldOpenLinksInWebView(false)
        _adView.delegate = _adViewDelegate

        _scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 150.0, right: 0.0)

        _refreshControl = RefreshControl()
        _refreshControl.setOnRefresh({
            () -> RefreshControl.ShouldHide_t in
                self._downloadData()
                return false
        })
        _refreshControl.applyToView(_scrollView)

        _deployedArmyAdapter = TableViewAdapter<DeployedArmy>()
        _deployedArmyAdapter.setCellFactory(DeployedArmyCellFactory())
        _deployedArmiesTableView.delegate = _deployedArmyAdapter
        _deployedArmiesTableView.dataSource = _deployedArmyAdapter

        self.navigationController?.navigationBar.topItem?.title = "Logout"
    }

    open override func viewDidAppear(_ animated: Bool) {
        _session.addAdviewCallback(uniqueIdentifier: ThroneViewController.ADVIEW_CALLBACK_IDENTIFIER, adviewCallback: {
            (adScripts: String?) -> Void in
                if (adScripts != nil) {
                    let html : String = "<!DOCTYPE HTML><html><head><style>html, body { margin: 0px; padding: 0px; background-color: #FFFFFF; }</style></head><body><center>\(adScripts!)</center></body></html>";

                    let now : Double = Util.getTimestamp()
                    if (now - self._lastAdviewLoad > 5000) {
                        self._lastAdviewLoad = now
                        self._adView.load(html.data(using: String.Encoding.utf8)!, mimeType: "text/html", textEncodingName: "utf-8", baseURL: URL(string: "http://utopia-game.com/")!)
                    }
                }
        })

        _downloadData()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        _session.removeAdviewCallback(ThroneViewController.ADVIEW_CALLBACK_IDENTIFIER)
    }

    @IBAction
    open func onNavigationButtonClicked() { }

    @IBAction
    open func onSoldiersButtonClicked() {
        let province : Province = _province

        let dialog : TrainUnitsDialog = TrainUnitsDialog.newInstance()
        dialog.setDialogTitle("Release Soldiers")
        dialog.setCurrentQuantity(province.getSoldiers())
        dialog.setInProgressQuantity(0)
        dialog.setBaseTrainingCost(0)
        dialog.setOnSubmitCallback({
            (count: Int, isExpedited: Bool) -> Void in
                self._trainArmy(unitCount: count, unitType: .soldiers, isExpedited: isExpedited, callback: {
                    (wasSuccess: Bool) -> Void in
                        self._downloadData()
                })
        })
        self.present(dialog, animated: true, completion: nil)
    }

    @IBAction
    open func onDefenseUnitsButtonClicked() {
        let province : Province = _province

        let dialog : TrainUnitsDialog = TrainUnitsDialog.newInstance()
        dialog.setDialogTitle("Train/Release Defensive Units")
        dialog.setCurrentQuantity(province.getDefensiveUnits())
        dialog.setInProgressQuantity(province.getTotalDefensiveUnitsInProgress())
        dialog.setBaseTrainingCost(province.getDefenseUnitCost())
        dialog.setOnSubmitCallback({
            (count: Int, isExpedited: Bool) -> Void in
                self._trainArmy(unitCount: count, unitType: .defensive_UNITS, isExpedited: isExpedited, callback: {
                    (wasSuccess: Bool) -> Void in
                        self._downloadData()
                })
        })
        self.present(dialog, animated: true, completion: nil)
    }

    @IBAction
    open func onOffenseUnitsButtonClicked() {
        let province : Province = _province

        let dialog : TrainUnitsDialog = TrainUnitsDialog.newInstance()
        dialog.setDialogTitle("Train/Release Offensive Units")
        dialog.setCurrentQuantity(province.getOffensiveUnits())
        dialog.setInProgressQuantity(province.getTotalOffensiveUnitsInProgress())
        dialog.setBaseTrainingCost(province.getOffenseUnitCost())
        dialog.setOnSubmitCallback({
            (count: Int, isExpedited: Bool) -> Void in
                self._trainArmy(unitCount: count, unitType: .offensive_UNITS, isExpedited: isExpedited, callback: {
                    (wasSuccess: Bool) -> Void in
                        self._downloadData()
                })
        })
        self.present(dialog, animated: true, completion: nil)
    }

    @IBAction
    open func onElitesButtonClicked() {
        let province : Province = _province

        let dialog : TrainUnitsDialog = TrainUnitsDialog.newInstance()
        dialog.setDialogTitle("Train/Release Elites")
        dialog.setCurrentQuantity(province.getElites())
        dialog.setInProgressQuantity(province.getTotalElitesInProgress())
        dialog.setBaseTrainingCost(province.getEliteCost())
        dialog.setOnSubmitCallback({
            (count: Int, isExpedited: Bool) -> Void in
                self._trainArmy(unitCount: count, unitType: .elites, isExpedited: isExpedited, callback: {
                    (wasSuccess: Bool) -> Void in
                        self._downloadData()
                })
        })
        self.present(dialog, animated: true, completion: nil)
    }

    @IBAction
    open func onThievesButtonClicked() {
        let province : Province = _province

        let dialog : TrainUnitsDialog = TrainUnitsDialog.newInstance()
        dialog.setDialogTitle("Train/Release Thieves")
        dialog.setCurrentQuantity(province.getThieves())
        dialog.setInProgressQuantity(province.getTotalThievesInProgress())
        dialog.setBaseTrainingCost(province.getThiefCost())
        dialog.setOnSubmitCallback({
            (count: Int, isExpedited: Bool) -> Void in
                self._trainArmy(unitCount: count, unitType: .thieves, isExpedited: isExpedited, callback: {
                    (wasSuccess: Bool) -> Void in
                        self._downloadData()
                })
        })
        self.present(dialog, animated: true, completion: nil)
    }

    @IBAction
    open func onWagesButtonClicked() {
        let province : Province = _province

        let dialog : MilitaryWagesDialog = MilitaryWagesDialog.newInstance()
        dialog.setCurrentWages(province.getMilitaryWageRate())
        dialog.setOnSubmitCallback({
            (wagePercentAsInt: Int) -> Void in
                let trainArmyData : TrainArmyData = TrainArmyData(race: province.getRace())
                trainArmyData.setWageRate(wagePercentAsInt)
                trainArmyData.setDraftRate(province.getDraftRate())
                trainArmyData.setDraftTarget(province.getDraftTarget())

                self._session.trainArmy(trainArmyData: trainArmyData, isExpedited: false, callback: {
                    (trainArmyResponse : SessionResponse) -> Void in
                        self._downloadData()
                })
        })
        self.present(dialog, animated: true, completion: nil)
    }

    @IBAction
    open func onDraftRateButtonClicked() {
        let province : Province = _province

        let dialog : DraftRateDialog = DraftRateDialog.newInstance()
        dialog.setAvailableDraftRates(_session.getDraftRates())
        dialog.setCurrentDraftRate(province.getDraftRate())
        dialog.setOnSubmitCallback({
            (draftRate: DraftRate) -> Void in
                let trainArmyData : TrainArmyData = TrainArmyData(race: province.getRace())
                trainArmyData.setWageRate(province.getMilitaryWageRate())
                trainArmyData.setDraftRate(draftRate)
                trainArmyData.setDraftTarget(province.getDraftTarget())

                self._session.trainArmy(trainArmyData: trainArmyData, isExpedited: false, callback: {
                    (trainArmyResponse : SessionResponse) -> Void in
                        self._downloadData()
                })
        })
        self.present(dialog, animated: true, completion: nil)
    }

    @IBAction
    open func onDraftTargetDrag(_ view: UIView, event: UIEvent) {
        let touchList : Set<UITouch>! = event.allTouches
        if (touchList == nil || touchList!.count == 0) { return }

        let viewWidth : Float = Float(_militaryPercentContainerView.bounds.width)
        let xPosition : Float = Float(touchList.first!.location(in: view).x)

        if (xPosition < 0) { return }
        if (xPosition > viewWidth) { return }

        let desiredPercent : Float = xPosition / viewWidth

        _desiredDraftPercentAsInt = Int(desiredPercent * 100)

        _drawDraftTarget(desiredPercent)
    }

    @IBAction
    open func onDraftTargetDragComplete() {
        let province : Province = _province

        if (_desiredDraftPercentAsInt == nil) { return }
        if (_desiredDraftPercentAsInt == province.getDraftTarget()) { return }

        let trainArmyData : TrainArmyData = TrainArmyData(race: province.getRace())
        trainArmyData.setWageRate(province.getMilitaryWageRate())
        trainArmyData.setDraftRate(province.getDraftRate())
        trainArmyData.setDraftTarget(_desiredDraftPercentAsInt!)

        self._session.trainArmy(trainArmyData: trainArmyData, isExpedited: false, callback: {
            (trainArmyResponse : SessionResponse) -> Void in
                self._downloadData()
        })
    }
}
