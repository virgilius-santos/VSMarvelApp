//
//  AppDelegateTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 24/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import XCTest
@testable import VSMarvelApp
@testable import Hero

class AppDelegateTests: XCTestCase {
    
    var sut: AppDelegate!
    
    override func setUp() {
        sut = .init()
        
    }

    override func tearDown() {
        sut = nil
    }
    
    func testHeroBackgroundMustBeColored() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssertEqual(Hero.shared.containerColor, DSColor.secondary.uiColor)
    }
    
    func testWindowMustBeStartedAndReceiveNavigationController() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssertNotNil(sut.window)
        XCTAssertEqual(sut.window?.rootViewController, (sut.coordinator?.navController as? DSNavigationController)?.nav)
    }
    
    func testStyleMustBeApply() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        XCTAssertEqual(sut.window?.tintColor, Asset.Colors.text.color)
        XCTAssertEqual(sut.window?.backgroundColor, Asset.Colors.secondary.color)
    }
    
    func testNavControllerMustBeStarted() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssertNotNil(sut.navController)
    }
    
    func testCoordinatorMustReceiveNavController() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssertEqual(sut.navController?.nav, (sut.coordinator?.navController as? DSNavigationController)?.nav)
    }
    
    func testCoordinatorMustBeStarted() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssertNotNil(sut.coordinator)
    }

    func testApplicationShouldReturnTrue() {
        let result: Bool = sut.application(UIApplication.shared,
                                           didFinishLaunchingWithOptions: nil)
        
        XCTAssertTrue(result)
    }
}
