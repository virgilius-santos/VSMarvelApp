
@testable import VSMarvelApp
import XCTest

final class DetailViewControllerTests: XCTestCase {
    func testRetainCycle() {
        XCTAssertNotRetainCycle {
            makeSut().sut
        }
    }

    func testSetData() {
        let (sut, viewModel) = makeSut()

        XCTAssertEqual(sut.title, viewModel.title)
        XCTAssertEqual(sut.detailView.descriptionLabel.text, viewModel.description)
        XCTAssertNotNil(sut.detailView.imageView.image)
        XCTAssertEqual(sut.detailView.imageView.heroID, viewModel.path)
    }
}

extension DetailViewControllerTests {
    typealias Sut = DetailViewController
    typealias Fields = DetailViewModel

    func makeSut() -> (sut: Sut, fields: Fields) {
        let sut: Sut = .init(viewModel: .dummy)
        _ = sut.view

        return ( sut, .dummy)
    }
}
