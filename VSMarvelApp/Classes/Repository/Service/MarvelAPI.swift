//
//  MarvelAPI.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 25/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import VService
import RxSwift
import VCore

final class MarvelAPI {
    
    static let baseURL = "https://gateway.marvel.com:443/v1/public"
    
    let session: VSession
    
    let charactersResponse: ((Data) throws -> MarvelAPI.Response.DataReceived) = {
        let response = try MarvelAPI.Response.decode(data: $0)
        return response.data
    }
    
    init(session: VSession? = nil) {
        self.session = session ?? VSession(config: VConfiguration.default)
    }
    
    func getCharacters(
        id: Int?,
        queries: [QueryKeys],
        completion: @escaping((Result<Response.DataReceived, VSessionError>)->())
        ) {
        
        let requestData = self.getCharactersRequestData(id: id, queries: queries)
        let responseData = self.charactersResponse
        logger.info(String(describing: requestData.url))
        
        self.session.request(resquest: requestData, response: responseData) { (result) in
            switch result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
    
    func getCharactersRequestData(id: Int?, queries: [QueryKeys]) -> VRequestData {
        
        let keys = queries
            .map { (queryKeys) -> (key: String, value: String) in queryKeys.value }
        
        let path: [Any] = (id == nil) ? ["characters"] : ["characters", id ?? 0]
        
        return VRequestData(
            urlString: MarvelAPI.baseURL,
            queryParameters: keys + [
                ("apikey", ApiKeys.marvelApiKey),
                ("ts", ApiKeys.ts),
                ("hash", ApiKeys.hash),
            ],
            paths: path
        )
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
    
    enum QueryKeys {
        case nameStartsWith(string: String)
        case orderBy(type: OrderType)
        case offset(index: Int)
        
        var value: (key: String, value: String) {
            switch self {
                case let .nameStartsWith(string):
                    return (key: "nameStartsWith", value: string)
                case let .orderBy(type):
                    return (key: "orderBy", value: type.value)
                case let .offset(index):
                    return (key: "offset", value: "\(index)")
            }
        }
    }
    
    struct Response: Decodable {
        struct DataReceived: Decodable {
            let offset: Int
            let limit: Int
            let total: Int
            let count: Int
            var results: [MarvelAPI.Character]
        }
        let data: DataReceived
    }
    
    struct Character: Decodable {
        let id: Int
        let name: String
        let description: String
        let thumbnail: Thumbnail
    }
    
    struct Thumbnail: Decodable {
        let path: String
        let `extension`: String
    }
}
