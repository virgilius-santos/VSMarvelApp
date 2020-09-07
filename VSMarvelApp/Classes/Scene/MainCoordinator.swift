
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
        let vm = CharactersCollectionViewModel(
            type: CharactersCollectionViewModel.ViewModelType.list
        )

        vm.switchAction = switchToGrid

        vm.goToDetail = { [navController] vm in
            let coord = DetailCoordinator(
                navController: navController,
                viewModel: vm
            )
            coord.start()
        }

        navigateToList(vm, using: .push)
    }

    func switchToGrid(_ vm: CharactersCollectionViewModel) {
        vm.viewModelType = .grid
        vm.switchAction = switchToList
        navigateToGrid(vm)
    }

    func switchToList(_ vm: CharactersCollectionViewModel) {
        vm.viewModelType = .list
        vm.switchAction = switchToGrid
        navigateToList(vm)
    }

    func navigateToList(
        _ vm: CharactersCollectionViewModel,
        using method: DSNavigationType = .replace
    ) {
        navController?.navigate(
            to: ListViewController(viewModel: vm),
            using: method
        )
    }

    func navigateToGrid(
        _ vm: CharactersCollectionViewModel,
        using method: DSNavigationType = .replace
    ) {
        navController?.navigate(
            to: GridViewController(viewModel: vm),
            using: method
        )
    }
}
