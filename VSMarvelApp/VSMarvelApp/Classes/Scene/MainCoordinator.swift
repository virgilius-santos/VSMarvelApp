
import RxSwift
import UIKit
import VCore

final class MainCoordinator: Coordinator {
    weak var navController: DSNavigationControllerProtocol?
    let viewControllerFactory: CharactersFactory

    let switchAction: SwitchAction
    let goToDetail: GoToDetail

    convenience init(
        navController: DSNavigationControllerProtocol?,
        viewControllerFactory: CharactersFactory,
        coordinator: DetailFactory = .init()
    ) {
        self.init(
            navController: navController,
            viewControllerFactory: viewControllerFactory,
            switchAction: { [navController, viewControllerFactory] vm in
                let vc = viewControllerFactory.makeCharacters(viewModel: vm)
                navController?.navigate(to: vc, using: .replace)
            },
            goToDetail: { [navController] vm in
                let coord = coordinator.makeCoordinator(navController, vm)
                coord.start()
            }
        )
    }

    init(
        navController: DSNavigationControllerProtocol?,
        viewControllerFactory: CharactersFactory,
        switchAction: @escaping SwitchAction,
        goToDetail: @escaping GoToDetail
    ) {
        self.navController = navController
        self.viewControllerFactory = viewControllerFactory
        self.switchAction = switchAction
        self.goToDetail = goToDetail
    }

    func start() {
        let vc = viewControllerFactory.makeCharacters(
            switchAction: switchAction,
            goToDetail: goToDetail
        )

        navController?.navigate(to: vc, using: .push)
    }
}
