
@testable import CollectionKit
@testable import VSMarvelApp
import XCTest

class VSCollectionViewControllerTests: XCTestCase {
    var nav: UINavigationController!
    var sut: DSCollectionViewController!

    override func setUp() {
        sut = .init()
        nav = .init(rootViewController: sut)
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
    }

    func testProviderSet() {
        let provider = SimpleViewProvider()
        XCTAssertNil(sut.collectionView.provider)
        sut.provider = provider
        XCTAssertNotNil(sut.collectionView.provider)
    }

    func testInputSearchBarText() {
        var text: String?

        let expectation = self.expectation(description: "searchBarText")
        sut.searchBarText = { args in
            text = args.text
            XCTAssertEqual(text, "TExt")
            expectation.fulfill()
        }

        let searchBar = UISearchBar()
        searchBar.text = "TExt"
        sut.searchBarSearchButtonClicked(searchBar)
        wait(for: [expectation], timeout: 3)
    }

    func test() {
        if let navBar = sut.navigationController?.navigationBar {
            XCTAssertEqual(navBar.barTintColor, DSColor.primary.uiColor)
            XCTAssertEqual(navBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor, DSColor.text.uiColor)
        } else {
            XCTFail("must have a navigationController")
        }
    }
}
