
import Foundation
import VCore

final class DetailCoordinator: Coordinator {
    weak var navController: DSNavigationControllerProtocol?
    let viewModel: CharacterViewModel
    let viewControllerFactory: DetailFactory

    init(
        navController: DSNavigationControllerProtocol?,
        viewModel: CharacterViewModel,
        viewControllerFactory: DetailFactory
    ) {
        self.navController = navController
        self.viewModel = viewModel
        self.viewControllerFactory = viewControllerFactory
    }

    func start() {
        let vc = viewControllerFactory.makeDetail(
            viewModel: viewModel,
            router: self
        )
        navController?.navigate(to: vc, using: DSNavigationType.push)
    }
}
