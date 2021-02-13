
import Foundation

protocol AppFactory {
    func makeApp(navController: DSNavigationControllerProtocol?) -> Coordinator
}

final class AppFactoryImpl: AppFactory {
    func makeApp(navController: DSNavigationControllerProtocol?) -> Coordinator {
        AppCoordinator(navController: navController)
    }
}
