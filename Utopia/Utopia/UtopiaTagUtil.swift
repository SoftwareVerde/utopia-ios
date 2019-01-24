
import Foundation

open class UtopiaTagUtil {
    open static func calculateProvinceTagSuggestions(_ inputText: String, provinces: Array<Province>) -> Array<String> {
        let javaProvinces : JavaUtilList = JavaUtilArrayList()
        for province : Province in provinces {
            javaProvinces.add(withId: province.toUtopiaProvince())
        }
        let javaTagSuggestions : JavaUtilList = ComSoftwareverdeUtopiaProvinceTagUtil.calculateProvinceTagSuggestions(with: inputText, with: javaProvinces)

        var tagSuggestions : Array<String> = Array<String>()

        for i : Int in 0 ..< Int(javaTagSuggestions.size()) {
            let tagSuggestion : String = javaTagSuggestions.getWith(Int32(i)) as! String
            tagSuggestions.append(tagSuggestion)
        }

        return tagSuggestions
    }

    open static func applyProvinceTag(_ inputText: String, provinceName: String) -> String {
        return ComSoftwareverdeUtopiaProvinceTagUtil.applyProvinceTagSuggestion(with: inputText, with: provinceName)
    }
}
