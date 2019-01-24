
import Foundation

open class KingdomIdentifier {
    open static func fromUtopiaKingdomIdentifier(_ utopiaKingdomIdentifier: ComSoftwareverdeUtopiaKingdom_Identifier) -> KingdomIdentifier {
        return KingdomIdentifier(kingdomIdentifier: utopiaKingdomIdentifier)
    }

    fileprivate var _kingdomIdentifier : ComSoftwareverdeUtopiaKingdom_Identifier

    fileprivate init(kingdomIdentifier: ComSoftwareverdeUtopiaKingdom_Identifier) {
        _kingdomIdentifier = kingdomIdentifier
    }

    public init(kingdomId: Int, islandId: Int) {
        _kingdomIdentifier = ComSoftwareverdeUtopiaKingdom_Identifier(javaLangInteger: JavaLangInteger(value: Int32(kingdomId)), with: JavaLangInteger(value: Int32(islandId)))
    }

    open func toUtopiaKingdomIdentifier() -> ComSoftwareverdeUtopiaKingdom_Identifier {
        return _kingdomIdentifier
    }

    open func getKingdomId() -> Int {
        return _kingdomIdentifier.getKingdomId().intValue
    }

    open func getIslandId() -> Int {
        return _kingdomIdentifier.getIslandId().intValue
    }
}
