
import Foundation

struct ThumbImage {
    var path: String
    let `extension`: String
}

extension ThumbImage {
    
    init( _ data: MarvelAPI.Thumbnail) {
        self.path = data.path
        self.extension = data.extension
    }
}
