
@testable import VSMarvelApp
import XCTest

class ListViewCellTests: XCTestCase {
    var sut: ListViewCell!

    override func setUp() {
        sut = .init()
    }

    override func tearDown() {
        sut = nil
    }

    func testApplyStyle() {
        sut.apply(style: CharacterViewStyle.grid)

        XCTAssertEqual(sut.dsLabel.tintColor, Asset.Colors.text.color)
        XCTAssertEqual(sut.dsLabel.backgroundColor, Asset.Colors.secondary.color.withAlphaComponent(0.5))
    }

    func testAddCellSubViews() {
        sut.addCellSubViews()

        XCTAssertEqual(sut.dsImageView.superview, sut)
        XCTAssertEqual(sut.dsLabel.superview, sut)
    }
}
