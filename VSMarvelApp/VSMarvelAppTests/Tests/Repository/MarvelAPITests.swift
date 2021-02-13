
@testable import VService
@testable import VSMarvelApp
import XCTest

class MarvelAPITests: XCTestCase {
    var sut: MarvelAPI!

    override func setUp() {
        sut = .init()
    }

    override func tearDown() {
        sut = nil
    }

    func test_getCharactersRequestData_withId() {
        let request = MarvelAPI.RequestData(
            id: 999,
            queries: [
                .nameStartsWith(string: "nome"),
                .offset(index: 80),
                .orderBy(type: MarvelAPI.OrderType.name(ascendent: false))
            ]
        )
            .request
        XCTAssertEqual(request.urlString, "https://gateway.marvel.com:443/v1/public")
        XCTAssertEqual(request.paths[0], "characters")
        XCTAssertEqual(request.paths[1], "999")
        XCTAssertEqual(request.queryParameters?[0].key, "nameStartsWith")
        XCTAssertEqual(request.queryParameters?[0].value, "nome")
        XCTAssertEqual(request.queryParameters?[1].key, "offset")
        XCTAssertEqual(request.queryParameters?[1].value, "80")
        XCTAssertEqual(request.queryParameters?[2].key, "orderBy")
        XCTAssertEqual(request.queryParameters?[2].value, "-name")
        XCTAssertEqual(request.queryParameters?[3].key, "apikey")
        XCTAssertEqual(request.queryParameters?[4].key, "ts")
        XCTAssertEqual(request.queryParameters?[5].key, "hash")
    }

    func test_getCharactersRequestData_withoutId() {
        let request = MarvelAPI.RequestData(
            id: nil,
            queries: [
                .nameStartsWith(string: "nome"),
                .offset(index: 80),
                .orderBy(type: .name(ascendent: false)),
                .orderBy(type: .name(ascendent: true)),
                .orderBy(type: .modified(ascendent: false)),
                .orderBy(type: .modified(ascendent: true))
            ]
        )
            .request
        XCTAssertEqual(request.urlString, "https://gateway.marvel.com:443/v1/public")
        XCTAssertEqual(request.paths[0], "characters")
        XCTAssertEqual(request.queryParameters?[0].key, "nameStartsWith")
        XCTAssertEqual(request.queryParameters?[0].value, "nome")
        XCTAssertEqual(request.queryParameters?[1].key, "offset")
        XCTAssertEqual(request.queryParameters?[1].value, "80")
        XCTAssertEqual(request.queryParameters?[2].key, "orderBy")
        XCTAssertEqual(request.queryParameters?[2].value, "-name")
        XCTAssertEqual(request.queryParameters?[3].key, "orderBy")
        XCTAssertEqual(request.queryParameters?[3].value, "name")
        XCTAssertEqual(request.queryParameters?[4].key, "orderBy")
        XCTAssertEqual(request.queryParameters?[4].value, "-modified")
        XCTAssertEqual(request.queryParameters?[5].key, "orderBy")
        XCTAssertEqual(request.queryParameters?[5].value, "modified")
        XCTAssertEqual(request.queryParameters?[6].key, "apikey")
        XCTAssertEqual(request.queryParameters?[7].key, "ts")
        XCTAssertEqual(request.queryParameters?[8].key, "hash")
    }

    func test_decode_verifyContract() {
        if let path = Bundle(for: Self.self).path(forResource: "Characters", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let resp = try sut.charactersResponse(data)
                XCTAssertEqual(resp.results[0].id, 1_009_144)
            } catch {
                XCTFail(String(describing: error))
            }
        } else {
            XCTFail("file not found")
        }
    }

    func test_request_infoPassed() {
        let session = SesionMock()
        sut = .init(session: session)

        let request = MarvelAPI.RequestData(id: nil, queries: [])
        sut.getCharacters(requestData: request) { _ in }

        XCTAssertNotNil(session.resquestSpy)
        XCTAssertNotNil(session.responseSpy)
        XCTAssertNil(session.errorHandlerSpy)
        XCTAssertNotNil(session.completionSpy)
    }

    func test_request_resultError() throws {
        let session = SesionMock()
        sut = .init(session: session)
        var resultData: Result<MarvelAPI.DataReceived, VSessionError>?

        let request = MarvelAPI.RequestData(id: nil, queries: [])
        let exp = expectation(description: "request")
        sut.getCharacters(requestData: request) { result in
                resultData = result
                exp.fulfill()
        }

        XCTAssertNotNil(session.resquestSpy)
        XCTAssertNotNil(session.responseSpy)
        XCTAssertNil(session.errorHandlerSpy)
        XCTAssertNotNil(session.completionSpy)

        let err = VSessionError(.generic)
        let completion = try XCTUnwrap(session.completionSpy as? ((Result<MarvelAPI.DataReceived, VSessionError>) -> Void))
        completion(.failure(err))

        waitForExpectations(timeout: 5, handler: nil)

        if case let .failure(error) = resultData {
            XCTAssertEqual(error.errorType, err.errorType)
        } else {
            XCTFail("deveria apresentar um erro")
        }
    }

    func test_request_resultSuccess() throws {
        let session = SesionMock()
        sut = .init(session: session)
        var resultData: Result<MarvelAPI.DataReceived, VSessionError>?

        let request = MarvelAPI.RequestData(id: nil, queries: [])
        let exp = expectation(description: "request")
        sut.getCharacters(requestData: request) { result in
                resultData = result
                exp.fulfill()
        }

        XCTAssertNotNil(session.resquestSpy)
        XCTAssertNotNil(session.responseSpy)
        XCTAssertNil(session.errorHandlerSpy)
        XCTAssertNotNil(session.completionSpy)

        let data = MarvelAPI.DataReceived(
            offset: 10,
            limit: 20,
            total: 30,
            count: 40,
            results: []
        )

        let completion = try XCTUnwrap(session.completionSpy as? ((Result<MarvelAPI.DataReceived, VSessionError>) -> Void))
        completion(.success(data))

        waitForExpectations(timeout: 5, handler: nil)

        if case let .success(dataReceived) = resultData {
            XCTAssertEqual(data.count, dataReceived.count)
            XCTAssertEqual(data.limit, dataReceived.limit)
            XCTAssertEqual(data.offset, dataReceived.offset)
            XCTAssertEqual(data.results.isEmpty, dataReceived.results.isEmpty)
            XCTAssertEqual(data.total, dataReceived.total)
        } else {
            XCTFail("deveria apresentar um sucesso")
        }
    }
}

extension MarvelAPITests {
    class SesionMock: VSessionProtocol {
        var cancelSpy: Bool?
        var resquestSpy: VRequestData?
        var responseSpy: Any?
        var errorHandlerSpy: CustomErrorHandler?
        var completionSpy: Any?

        var sessionError: VSessionError?
        var dataReceived: MarvelAPI.DataReceived?

        func request<DataReceived>(resquest requestData: VRequestData,
                                   response responseData: @escaping ((Data) throws -> DataReceived),
                                   errorHandler: CustomErrorHandler?,
                                   completion: ((Result<DataReceived, VSessionError>) -> Void)?)
        {
            resquestSpy = requestData
            responseSpy = responseData
            errorHandlerSpy = errorHandler
            completionSpy = completion
        }

        func cancel() {
            cancelSpy = true
        }
    }
}
