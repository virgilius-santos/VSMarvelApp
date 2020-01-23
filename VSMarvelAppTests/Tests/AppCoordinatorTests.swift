//
//  AppCoordinatorTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import XCTest
@testable import VSMarvelApp

class VSNavigationControllerSpy: VSNavigationControllerProtocol {

    var viewController: UIViewController?
    var type: NavigationType?
    
    func navigate(to viewController: UIViewController, using type: NavigationType) {
        self.viewController = viewController
        self.type = type
    }
}

class AppCoordinatorTests: XCTestCase {

    var sut: AppCoordinator!
    var spy: VSNavigationControllerSpy!
    
    override func setUp() {
        spy = VSNavigationControllerSpy()
        sut = AppCoordinator(navController: spy)
    }

    override func tearDown() {
        sut = nil
        spy = nil
    }

    func testStartCalled() {
        sut.start()
        XCTAssertNotNil(spy.viewController)
        XCTAssertEqual(spy.type, NavigationType.push)
    }
}
