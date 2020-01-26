
import Foundation
import VService
import RxSwift
import VCore

protocol CharactersRepositoryProtocol {
    func getCharacters(id: Int?, next: Bool, name: String?) -> Single<[Character]>
}

extension CharactersRepositoryProtocol {
    func getCharacters(next: Bool = false, name: String? = nil) -> Single<[Character]> {
        self.getCharacters(id: nil, next: next, name: name)
    }
}

final class CharactersRepository: CharactersRepositoryProtocol {
    
    typealias DataReceived = MarvelAPI.Response.DataReceived
    
    let api = MarvelAPI()
    
    var dataReceived = DataReceived(offset: 0,
                                    limit: 0,
                                    total: 0,
                                    count: 0,
                                    results: [])
    
    var orderBy: MarvelAPI.QueryKeys {
        MarvelAPI.QueryKeys.orderBy(type: MarvelAPI.OrderType.name(ascendent: true))
    }
    
    func getCharacters(id: Int?, next: Bool, name: String?) -> Single<[Character]> {
        
        let queries: [MarvelAPI.QueryKeys]
            
        do {
            queries = try getQueries(next: next, name: name)
        } catch {
            logger.error("\(error)")
            return Single<[Character]>.just([])
        }
        
        return Single<MarvelAPI.Response.DataReceived>
            .create { (single) -> Disposable in
                
                self.api.getCharacters(id: id, queries: queries)
                { result in
                    
                    switch result {
                        case let .success(data):
                            single(.success(data))
                        case let .failure(error):
                            single(.error(error))
                    }
                }
                
                return Disposables.create {
                    self.api.session.cancel()
                }
        }
        .do(onSuccess: { [weak self] data in self?.dataReceived = data })
        .map { data in data.results.map { Character($0) }}
    }
    
    func getQueries(next: Bool, name: String?) throws -> [MarvelAPI.QueryKeys] {
        var queries = [MarvelAPI.QueryKeys]()
        
        queries.append(orderBy)
        
        if let name = name {
            queries.append(MarvelAPI.QueryKeys.nameStartsWith(string: name))
        }
        
        if next {
            let offset = dataReceived.offset + dataReceived.limit
            if offset < dataReceived.total {
                queries.append(MarvelAPI.QueryKeys.offset(index: offset))
            }
            else {
                throw RepositoryError.noDataToRequest
            }
        }
        
        return queries
    }
    
    enum RepositoryError: Error {
        case noDataToRequest
    }
}
