//
//  DSWindowStyleTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import XCTest
@testable import VSMarvelApp
@testable import VCore

class DSWindowStyleTests: XCTestCase {

    var sut: WindowStyleSpy!
    
    override func setUp() {
        sut = .init()
    }

    override func tearDown() {
        sut = nil
    }

    func testApplyStyle() {
        sut.apply(style: DSWindowStyle.default)
        
        XCTAssertEqual(sut.window?.tintColor, Asset.Colors.text.color)
        XCTAssertEqual(sut.window?.backgroundColor, Asset.Colors.secondary.color)
    }

    class WindowStyleSpy: NSObject, UIApplicationDelegate, WindowStyleProtocol {
        var window: UIWindow? = .init(frame: .zero)
    }
}
