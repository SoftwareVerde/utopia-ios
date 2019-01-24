
import Foundation

open class VerdeIntelSync : ComSoftwareverdeUtopiaIntelsyncVerdeIntelUtil {
    public override init() {

        let base64Util : IosBase64Util = IosBase64Util()
        let bundleFactory : ComSoftwareverdeUtopiaBundleBundleFactory = ComSoftwareverdeUtopiaBundleBundleFactory()

        let verdeDependencies : ComSoftwareverdeUtopiaIntelsyncVerdeIntelUtil_Dependencies = ComSoftwareverdeUtopiaIntelsyncVerdeIntelUtil_Dependencies.init()
        verdeDependencies.setBase64UtilWith(base64Util)
        verdeDependencies.setBundleFactoryWith(bundleFactory)

        super.init(comSoftwareverdeUtopiaIntelsyncVerdeIntelUtil_Dependencies: verdeDependencies)
    }
}
