//
//  VSCollectionViewControllerTests.swift
//  VSMarvelAppTests
//
//  Created by Virgilius Santos on 24/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import XCTest
@testable import VSMarvelApp
@testable import CollectionKit

class VSCollectionViewControllerTests: XCTestCase {
    
    var nav: UINavigationController!
    var sut: DSCollectionViewController!
    
    override func setUp() {
        sut = .init()
        nav = .init(rootViewController: sut)
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testProviderSet() {
        let provider = SimpleViewProvider()
        XCTAssertNil(sut.collectionView.provider)
        sut.provider = provider
        XCTAssertNotNil(sut.collectionView.provider)
    }
    
    func testInputSearchBarText() {
        var text: String?
        
        let expectation = self.expectation(description: "searchBarText")
        sut.searchBarText = { args in
            text = args.text
            expectation.fulfill()
        }
        
        let sc = UISearchController()
        sc.searchBar.text = "TExt"
        sut.updateSearchResults(for: sc)
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(text, "TExt")
    }
    
    func test () {
        if let navBar = sut.navigationController?.navigationBar {
            XCTAssertEqual(navBar.barTintColor, DSColor.primary.uiColor)
            XCTAssertEqual(navBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor, DSColor.text.uiColor)
        } else {
            XCTFail("must have a navigationController")
        }
    }
}
