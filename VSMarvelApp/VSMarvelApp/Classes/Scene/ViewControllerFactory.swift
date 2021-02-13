
import UIKit

protocol ViewControllerFactory {
    func makeDetailViewController(
        viewModel: CharacterViewModel,
        router: DetailCoordinator
    ) -> UIViewController

    func makeCharactersViewController(
        switchAction: @escaping SwitchAction,
        goToDetail: @escaping GoToDetail
    ) -> UIViewController

    func makeCharactersViewController(
        viewModel: CharactersCollectionViewModel
    ) -> UIViewController
}

final class ViewControllerFactoryImpl: ViewControllerFactory {
    func makeDetailViewController(
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

    func makeCharactersViewController(
        switchAction: @escaping SwitchAction,
        goToDetail: @escaping GoToDetail
    ) -> UIViewController {
        let vm = CharactersCollectionViewModel(
            type: CharactersCollectionViewModel.ViewModelType.list
        )

        vm.switchAction = switchAction

        vm.goToDetail = goToDetail

        return ListViewController(viewModel: vm)
    }

    func makeCharactersViewController(
        viewModel: CharactersCollectionViewModel
    ) -> UIViewController {
        let vc: UIViewController
        switch viewModel.viewModelType {
        case .list:
            viewModel.viewModelType = .grid
            vc = GridViewController(viewModel: viewModel)
        default:
            viewModel.viewModelType = .list
            vc = ListViewController(viewModel: viewModel)
        }
        return vc
    }
}
