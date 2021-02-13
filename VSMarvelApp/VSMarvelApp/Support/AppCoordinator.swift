import UIKit

final class AppCoordinator: Coordinator {
    var navController: DSNavigationControllerProtocol
    @Inject private var mainFactory: MainFactory

    init(window: UIWindow?) {
        let nav = UINavigationController()
        window?.rootViewController = nav
        navController = DSNavigationController(nav: nav)
    }

    func start() {
        let coord = mainFactory.makeCoordinator(navController)
        coord.start()
    }
}
