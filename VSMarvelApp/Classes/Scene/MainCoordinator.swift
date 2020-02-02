
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
        navController?.navigate(to: listViewController(), using: DSNavigationType.push)
    }

    func listViewController() -> ListViewController {
        let vm = CharactersCollectionViewModel(type: CharactersCollectionViewModel.ViewModelType.list,
                                               router: self)
        let vc = ListViewController(viewModel: vm)
        return vc
    }

    func gridViewController() -> GridViewController {
        let vm = CharactersCollectionViewModel(type: CharactersCollectionViewModel.ViewModelType.grid,
                                               router: self)
        let vc = GridViewController(viewModel: vm)
        return vc
    }

    func switchToList() {
        navController?.navigate(to: listViewController(),
                                using: DSNavigationType.replace)
    }

    func switchToGrid() {
        navController?.navigate(to: gridViewController(),
                                using: DSNavigationType.replace)
    }

    func goToDetail(_ vm: CharacterViewModel) {
        let coord = DetailCoordinator(navController: navController,
                                      viewModel: vm)
        coord.start()
    }
}
