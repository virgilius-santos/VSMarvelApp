
@testable import VSMarvelApp
import XCTest

class DetailCoordinatorTests: XCTestCase {
    func testRetainCycle() {
        XCTAssertNotRetainCycle {
            makeSut().sut
        }
    }

    func testNavigationMustBeSeted() {
        let (sut, fields) = makeSut()

        sut.start()

        XCTAssertEqual(sut.navController as? DSNavigationControllerSpy, fields.nav)
    }

    func testDetailViewControllerMustBeStarted() {
        let (sut, fields) = makeSut()

        sut.start()

        XCTAssertEqual(fields.nav.viewControllers.first, fields.factory.viewControllers.first)
        XCTAssert(sut === fields.factory.routers.first)
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

    func makeSut(type _: CharactersCollectionViewModel.ViewModelType = .list) -> (sut: Sut, fields: Fields) {
        let nav: DSNavigationControllerSpy = .init()
        let factory = FactorySpy()

        let sut: Sut = .init(
            navController: nav,
            viewModel: .dummy,
            viewControllerFactory: factory
        )

        return (sut, (
            nav,
            .dummy,
            factory
        ))
    }
}
