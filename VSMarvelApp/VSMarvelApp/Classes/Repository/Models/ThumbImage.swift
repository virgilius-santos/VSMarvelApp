
import Foundation

struct ThumbImage: Equatable {
    var path: String
}

extension ThumbImage {
    init(_ data: MarvelAPI.Thumbnail) {
        path = "\(data.path)/portrait_xlarge.\(data.extension)"
    }
}
