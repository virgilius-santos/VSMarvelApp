
import Foundation
import RxSwift
import VCore
import VService

typealias CharacterData = [Character]

protocol CharactersRepositoryProtocol {
    func getCharacters(id: Int?, number: Int, name: String?) -> Single<CharacterData>
}

extension CharactersRepositoryProtocol {
    func getCharacters(number: Int, name: String?) -> Single<CharacterData> {
        getCharacters(id: nil, number: number, name: name)
    }
}

final class CharactersRepository: CharactersRepositoryProtocol {
    typealias DataReceived = MarvelAPI.DataReceived

    enum RepositoryError: Error {
        case noDataToRequest
    }

    let api = MarvelAPI()

    var dataReceived = DataReceived(
        offset: 0,
        limit: 20,
        total: 1000,
        count: 0,
        results: []
    )

    var orderBy: MarvelAPI.QueryKeys {
        MarvelAPI.QueryKeys.orderBy(type: MarvelAPI.OrderType.name(ascendent: true))
    }

    func getCharacters(id: Int?, number: Int, name: String?) -> Single<CharacterData> {
        let queries: [MarvelAPI.QueryKeys]

        do {
            queries = try getQueries(number: number, name: name)
        } catch {
            logger.error("\(error)")
            return Single<CharacterData>.error(error)
        }

        let request = MarvelAPI.RequestData(id: id, queries: queries)

        if let characters = cache.value(forKey: request) {
            return .just(characters.map { Character($0) })
        }

        return Single<MarvelAPI.DataReceived>
            .create { (single) -> Disposable in

                self.api.getCharacters(requestData: request) { result in

                    switch result {
                    case let .success(data):
                        cache.insert(data.results, forKey: request)
                        single(.success(data))
                    case let .failure(error):
                        single(.failure(error))
                    }
                }

                return Disposables.create {
                    self.api.session.cancel()
                }
            }
            .do(onSuccess: { [weak self] data in self?.dataReceived = data })
            .map { data in data.results.map { Character($0) } }
    }

    func getQueries(number: Int, name: String?) throws -> [MarvelAPI.QueryKeys] {
        var queries = [MarvelAPI.QueryKeys]()

        queries.append(orderBy)

        if let name = name {
            queries.append(MarvelAPI.QueryKeys.nameStartsWith(string: name))
        }

        let offset = number
        if offset < dataReceived.total {
            queries.append(MarvelAPI.QueryKeys.offset(index: offset))
        } else {
            throw RepositoryError.noDataToRequest
        }

        return queries
    }
}
