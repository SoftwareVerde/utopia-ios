
import Foundation
import UIKit

open class StingerIntelSync : ComSoftwareverdeUtopiaIntelsyncStingerUtil {
    public override init() {
        let dependencies : StingerDependencies = StingerDependencies()
        dependencies.setBuildVersion(BuildVersion())
        dependencies.setHtmlParser(ComSoftwareverdeUtopiaParserJsoupHtmlParser())

        super.init(comSoftwareverdeUtopiaIntelsyncStingerUtil_Dependencies: dependencies.getUtopiaStingerDependencies())
    }
}

open class StingerDependencies {
    fileprivate let _utopiaStingerDependencies : ComSoftwareverdeUtopiaIntelsyncStingerUtil_Dependencies = ComSoftwareverdeUtopiaIntelsyncStingerUtil_Dependencies()

    open func setBuildVersion(_ buildVersion: BuildVersion) {
        _utopiaStingerDependencies.setBuildVersionWith(buildVersion)
    }

    open func setHtmlParser(_ htmlParser: ComSoftwareverdeUtopiaParserHtmlParser) {
        _utopiaStingerDependencies.setHtmlParserWith(htmlParser)
    }

    open func getUtopiaStingerDependencies() -> ComSoftwareverdeUtopiaIntelsyncStingerUtil_Dependencies {
        return _utopiaStingerDependencies
    }
}
