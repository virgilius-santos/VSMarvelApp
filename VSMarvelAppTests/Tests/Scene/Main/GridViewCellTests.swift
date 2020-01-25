
import XCTest
@testable import VSMarvelApp

class GridViewCellTests: XCTestCase {

    var sut: GridViewCell!
    
    override func setUp() {
        sut = .init()
    }

    override func tearDown() {
        sut = nil
    }

    func testApplyStyle() {
        sut.apply(style: DSCellStyle.default)
        
        XCTAssertEqual(sut.layer.shadowColor, Asset.Colors.secondary.color.cgColor)
        XCTAssertEqual(sut.layer.shadowOpacity, 0)
        XCTAssertEqual(sut.layer.shadowOffset, .zero)
        XCTAssertEqual(sut.layer.shadowRadius, 16)
        
        XCTAssertEqual(sut.layer.cornerRadius, 8)
        
        XCTAssertEqual(sut.dsLabel.tintColor, Asset.Colors.text.color)
        XCTAssertEqual(sut.dsLabel.backgroundColor, Asset.Colors.secondary.color.withAlphaComponent(0.5))
    }
    
    func testAddCellSubViews() {
        sut.addCellSubViews()
        
        XCTAssertEqual(sut.dsImageView.superview, sut)
        XCTAssertEqual(sut.dsLabel.superview, sut)
    }
    
    class CollectionCellSpy: UICollectionViewCell, DSCellStyleable {
        var dsLabel: UILabel = .init()
        var dsImageView: UIImageView = .init()
    }
}
