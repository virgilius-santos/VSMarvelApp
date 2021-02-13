
@testable import VSMarvelApp
import XCTest

final class AppCoordinatorTests: XCTestCase {
    func testRetainCycle() {
        XCTAssertNotRetainCycle {
            makeSut().sut
        }
    }

    func testStartCalled() {
        let (sut, spy) = makeSut()
        sut.start()
        XCTAssertNotNil(spy.viewController)
        XCTAssertEqual(spy.type, DSNavigationType.push)
    }
}

extension AppCoordinatorTests {
    typealias Sut = AppCoordinator
    typealias Fields = DSNavigationControllerSpy

    func makeSut() -> (sut: Sut, fields: Fields) {
        let spy = DSNavigationControllerSpy()

        let sut: Sut = .init(navController: spy)

        return (sut, spy)
    }
}
