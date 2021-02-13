
import UIKit

final class AppCoordinator: Coordinator {
    weak var navController: DSNavigationControllerProtocol?
    let coordinator: CoordinatorFactory

    init(
        navController: DSNavigationControllerProtocol?,
        coordinator: CoordinatorFactory
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
