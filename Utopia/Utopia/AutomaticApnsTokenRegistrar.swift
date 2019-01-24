
import Foundation

open class AutomaticApnsTokenRegistrar {
    public typealias Callback_t = (_ wasSuccess: Bool, _ errorMessage: String?) -> Void

    fileprivate static var _instance : AutomaticApnsTokenRegistrar! = nil
    open static func getInstance() -> AutomaticApnsTokenRegistrar {
        if (_instance == nil) {
            _instance = AutomaticApnsTokenRegistrar()
        }
        return _instance
    }

    fileprivate class UtopiaCallback : NSObject, ComSoftwareverdeUtopiaProvinceTagUtil_Callback {
        fileprivate let _callback: Callback_t?

        init(_ callback: Callback_t?) {
            _callback = callback
        }

        @objc
        func run(with response: ComSoftwareverdeUtopiaProvinceTagUtil_Response!) {
            _callback?(response.getWasSuccess().booleanValue(), response.getErrorMessage())
        }
    }

    fileprivate var _apnsToken: String? = nil
    fileprivate var _provinceName: String? = nil
    fileprivate var _kingdomIdentifier : KingdomIdentifier? = nil

    fileprivate var _wasSubmitted: Bool = false
    fileprivate var _isSubmitting: Bool = false

    fileprivate init() { }

    fileprivate func _registerApnsToken() {
        _isSubmitting = true
        let utopiaProvinceTagUtil : ComSoftwareverdeUtopiaProvinceTagUtil = ComSoftwareverdeUtopiaProvinceTagUtil()

        utopiaProvinceTagUtil.registerApnsToken(
            with: _apnsToken,
            with: _provinceName,
            with: JavaLangInteger(value: Int32(_kingdomIdentifier!.getKingdomId())),
            with: JavaLangInteger(value: Int32(_kingdomIdentifier!.getIslandId())),
            with: UtopiaCallback({
                (wasSuccess: Bool, errorMessage: String?) -> Void in
                    if (wasSuccess) {
                        self._wasSubmitted = true
                    }

                    self._isSubmitting = false
            })
        )
    }

    fileprivate func _submitTokenIfReady() {
        if (_isSubmitting) { return }
        if (_wasSubmitted) { return }

        if (_apnsToken != nil && _provinceName != nil && _kingdomIdentifier != nil) {
            _registerApnsToken()
        }
    }

    open func hasRegisteredApnsToken() -> Bool {
        return _wasSubmitted
    }

    open func setProvince(provinceName: String, kingdomIdentifier: KingdomIdentifier) {
        _provinceName = provinceName
        _kingdomIdentifier = KingdomIdentifier(kingdomId: kingdomIdentifier.getKingdomId(), islandId: kingdomIdentifier.getIslandId())

        _submitTokenIfReady()
    }

    open func setApnsToken(_ apnsToken: String) {
        _apnsToken = apnsToken

        _submitTokenIfReady()
    }
}
