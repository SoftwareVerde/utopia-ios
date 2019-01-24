
import Foundation

open class Spell {
    open static func fromUtopiaSpell(_ utopiaSpell: ComSoftwareverdeUtopiaSpell) -> Spell {
        return Spell(utopiaSpell: utopiaSpell)
    }

    fileprivate let _spell : ComSoftwareverdeUtopiaSpell

    fileprivate init(utopiaSpell: ComSoftwareverdeUtopiaSpell) {
        _spell = utopiaSpell
    }

    open func toUtopiaSpell() -> ComSoftwareverdeUtopiaSpell {
        return _spell
    }

    open func getName() -> String {
        return _spell.getName()
    }

    open func getIdentifier() -> String {
        return _spell.getIdentifier()
    }

    open func getRuneCost() -> Int {
        return _spell.getRuneCost().intValue
    }

    open func getIdentifier() -> SpellType {
        return SpellType.fromUtopiaSpellType(_spell.getType())
    }
}

public enum SpellType {
    case offensive, defensive

    public static func fromUtopiaSpellType(_ spellType: ComSoftwareverdeUtopiaSpell_SpellType) -> SpellType! {
        switch(UInt(spellType.ordinal())) {
            case ComSoftwareverdeUtopiaSpell_SpellType_Enum.OFFENSIVE.rawValue: return SpellType.offensive
            case ComSoftwareverdeUtopiaSpell_SpellType_Enum.DEFENSIVE.rawValue: return SpellType.defensive
            default: return nil
        }
    }

    public func toUtopiaSpellType() -> ComSoftwareverdeUtopiaSpell_SpellType! {
        switch(self) {
            case .offensive:    return ComSoftwareverdeUtopiaSpell_SpellType_fromOrdinal(ComSoftwareverdeUtopiaSpell_SpellType_Enum.OFFENSIVE.rawValue)
            case .defensive:    return ComSoftwareverdeUtopiaSpell_SpellType_fromOrdinal(ComSoftwareverdeUtopiaSpell_SpellType_Enum.DEFENSIVE.rawValue)
        }
    }
}

open class ActiveSpell {
    open static func fromUtopiaActiveSpell(_ utopiaActiveSpell: ComSoftwareverdeUtopiaActiveSpell) -> ActiveSpell {
        return ActiveSpell(utopiaActiveSpell: utopiaActiveSpell)
    }

    fileprivate let _activeSpell : ComSoftwareverdeUtopiaActiveSpell

    fileprivate init(utopiaActiveSpell: ComSoftwareverdeUtopiaActiveSpell) {
        _activeSpell = utopiaActiveSpell
    }

    open func getSpellName() -> String {
        return _activeSpell.getName()
    }

    open func getExpirationTime() -> Int {
        return _activeSpell.getExpirationTime().intValue
    }

    open func getSpellDescription() -> String {
        return _activeSpell.getDescription()
    }

    open func toUtopiaActiveSpell() -> ComSoftwareverdeUtopiaActiveSpell {
        return _activeSpell
    }

}
