
import Foundation

open class UtopiaUtil {
    open static func getUtopianMonthFromIndex(_ month: Int) -> String? {
        return ComSoftwareverdeUtopiaUtopiaUtil.getUtopianMonthFromIndex(with: JavaUtil.toJavaInteger(month))
    }
}
