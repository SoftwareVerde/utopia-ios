
import Foundation
import UIKit

open class KingdomChatController : UIViewController {
    open static let STORYBOARD_ID : String = "KingdomChatController"
    static let ON_MESSAGE_RECEIVED_CALLBACK_IDENTIFIER : String = "KingdomChatController.ON_MESSAGE_RECEIVED_CALLBACK"

    class ChatroomMessageCellFactory : TableViewCellFactory<ChatroomMessage> {
        fileprivate let _rowHeight : Float = 60

        override func getCellHeight(data: ChatroomMessage, cell: TableViewCell?) -> Float {
            let chatroomMessageCell : ChatroomMessageCell? = cell as? ChatroomMessageCell

            if (chatroomMessageCell != nil) {

                return Float(chatroomMessageCell!._messageContent.text!.boundingRect(with: CGSize(width: cell!.bounds.width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName: chatroomMessageCell!._messageContent.font], context: nil).height) + _rowHeight - 21.0
            }
            else {
                return _rowHeight
            }
        }

        override func createCell(_ chatroomMessage: ChatroomMessage) -> ChatroomMessageCell {
            let cell : ChatroomMessageCell = ChatroomMessageCell.newInstance()

            cell.setProvinceName(chatroomMessage.getDisplayName())
            cell.setMessage(chatroomMessage.getMessage())
            cell.setTimestamp(chatroomMessage.getTimestamp())

            return cell
        }
    }

    class ProvinceTagCellFactory : TableViewCellFactory<String> {
        fileprivate let _rowHeight : Float = 30

        override func getCellHeight(data: String, cell: TableViewCell?) -> Float {
            return _rowHeight
        }

        override func createCell(_ provinceTag: String) -> ProvinceTagCell {
            let cell : ProvinceTagCell = ProvinceTagCell.newInstance()
            cell.setProvinceTag(provinceTag)
            return cell
        }
    }

    class ChatroomTagCellFactory : TableViewCellFactory<String> {
        fileprivate let _rowHeight : Float = 21

        override func getCellHeight(data: String, cell: TableViewCell?) -> Float {
            return _rowHeight
        }

        override func createCell(_ provinceName: String) -> TableViewCell {
            let cell : TableViewCell = TableViewCell.newInstance()
            cell._textView.text = provinceName
            return cell
        }
    }

    @IBOutlet
    internal weak var _messageEditText : UITextField!

    @IBOutlet
    internal weak var _messagesTableView : UITableView!

    @IBOutlet
    internal weak var _provinceTagTableView : UITableView!

    fileprivate var _session : Session!
    fileprivate var _provinceTagAdapter : TableViewAdapter<String>!
    fileprivate var _messagesAdapater : TableViewAdapter<ChatroomMessage>!
    fileprivate var _refreshControl : RefreshControl!

    fileprivate func _updateView() {
        _messagesAdapater.clearData()
        for message : ChatroomMessage in _session.getChatroomMessages().reversed() {
            _messagesAdapater.appendData(message)
        }
        _messagesTableView.reloadData()
    }

    @IBAction
    open func onSubmitButtonClicked() {
        let messageContent : String = _messageEditText.text ?? ""
        if (NSString(string: messageContent).length() == 0) { return }

        _session.sendChatroomMessage(messageContent, callback: {
            (sendMessageResponse: SessionResponse) -> Void in
                self._messageEditText.text = ""
                self.onMessageContentChanged()

                self._session.downloadChatMessages({
                    (response: SessionResponse) -> Void in
                        self._updateView()
                })
        })
    }

    @IBAction
    open func onMessageContentChanged() {
        let provinces : Array<Province> = _session.getKingdom().getProvinces()
        let inputText : String = _messageEditText.text ?? ""

        _provinceTagAdapter.clearData()
        if (inputText.contains("@")) {
            let tagSuggestions : Array<String> = UtopiaTagUtil.calculateProvinceTagSuggestions(inputText, provinces: provinces)
            for provinceTag : String in tagSuggestions {
                _provinceTagAdapter.appendData(provinceTag)
            }
        }
        _provinceTagTableView.reloadData()

        _provinceTagTableView.isHidden = (_provinceTagAdapter.getCount() == 0)
    }

    open override func viewDidLoad() {
        _session = Session.getInstance()

        _messagesAdapater = TableViewAdapter<ChatroomMessage>()
        _messagesAdapater.setCellFactory(ChatroomMessageCellFactory())

        _provinceTagAdapter = TableViewAdapter<String>()
        _provinceTagAdapter.setCellFactory(ProvinceTagCellFactory())

         _provinceTagAdapter.setOnItemClickedCallback({
             (provinceTag: String) -> Void in
                let currentText : String = (self._messageEditText.text ?? "")
                let newText : String = UtopiaTagUtil.applyProvinceTag(currentText, provinceName: provinceTag)
                self._messageEditText.text = newText
         })

        _refreshControl = RefreshControl()
        _refreshControl.setOnRefresh({
            () -> RefreshControl.ShouldHide_t in
                self._refreshControl.setTitleText("Downloading Chat Messages...")
                self._session.downloadChatMessages({
                    (response: SessionResponse) -> Void in
                        self._refreshControl.hide()
                })
                return false
        })
        _refreshControl.applyToView(_messagesTableView)

        _messagesTableView.delegate = _messagesAdapater
        _messagesTableView.dataSource = _messagesAdapater

        _provinceTagTableView.delegate = _provinceTagAdapter
        _provinceTagTableView.dataSource = _provinceTagAdapter

        _session.startDownloadMessagesThread()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        _session.addMessagesCallback(KingdomChatController.ON_MESSAGE_RECEIVED_CALLBACK_IDENTIFIER, callback: {
            () -> Void in
                self._updateView()
        })
    }

    open override func viewDidDisappear(_ animated: Bool) {
        _session.removeMessagesCallback(KingdomChatController.ON_MESSAGE_RECEIVED_CALLBACK_IDENTIFIER)

        super.viewDidDisappear(animated)
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        _updateView()
    }
}
