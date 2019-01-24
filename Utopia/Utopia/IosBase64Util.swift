
import Foundation

open class IosBase64Util : NSObject, ComSoftwareverdeUtopiaUtilBase64Util {
    open func encodeString(with string: String) -> String {
        return string.data(using: String.Encoding.utf8)!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }

    open func decodeString(with string: String) -> String {
        let decodedData : Data = Data(base64Encoded: string, options: NSData.Base64DecodingOptions(rawValue: 0))!
        return NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue)! as String
    }
}
