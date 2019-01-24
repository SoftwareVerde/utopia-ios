
import Foundation

open class DeployedArmy {
    open static func fromUtopiaDeployedArmy(_ utopiaDeployedArmy: ComSoftwareverdeUtopiaProvince_DeployedArmy) -> DeployedArmy {
        let deployedArmy : DeployedArmy = DeployedArmy()
        deployedArmy._deployedArmy = utopiaDeployedArmy
        return deployedArmy
    }

    fileprivate var _deployedArmy : ComSoftwareverdeUtopiaProvince_DeployedArmy!

    fileprivate init() {
        // Nothing.
    }

    open func toUtopiaDeployedArmy() -> ComSoftwareverdeUtopiaProvince_DeployedArmy {
        return _deployedArmy
    }

    open func getAcres() -> Int {
        return _deployedArmy.getAcres().intValue
    }

    open func getReturnTime() -> Int {
        return _deployedArmy.getReturnTime().intValue
    }

    open func getGenerals() -> Int {
        return _deployedArmy.getGenerals().intValue
    }
}
