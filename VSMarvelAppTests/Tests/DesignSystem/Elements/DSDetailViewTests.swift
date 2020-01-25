//
//  DSDetailViewTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 24/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import XCTest
@testable import VSMarvelApp

class DSDetailViewTests: XCTestCase {

    var sut: DSDetailView!
    
    override func setUp() {
        sut = .init()
        let vm = DetailViewModel(title: "um", description: "dois", asset: DSImage.image1)
        sut.setup(viewModel: vm)
    }

    override func tearDown() {
        sut = nil
    }

    func testViewModelSeted() {
        XCTAssertEqual(sut.descriptionLabel.text, "dois")
        XCTAssertEqual(sut.imageView.image, DSImage.image1.image)
        XCTAssertEqual(sut.imageView.heroID, DSImage.image1.name)
    }
}
