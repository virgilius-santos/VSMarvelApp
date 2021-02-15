
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

    func testRetainCycle() {
        XCTAssertNotRetainCycle {
            DSCollectionViewController()
        }
    }

    func testProviderSet() {
        let provider = SimpleViewProvider()
        XCTAssertNil(sut.collectionView.provider)
        sut.provider = provider
        XCTAssertNotNil(sut.collectionView.provider)
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
