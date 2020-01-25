
import XCTest
@testable import VSMarvelApp

class MainCoordinatorTests: XCTestCase {

    var nav: DSNavigationControllerSpy!
    var sut: MainCoordinator!
    
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
        let vm = DetailViewModel.init(title: "a", description: "b", asset: DSImage.image1)
        sut.grid_goTo(vm)
        XCTAssert(nav?.viewController is DetailViewController)
        XCTAssertEqual(nav?.type, DSNavigationType.push)
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.title, "a")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.description, "b")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.asset.name, DSImage.image1.name)
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.asset.image, DSImage.image1.image)
    }
    
    func testWhenGoToFromListCalledDetailMustBeStarted() {
        let vm = DetailViewModel.init(title: "a", description: "b", asset: DSImage.image1)
        sut.list_goTo(vm)
        XCTAssert(nav?.viewController is DetailViewController)
        XCTAssertEqual(nav?.type, DSNavigationType.push)
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.title, "a")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.description, "b")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.asset.name, DSImage.image1.name)
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.asset.image, DSImage.image1.image)
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
