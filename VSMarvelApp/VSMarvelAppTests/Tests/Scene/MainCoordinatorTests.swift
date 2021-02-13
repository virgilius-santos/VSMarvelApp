
@testable import VSMarvelApp
import XCTest

class MainCoordinatorTests: XCTestCase {
    func testRetainCycle() {
        XCTAssertNotRetainCycle {
            makeSut().sut
        }
    }

    func testNavigationMustBeSeted() {
        let (sut, _) = makeSut()

        sut.start()

        XCTAssertNotNil(sut.navController)
    }

    func testListViewControllerMustBeStarted() {
        let (sut, fields) = makeSut()

        sut.start()

        XCTAssertEqual(fields.nav.viewControllers.first, fields.factory.viewControllers.first)
        XCTAssertNotNil(fields.factory.switchActions.first)
        XCTAssertNotNil(fields.factory.goToDetails.first)
        XCTAssertEqual(fields.nav.type, DSNavigationType.push)
    }

    func testWhenGoToFromGridCalledDetailMustBeStarted() throws {
        let (sut, fields) = makeSut()

        sut.start()
        fields.factory.goToDetails.first?(.dummy)

        let factory = fields.factory
        XCTAssertEqual(factory.navControllers.first as? DSNavigationControllerSpy, fields.nav)
        XCTAssertEqual(factory.coordinatorSpies.first?.startCalled, true)
        XCTAssertEqual(factory.characterVMs.first, .dummy)
    }

    func testWhenSwitchActionIsCalledViewControllerMustBeShowed() throws {
        let (sut, fields) = makeSut()

        sut.start()
        fields.factory.switchActions.first?(.dummy)

        XCTAssertEqual(fields.nav.viewControllers[1], fields.factory.viewControllers[1])
        XCTAssert(fields.factory.charactersCVMs.first === CharactersCollectionViewModel.dummy)
        XCTAssertEqual(fields.nav.type, DSNavigationType.replace)
    }
}

extension MainCoordinatorTests {
    typealias Sut = MainCoordinator

    typealias Fields = (
        nav: DSNavigationControllerSpy,
        characterViewModel: CharacterViewModel,
        character: Character,
        factory: FactorySpy
    )

    func makeSut(type _: CharactersCollectionViewModel.ViewModelType = .list) -> (sut: Sut, fields: Fields) {
        let character = Character.dummy
        let characterViewModel = CharacterViewModel.dummy

        let nav: DSNavigationControllerSpy = .init()
        let factory = FactorySpy()

        let sut: Sut = .init(
            navController: nav,
            viewControllerFactory: factory
        )

        return (sut, (
            nav,
            characterViewModel,
            character,
            factory
        ))
    }
}
