
import Foundation
import UIKit

open class Util {
    open static func getImageFromFile(_ filename: String) -> UIImage {
        let paths : NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let getImagePath = paths.appendingPathComponent(filename)
        return UIImage(contentsOfFile: getImagePath)!
    }

    open static func parseColor(_ hex: String) -> UIColor {
        var cString : NSString = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString

        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: 1) as NSString
        }

        if (cString.length() != 6) {
            return UIColor.black
        }

        let rString : NSString = cString.substring(to: 2) as NSString
        let gString : NSString  = (cString.substring(from: 2) as NSString).substring(to: 2) as NSString
        let bString : NSString  = (cString.substring(from: 4) as NSString).substring(to: 2) as NSString

        var r : CUnsignedInt = 0;
        var g : CUnsignedInt = 0;
        var b : CUnsignedInt = 0;

        Scanner(string: rString as String).scanHexInt32(&r)
        Scanner(string: gString as String).scanHexInt32(&g)
        Scanner(string: bString as String).scanHexInt32(&b)

        let maxValue : Float = Float(255.0)
        return UIColor(red: CGFloat(Float(r) / maxValue), green: CGFloat(Float(g) / maxValue), blue: CGFloat(Float(b) / maxValue), alpha: CGFloat(1.0))
    }

    open static func formatPercent(_ float: Float, decimals: Int) -> String {
        if (decimals > 0) {
            return String.localizedStringWithFormat("%.\(decimals)f", float)
        }
        else {
            return String(round(float))
        }
    }

    open static func getTimestamp() -> Double {
        return (Date().timeIntervalSince1970 * 1000)
    }
}
