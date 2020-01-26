
import XCTest
@testable import VSMarvelApp

class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    
    override func setUp() {
        sut = .init(viewModel: vmMock)
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
    }

    func testSetData() {
        XCTAssertEqual(sut.title, "Spider-Man")
        XCTAssertEqual(sut.detailView.descriptionLabel.text, "Teste")
        XCTAssertNotNil(sut.detailView.imageView.image)
        XCTAssertEqual(sut.detailView.imageView.heroID, "arte")
    }
    
    let vmMock = DetailViewModel(title: "Spider-Man",
                                 description: "Teste",
                                 path: "arte")

}
