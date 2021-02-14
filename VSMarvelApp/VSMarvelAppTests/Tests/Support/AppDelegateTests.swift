
@testable import Hero
@testable import VSMarvelApp
import XCTest

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
        XCTAssertEqual(sut.window?.rootViewController, ((sut.coordinator as? AppCoordinator)?.navController as? DSNavigationController)?.nav)
    }

    func testStyleMustBeApply() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

        XCTAssertEqual(sut.window?.tintColor, Asset.Colors.text.color)
        XCTAssertEqual(sut.window?.backgroundColor, Asset.Colors.secondary.color)
    }

    func testNavControllerMustBeStarted() {
        let factory = FactorySpy()
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssertNotNil(factory.windows[0])
        XCTAssertNotNil(factory.coordinatorSpies[0])
    }

    func testCoordinatorMustReceiveNavController() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssertEqual(sut.window?.rootViewController, ((sut.coordinator as? AppCoordinator)?.navController as? DSNavigationController)?.nav)
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
