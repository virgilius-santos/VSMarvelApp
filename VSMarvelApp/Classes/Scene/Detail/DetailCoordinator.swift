
import Foundation

final class DetailCoordinator {
    weak var navController: DSNavigationControllerProtocol?
    let viewModel: DetailViewModel
    
    init(navController: DSNavigationControllerProtocol?,
         viewModel: DetailViewModel) {
        
        self.navController = navController
        self.viewModel = viewModel
    }
    
    func start() {
        let vc = DetailViewController(viewModel: viewModel)
        self.navController?.navigate(to: vc, using: DSNavigationType.push)
    }
}
