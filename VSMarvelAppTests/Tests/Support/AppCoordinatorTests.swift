
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import XCTest
@testable import VSMarvelApp

class DSNavigationControllerSpy: DSNavigationControllerProtocol {

    var viewController: UIViewController?
    var type: DSNavigationType?
    
    func navigate(to viewController: UIViewController, using type: DSNavigationType) {
        self.viewController = viewController
        self.type = type
    }
}

class AppCoordinatorTests: XCTestCase {

    var sut: AppCoordinator!
    var spy: DSNavigationControllerSpy!
    
    override func setUp() {
        spy = DSNavigationControllerSpy()
        sut = AppCoordinator(navController: spy)
    }

    override func tearDown() {
        sut = nil
        spy = nil
    }

    func testStartCalled() {
        sut.start()
        XCTAssertNotNil(spy.viewController)
        XCTAssertEqual(spy.type, DSNavigationType.push)
    }
}
