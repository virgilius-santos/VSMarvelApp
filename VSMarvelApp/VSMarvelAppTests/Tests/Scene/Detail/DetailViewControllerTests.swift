
@testable import VSMarvelApp
import XCTest

final class DetailViewControllerTests: XCTestCase {
    func testSetData() {
        let (sut, fields) = makeSut()

        XCTAssertEqual(sut.title, fields.viewModel.title)
        XCTAssertEqual(sut.detailView.descriptionLabel.text, fields.viewModel.description)
        XCTAssertNotNil(sut.detailView.imageView.image)
        XCTAssertEqual(sut.detailView.imageView.heroID, fields.viewModel.path)
    }
}

extension DetailViewControllerTests {
    typealias Sut = DetailViewController
    typealias Fields = (
        viewModel: DetailViewModel,
        ()
    )

    func makeSut() -> (sut: Sut, fields: Fields) {
        let sut: Sut = .init(viewModel: .dummy)
        _ = sut.view

        return ( sut, (
            .dummy,
            ()
        ))
    }
}

extension DetailViewModel {
    static let dummy = DetailViewModel(
        title: "Spider-Man",
        description: "Teste",
        path: "arte"
    )
}
