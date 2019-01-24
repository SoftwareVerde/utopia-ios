
import Foundation

open class Province {
    open static func fromUtopiaProvince(_ utopiaProvince : ComSoftwareverdeUtopiaProvince) -> Province {
        let province : Province = Province()
        province._province = utopiaProvince
        return province
    }

    fileprivate var _province : ComSoftwareverdeUtopiaProvince!

    fileprivate init() {
        // Nothing.
    }

    fileprivate func _toIntegerArray(_ iosObjectArray : IOSObjectArray?) -> Array<Int> {
        if (iosObjectArray == nil) { return Array<Int>() }

        var array : Array<Int> = Array<Int>()

        let length : Int = Int(iosObjectArray!.length())
        for i : UInt in 0 ..< UInt(length) {
            let integerValue : jint? = (iosObjectArray!.object(at: i) as? JavaLangInteger)?.intValue()

            if (integerValue == nil) {
                array.append(0)
            }
            else {
                array.append(Int(integerValue!))
            }
        }

        return array
    }

    open func toUtopiaProvince() -> ComSoftwareverdeUtopiaProvince {
        return _province
    }

    open func getName() -> String! {
        return _province.getName()
    }

    open func getRulerName() -> String! {
        return _province.getRulerName()
    }

    open func getMoney() -> Int! {
        return _province.getMoney()?.intValue
    }

    open func getFood() -> Int! {
        return _province.getFood()?.intValue
    }

    open func getRunes() -> Int! {
        return _province.getRunes()?.intValue
    }

    open func getAcres() -> Int! {
        return _province.getAcres()?.intValue
    }

    open func getNetworth() -> Int! {
        return _province.getNetworth()?.intValue
    }

    open func getTotalDefense() -> Int! {
        return _province.getTotalDefense()?.intValue
    }

    open func getTotalOffense() -> Int! {
        return _province.getTotalOffense()?.intValue
    }

    open func getPeasants() -> Int! {
        return _province.getPeasants()?.intValue
    }

    open func getMaxPeasants() -> Int! {
        return _province.getMaxPeasants()?.intValue
    }

    open func getBuildingEfficiency() -> Float! {
        return _province.getBuildingEfficiency()?.floatValue()
    }

    open func getSoldiers() -> Int! {
        return _province.getSoldiers()?.intValue
    }

    open func getDefensiveUnits() -> Int! {
        return _province.getDefensiveUnits()?.intValue
    }

    open func getDefensiveUnitsInProgress() -> Array<Int>! {
        return _toIntegerArray(_province.getDefensiveUnitsInProgress())
    }
    open func getTotalDefensiveUnitsInProgress() -> Int {
        return _province.getTotalDefensiveUnitsInProgress().intValue
    }

    open func getOffensiveUnits() -> Int! {
        return _province.getOffensiveUnits()?.intValue
    }

    open func getOffensiveUnitsInProgress() -> Array<Int>! {
        return _toIntegerArray(_province.getOffensiveUnitsInProgress())
    }
    open func getTotalOffensiveUnitsInProgress() -> Int {
        return _province.getTotalOffensiveUnitsInProgress().intValue
    }

    open func getElites() -> Int! {
        return _province.getElites()?.intValue
    }

    open func getElitesInProgress() -> Array<Int>! {
        return _toIntegerArray(_province.getElitesInProgress())
    }
    open func getTotalElitesInProgress() -> Int! {
        return _province.getTotalElitesInProgress()?.intValue
    }

    open func getThieves() -> Int! {
        return _province.getThieves()?.intValue
    }

    open func getThievesInProgress() -> Array<Int>! {
        return _toIntegerArray(_province.getThievesInProgress())
    }
    open func getTotalThievesInProgress() -> Int! {
        return _province.getTotalThievesInProgress()?.intValue
    }

    open func getWizards() -> Int! {
        return _province.getWizards()?.intValue
    }

    open func getHorses() -> Int! {
        return _province.getHorses()?.intValue
    }

    open func getPrisoners() -> Int! {
        return _province.getPrisoners()?.intValue
    }

    open func getMaxHorses() -> Int! {
        return _province.getMaxHorses()?.intValue
    }

    open func getMaxPrisoners() -> Int! {
        return _province.getMaxPrisoners()?.intValue
    }

    open func getMaxPopulation() -> Int! {
        return _province.getMaxPopulation()?.intValue
    }

    open func getMilitaryPopulation() -> Int! {
        return _province.getMilitaryPopulation()?.intValue
    }

    open func getDraftTarget() -> Int! {
        return _province.getDraftTarget()?.intValue
    }

    open func getMilitaryWageRate() -> Int! {
        return _province.getMilitaryWageRate()?.intValue
    }

    open func getDraftRate() -> DraftRate! {
        let draftRate : ComSoftwareverdeUtopiaDraftRate? = _province.getDraftRate()
        return (draftRate != nil ? DraftRate.fromUtopiaDraftRate(draftRate!) : nil)
    }

    open func getStealth() -> Int! {
        return _province.getStealth()?.intValue
    }

    open func getMana() -> Int! {
        return _province.getMana()?.intValue
    }

    open func getRace() -> Race! {
        return Race.fromUtopiaRace(_province.getRace())
    }

    open func getDefenseUnitCost() -> Int! {
        return _province.getDefenseUnitCost()?.intValue
    }

    open func getOffenseUnitCost() -> Int! {
        return _province.getOffenseUnitCost()?.intValue
    }

    open func getEliteCost() -> Int! {
        return _province.getEliteCost()?.intValue
    }

    open func getThiefCost() -> Int! {
        return _province.getThiefCost()?.intValue
    }

    open func getActiveSpells() -> Array<ActiveSpell> {
        var activeSpells : Array<ActiveSpell> = Array<ActiveSpell>()

        let javaActiveSpells : JavaUtilList = _province.getActiveSpells()

        for i : Int in 0 ..< Int(javaActiveSpells.size()) {
            let javaActiveSpell : ComSoftwareverdeUtopiaActiveSpell = javaActiveSpells.getWith(Int32(i)) as! ComSoftwareverdeUtopiaActiveSpell
            // let activeSpellName : String = activeSpell.getSpellName()
            // let activeSpellExpiration : Int = activeSpell.getExpirationTime().integerValue
            let activeSpell : ActiveSpell = ActiveSpell.fromUtopiaActiveSpell(javaActiveSpell)
            activeSpells.append(activeSpell)
        }

        return activeSpells
    }

    open func getSpellDuration(_ spellName: String) -> Int! {
        return _province.getSpellDuration(with: spellName).intValue
    }

    open func getGuilds() -> Building! {
        return Building.fromUtopiaBuilding(_province.getBuildingWith(BuildingType.guilds.toUtopiaSpellType()))
    }

    open func getKingdomIdentifier() -> KingdomIdentifier! {
        return KingdomIdentifier.fromUtopiaKingdomIdentifier(_province.getKingdomIdentifier())
    }

    open func getDeployedArmies() -> Array<DeployedArmy> {
        var deployedArmies : Array<DeployedArmy> = Array<DeployedArmy>()

        let javaDeployedArmies : JavaUtilList = _province.getDeployedArmies()

        for i : Int in 0 ..< Int(javaDeployedArmies.size()) {
            let utopiaDeployedArmy : ComSoftwareverdeUtopiaProvince_DeployedArmy = javaDeployedArmies.getWith(Int32(i)) as! ComSoftwareverdeUtopiaProvince_DeployedArmy
            deployedArmies.append(DeployedArmy.fromUtopiaDeployedArmy(utopiaDeployedArmy))
        }

        return deployedArmies;
    }
}
