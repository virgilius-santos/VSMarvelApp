//
//  MarvelAPI.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 25/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import RxSwift
import VCore
import VService

final class MarvelAPI {
    static let baseURL = "https://gateway.marvel.com:443/v1/public"

    let session: VSessionProtocol

    let charactersResponse: ((Data) throws -> MarvelAPI.DataReceived) = {
        let response = try MarvelAPI.Response.decode(data: $0)
        return response.data
    }

    init(session: VSessionProtocol? = nil) {
        self.session = session ?? VSession(config: VConfiguration.default)
    }

    func getCharacters(
        requestData: RequestData,
        completion: @escaping ((Result<DataReceived, VSessionError>) -> Void)
    ) {
        let request = requestData.request
        let responseData = charactersResponse
        logger.info(String(describing: request.url))

        session.request(
            resquest: request,
            response: responseData,
            errorHandler: nil
        ) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    enum OrderType {
        case name(ascendent: Bool)
        case modified(ascendent: Bool)

        var value: String {
            switch self {
            case let .name(ascendent) where !ascendent:
                return "-name"
            case let .modified(ascendent) where ascendent:
                return "modified"
            case let .modified(ascendent) where !ascendent:
                return "-modified"
            default:
                return "name"
            }
        }
    }

    struct QueryKeys: Codable, Hashable {
        static func nameStartsWith(string: String) -> QueryKeys {
            .init(key: "nameStartsWith", value: string)
        }

        static func orderBy(type: OrderType) -> QueryKeys {
            .init(key: "orderBy", value: type.value)
        }

        static func offset(index: Int) -> QueryKeys {
            .init(key: "offset", value: "\(index)")
        }

        let key: String
        let value: String

        var tupleValue: (key: String, value: String) {
            (key, value)
        }
    }

    struct RequestData: Codable, Hashable {
        var request: VRequestData {
            let keys = queries
                .map { (queryKeys) -> (key: String, value: String) in queryKeys.tupleValue }

            return VRequestData(
                urlString: urlString,
                queryParameters: keys + [
                    ("apikey", apikey),
                    ("ts", ts),
                    ("hash", hash)
                ],
                paths: paths
            )
        }

        let urlString: String
        let apikey: String
        let ts: String
        let hash: String
        let paths: [String]
        let queries: [QueryKeys]

        init(id: Int?, queries: [QueryKeys]) {
            urlString = MarvelAPI.baseURL
            apikey = ApiKeys.marvelApiKey
            ts = ApiKeys.ts
            hash = ApiKeys.hash
            if let id = id {
                paths = ["characters", "\(id)"]
            } else {
                paths = ["characters"]
            }
            self.queries = queries
        }
    }

    struct Response: Codable {
        let data: DataReceived
    }

    struct DataReceived: Codable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        var results: [MarvelAPI.Character]
    }

    struct Character: Codable {
        let id: Int
        let name: String
        let description: String
        let thumbnail: Thumbnail
    }

    struct Thumbnail: Codable {
        let path: String
        let `extension`: String
    }
}
