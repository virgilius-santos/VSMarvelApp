//
//  DSWindowStyleTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

@testable import VCore
@testable import VSMarvelApp
import XCTest

class DSWindowStyleTests: XCTestCase {
    func testApplyStyle() {
        let sut: UIWindow = .init()

        sut.apply(style: DSWindowStyle.default)

        XCTAssertEqual(sut.tintColor, Asset.Colors.text.color)
        XCTAssertEqual(sut.backgroundColor, Asset.Colors.secondary.color)
    }
}
