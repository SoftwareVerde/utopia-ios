
import Foundation
import UIKit

open class ProvinceNewsController : UIViewController {
    open static let STORYBOARD_ID : String = "ProvinceNewsController"
    fileprivate static let ADVIEW_CALLBACK_IDENTIFIER : String = "ProvinceNewsController.AdviewCallbackIdentifier"
    fileprivate static let NEWS_DOWNLOAD_IDENTIFIER : String = "ProvinceNewsController.NewsDownloadIdentifier"

    class ProvinceNewsCellFactory : TableViewCellFactory<ProvinceNews> {
        override func createCell(_ provinceNews: ProvinceNews) -> ProvinceNewsCell {
            let provinceNewsCell : ProvinceNewsCell = ProvinceNewsCell.newInstance()
            provinceNewsCell.setDate(provinceNews.getDate())
            provinceNewsCell.setNews(provinceNews.getNews())
            return provinceNewsCell
        }

        override func getCellHeight(data: ProvinceNews, cell: TableViewCell?) -> Float {
            return 75.0
        }
    }

    @IBOutlet
    internal weak var _provinceNewsTableView : UITableView!

    @IBOutlet
    internal weak var _newsDateTextView : UILabel!

    @IBOutlet
    internal weak var _adView : UIWebView!

    fileprivate var _session : Session!
    fileprivate var _newsAdapter : TableViewAdapter<ProvinceNews>!
    fileprivate var _refreshControl : RefreshControl!

    fileprivate var _adViewDelegate : WebViewDelegate!
    fileprivate var _lastAdviewLoad : Double = 0

    fileprivate var _month : Int! = nil
    fileprivate var _year : Int! = nil

    fileprivate func _downloadData() {
        let loadingDialog : LoadingDialog = LoadingDialog.newInstance()
        loadingDialog.show(self.view)
        _refreshControl.setTitleText("Downloading News...")

        _session.downloadProvinceNews({
            (sessionResponse: SessionResponse) -> Void in
                self._updateView()

                loadingDialog.hide()
                self._refreshControl.hide()
        })
    }

    fileprivate func _updateView() {
        var year : String = "00"
        if (_year != nil) {
            year = String(_year)
            if (year.characters.count == 1) {
                year = "0\(year)"
            }
        }
        
        var month : String! = UtopiaUtil.getUtopianMonthFromIndex(_month);
        if (month == nil || month.characters.count == 0) {
            month = "??"
        }

        _newsDateTextView.text = "\(month!) \(year)"

        _newsAdapter.clearData()
        for news : ProvinceNews in _session.getNews().reversed() {
            _newsAdapter.appendData(news)
        }
        _provinceNewsTableView.reloadData()
    }

    @IBAction
    open func onPreviousNewsButtonClicked() {
        let loadingDialog : LoadingDialog = LoadingDialog.newInstance()
        loadingDialog.show(self.view)
        
        _session.downloadProvinceNews(month: _month-1, year: _year, callback: {
            (sessionResponse: SessionResponse) -> Void in
                self._updateView()
                loadingDialog.hide()
        })
    }

    @IBAction
    open func onNextNewsButtonClicked() {
        let loadingDialog : LoadingDialog = LoadingDialog.newInstance()
        loadingDialog.show(self.view)
        
        _session.downloadProvinceNews(month: _month+1, year: _year, callback: {
            (sessionResponse: SessionResponse) -> Void in
                self._updateView()
                loadingDialog.hide()
        })
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        _session = Session.getInstance()

        _adViewDelegate = WebViewDelegate()
        _adViewDelegate.setShouldOpenLinksInWebView(false)
        _adView.delegate = _adViewDelegate

        _newsAdapter = TableViewAdapter()
        _newsAdapter.setCellFactory(ProvinceNewsCellFactory())

        _refreshControl = RefreshControl()
        _refreshControl.setOnRefresh({
            () -> RefreshControl.ShouldHide_t in
                self._downloadData()
                return false
        })
        _refreshControl.applyToView(_provinceNewsTableView)

        _provinceNewsTableView.delegate = _newsAdapter
        _provinceNewsTableView.dataSource = _newsAdapter
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        _session.addAdviewCallback(uniqueIdentifier: ProvinceNewsController.ADVIEW_CALLBACK_IDENTIFIER, adviewCallback: {
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

        _session.addNewsCallback(uniqueIdentifier: ProvinceNewsController.NEWS_DOWNLOAD_IDENTIFIER, callback: {
            (month: Int, year: Int) -> Void in
                self._month = month
                self._year = year
                self._updateView()
        })

        _downloadData()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        _session.removeNewsCallback(ProvinceNewsController.NEWS_DOWNLOAD_IDENTIFIER)

        super.viewWillDisappear(animated)
    }

    open override func viewDidDisappear(_ animated: Bool) {
        _session.removeAdviewCallback(ProvinceNewsController.ADVIEW_CALLBACK_IDENTIFIER)
    }
}
