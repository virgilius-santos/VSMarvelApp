
import XCTest
@testable import VSMarvelApp

class DetailViewTests: XCTestCase {

    var sut: DetailView!
    
    override func setUp() {
        sut = .init()
        let vm = DetailViewModel(title: "um", description: "dois", path: "arte")
        sut.setup(viewModel: vm)
    }

    override func tearDown() {
        sut = nil
    }

    func testViewModelSeted() {
        XCTAssertEqual(sut.descriptionLabel.text, "dois")
        XCTAssertNotNil(sut.imageView.image)
        XCTAssertEqual(sut.imageView.heroID, "arte")
    }
}
