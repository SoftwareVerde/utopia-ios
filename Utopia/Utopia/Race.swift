
public enum Race {
    case avian, dwarf, elf, faery, halfling, human, orc, undead

    public static func fromUtopiaRace(_ utopiaRace: ComSoftwareverdeUtopiaProvince_Race) -> Race! {
        switch(UInt(utopiaRace.ordinal())) {
            case ComSoftwareverdeUtopiaProvince_Race_Enum.AVIAN.rawValue:       return Race.avian
            case ComSoftwareverdeUtopiaProvince_Race_Enum.DWARF.rawValue:       return Race.dwarf
            case ComSoftwareverdeUtopiaProvince_Race_Enum.ELF.rawValue:         return Race.elf
            case ComSoftwareverdeUtopiaProvince_Race_Enum.FAERY.rawValue:       return Race.faery
            case ComSoftwareverdeUtopiaProvince_Race_Enum.HALFLING.rawValue:    return Race.halfling
            case ComSoftwareverdeUtopiaProvince_Race_Enum.HUMAN.rawValue:       return Race.human
            case ComSoftwareverdeUtopiaProvince_Race_Enum.ORC.rawValue:         return Race.orc
            case ComSoftwareverdeUtopiaProvince_Race_Enum.UNDEAD.rawValue:      return Race.undead
            default: return nil
        }
    }

    public func toUtopiaRace() -> ComSoftwareverdeUtopiaProvince_Race! {
        switch(self) {
        case .avian:    return ComSoftwareverdeUtopiaProvince_Race_fromOrdinal(ComSoftwareverdeUtopiaProvince_Race_Enum.AVIAN.rawValue)
        case .dwarf:    return ComSoftwareverdeUtopiaProvince_Race_fromOrdinal(ComSoftwareverdeUtopiaProvince_Race_Enum.DWARF.rawValue)
        case .elf:      return ComSoftwareverdeUtopiaProvince_Race_fromOrdinal(ComSoftwareverdeUtopiaProvince_Race_Enum.ELF.rawValue)
        case .faery:    return ComSoftwareverdeUtopiaProvince_Race_fromOrdinal(ComSoftwareverdeUtopiaProvince_Race_Enum.FAERY.rawValue)
        case .halfling: return ComSoftwareverdeUtopiaProvince_Race_fromOrdinal(ComSoftwareverdeUtopiaProvince_Race_Enum.HALFLING.rawValue)
        case .human:    return ComSoftwareverdeUtopiaProvince_Race_fromOrdinal(ComSoftwareverdeUtopiaProvince_Race_Enum.HUMAN.rawValue)
        case .orc:      return ComSoftwareverdeUtopiaProvince_Race_fromOrdinal(ComSoftwareverdeUtopiaProvince_Race_Enum.ORC.rawValue)
        case .undead:   return ComSoftwareverdeUtopiaProvince_Race_fromOrdinal(ComSoftwareverdeUtopiaProvince_Race_Enum.UNDEAD.rawValue)
        }
    }
}
