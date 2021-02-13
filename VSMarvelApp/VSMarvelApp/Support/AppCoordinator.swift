
import UIKit

final class AppCoordinator: Coordinator {
    weak var navController: DSNavigationControllerProtocol?
    let coordinator: MainFactory

    init(
        navController: DSNavigationControllerProtocol?,
        coordinator: MainFactory
    ) {
        self.navController = navController
        self.coordinator = coordinator
    }

    func start() {
        let coord = coordinator.makeMain(
            navController: navController
        )
        coord.start()
    }
}
