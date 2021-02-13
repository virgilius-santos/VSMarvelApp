
import Foundation

protocol MainFactory {
    func makeMain(
        navController: DSNavigationControllerProtocol?
    ) -> Coordinator
}

final class MainFactoryImpl: MainFactory {
    func makeMain(
        navController: DSNavigationControllerProtocol?
    ) -> Coordinator {
        MainCoordinator(
            navController: navController,
            viewControllerFactory: CharactersFactoryImpl(),
            coordinator: DetailFactoryImpl()
        )
    }
}
