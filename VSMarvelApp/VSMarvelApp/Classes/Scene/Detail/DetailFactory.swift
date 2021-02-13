
import UIKit

protocol DetailFactory {
    func makeDetail(
        navController: DSNavigationControllerProtocol?,
        viewModel: CharacterViewModel
    ) -> Coordinator

    func makeDetail(
        viewModel: CharacterViewModel,
        router: DetailCoordinator
    ) -> UIViewController
}

final class DetailFactoryImpl: DetailFactory {
    func makeDetail(
        navController: DSNavigationControllerProtocol?,
        viewModel: CharacterViewModel
    ) -> Coordinator {
        DetailCoordinator(
            navController: navController,
            viewModel: viewModel,
            viewControllerFactory: self
        )
    }

    func makeDetail(
        viewModel: CharacterViewModel,
        router: DetailCoordinator
    ) -> UIViewController {
        var detail = DetailViewModel(title: viewModel.name,
                                     description: viewModel.bio,
                                     path: viewModel.path)
        detail.router = router
        let vc = DetailViewController(viewModel: detail)
        return vc
    }
}
