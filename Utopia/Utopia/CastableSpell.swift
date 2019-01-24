
import Foundation

open class CastableSpell {
    fileprivate let _spell : Spell
    fileprivate let _spellDuration : Int?
    
    init(spell: Spell, spellDuration: Int?) {
        _spell = spell
        _spellDuration = spellDuration
    }
    
    func getSpell() -> Spell {
        return _spell
    }
    
    func getSpellDuration() -> Int? {
        return _spellDuration
    }
    
    func isActive() -> Bool {
        return (_spellDuration != nil)
    }
}
