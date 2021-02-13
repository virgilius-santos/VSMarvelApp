
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
        let factory = fields.coordFactorySpy

        sut.start()
        XCTAssertEqual(factory.navControllers.first as? DSNavigationControllerSpy, fields.spy)
        XCTAssertEqual(factory.coordinatorSpy?.startCalled, true)
    }
}

extension AppCoordinatorTests {
    typealias Sut = AppCoordinator
    typealias Fields = (
        spy: DSNavigationControllerSpy,
        coordFactorySpy: CoordinatorFactorySpy
    )

    func makeSut() -> (sut: Sut, fields: Fields) {
        let spy = DSNavigationControllerSpy()
        let coordFactorySpy = CoordinatorFactorySpy()
        coordFactorySpy.coordinatorSpy = .init()

        let sut: Sut = .init(navController: spy, coordinator: coordFactorySpy)

        return (sut, (spy, coordFactorySpy))
    }
}
