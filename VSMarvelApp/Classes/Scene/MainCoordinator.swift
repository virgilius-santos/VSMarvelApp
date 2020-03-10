
import RxSwift
import UIKit
import VCore

typealias GridViewController = CharactersCollectionViewController<GridViewCell>
typealias ListViewController = CharactersCollectionViewController<ListViewCell>

final class MainCoordinator {
    weak var navController: DSNavigationControllerProtocol?

    init(navController: DSNavigationControllerProtocol?) {
        self.navController = navController
    }

    deinit {
        logger.info("fuii", String(describing: Self.self))
    }

    func start() {
        let vm = CharactersCollectionViewModel(type: CharactersCollectionViewModel.ViewModelType.list)
        vm.switchToList = { [navController] vm in
            vm.viewModelType = .list
            navController?.navigate(to: ListViewController(viewModel: vm),
                                    using: DSNavigationType.replace)
        }
        vm.switchToGrid = { [navController] vm in
            vm.viewModelType = .grid
            navController?.navigate(to: GridViewController(viewModel: vm),
                                    using: DSNavigationType.replace)
        }
        vm.goToDetail = { [navController] vm in
            let coord = DetailCoordinator(navController: navController,
                                          viewModel: vm)
            coord.start()
        }

        let vc = ListViewController(viewModel: vm)
        navController?.navigate(to: vc, using: DSNavigationType.push)
    }
}
