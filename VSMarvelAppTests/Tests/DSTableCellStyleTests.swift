//
//  DSCellStyleTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import XCTest
@testable import VSMarvelApp

class DSTableCellStyleTests: XCTestCase {

    var sut: DSCharacterListTableViewCell!
    
    override func setUp() {
        sut = .init()
    }

    override func tearDown() {
        sut = nil
    }

    func testApplyStyle() {
        sut.apply(style: DSCellStyle.default)
        
        XCTAssertEqual(sut.dsLabel.tintColor, Asset.Colors.text.color)
        XCTAssertEqual(sut.dsLabel.backgroundColor, Asset.Colors.secondary.color.withAlphaComponent(0.5))
    }
    
    func testAddCellSubViews() {
        sut.addCellSubViews()
        
        XCTAssertEqual(sut.dsImageView.superview, sut)
        XCTAssertEqual(sut.dsLabel.superview, sut)
    }
}
