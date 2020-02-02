
import Foundation

struct CharacterViewModel: Equatable {
    var name: String { character.name }
    var path: String { character.thumImage.path }
    var style: CharacterViewStyle { CharacterViewStyle.default }
    var bio: String { character.bio }
    var asset: DSAsset { DSImage.placeholder }

    let character: Character

    init(character: Character) {
        self.character = character
    }

    static func == (lhs: CharacterViewModel, rhs: CharacterViewModel) -> Bool {
        lhs.name.elementsEqual(rhs.name)
            && lhs.path.elementsEqual(rhs.path)
            && lhs.bio.elementsEqual(rhs.bio)
    }
}
