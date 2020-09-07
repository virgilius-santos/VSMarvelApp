
@testable import VSMarvelApp
import XCTest

class MainCoordinatorTests: XCTestCase {
    func testNavigationMustBeSeted() {
        let (sut, _) = makeSut()
        XCTAssertNotNil(sut.navController)
    }

    func testListViewControllerMustBeStarted() {
        let (_, fields) = makeSut()
        XCTAssert(fields.nav.viewController is ListViewController)
        XCTAssertEqual(fields.nav.type, DSNavigationType.push)
    }

    func testWhenGoToFromGridCalledDetailMustBeStarted() throws {
        let (_, fields) = makeSut()

        let listVC = try XCTUnwrap(fields.nav.viewController as? ListViewController)
        listVC.viewModel.goTo(fields.characterViewModel)

        XCTAssertEqual(fields.nav.type, DSNavigationType.push)

        let detailVC = try XCTUnwrap(fields.nav.viewController as? DetailViewController)
        XCTAssertEqual(detailVC.viewModel.title, fields.character.name)
        XCTAssertEqual(detailVC.viewModel.description, fields.character.bio)
        XCTAssertEqual(detailVC.viewModel.path, fields.character.thumImage.path)
    }

    func testWhenSwitchToListCalledGridMustBeStarted() throws {
        let (_, fields) = makeSut()

        let listVC = try XCTUnwrap(fields.nav.viewController as? ListViewController)
        let viewModel = try XCTUnwrap(listVC.viewModel as? CharactersCollectionViewModel)
        viewModel.switchAction?(viewModel)

        XCTAssert(fields.nav.viewController is GridViewController)
        XCTAssertEqual(fields.nav.type, DSNavigationType.replace)
    }

    func testWhenSwitchToGridCalledListMustBeStarted() throws {
        let (_, fields) = makeSut()

        let listVC = try XCTUnwrap(fields.nav.viewController as? ListViewController)
        let viewModel = try XCTUnwrap(listVC.viewModel as? CharactersCollectionViewModel)
        viewModel.switchAction?(viewModel)
        viewModel.switchAction?(viewModel)

        XCTAssert(fields.nav.viewController is ListViewController)
        XCTAssertEqual(fields.nav.type, DSNavigationType.replace)
    }
}

extension MainCoordinatorTests {
    typealias Sut = MainCoordinator

    typealias Fields = (
        nav: DSNavigationControllerSpy,
        characterViewModel: CharacterViewModel,
        character: Character
    )

    func makeSut(type _: CharactersCollectionViewModel.ViewModelType = .list) -> (sut: Sut, fields: Fields) {
        let characterMock = Character(
            id: 0,
            name: "a",
            bio: "b",
            thumImage: ThumbImage(path: "arte.jpg")
        )

        let characterViewModel = CharacterViewModel(character: characterMock)

        let nav: DSNavigationControllerSpy = .init()
        let sut: Sut = .init(navController: nav)
        sut.start()

        return (sut, (
            nav,
            characterViewModel,
            characterMock
        ))
    }
}
