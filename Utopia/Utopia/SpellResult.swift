
import Foundation

open class SpellResult {
    open static func fromUtopiaSpellResultBundle(_ spellResultBundle : ComSoftwareverdeUtopiaBundleSpellResultBundle) -> SpellResult {
        return SpellResult(spellResultBundle: spellResultBundle)
    }

    fileprivate let _spellResultBundle : ComSoftwareverdeUtopiaBundleSpellResultBundle

    fileprivate init(spellResultBundle : ComSoftwareverdeUtopiaBundleSpellResultBundle) {
        _spellResultBundle = spellResultBundle
    }

    open func getResultText() -> String {
        return _spellResultBundle.getWith(ComSoftwareverdeUtopiaBundleSpellResultBundle_Keys_RESULT_TEXT)
    }
}
