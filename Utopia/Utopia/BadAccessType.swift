
public enum BadAccessType {
    case unverified_EMAIL, no_PROVINCE, dead_PROVINCE, none

    public static func fromUtopiaBadAccessType(_ utopiaBadAccessType: ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType) -> BadAccessType! {
        switch(UInt(utopiaBadAccessType.ordinal())) {
            case ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_Enum.UNVERIFIED_EMAIL.rawValue: return BadAccessType.unverified_EMAIL
            case ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_Enum.NO_PROVINCE.rawValue:      return BadAccessType.no_PROVINCE
            case ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_Enum.DEAD_PROVINCE.rawValue:    return BadAccessType.dead_PROVINCE
            case ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_Enum.NONE.rawValue:             return BadAccessType.none
            default: return nil
        }
    }

    public func toUtopiaBadAccessType() -> ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType! {
        switch(self) {
            case .unverified_EMAIL: return ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_fromOrdinal(ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_Enum.UNVERIFIED_EMAIL.rawValue)
            case .no_PROVINCE:      return ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_fromOrdinal(ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_Enum.UNVERIFIED_EMAIL.rawValue)
            case .dead_PROVINCE:    return ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_fromOrdinal(ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_Enum.UNVERIFIED_EMAIL.rawValue)
            case .none:             return ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_fromOrdinal(ComSoftwareverdeUtopiaParserUtopiaParser_BadAccessType_Enum.UNVERIFIED_EMAIL.rawValue)
        }
    }
}
