
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
        XCTAssertEqual(sut.detailView.imageView.image, DSImage.image10.image)
        XCTAssertEqual(sut.detailView.imageView.heroID, DSImage.image10.name)
    }
    
    let vmMock = DetailViewModel(title: "Spider-Man",
                                 description: "Teste",
                                 asset: DSImage.image10)

}
