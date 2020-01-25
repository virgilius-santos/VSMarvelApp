
import UIKit

final class MainCoordinator {
    
    weak var navController: DSNavigationControllerProtocol?
    
    init(navController: DSNavigationControllerProtocol?) {
        self.navController = navController
    }
    
    func start() {
        let vc = ListViewController(viewModel: ListViewModel(title: "Character", router: self))
        navController?.navigate(to: vc, using: DSNavigationType.push)
    }
}

extension MainCoordinator: GridRouter {
    func grid_goTo(_ vm: DetailViewModel) {
        let coord = DetailCoordinator(navController: navController, viewModel: vm)
        coord.start()
    }
    
    func grid_switchToList() {
        let vc = ListViewController(viewModel: ListViewModel(title: "Character", router: self))
        navController?.navigate(to: vc, using: DSNavigationType.replace)
    }
}

extension MainCoordinator: ListRouter {
    func list_goTo(_ vm: DetailViewModel) {
        let coord = DetailCoordinator(navController: navController, viewModel: vm)
        coord.start()
    }
    
    func list_switchToGrid() {
        let vc = GridViewController(viewModel: GridViewModel(title: "Character", router: self))
        navController?.navigate(to: vc, using: DSNavigationType.replace)
    }
}
