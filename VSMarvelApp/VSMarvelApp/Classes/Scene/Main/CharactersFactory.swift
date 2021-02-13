
import UIKit

final class CharactersFactory {
    typealias RebuildViewControllerFunction = (
        _ viewModel: CharactersCollectionViewModel
    ) -> UIViewController

    typealias ViewControllerFunction = (
        _ switchAction: @escaping SwitchAction,
        _ goToDetail: @escaping GoToDetail
    ) -> UIViewController

    var rebuildViewController: RebuildViewControllerFunction
    var makeViewController: ViewControllerFunction

    init(
        rebuildViewController: @escaping RebuildViewControllerFunction,
        makeViewController: @escaping ViewControllerFunction
    ) {
        self.rebuildViewController = rebuildViewController
        self.makeViewController = makeViewController
    }

    convenience init() {
        self.init(
            rebuildViewController: { viewModel in
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
            },
            makeViewController: { switchAction, goToDetail in
                let vm = CharactersCollectionViewModel(
                    type: CharactersCollectionViewModel.ViewModelType.list
                )

                vm.switchAction = switchAction

                vm.goToDetail = goToDetail

                return ListViewController(viewModel: vm)
            }
        )
    }
}
