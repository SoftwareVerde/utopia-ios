
import Foundation

open class Building {
    open static func fromUtopiaBuilding(_ utopiaBuilding: ComSoftwareverdeUtopiaBuilding) -> Building {
        return Building(utopiaBuilding: utopiaBuilding)
    }

    fileprivate let _building : ComSoftwareverdeUtopiaBuilding

    fileprivate init(utopiaBuilding: ComSoftwareverdeUtopiaBuilding) {
        _building = utopiaBuilding
    }

    open func toUtopiaBuilding() -> ComSoftwareverdeUtopiaBuilding {
        return _building
    }

    open func getCount() -> Int {
        return _building.getCount().intValue
    }

    open func getEffect() -> String {
        return _building.getEffect()
    }

    open func getPercent() -> Float {
        return _building.getPercent().floatValue()
    }

    open func getType() -> BuildingType {
        return BuildingType.fromUtopiaBuildingType(_building.getType())
    }
}

public enum BuildingType {
    case barren, homes, farms, banks, dungeons, armories, mills, universities, laboratories, training_GROUNDS, barracks, stables, forts, guard_STATIONS, watchtowers, hospitals, guilds, thieves_DENS, towers

    public static func fromUtopiaBuildingType(_ buildingType: ComSoftwareverdeUtopiaBuilding_Type) -> BuildingType! {
        switch(UInt(buildingType.ordinal())) {
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.BARREN.rawValue:              return BuildingType.barren
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.HOMES.rawValue:               return BuildingType.homes
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.FARMS.rawValue:               return BuildingType.farms
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.BANKS.rawValue:               return BuildingType.banks
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.DUNGEONS.rawValue:            return BuildingType.dungeons
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.ARMORIES.rawValue:            return BuildingType.armories
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.MILLS.rawValue:               return BuildingType.mills
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.UNIVERSITIES.rawValue:        return BuildingType.universities
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.LABORATORIES.rawValue:        return BuildingType.laboratories
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.TRAINING_GROUNDS.rawValue:    return BuildingType.training_GROUNDS
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.BARRACKS.rawValue:            return BuildingType.barracks
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.STABLES.rawValue:             return BuildingType.stables
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.FORTS.rawValue:               return BuildingType.forts
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.GUARD_STATIONS.rawValue:      return BuildingType.guard_STATIONS
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.WATCHTOWERS.rawValue:         return BuildingType.watchtowers
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.HOSPITALS.rawValue:           return BuildingType.hospitals
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.GUILDS.rawValue:              return BuildingType.guilds
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.THIEVES_DENS.rawValue:        return BuildingType.thieves_DENS
            case ComSoftwareverdeUtopiaBuilding_Type_Enum.TOWERS.rawValue:              return BuildingType.towers
            default: return nil
        }
    }

    public func toUtopiaSpellType() -> ComSoftwareverdeUtopiaBuilding_Type! {
        switch(self) {
            case .barren:           return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.BARREN.rawValue)
            case .homes:            return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.HOMES.rawValue)
            case .farms:            return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.FARMS.rawValue)
            case .banks:            return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.BANKS.rawValue)
            case .dungeons:         return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.DUNGEONS.rawValue)
            case .armories:         return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.ARMORIES.rawValue)
            case .mills:            return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.MILLS.rawValue)
            case .universities:     return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.UNIVERSITIES.rawValue)
            case .laboratories:     return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.LABORATORIES.rawValue)
            case .training_GROUNDS: return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.TRAINING_GROUNDS.rawValue)
            case .barracks:         return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.BARRACKS.rawValue)
            case .stables:          return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.STABLES.rawValue)
            case .forts:            return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.FORTS.rawValue)
            case .guard_STATIONS:   return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.GUARD_STATIONS.rawValue)
            case .watchtowers:      return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.WATCHTOWERS.rawValue)
            case .hospitals:        return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.HOSPITALS.rawValue)
            case .guilds:           return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.GUILDS.rawValue)
            case .thieves_DENS:     return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.THIEVES_DENS.rawValue)
            case .towers:           return ComSoftwareverdeUtopiaBuilding_Type_fromOrdinal(ComSoftwareverdeUtopiaBuilding_Type_Enum.TOWERS.rawValue)
        }
    }
}
