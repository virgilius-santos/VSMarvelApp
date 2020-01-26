

import Foundation

struct Character {
    let id: Int
    let name: String
    let bio: String
    let thumImage: ThumbImage
}

extension Character {
    
    init(_ data: MarvelAPI.Character) {
        self.id = data.id
        self.name = data.name
        self.bio = data.description
        self.thumImage = ThumbImage(data.thumbnail)
    }
}
