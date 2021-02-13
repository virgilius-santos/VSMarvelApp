
import UIKit

protocol CharactersFactory {
    func makeCharacters(
        switchAction: @escaping SwitchAction,
        goToDetail: @escaping GoToDetail
    ) -> UIViewController

    func makeCharacters(
        viewModel: CharactersCollectionViewModel
    ) -> UIViewController
}

final class CharactersFactoryImpl: CharactersFactory {
    func makeCharacters(
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

    func makeCharacters(
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
