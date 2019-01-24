
import Foundation

open class Kingdom {
    open static func fromUtopiaKingdom(_ utopiaKingdom: ComSoftwareverdeUtopiaKingdom) -> Kingdom {
        let kingdom : Kingdom = Kingdom()
        kingdom._kingdom = utopiaKingdom
        return kingdom
    }

    fileprivate var _kingdom : ComSoftwareverdeUtopiaKingdom!

    fileprivate init() {
        // Nothing.
    }

    open func toUtopiaKingdom() -> ComSoftwareverdeUtopiaKingdom {
        return _kingdom
    }

    open func getProvinces() -> Array<Province> {
        var provinces : Array<Province> = Array<Province>()

        let javaProvinces : JavaUtilList = _kingdom.getProvinces()
        for i : Int in 0 ..< Int(javaProvinces.size()) {
            let javaProvince : ComSoftwareverdeUtopiaProvince = javaProvinces.getWith(Int32(i)) as! ComSoftwareverdeUtopiaProvince
            provinces.append(Province.fromUtopiaProvince(javaProvince))
        }

        return provinces
    }

    open func getIdentifier() -> KingdomIdentifier {
        return KingdomIdentifier.fromUtopiaKingdomIdentifier(_kingdom.getIdentifier())
    }

    open func getName() -> String {
        return _kingdom.getName()
    }

    open func getNetworth() -> Int {
        return _kingdom.getNetworth().intValue
    }

    open func getStance() -> String {
        return _kingdom.getStance()
    }
}
