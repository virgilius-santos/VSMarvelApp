
import XCTest
@testable import VSMarvelApp
@testable import Hero

class UINavigationControllerSpy: UINavigationController {
    
    var viewController: UIViewController?
    var animated: Bool?
    
    var viewControllerToPresent: UIViewController?
    var flag: Bool?
    
    var vsVC: UIViewController?
    
    override var visibleViewController: UIViewController? {
        get {
            vsVC = UIViewController()
            return vsVC
        }
        set { }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.viewController = viewController
        self.animated = animated
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.viewControllerToPresent = viewControllerToPresent
        self.flag = flag
    }
}

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
