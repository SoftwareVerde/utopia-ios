
import Foundation

open class SpellCellFactory : TableViewCellFactory<CastableSpell> {
    fileprivate let _rowHeight : Float = 55
    fileprivate let _province : Province

    public init(province: Province) {
        _province = province
    }
    
    open override func getCellHeight(data: CastableSpell, cell: TableViewCell?) -> Float {
        return _rowHeight
    }
    
    open override func createCell(_ castableSpell: CastableSpell) -> SpellTableViewCell {
        let spell : Spell = castableSpell.getSpell()

        let cell : SpellTableViewCell = SpellTableViewCell.newInstance()
        cell.setSpellName(spell.getName())
        cell.setSpellCost(spell.getRuneCost())
        if (castableSpell.isActive()) {
            let spellDuration : Int = _province.getSpellDuration(spell.getName())
            let hoursFloat : Float = Float(spellDuration) / 60.0 / 60.0
            
            let hours : Int = Int(floor(hoursFloat))
            let minutes : Int = Int(floor((hoursFloat - Float(hours)) * 60.0))
            
            cell.setSpellDuration(hours: hours, minutes: minutes)
        }
        else {
            cell.setSpellDuration(hours: 0, minutes: 0)
        }
        return cell
    }
}
