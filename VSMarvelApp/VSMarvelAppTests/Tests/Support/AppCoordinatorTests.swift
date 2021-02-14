
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

        let root = fields.spy.rootViewController as? UINavigationController
        let navigation = factory.navControllers.first as? DSNavigationController
        XCTAssertEqual(root, navigation?.nav)
        XCTAssertEqual(factory.coordinatorSpies.first?.startCalled, true)
    }
}

extension AppCoordinatorTests {
    typealias Sut = AppCoordinator
    typealias Fields = (
        spy: UIWindow,
        factory: FactorySpy
    )

    func makeSut() -> (sut: Sut, fields: Fields) {
        let spy = UIWindow()
        let factory = FactorySpy()

        let sut: Sut = .init(window: spy)

        return (sut, (spy, factory))
    }
}
