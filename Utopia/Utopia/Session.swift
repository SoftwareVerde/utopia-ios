
import Foundation

open class SessionResponse : NSObject {
    fileprivate let _wasSuccess : Bool
    fileprivate let _errorMessage : String?

    public init(wasSuccess : Bool, errorMessage : String?) {
        _wasSuccess = wasSuccess
        _errorMessage = errorMessage
    }

    open func getWasSuccess() -> Bool { return _wasSuccess }
    open func getErrorMessage() -> String? { return _errorMessage }
}

open class CastSpellResponse : SessionResponse {
    fileprivate let _spellResult : SpellResult?

    public init(wasSuccess: Bool, errorMessage: String?, spellResult: SpellResult?) {
        _spellResult = spellResult

        super.init(wasSuccess: wasSuccess, errorMessage: errorMessage)
    }

    open func getSpellResult() -> SpellResult? {
        return _spellResult
    }
}

public typealias AdviewCallback = (_ html: String?) -> Void
open class UtopiaAdviewCallback : NSObject, ComSoftwareverdeUtopiaUtopiaUtil_AdViewCallback {
    fileprivate let _callback : ((String?) -> Void)?
    public init(_ callback: ((String?) -> Void)?) {
        _callback = callback
    }

    open func run(with html: String!) {
        DispatchQueue.main.async(execute: {
            self._callback?(html)
        })
    }
}

public typealias SessionCallback = (_ response: SessionResponse) -> Void
public typealias CastSpellCallback = (_ response: CastSpellResponse) -> Void
public typealias BadAccessCallback = (_ badAccessType: BadAccessType) -> Void
public typealias NewsCallback = (_ month: Int, _ year: Int) -> Void

open class Runnable : NSObject, JavaLangRunnable {
    fileprivate let _callback : (() -> Void)?
    public init(_ callback: (() -> Void)?) {
        _callback = callback
    }

    open func run() {
        DispatchQueue.main.async(execute: {
            self._callback?()
        })
    }
}

public typealias UtopiaSessionResponse = ComSoftwareverdeUtopiaSession_SessionResponse
public typealias UtopiaKingdomIdentifier = ComSoftwareverdeUtopiaKingdom_Identifier

open class UtopiaSessionCallback : NSObject, ComSoftwareverdeUtopiaSession_Callback {
    fileprivate let _callback : ((UtopiaSessionResponse) -> Void)?
    public init(_ callback: ((UtopiaSessionResponse) -> Void)?) {
        _callback = callback
    }

    public init(sessionCallback: SessionCallback?) {
        _callback = {
            (utopiaResponse: UtopiaSessionResponse) -> Void in
                sessionCallback?(SessionResponse(wasSuccess: JavaUtil.toSwiftBool(utopiaResponse.getWasSuccess()), errorMessage: utopiaResponse.getErrorMessage()))
        }
    }

    open func run(with sessionResponse : UtopiaSessionResponse) {
        DispatchQueue.main.async(execute: {
            self._callback?(sessionResponse)
        })
    }
}

open class UtopiaNewsCallback : NSObject, ComSoftwareverdeUtopiaSession_DownloadNewsCallback {
    fileprivate let _newsCallback : NewsCallback?

    public init(_ callback: NewsCallback?) {
        _newsCallback = callback
    }

    open func run(with newsMonth: JavaLangInteger, with newsYear: JavaLangInteger) {
        DispatchQueue.main.async(execute: {
            self._newsCallback?(JavaUtil.toSwiftInt(newsMonth), JavaUtil.toSwiftInt(newsYear))
        })
    }
}

open class UtopiaDownloadKingdomCallback : NSObject, ComSoftwareverdeUtopiaSession_DownloadKingdomCallback {
    fileprivate let _callback : ((UtopiaSessionResponse, UtopiaKingdomIdentifier) -> Void)?
    public init(_ callback: ((UtopiaSessionResponse, UtopiaKingdomIdentifier) -> Void)?) {
        _callback = callback
    }
    
    open func run(with sessionResponse : UtopiaSessionResponse, with kingdomIdentifier : UtopiaKingdomIdentifier) {
        DispatchQueue.main.async(execute: {
            self._callback?(sessionResponse, kingdomIdentifier)
        })
    }
}

open class DownloadKingdomCallback : NSObject, ComSoftwareverdeUtopiaSession_DownloadKingdomCallback {
    fileprivate let _callback : ((UtopiaSessionResponse, KingdomIdentifier) -> Void)?
    public init(_ callback: ((UtopiaSessionResponse, KingdomIdentifier) -> Void)?) {
        _callback = callback
    }

    open func run(with response: ComSoftwareverdeUtopiaSession_SessionResponse, with utopiaKingdomIdentifier: ComSoftwareverdeUtopiaKingdom_Identifier) {
        DispatchQueue.main.async(execute: {
            self._callback?(response, KingdomIdentifier.fromUtopiaKingdomIdentifier(utopiaKingdomIdentifier))
        })
    }
}

open class UtopiaKingdomCallback : NSObject, ComSoftwareverdeUtopiaSession_KingdomCallback {
    fileprivate let _callback : ((KingdomIdentifier) -> Void)?
    public init(_ callback: ((KingdomIdentifier) -> Void)?) {
        _callback = callback
    }

    open func run(with utopiaKingdomIdentifier: ComSoftwareverdeUtopiaKingdom_Identifier) {
        DispatchQueue.main.async(execute: {
            self._callback?(KingdomIdentifier.fromUtopiaKingdomIdentifier(utopiaKingdomIdentifier))
        })
    }
}

open class UtopiaBadAccessCallback : NSObject, ComSoftwareverdeUtopiaSession_BadAccessCallback {
    fileprivate let _callback : BadAccessCallback?
    public init(_ callback: BadAccessCallback?) {
        _callback = callback
    }

    open func run(with utopiaBadAccessType : ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType) {
        DispatchQueue.main.async(execute: {
            self._callback?(BadAccessType.fromUtopiaBadAccessType(utopiaBadAccessType))
        })
    }
}

public typealias UtopiaCastSpellResponse = ComSoftwareverdeUtopiaSession_CastSpellResponse

open class UtopiaCastSpellCallback : NSObject, ComSoftwareverdeUtopiaSession_CastSpellCallback {
    fileprivate let _callback : ((UtopiaCastSpellResponse) -> Void)?
    public init(_ callback: ((UtopiaCastSpellResponse) -> Void)?) {
        _callback = callback
    }

    open func run(with response: UtopiaCastSpellResponse!) {
        DispatchQueue.main.async(execute: {
            self._callback?(response)
        })
    }
}

public func _runOnUiThread(_ runnable : @escaping () -> Void) {
    DispatchQueue.main.async(execute: {
        runnable()
    })
}

open class Session {
    fileprivate static var _instance : Session!
    open static func getInstance() -> Session {
        if (_instance == nil) {
            _instance = Session()
        }

        return _instance
    }

    fileprivate let _session : ComSoftwareverdeUtopiaSession!
    fileprivate let _apnsRegistrar : AutomaticApnsTokenRegistrar

    fileprivate init() {
        let htmlParser : ComSoftwareverdeUtopiaParserJsoupHtmlParser = ComSoftwareverdeUtopiaParserJsoupHtmlParser()
        let utopiaUtilDependencies : ComSoftwareverdeUtopiaUtopiaUtil_Dependencies = ComSoftwareverdeUtopiaUtopiaUtil_Dependencies()
        utopiaUtilDependencies.setBuildVersionWith(BuildVersion());
        utopiaUtilDependencies.setHtmlParserWith(htmlParser);
        utopiaUtilDependencies.setUtopiaParserWith(ComSoftwareverdeUtopiaParserUtopiaParser(comSoftwareverdeUtopiaParserHtmlParser: htmlParser))
        ComSoftwareverdeUtopiaUtopiaUtil.setDependenciesWith(utopiaUtilDependencies)

        let databaseName : String = ComSoftwareverdeUtopiaDatabaseUtopiaDatabaseV1_DATABASE_NAME
        let databaseVersion : Int = Int(ComSoftwareverdeUtopiaDatabaseUtopiaDatabaseV1_DATABASE_VERSION)

        let iosDatabase : IosDatabase = IosDatabase(
            databaseName: databaseName,
            requiredVersion: databaseVersion
        )

        let utopiaDatabase : ComSoftwareverdeUtopiaDatabaseUtopiaDatabaseV1 = ComSoftwareverdeUtopiaDatabaseUtopiaDatabaseV1(comSoftwareverdeUtopiaDatabaseDatabase: iosDatabase)

        let sessionDependencies : ComSoftwareverdeUtopiaSession_Dependencies = ComSoftwareverdeUtopiaSession_Dependencies()
        sessionDependencies.setKeyValueStoreWith(IosKeyValueStore())
        sessionDependencies.setUtopiaDatabaseWith(utopiaDatabase)
        sessionDependencies.setNotificationMakerWith(NotificationMaker())
        sessionDependencies.setVibratorWith(Vibrator())
        sessionDependencies.setIntelSyncFactoryWith(IntelSyncFactory())

        ComSoftwareverdeUtopiaSession.setDependenciesWith(sessionDependencies)

        _session = ComSoftwareverdeUtopiaSession.getInstance()

        _apnsRegistrar = AutomaticApnsTokenRegistrar.getInstance()
    }

    open func login(username : String, password : String, callback : SessionCallback?) {
        _session.login(with: username, with: password, with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func downloadKingdom(_ callback : SessionCallback?) {
        _session.downloadKingdom(with: UtopiaDownloadKingdomCallback({
            (kingdomResponse : UtopiaSessionResponse, kingdomIdentifier : UtopiaKingdomIdentifier) -> Void in
                (callback?(SessionResponse(wasSuccess: JavaUtil.toSwiftBool(kingdomResponse.getWasSuccess()), errorMessage: kingdomResponse.getErrorMessage())))!
        }))
    }

    open func downloadThrone(_ callback : SessionCallback?) {
        _session.downloadThrone(with: UtopiaSessionCallback({
                (throneResponse : UtopiaSessionResponse) -> Void in
                    let wasSuccess : Bool = JavaUtil.toSwiftBool(throneResponse.getWasSuccess())

                    if (wasSuccess) {
                        let province : Province = Province.fromUtopiaProvince(self._session.getProvince())
                        self._apnsRegistrar.setProvince(provinceName: province.getName(), kingdomIdentifier: province.getKingdomIdentifier())
                    }

                    callback?(SessionResponse(wasSuccess: wasSuccess, errorMessage: throneResponse.getErrorMessage()))
        }))
    }

    open func downloadStateCouncil(_ callback : SessionCallback?) {
        _session.downloadStateCouncil(with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func downloadBuildingCouncil(_ callback : SessionCallback?) {
        _session.downloadBuildingsCouncil(with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func downloadMilitarySettings(_ callback : SessionCallback?) {
        _session.downloadMilitarySettings(with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func downloadMilitaryCouncil(_ callback: SessionCallback?) {
        _session.downloadMilitaryCouncil(with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func hasSavedCredentials() -> Bool {
        return _session.hasSavedCredentials()
    }

    open func resume(_ callback : Runnable?) {
        _session.resume(with: callback != nil ? callback : Runnable(nil))
    }

    open func autoLogin(_ callback : SessionCallback?) {
        _session.autoLogin(with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func getProvince() -> Province {
        return Province.fromUtopiaProvince(_session.getProvince())
    }

    open func trainArmy(trainArmyData: TrainArmyData, isExpedited: Bool, callback : SessionCallback?) {
        _session.trainArmy(
            with: trainArmyData.toUtopiaTrainArmyBundle(),
            with: JavaLangBoolean(boolean: isExpedited),
            with: UtopiaSessionCallback({
                (trainArmyResponse : UtopiaSessionResponse) -> Void in
                    callback?(SessionResponse(wasSuccess: JavaUtil.toSwiftBool(trainArmyResponse.getWasSuccess()), errorMessage: trainArmyResponse.getErrorMessage()))
            })
        )
    }

    open func getDraftRates() -> Array<DraftRate> {
        var draftRates : Array<DraftRate> = Array<DraftRate>()

        let javaDraftRates : JavaUtilList = _session.getDraftRates()
        for i : Int in 0 ..< Int(javaDraftRates.size()) {
            let javaDraftRate : ComSoftwareverdeUtopiaDraftRate = javaDraftRates.getWith(JavaUtil.toJavaIntegerPrimitive(i))! as! ComSoftwareverdeUtopiaDraftRate
            draftRates.append(DraftRate.fromUtopiaDraftRate(javaDraftRate))
        }

        return draftRates
    }

    open func getAvailableSpells(_ spellType : SpellType) -> Array<Spell> {
        var availableSpells : Array<Spell> = Array<Spell>()

        let javaSpellList : JavaUtilList = _session.getAvailableSpells(with: spellType.toUtopiaSpellType())
        for i : Int in 0 ..< Int(javaSpellList.size()) {
            let javaSpell : ComSoftwareverdeUtopiaSpell = javaSpellList.getWith(JavaUtil.toJavaIntegerPrimitive(i))! as! ComSoftwareverdeUtopiaSpell
            availableSpells.append(Spell.fromUtopiaSpell(javaSpell))
        }

        return availableSpells
    }

    open func downloadAvailableSpells(_ callback: SessionCallback?) {
        _session.downloadAvailableSpells(with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func downloadActiveSpells(_ callback: SessionCallback?) {
        _session.downloadActiveSpells(with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func downloadActiveSpells(province: Province, callback: SessionCallback?) {
        _session.downloadActiveSpells(with: province.toUtopiaProvince(), with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func castSpell(spell: Spell, callback: CastSpellCallback?) {
        _session.castSpell(with: spell.toUtopiaSpell(), with: UtopiaCastSpellCallback({
            (castSpellResponse: UtopiaCastSpellResponse) -> Void in
            let hasSpellResult : Bool = JavaUtil.toSwiftBool(castSpellResponse.hasSpellResultBundle())
            let spellResult : SpellResult? = (hasSpellResult ? SpellResult.fromUtopiaSpellResultBundle(castSpellResponse.getSpellResultBundle()) : nil)
            callback?(CastSpellResponse(wasSuccess: JavaUtil.toSwiftBool(castSpellResponse.getWasSuccess()), errorMessage: castSpellResponse.getErrorMessage(), spellResult: spellResult))
        }))
    }

    open func castSpell(spell: Spell, province: Province, callback: CastSpellCallback?) {
        _session.castSpell(with: spell.toUtopiaSpell(), with: province.toUtopiaProvince(), with: UtopiaCastSpellCallback({
            (castSpellResponse: UtopiaCastSpellResponse) -> Void in
                let hasSpellResult : Bool = JavaUtil.toSwiftBool(castSpellResponse.hasSpellResultBundle())
                let spellResult : SpellResult? = (hasSpellResult ? SpellResult.fromUtopiaSpellResultBundle(castSpellResponse.getSpellResultBundle()) : nil)
                callback?(CastSpellResponse(wasSuccess: JavaUtil.toSwiftBool(castSpellResponse.getWasSuccess()), errorMessage: castSpellResponse.getErrorMessage(), spellResult: spellResult))
        }))
    }

    open func getChatroomMessages() -> Array<ChatroomMessage> {
        var chatMessages : Array<ChatroomMessage> = Array<ChatroomMessage>()

        let javaMessageList : JavaUtilList = _session.getChatroom().getMessages()
        for i : Int in 0 ..< Int(javaMessageList.size()) {
            let javaMessage : ComSoftwareverdeUtopiaChatroom_Message = javaMessageList.getWith(JavaUtil.toJavaIntegerPrimitive(i)) as! ComSoftwareverdeUtopiaChatroom_Message
            chatMessages.append(ChatroomMessage.fromUtopiaChatroomMessage(javaMessage))
        }

        return chatMessages
    }

    open func addMessagesCallback(_ identifier: String, callback: @escaping () -> Void) {
        _session.addMessagesCallback(with: identifier, with: Runnable(callback))
    }
    open func removeMessagesCallback(_ identifier: String) {
        _session.removeMessagesCallback(with: identifier)
    }

    open func startDownloadMessagesThread() {
        _session.startDownloadMessagesThread()
    }

    open func sendChatroomMessage(_ messageContent: String, callback: SessionCallback?) {
        _session.sendChatMessage(with: messageContent, with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func addAdviewCallback(uniqueIdentifier: String, adviewCallback: AdviewCallback?) {
        _session.addAdviewCallback(with: uniqueIdentifier, with: UtopiaAdviewCallback(adviewCallback))
    }

    open func removeAdviewCallback(_ uniqueIdentifier: String) {
        _session.removeAdViewCallback(with: uniqueIdentifier)
    }

    open func downloadChatMessages(_ callback: SessionCallback?) {
        _session.downloadChatMessages(with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func downloadProvinceNews(_ callback: SessionCallback?) {
        _session.downloadNews(with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func downloadProvinceNews(month: Int, year: Int, callback: SessionCallback?) {
        _session.downloadNews(with: JavaUtil.toJavaInteger(month), with: JavaUtil.toJavaInteger(year), with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func downloadProvinceIntel(province: Province, callback: SessionCallback?) {
        _session.downloadProvinceIntel(with: province.toUtopiaProvince(), with: UtopiaSessionCallback(sessionCallback: callback))
    }

    open func getNews() -> Array<ProvinceNews> {
        var provinceNews : Array<ProvinceNews> = Array<ProvinceNews>()

        let javaNewsList : JavaUtilList = _session.getNews()
        for i : Int in 0 ..< Int(javaNewsList.size()) {
            let javaNews : ComSoftwareverdeUtopiaNewsNewsEvent = javaNewsList.getWith(JavaUtil.toJavaIntegerPrimitive(i)) as! ComSoftwareverdeUtopiaNewsNewsEvent
            provinceNews.append(ProvinceNews.fromUtopiaNews(javaNews))
        }

        return provinceNews
    }

    open func getKingdom() -> Kingdom {
        return Kingdom.fromUtopiaKingdom(_session.getKingdom())
    }

    open func getKingdom(_ kingdomIdentifier: KingdomIdentifier) -> Kingdom {
        return Kingdom.fromUtopiaKingdom(_session.getKingdomWith(kingdomIdentifier.toUtopiaKingdomIdentifier()))
    }

    open func intelSyncAuthenticate(intelSyncType: IntelSyncType, subDomain: String, username: String, password: String, sessionCallback: SessionCallback?) {
        let intelSyncType : ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType = intelSyncType.toUtopiaIntelSyncType()

        _session.intelSyncAuthenticate(with: intelSyncType, with: subDomain, with: username, with: password, with: UtopiaSessionCallback(sessionCallback: sessionCallback))
    }

    open func intelSyncLogin(_ sessionCallback: SessionCallback?) {
        _session.intelSyncLogin(with: UtopiaSessionCallback(sessionCallback: sessionCallback))
    }

    open func hasIntelSyncEnabled() -> Bool {
        return JavaUtil.toSwiftBool(_session.hasIntelSyncEnabled())
    }

    open func isIntelSyncLoggedIn() -> Bool {
        return JavaUtil.toSwiftBool(_session.isIntelSyncLoggedIn())
    }

    open func clearIntelSyncCredentials() {
        _session.clearIntelSyncCredentials()
    }

    open func setOnBadAccessCallback(_ badAccessCallback: @escaping BadAccessCallback) {
        _session.setBadAccessCallbackWith(UtopiaBadAccessCallback(badAccessCallback))
    }

    open func setVerdeIntelSyncEnabled(_ shouldBeEnabled: Bool) {
        _session.setVerdeIntelSyncEnabledWith(JavaLangBoolean(boolean: shouldBeEnabled))
    }

    open func isVerdeIntelSyncLoggedIn() -> Bool {
        return JavaUtil.toSwiftBool(_session.isVerdeIntelSyncLoggedIn())
    }

    open func verdeIntelSyncLogin() {
        _session.verdeIntelSyncLogin()
    }

    open func hasVerdeIntelSyncEnabled() -> Bool {
        return JavaUtil.toSwiftBool(_session.hasVerdeIntelSyncEnabled())
    }

    open func getIntelSyncType() -> IntelSyncType? {
        return IntelSyncType.fromUtopiaIntelSyncType(_session.getIntelSyncType())
    }

    open func setFocusedKingdom(_ kingdomIdentifier: KingdomIdentifier) {
        _session.setFocusedKingdomWith(kingdomIdentifier.toUtopiaKingdomIdentifier())
    }

    open func addOnKingdomDownloadCallback(uniqueIdentifier: String, callback: ((KingdomIdentifier) -> Void)?) {
        _session.addKingdomCallback(with: uniqueIdentifier, with: UtopiaKingdomCallback(callback))
    }

    open func removeKingdomDownloadCallback(_ uniqueIdentifier: String) {
        _session.removeKingdomCallback(with: uniqueIdentifier)
    }

    open func downloadNextKingdom(currentKingdomIdentifier: KingdomIdentifier, callback: DownloadKingdomCallback) {
        _session.downloadNextKingdom(with: currentKingdomIdentifier.toUtopiaKingdomIdentifier(), with: callback)
    }

    open func downloadPreviousKingdom(currentKingdomIdentifier: KingdomIdentifier, callback: DownloadKingdomCallback) {
        _session.downloadPreviousKingdom(with: currentKingdomIdentifier.toUtopiaKingdomIdentifier(), with: callback)
    }

    open func downloadKingdom(kingdomIdentifier: KingdomIdentifier, callback: DownloadKingdomCallback) {
        _session.downloadKingdom(with: kingdomIdentifier.toUtopiaKingdomIdentifier(), with: callback)
    }

    open func addNewsCallback(uniqueIdentifier: String, callback: NewsCallback?) {
        _session.addNewsCallback(with: uniqueIdentifier, with: UtopiaNewsCallback(callback))
    }

    open func removeNewsCallback(_ uniqueIdentifier: String) {
        _session.removeNewsCallback(with: uniqueIdentifier)
    }
}
