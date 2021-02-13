
import UIKit

final class AppCoordinator: Coordinator {
    weak var navController: DSNavigationControllerProtocol?
    @Inject private var coordinator: MainFactory

    init(navController: DSNavigationControllerProtocol?) {
        self.navController = navController
    }

    func start() {
        let coord = coordinator.makeCoordinator(navController)
        coord.start()
    }
}
