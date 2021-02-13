
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
        XCTAssertEqual(sut.navController as? DSNavigationControllerSpy, fields.nav)
    }

    func testDetailViewControllerMustBeStarted() {
        let (_, fields) = makeSut()
        XCTAssert(fields.nav.viewController is DetailViewController)
        XCTAssertEqual(fields.nav.type, DSNavigationType.push)
    }
}

extension DetailCoordinatorTests {
    typealias Sut = DetailCoordinator

    typealias Fields = (
        nav: DSNavigationControllerSpy,
        characterViewModel: CharacterViewModel
    )

    func makeSut(type _: CharactersCollectionViewModel.ViewModelType = .list) -> (sut: Sut, fields: Fields) {
        let nav: DSNavigationControllerSpy = .init()
        let sut: Sut = .init(
            navController: nav,
            viewModel: .dummy
        )
        sut.start()

        return (sut, (
            nav,
            .dummy
        ))
    }
}
