
import Foundation
import UIKit

open class UpoopuIntelSync : ComSoftwareverdeUtopiaIntelsyncUpoopuUtil {
    public override init() {
        let upoopuLib : String = try! String(contentsOfFile: Bundle.main.path(forResource: "upoopu_lib", ofType: "js")!, encoding: String.Encoding.utf8)
        let javaScriptExecutor : IosJavaScriptExecutor = IosJavaScriptExecutor()
        let base64Util : IosBase64Util = IosBase64Util()

        let dependencies : UpoopuDependencies = UpoopuDependencies()
        dependencies.setUpoopuLibrary(upoopuLib)
        dependencies.setJavaScriptExecutor(javaScriptExecutor)
        dependencies.setBase64Util(base64Util)

        super.init(comSoftwareverdeUtopiaIntelsyncUpoopuUtil_Dependencies: dependencies.getUtopiaUpoopuDependencies())
    }
}

open class UpoopuDependencies {
    fileprivate let _utopiaUpoopuDependencies : ComSoftwareverdeUtopiaIntelsyncUpoopuUtil_Dependencies = ComSoftwareverdeUtopiaIntelsyncUpoopuUtil_Dependencies()

    open func setUpoopuLibrary(_ upoopuLibrary: String) {
        _utopiaUpoopuDependencies.setUpoopuLibraryWith(upoopuLibrary)
    }

    open func setJavaScriptExecutor(_ javaScriptExecutor: IosJavaScriptExecutor) {
        _utopiaUpoopuDependencies.setJavaScriptExecutorWith(javaScriptExecutor)
    }

    open func setBase64Util(_ iosBase64Util: IosBase64Util) {
        _utopiaUpoopuDependencies.setBase64UtilWith(iosBase64Util)
    }

    open func getUtopiaUpoopuDependencies() -> ComSoftwareverdeUtopiaIntelsyncUpoopuUtil_Dependencies {
        return _utopiaUpoopuDependencies
    }
}
