
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

    var dummyCharsCVM: CharactersCollectionViewModel {
        .init(type: CharactersCollectionViewModel.ViewModelType.list)
    }

    override func setUp() {
        nav = .init()
        sut = .init(navController: nav)
        sut.start()
    }

    override func tearDown() {
        nav = nil
        sut = nil
    }

    func testNavigationMustBeSeted() {
        XCTAssertNotNil(sut?.navController)
    }

    func testListViewControllerMustBeStarted() {
        XCTAssert(nav?.viewController is CharactersCollectionViewController<ListViewCell>)
        XCTAssertEqual(nav?.type, DSNavigationType.push)
    }

    func testWhenGoToFromGridCalledDetailMustBeStarted() {
        let vc = nav?.viewController as! CharactersCollectionViewController<ListViewCell>
        vc.viewModel.goTo(dummyGridVM)
        XCTAssert(nav?.viewController is DetailViewController)
        XCTAssertEqual(nav?.type, DSNavigationType.push)
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.title, "a")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.description, "b")
        XCTAssertEqual((nav?.viewController as? DetailViewController)?.viewModel.path, "arte.jpg")
    }

    func testWhenSwitchToListCalledGridMustBeStarted() {
        let vm = (nav!.viewController as! CharactersCollectionViewController<ListViewCell>)
            .viewModel as! CharactersCollectionViewModel
        vm.switchToGrid!(dummyCharsCVM)
        XCTAssert(nav?.viewController is CharactersCollectionViewController<GridViewCell>)
        XCTAssertEqual(nav?.type, DSNavigationType.replace)
    }

    func testWhenSwitchToGridCalledListMustBeStarted() {
        let vm = (nav!.viewController as! CharactersCollectionViewController<ListViewCell>)
            .viewModel as! CharactersCollectionViewModel
        vm.switchToList!(dummyCharsCVM)
        XCTAssert(nav?.viewController is CharactersCollectionViewController<ListViewCell>)
        XCTAssertEqual(nav?.type, DSNavigationType.replace)
    }
}
