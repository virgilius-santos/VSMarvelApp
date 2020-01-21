//
//  DSNavigationBarStyleTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import XCTest
@testable import VSMarvelApp

class DSNavigationBarStyleTests: XCTestCase {

    var nav: UINavigationController!
    var sut: ViewControllerSpy!
    
    override func setUp() {
        sut = .init()
        nav = .init(rootViewController: sut)
    }

    override func tearDown() {
        sut = nil
        nav = nil
    }

    func testApplyStyle() {
        sut.apply(style: DSNavigationBarStyle.default)
        
        let navBar = nav.navigationBar
        XCTAssertEqual(navBar.barTintColor, Asset.Colors.primary.color)
        XCTAssertEqual(navBar.titleTextAttributes?[.foregroundColor] as? UIColor, Asset.Colors.text.color)
    }

    func testConfiguration() {
        sut.configureRightButton(with: DSIcon.gridIcon.image,
                                 target: sut as Any,
                                 action: Selector(("tapAction")))
        _ = sut.view
        
        let button = sut.navigationItem.rightBarButtonItem
        XCTAssertEqual(button?.style, .plain)
        XCTAssertEqual(button?.image, DSIcon.gridIcon.image)
        
        _ = button?.target?.perform(button?.action, with: nil)
        XCTAssert(sut.tapped)
    }

    class ViewControllerSpy: UIViewController, DSNavigationBarStyleProtocol {
        
        var tapped = false
        @objc func tapAction() {
            tapped = true
        }
    }
}
