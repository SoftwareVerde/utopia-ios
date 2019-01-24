
import Foundation
import UIKit

open class DefensiveSpellsController : UIViewController {
    open static let STORYBOARD_ID : String = "DefensiveSpellsController"
    open static let ADVIEW_CALLBACK_IDENTIFIER : String = "DEFENSIVE_SPELLS_CALLBACK_IDENTIFIER"

    open class func newInstance() -> DefensiveSpellsController {
        return (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: STORYBOARD_ID) as! DefensiveSpellsController)
    }

    @IBOutlet
    internal weak var _runesTextView : UILabel!

    @IBOutlet
    internal weak var _wizardsPerAcreTextView : UILabel!

    @IBOutlet
    internal weak var _manaTextView : UILabel!

    @IBOutlet
    internal weak var _guildsTextView : UILabel!

    @IBOutlet
    internal weak var _castResultTextView : UILabel!

    @IBOutlet
    internal weak var _spellsTableView : UITableView!

    @IBOutlet
    internal weak var _adView : UIWebView!

    @IBOutlet
    internal weak var _navigationContainer : UIView!
    
    @IBOutlet
    internal weak var _navigationButton : UIButton!

    @IBOutlet
    internal weak var _navigationViewHeightConstraint : NSLayoutConstraint!

    @IBOutlet
    internal weak var _titleTextView : UILabel!

    internal func _hideNavigationBar() {
        self._navigationContainer.alpha = 0
        _navigationViewHeightConstraint.constant = 0
    }
    
    internal func _showNavigationBar(_ buttonText: String) {
        _navigationViewHeightConstraint.constant = 50
        _navigationButton.setTitle(buttonText, for: UIControlState())
        self._navigationContainer.alpha = 1
    }

    internal var _session : Session!
    internal var _spellsAdapter : TableViewAdapter<CastableSpell>!
    fileprivate var _adViewDelegate : WebViewDelegate!
    fileprivate var _lastAdviewLoad : Double = 0
    fileprivate var _refreshControl : RefreshControl!

    internal func _updateView() {
        let province : Province = _session.getProvince()

        _manaTextView.text = "\(province.getMana())%"
        _guildsTextView.text = "\(province.getGuilds().getPercent() * 100.0)%"
        _runesTextView.text = String(province.getRunes())

        let wizardsPerAcre : Float = Float(province.getWizards()) / Float(province.getAcres())
        _wizardsPerAcreTextView.text = Util.formatPercent(wizardsPerAcre, decimals: 2)

        _spellsAdapter.clearData()
        for spell : Spell in _session.getAvailableSpells(SpellType.defensive) {
            let spellDuration : Int = province.getSpellDuration(spell.getName())
            _spellsAdapter.appendData(CastableSpell(spell: spell, spellDuration: spellDuration))
        }
        _spellsTableView.reloadData()

        _refreshControl.hide()
    }

    internal func _downloadData() {
        let loadingDialog : LoadingDialog = LoadingDialog.newInstance()
        loadingDialog.show(self.view)

        _refreshControl.setTitleText("Downloading Available Spells...")
        _session.downloadAvailableSpells({
            (availableSpellsResponse : SessionResponse) -> Void in
                self._refreshControl.setTitleText("Downloading Active Spells...")
                self._session.downloadActiveSpells({
                    (activeSpellsResponse : SessionResponse) -> Void in
                        self._refreshControl.setTitleText("Downloading Throne...")
                        self._session.downloadThrone({
                            (throneResponse : SessionResponse) -> Void in
                                loadingDialog.hide()
                                self._refreshControl.setTitleText("Loading...")

                                self._updateView()
                        })

                })
        })
    }

    internal func _castSpell(_ spell: Spell) {
        let loadingDialog : LoadingDialog = LoadingDialog.newInstance()
        loadingDialog.show(self.view)

        _session.castSpell(spell: spell, callback: {
            (castSpellResponse : CastSpellResponse) -> Void in
                loadingDialog.hide()

                let spellResult : SpellResult? = castSpellResponse.getSpellResult()
                let resultText : String = (spellResult?.getResultText() ?? "")
                self._castResultTextView.text = resultText
                self._downloadData()
        })
    }

    @IBAction
    open func onNavigationButtonClicked() { }

    open override func viewDidLoad() {
        _session = Session.getInstance()

        _hideNavigationBar()

        _adViewDelegate = WebViewDelegate()
        _adViewDelegate.setShouldOpenLinksInWebView(false)
        _adView.delegate = _adViewDelegate

        _spellsAdapter = TableViewAdapter<CastableSpell>()
        _spellsAdapter.setCellFactory(SpellCellFactory(province: _session.getProvince()))

        _spellsAdapter.setSortFunction({
            (left: CastableSpell, right: CastableSpell) -> Bool in
                return (left.getSpell().getRuneCost() < right.getSpell().getRuneCost())
        })

        _spellsAdapter.setOnItemClickedCallback({
            (castableSpell: CastableSpell) -> Void in
                let province : Province = self._session.getProvince()
                let spell : Spell = castableSpell.getSpell()
                let dialog : CastSpellDialog = CastSpellDialog.newInstance()
                dialog.setSpellName(spell.getName())
                dialog.setSpellCost(spell.getRuneCost())
                dialog.setCurrentRuneCount(province.getRunes())

                dialog.setOnSubmitCallback({
                    () -> Void in
                        self._castSpell(castableSpell.getSpell())
                })

                self.present(dialog, animated: true, completion: nil)
        })

        _spellsTableView.delegate = _spellsAdapter
        _spellsTableView.dataSource = _spellsAdapter

        _refreshControl = RefreshControl()
        _refreshControl.applyToView(_spellsTableView)
        _refreshControl.setOnRefresh({
            () -> RefreshControl.ShouldHide_t in
                self._downloadData()
                return false
        })
    }

    open override func viewDidAppear(_ animated: Bool) {
        _session.addAdviewCallback(uniqueIdentifier: DefensiveSpellsController.ADVIEW_CALLBACK_IDENTIFIER, adviewCallback: {
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
        _session.removeAdviewCallback(DefensiveSpellsController.ADVIEW_CALLBACK_IDENTIFIER)
    }
}
