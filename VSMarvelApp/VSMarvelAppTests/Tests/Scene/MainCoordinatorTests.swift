
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

        XCTAssertEqual(fields.nav.viewControllers.first, fields.viewControllerFactory.viewControler2)
        XCTAssertNotNil(fields.viewControllerFactory.switchAction)
        XCTAssertNotNil(fields.viewControllerFactory.goToDetail)
        XCTAssertEqual(fields.nav.type, DSNavigationType.push)
    }

    func testWhenGoToFromGridCalledDetailMustBeStarted() throws {
        let (sut, fields) = makeSut()

        sut.start()
        fields.viewControllerFactory.goToDetail?(.dummy)

        let factory = fields.coordSpy
        XCTAssertEqual(factory.navControllers.first as? DSNavigationControllerSpy, fields.nav)
        XCTAssertEqual(factory.coordinatorSpy?.startCalled, true)
        XCTAssertEqual(factory.characterVM, .dummy)
    }

    func testWhenSwitchActionIsCalledViewControllerMustBeShowed() throws {
        let (sut, fields) = makeSut()

        sut.start()
        fields.viewControllerFactory.switchAction?(.dummy)

        XCTAssertEqual(fields.nav.viewControllers[1], fields.viewControllerFactory.viewControler3)
        XCTAssert(fields.viewControllerFactory.charactersCVM === CharactersCollectionViewModel.dummy)
        XCTAssertEqual(fields.nav.type, DSNavigationType.replace)
    }
}

extension MainCoordinatorTests {
    typealias Sut = MainCoordinator

    typealias Fields = (
        nav: DSNavigationControllerSpy,
        characterViewModel: CharacterViewModel,
        character: Character,
        viewControllerFactory: ViewControllerFactorySpy,
        coordSpy: CoordinatorFactorySpy
    )

    func makeSut(type _: CharactersCollectionViewModel.ViewModelType = .list) -> (sut: Sut, fields: Fields) {
        let character = Character.dummy
        let characterViewModel = CharacterViewModel.dummy
        let viewControllerFactory = ViewControllerFactorySpy()
        viewControllerFactory.viewControler2 = .init()
        viewControllerFactory.viewControler3 = .init()

        let nav: DSNavigationControllerSpy = .init()
        let coordSpy = CoordinatorFactorySpy()
        coordSpy.coordinatorSpy = .init()

        let sut: Sut = .init(
            navController: nav,
            viewControllerFactory: viewControllerFactory,
            coordinator: coordSpy
        )

        return (sut, (
            nav,
            characterViewModel,
            character,
            viewControllerFactory,
            coordSpy
        ))
    }
}
