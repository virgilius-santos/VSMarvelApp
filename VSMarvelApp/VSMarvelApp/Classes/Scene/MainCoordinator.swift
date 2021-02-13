
import RxSwift
import UIKit
import VCore

final class MainCoordinator: Coordinator {
    weak var navController: DSNavigationControllerProtocol?
    let viewControllerFactory: ViewControllerFactory

    let switchAction: SwitchAction
    let goToDetail: GoToDetail

    convenience init(
        navController: DSNavigationControllerProtocol?,
        viewControllerFactory: ViewControllerFactory,
        coordinator: CoordinatorFactory
    ) {
        self.init(
            navController: navController,
            viewControllerFactory: viewControllerFactory,
            switchAction: { [navController, viewControllerFactory] vm in
                let vc = viewControllerFactory.makeCharactersViewController(viewModel: vm)
                navController?.navigate(to: vc, using: .replace)
            },
            goToDetail: { [navController] vm in
                let coord = coordinator.makeDetail(
                    navController: navController,
                    viewModel: vm
                )
                coord.start()
            }
        )
    }

    init(
        navController: DSNavigationControllerProtocol?,
        viewControllerFactory: ViewControllerFactory,
        switchAction: @escaping SwitchAction,
        goToDetail: @escaping GoToDetail
    ) {
        self.navController = navController
        self.viewControllerFactory = viewControllerFactory
        self.switchAction = switchAction
        self.goToDetail = goToDetail
    }

    func start() {
        let vc = viewControllerFactory.makeCharactersViewController(
            switchAction: switchAction,
            goToDetail: goToDetail
        )

        navController?.navigate(to: vc, using: .push)
    }
}
