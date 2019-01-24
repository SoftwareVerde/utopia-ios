
import Foundation

open class DraftRate {
    open static func fromUtopiaDraftRate(_ utopiaDraftRate: ComSoftwareverdeUtopiaDraftRate) -> DraftRate {
        return DraftRate(utopiaDraftRate: utopiaDraftRate)
    }

    fileprivate let _draftRate : ComSoftwareverdeUtopiaDraftRate

    fileprivate init(utopiaDraftRate: ComSoftwareverdeUtopiaDraftRate) {
        _draftRate = utopiaDraftRate
    }

    open func getIdentifier() -> String {
        return _draftRate.getIdentifier()
    }

    open func getCost(_ totalPeasants: Int) -> Int {
        return _draftRate.getCostWith(JavaLangInteger(value: Int32(totalPeasants))).intValue
    }

    open func getName() -> String {
        return _draftRate.getName()
    }

    open func getRate() -> Float {
        return _draftRate.getRate().floatValue()
    }

    open func getRateCost() -> Float {
        return _draftRate.getCost().floatValue()
    }

    open func toUtopiaDraftRate() -> ComSoftwareverdeUtopiaDraftRate {
        return _draftRate
    }
}
