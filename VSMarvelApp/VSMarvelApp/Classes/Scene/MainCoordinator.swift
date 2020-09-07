
import RxSwift
import UIKit
import VCore

final class MainCoordinator {
    weak var navController: DSNavigationControllerProtocol?

    init(navController: DSNavigationControllerProtocol?) {
        self.navController = navController
    }

    deinit {
        logger.info("fuii", String(describing: Self.self))
    }

    func start() {
        let vm = CharactersCollectionViewModel(
            type: CharactersCollectionViewModel.ViewModelType.list
        )

        vm.switchAction = { [navController] vm in

            let vc: UIViewController
            switch vm.viewModelType {
            case .list:
                vm.viewModelType = .grid
                vc = GridViewController(viewModel: vm)
            default:
                vm.viewModelType = .list
                vc = ListViewController(viewModel: vm)
            }

            navController?.navigate(to: vc, using: .replace)
        }

        vm.goToDetail = { [navController] vm in
            let coord = DetailCoordinator(
                navController: navController,
                viewModel: vm
            )
            coord.start()
        }

        navController?.navigate(
            to: ListViewController(viewModel: vm),
            using: .push
        )
    }
}
