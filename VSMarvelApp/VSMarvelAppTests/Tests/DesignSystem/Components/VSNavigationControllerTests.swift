
@testable import Hero
@testable import VSMarvelApp
import XCTest

class VSNavigationControllerTests: XCTestCase {
    var spy: UINavigationControllerSpy!
    var sut: DSNavigationController!

    override func setUp() {
        spy = UINavigationControllerSpy()
        sut = DSNavigationController(nav: spy)
    }

    override func tearDown() {
        sut = nil
        spy = nil
    }

    func testRetainCycle() {
        XCTAssertNotRetainCycle {
            DSNavigationController(nav: UINavigationControllerSpy())
        }
    }

    func testPushNavigation() {
        let vc = UIViewController()
        sut.navigate(to: vc, using: DSNavigationType.push)
        XCTAssertEqual(spy.viewController, vc)
        XCTAssertEqual(spy.animated, true)
    }

    func testPresentNavigation() {
        let vc = UIViewController()
        sut.navigate(to: vc, using: DSNavigationType.present)
        XCTAssertEqual(spy.viewControllerToPresent, vc)
        XCTAssertEqual(spy.flag, true)
    }

    func testReplacePresentNavigation() {
        let vc = UIViewController()
        sut.navigate(to: vc, using: DSNavigationType.replace)
        XCTAssertNotNil(spy.vsVC)
    }
}
