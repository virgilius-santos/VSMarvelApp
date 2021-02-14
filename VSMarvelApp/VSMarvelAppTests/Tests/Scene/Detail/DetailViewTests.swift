
@testable import VSMarvelApp
import XCTest

class DetailViewTests: XCTestCase {
    func testRetainCycle() {
        XCTAssertNotRetainCycle {
            makeSut().sut
        }
    }

    func testViewModelSeted() {
        let (sut, vm) = makeSut()
        XCTAssertEqual(sut.descriptionLabel.text, vm.description)
        XCTAssertNotNil(sut.imageView.image)
        XCTAssertEqual(sut.imageView.heroID, vm.path)
    }
}

extension DetailViewTests {
    typealias Sut = DetailView
    typealias Fields = DetailViewModel

    func makeSut() -> (sut: Sut, fields: Fields) {
        let sut: Sut = .init()
        sut.setup(viewModel: .dummy)

        return ( sut, .dummy)
    }
}
