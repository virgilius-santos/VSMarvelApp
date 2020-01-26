
import Foundation
import VService
import RxSwift

protocol CharactersRepositoryProtocol {
    func getCharacters(id: Int?, queries: [MarvelAPI.QueryKeys]) -> Single<[Character]>
}

extension CharactersRepositoryProtocol {
    func getCharacters(queries: [MarvelAPI.QueryKeys]) -> Single<[Character]> {
        self.getCharacters(id: nil, queries: queries)
    }
}

final class CharactersRepository: CharactersRepositoryProtocol {
    
    let api = MarvelAPI()
    
    func getCharacters(id: Int?, queries: [MarvelAPI.QueryKeys]) -> Single<[Character]> {
        
        return Single<[Character]>.create { (single) -> Disposable in
            
            self.api.getCharacters(id: id, queries: queries)
            { result in
                
                switch result {
                    case let .success(characters):
                        single(.success(characters.map { Character($0) }))
                    case let .failure(error):
                        single(.error(error))
                }
            }
            
            return Disposables.create {
                self.api.session.cancel()
            }
        }
    }
}
