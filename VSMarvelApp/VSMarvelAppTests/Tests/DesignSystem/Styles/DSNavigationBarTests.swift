//
//  DSNavigationBarStyleTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

@testable import VSMarvelApp
import XCTest

final class DSNavigationBarStyleTests: XCTestCase {
    func testApplyStyle() {
        let vc = UIViewController()
        let nav: UINavigationController = .init(rootViewController: vc)

        vc.apply(style: DSNavigationBarStyle.default)

        let navBar = nav.navigationBar
        XCTAssertEqual(navBar.barTintColor, Asset.Colors.primary.color)
        XCTAssertEqual(navBar.titleTextAttributes?[.foregroundColor] as? UIColor, Asset.Colors.text.color)
    }

    func testConfiguration() {
        let vc = UIViewController()
        let button = vc.configureRightButton(
            with: DSIcon.gridIcon.image
        )

        XCTAssertEqual(button.style, .plain)
        XCTAssertEqual(button.image, DSIcon.gridIcon.image)
    }
}
