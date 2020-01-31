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
    var appDelegate: AppDelegate!
    var sut: UIWindow!

    override func setUp() {
        appDelegate = .init()
        sut = .init()
    }

    override func tearDown() {
        sut = nil
        appDelegate = nil
    }

    func testApplyStyle() {
        appDelegate.applyWindow(style: DSWindowStyle.default, in: sut)

        XCTAssertEqual(sut.tintColor, Asset.Colors.text.color)
        XCTAssertEqual(sut.backgroundColor, Asset.Colors.secondary.color)
    }

    class AppDelegate: NSObject, UIApplicationDelegate, WindowStyleable {
        var window: UIWindow? = .init(frame: .zero)
    }
}
