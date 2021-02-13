
@testable import VSMarvelApp
import XCTest

final class AppCoordinatorTests: XCTestCase {
    func testRetainCycle() {
        XCTAssertNotRetainCycle {
            makeSut().sut
        }
    }

    func testStartCalled() {
        let (sut, fields) = makeSut()
        let factory = fields.factory

        sut.start()
        XCTAssertEqual(factory.navControllers.first as? DSNavigationControllerSpy, fields.spy)
        XCTAssertEqual(factory.coordinatorSpies.first?.startCalled, true)
    }
}

extension AppCoordinatorTests {
    typealias Sut = AppCoordinator
    typealias Fields = (
        spy: DSNavigationControllerSpy,
        factory: FactorySpy
    )

    func makeSut() -> (sut: Sut, fields: Fields) {
        let spy = DSNavigationControllerSpy()
        let factory = FactorySpy()

        let sut: Sut = .init(navController: spy)

        return (sut, (spy, factory))
    }
}
