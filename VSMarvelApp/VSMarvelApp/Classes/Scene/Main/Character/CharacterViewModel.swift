
import Foundation

struct CharacterViewModel: Equatable {
    var name: String { character.name }
    var path: String { character.thumImage.path }
    var bio: String { character.bio }
    var asset: DSAsset { DSImage.placeholder }

    let character: Character
    let label: String
    let style: CharacterViewStyle

    init(
        character: Character,
        label: String,
        style: CharacterViewStyle
    ) {
        self.character = character
        self.label = label
        self.style = style
    }
}
