
@testable import VSMarvelApp
import XCTest

class DetailCoordinatorTests: XCTestCase {
    func testRetainCycle() {
        XCTAssertNotRetainCycle {
            makeSut().sut
        }
    }

    func testDetailViewControllerMustBeStarted() {
        let (sut, fields) = makeSut()

        sut.start()

        XCTAssertEqual(fields.nav.viewControllers.first, fields.factory.viewControllers.first)
        XCTAssert(sut === fields.factory.routers.first as? DetailCoordinator)
        XCTAssertEqual(.dummy, fields.factory.characterVMs.first)
        XCTAssertEqual(fields.nav.type, DSNavigationType.push)
    }
}

extension DetailCoordinatorTests {
    typealias Sut = DetailCoordinator

    typealias Fields = (
        nav: DSNavigationControllerSpy,
        characterViewModel: CharacterViewModel,
        factory: FactorySpy
    )

    func makeSut() -> (sut: Sut, fields: Fields) {
        let nav: DSNavigationControllerSpy = .init()
        let factory = FactorySpy()

        appContainer.container.register(DetailFactory.self, factory: { _ in
            factory.detailFactory
        })

        let sut: Sut = .init(
            navController: nav,
            viewModel: .dummy
        )

        return (sut, (
            nav,
            .dummy,
            factory
        ))
    }
}
