
import Foundation

open class TrainArmyData {
    fileprivate let _trainArmyBundle : ComSoftwareverdeUtopiaTrainArmyData

    public init(race: Race) {
        _trainArmyBundle = ComSoftwareverdeUtopiaTrainArmyData(comSoftwareverdeUtopiaProvince_Race: race.toUtopiaRace())
    }

    open func toUtopiaTrainArmyBundle() -> ComSoftwareverdeUtopiaTrainArmyData {
        return _trainArmyBundle
    }

    open func setSoldiersCount(_ count: Int) {
        _trainArmyBundle.setSoldierCountWith(JavaLangInteger.init(value: Int32(count)))
    }

    open func setDefensiveUnitsCount(_ count: Int) {
        _trainArmyBundle.setDefensiveUnitCountWith(JavaLangInteger.init(value: Int32(count)))
    }

    open func setOffensiveUnitsCount(_ count: Int) {
        _trainArmyBundle.setOffensiveUnitCountWith(JavaLangInteger.init(value: Int32(count)))
    }

    open func setElitesCount(_ count: Int) {
        _trainArmyBundle.setEliteCountWith(JavaLangInteger.init(value: Int32(count)))
    }

    open func setThievesCount(_ count: Int) {
        _trainArmyBundle.setThiefCountWith(JavaLangInteger.init(value: Int32(count)))
    }

    open func setDraftTarget(_ draftTarget: Int) {
        _trainArmyBundle.setDraftTargetWith(JavaLangInteger.init(value: Int32(draftTarget)))
    }

    open func setDraftRate(_ draftRate: DraftRate) {
        _trainArmyBundle.setDraftRateWith(draftRate.toUtopiaDraftRate())
    }

    open func setWageRate(_ wageRate: Int) {
        _trainArmyBundle.setWageRateWith(JavaLangInteger.init(value: Int32(wageRate)))
    }
}
