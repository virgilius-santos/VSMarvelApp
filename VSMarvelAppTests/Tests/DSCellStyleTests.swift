//
//  DSCellStyleTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import XCTest
@testable import VSMarvelApp

class DSCellStyleTests: XCTestCase {

    var sut: CellSpy!
    
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
        XCTAssertEqual(sut.dsLabel.backgroundColor, Asset.Colors.secondary.color)
        XCTAssertEqual(sut.dsLabel.alpha, 0.5)
    }
    
    class CellSpy: UICollectionViewCell, DSCellStyleable {
        var dsLabel: UILabel = .init()
        var dsImageView: UIImageView = .init()
    }
}
