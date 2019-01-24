
import Foundation
import UIKit

open class UiTheme {
    fileprivate let _race : Race

    public init(race: Race) {
        _race = race
    }

    open func getRaceIcon() -> UIImage {
        switch(_race) {
            case .avian:
                return UIImage(named: "portrait_avian")!
            case .dwarf:
                return UIImage(named: "portrait_dwarf")!
            case .elf:
                return UIImage(named: "portrait_elf")!
            case .faery:
                return UIImage(named: "portrait_faery")!
            case .halfling:
                return UIImage(named: "portrait_halfling")!
            case .human:
                return UIImage(named: "portrait_human")!
            case .orc:
                return UIImage(named: "portrait_orc")!
            case .undead:
                return UIImage(named: "portrait_undead")!
        }
    }
}
