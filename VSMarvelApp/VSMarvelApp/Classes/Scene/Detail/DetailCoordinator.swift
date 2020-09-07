
import Foundation
import VCore

final class DetailCoordinator {
    weak var navController: DSNavigationControllerProtocol?
    let viewModel: CharacterViewModel

    init(navController: DSNavigationControllerProtocol?,
         viewModel: CharacterViewModel)
    {
        self.navController = navController
        self.viewModel = viewModel
    }

    deinit {
        logger.info("fui...")
    }

    func start() {
        var detail = DetailViewModel(title: viewModel.name,
                                     description: viewModel.bio,
                                     path: viewModel.path)
        detail.router = self
        let vc = DetailViewController(viewModel: detail)
        navController?.navigate(to: vc, using: DSNavigationType.push)
    }
}
