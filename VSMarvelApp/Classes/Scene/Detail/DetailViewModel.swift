
import Foundation

struct DetailViewModel {
    let title: String
    let description: String
    let path: String
    
    var router: DetailCoordinator? // could be a protocol
}
