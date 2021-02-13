
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

        XCTAssertEqual(fields.nav.viewControllers.first, fields.viewControllerFactory.viewControler1)
        XCTAssert(sut === fields.viewControllerFactory.router)
        XCTAssertEqual(.dummy, fields.viewControllerFactory.characterVM)
        XCTAssertEqual(fields.nav.type, DSNavigationType.push)
    }
}

extension DetailCoordinatorTests {
    typealias Sut = DetailCoordinator

    typealias Fields = (
        nav: DSNavigationControllerSpy,
        characterViewModel: CharacterViewModel,
        viewControllerFactory: ViewControllerFactorySpy
    )

    func makeSut(type _: CharactersCollectionViewModel.ViewModelType = .list) -> (sut: Sut, fields: Fields) {
        let nav: DSNavigationControllerSpy = .init()
        let viewControllerFactory = ViewControllerFactorySpy()
        viewControllerFactory.viewControler1 = .init()

        let sut: Sut = .init(
            navController: nav,
            viewModel: .dummy,
            viewControllerFactory: viewControllerFactory
        )

        return (sut, (
            nav,
            .dummy,
            viewControllerFactory
        ))
    }
}
