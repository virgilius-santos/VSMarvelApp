
import Foundation
import VCore

final class DetailCoordinator: Coordinator {
    weak var navController: DSNavigationControllerProtocol?
    let viewModel: CharacterViewModel
    let viewControllerFactory: ViewControllerFactory

    init(
        navController: DSNavigationControllerProtocol?,
        viewModel: CharacterViewModel,
        viewControllerFactory: ViewControllerFactory
    ) {
        self.navController = navController
        self.viewModel = viewModel
        self.viewControllerFactory = viewControllerFactory
    }

    func start() {
        let vc = viewControllerFactory.makeDetailViewController(
            viewModel: viewModel,
            router: self
        )
        navController?.navigate(to: vc, using: DSNavigationType.push)
    }
}
