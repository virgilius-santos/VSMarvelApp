
import Foundation
import VCore

final class DetailCoordinator: Coordinator {
    private weak var navController: DSNavigationControllerProtocol?
    private let viewModel: CharacterViewModel

    @Inject private var detailFactory: DetailFactory

    init(
        navController: DSNavigationControllerProtocol?,
        viewModel: CharacterViewModel
    ) {
        self.navController = navController
        self.viewModel = viewModel
    }

    func start() {
        let vc = detailFactory.makeViewController(self, viewModel)
        navController?.navigate(to: vc, using: DSNavigationType.push)
    }
}
