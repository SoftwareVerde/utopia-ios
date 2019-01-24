
import Foundation

open class BuildVersion : NSObject, ComSoftwareverdeUtopiaUtilBuildVersion {
    open func getName() -> String {
        let versionString : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return versionString
    }

    open func getNumber() -> JavaLangInteger {
        let versionNumberString : String = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        let versionNumber : Int = Int(versionNumberString)!
        return JavaLangInteger(value: Int32(versionNumber))
    }
}
