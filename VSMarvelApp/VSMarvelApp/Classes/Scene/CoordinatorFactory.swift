

import Foundation

protocol Coordinator {
    func start()
}

protocol CoordinatorFactory {
    func makeApp(
        navController: DSNavigationControllerProtocol?
    ) -> Coordinator

    func makeMain(
        navController: DSNavigationControllerProtocol?
    ) -> Coordinator

    func makeDetail(
        navController: DSNavigationControllerProtocol?,
        viewModel: CharacterViewModel
    ) -> Coordinator
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
    func makeApp(
        navController: DSNavigationControllerProtocol?
    ) -> Coordinator {
        AppCoordinator(
            navController: navController,
            coordinator: CoordinatorFactoryImpl()
        )
    }

    func makeMain(
        navController: DSNavigationControllerProtocol?
    ) -> Coordinator {
        MainCoordinator(
            navController: navController,
            viewControllerFactory: ViewControllerFactoryImpl(),
            coordinator: CoordinatorFactoryImpl()
        )
    }

    func makeDetail(
        navController: DSNavigationControllerProtocol?,
        viewModel: CharacterViewModel
    ) -> Coordinator {
        DetailCoordinator(
            navController: navController,
            viewModel: viewModel,
            viewControllerFactory: ViewControllerFactoryImpl()
        )
    }
}
