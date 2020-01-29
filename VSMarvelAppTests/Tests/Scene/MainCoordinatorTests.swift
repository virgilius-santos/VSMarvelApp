
import XCTest
@testable import VSMarvelApp

class MainCoordinatorTests: XCTestCase {

    var nav: DSNavigationControllerSpy!
    var sut: MainCoordinator!
    
    var dummyGridVM: CharacterViewModel {
        return .init(character: characterMock)
    }
    
    var characterMock: Character {
        return .init(id: 0,
                     name: "a",
                     bio: "b",
                     thumImage: ThumbImage(path: "arte",
                                           extension: "jpg"))
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
        XCTAssert(nav?.viewController is CharactersViewController<ListViewCell>)
        XCTAssertEqual(nav?.type, DSNavigationType.push)
    }
    
    func testWhenGoToFromGridCalledDetailMustBeStarted() {
        sut.grid_goTo(dummyGridVM)
        XCTAssert(nav?.viewController is DetailViewController)
        XCTAssertEqual(nav?.type, DSNavigationType.push)
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.title, "a")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.description, "b")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.path, "arte/portrait_xlarge.jpg")
    }
    
    func testWhenGoToFromListCalledDetailMustBeStarted() {
        sut.list_goTo(dummyGridVM)
        XCTAssert(nav?.viewController is DetailViewController)
        XCTAssertEqual(nav?.type, DSNavigationType.push)
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.title, "a")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.description, "b")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.path, "arte/portrait_xlarge.jpg")
    }
    
    func testWhenSwitchToListCalledGridMustBeStarted() {
        sut.list_switchToGrid()
        XCTAssert(nav?.viewController is CharactersViewController<GridViewCell>)
        XCTAssertEqual(nav?.type, DSNavigationType.replace)
    }
    
    func testWhenSwitchToGridCalledListMustBeStarted() {
        sut.grid_switchToList()
        XCTAssert(nav?.viewController is CharactersViewController<ListViewCell>)
        XCTAssertEqual(nav?.type, DSNavigationType.replace)
    }
}
