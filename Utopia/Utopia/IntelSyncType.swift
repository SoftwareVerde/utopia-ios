
import Foundation

public enum IntelSyncType {
    case umunk, stinger, upoopu, verde

    public static func fromUtopiaIntelSyncType(_ intelSyncType: ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType?) -> IntelSyncType! {
        if (intelSyncType == nil) { return nil }

        switch(UInt(intelSyncType!.ordinal())) {
            case ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_Enum.UMUNK.rawValue:    return IntelSyncType.umunk
            case ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_Enum.STINGER.rawValue:  return IntelSyncType.stinger
            case ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_Enum.UPOOPU.rawValue:   return IntelSyncType.upoopu
            case ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_Enum.VERDE.rawValue:   return IntelSyncType.verde
            default: return nil
        }
    }

    public func toUtopiaIntelSyncType() -> ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType! {
        switch(self) {
            case .umunk:    return ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_fromOrdinal(ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_Enum.UMUNK.rawValue)
            case .stinger:  return ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_fromOrdinal(ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_Enum.STINGER.rawValue)
            case .upoopu:   return ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_fromOrdinal(ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_Enum.UPOOPU.rawValue)
            case .verde:    return ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_fromOrdinal(ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType_Enum.VERDE.rawValue)
            default:        return nil
        }
    }
}
