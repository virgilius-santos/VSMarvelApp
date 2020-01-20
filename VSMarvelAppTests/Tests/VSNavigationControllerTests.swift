//
//  VSNavigationControllerTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import XCTest
@testable import VSMarvelApp

class UINavigationControllerSpy: UINavigationController {
    
    var viewController: UIViewController?
    var animated: Bool?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.viewController = viewController
        self.animated = animated
    }
}

class VSNavigationControllerTests: XCTestCase {

    var spy: UINavigationControllerSpy!
    var sut: VSNavigationController!
    
    override func setUp() {
        spy = UINavigationControllerSpy()
        sut = VSNavigationController(nav: spy)
    }

    override func tearDown() {
        sut = nil
        spy = nil
    }

    func testCommonNavigation() {
        let vc = UIViewController()
        sut.navigate(to: vc)
        XCTAssertEqual(spy.viewController, vc)
        XCTAssertEqual(spy.animated, true)
    }
}
