

import Foundation

struct Character {
    let id: Int
    let name: String
    let bio: String
    let thumImage: ThumbImage
}

extension Character {
    init(_ data: MarvelAPI.Character) {
        id = data.id
        name = data.name
        bio = data.description
        thumImage = ThumbImage(data.thumbnail)
    }
}
