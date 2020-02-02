
import RxSwift
import UIKit
import VCore

typealias GridViewController = CharactersCollectionViewController<GridViewCell>
typealias ListViewController = CharactersCollectionViewController<ListViewCell>

final class MainCoordinator: CharactersRouter {
    weak var navController: DSNavigationControllerProtocol?

    init(navController: DSNavigationControllerProtocol?) {
        self.navController = navController
    }

    deinit {
        logger.info("fuii", String(describing: Self.self))
    }

    func start() {
        let vm = CharactersCollectionViewModel(type: CharactersCollectionViewModel.ViewModelType.list,
                                               router: self)
        let vc = ListViewController(viewModel: vm)
        navController?.navigate(to: vc, using: DSNavigationType.push)
    }

    func switchToList(_ vm: CharactersCollectionViewModel) {
        vm.viewModelType = .list
        navController?.navigate(to: ListViewController(viewModel: vm),
                                using: DSNavigationType.replace)
    }

    func switchToGrid(_ vm: CharactersCollectionViewModel) {
        vm.viewModelType = .grid
        navController?.navigate(to: GridViewController(viewModel: vm),
                                using: DSNavigationType.replace)
    }

    func goToDetail(_ vm: CharacterViewModel) {
        let coord = DetailCoordinator(navController: navController,
                                      viewModel: vm)
        coord.start()
    }
}
