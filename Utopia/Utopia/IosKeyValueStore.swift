
import Foundation

open class IosKeyValueStore : NSObject, ComSoftwareverdeUtopiaDatabaseKeyValueStore {

    fileprivate var _userDefaults : UserDefaults!

    public override init() {
        super.init()

        _userDefaults = UserDefaults.standard
    }

    open func getStringWith(_ key: String!) -> String! {
        let value : String? = _userDefaults.string(forKey: key)
        return (value != nil ? value : "")
    }

    open func putString(with key: String!, with value: String!) {
        _userDefaults.setValue(value, forKey: key)
        _userDefaults.synchronize()
    }

    open func hasKey(with key: String!) -> jboolean {
        return (_userDefaults.object(forKey: key) != nil)
    }

    open func removeKey(with key: String!) {
        _userDefaults.removeObject(forKey: key)
    }

    open func clear() {
        _userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }

    open func clearAllStores() {
        _userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }

}
