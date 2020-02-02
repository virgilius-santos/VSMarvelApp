
@testable import VSMarvelApp
import XCTest

class MainCoordinatorTests: XCTestCase {
    var nav: DSNavigationControllerSpy!
    var sut: MainCoordinator!

    var dummyGridVM: CharacterViewModel {
        .init(character: characterMock)
    }

    var characterMock: Character {
        .init(id: 0,
              name: "a",
              bio: "b",
              thumImage: ThumbImage(path: "arte.jpg"))
    }

    override func setUp() {
        nav = .init()
        sut = .init(navController: nav)
    }

    override func tearDown() {
        nav = nil
        sut = nil
    }

    func testNavigationMustBeSeted() {
        XCTAssertNotNil(sut?.navController)
    }

    func testListViewControllerMustBeStarted() {
        sut.start()
        XCTAssert(nav?.viewController is CharactersCollectionViewController<ListViewCell>)
        XCTAssertEqual(nav?.type, DSNavigationType.push)
    }

    func testWhenGoToFromGridCalledDetailMustBeStarted() {
        sut.goToDetail(dummyGridVM)
        XCTAssert(nav?.viewController is DetailViewController)
        XCTAssertEqual(nav?.type, DSNavigationType.push)
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.title, "a")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.description, "b")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.path, "arte.jpg")
    }

    func testWhenGoToFromListCalledDetailMustBeStarted() {
        sut.goToDetail(dummyGridVM)
        XCTAssert(nav?.viewController is DetailViewController)
        XCTAssertEqual(nav?.type, DSNavigationType.push)
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.title, "a")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.description, "b")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.path, "arte.jpg")
    }

    func testWhenSwitchToListCalledGridMustBeStarted() {
        sut.switchToGrid()
        XCTAssert(nav?.viewController is CharactersCollectionViewController<GridViewCell>)
        XCTAssertEqual(nav?.type, DSNavigationType.replace)
    }

    func testWhenSwitchToGridCalledListMustBeStarted() {
        sut.switchToList()
        XCTAssert(nav?.viewController is CharactersCollectionViewController<ListViewCell>)
        XCTAssertEqual(nav?.type, DSNavigationType.replace)
    }
}
