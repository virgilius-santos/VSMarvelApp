
import Foundation
import VService

let cache: Cache<MarvelAPI.RequestData, [MarvelAPI.Character]> = {
    if let cacheReaded = (try? Cache<MarvelAPI.RequestData, [MarvelAPI.Character]>.readFromDisk(withName: "MarvelAPI")) {
        return cacheReaded
    }
    return .init()
}()

extension Cache {
    func save() {
        try? cache.saveToDisk(withName: "MarvelAPI")
    }
}
