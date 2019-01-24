
import Foundation

open class IntelSyncFactory : NSObject, ComSoftwareverdeUtopiaIntelsyncIntelSyncFactory {
    open func createInstance(with utopiaIntelSyncType: ComSoftwareverdeUtopiaIntelsyncIntelSync_IntelSyncType) -> ComSoftwareverdeUtopiaIntelsyncIntelSync? {
        let intelSyncType : IntelSyncType = IntelSyncType.fromUtopiaIntelSyncType(utopiaIntelSyncType)

        switch (intelSyncType) {
            case .verde:
                return VerdeIntelSync()
            case .upoopu:
                return UpoopuIntelSync()
            case .umunk:
                return UmunkIntelSync()
            case .stinger:
                return StingerIntelSync()
            default:
                return nil
        }
    }
}
