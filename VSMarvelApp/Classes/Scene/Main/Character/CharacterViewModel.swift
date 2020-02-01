
import Foundation

struct CharacterViewModel: Equatable {
    var name: String { character.name }
    var path: String { "\(character.thumImage.path)/portrait_xlarge.\(character.thumImage.extension)" }
    var style: CharacterViewStyle { CharacterViewStyle.default }
    var bio: String { character.bio }

    let character: Character

    init(character: Character) {
        self.character = character
    }
}

extension CharacterViewModel {
    var asset: DSAsset { DSImage.placeholder }
}
