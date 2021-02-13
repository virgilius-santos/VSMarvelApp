
import UIKit

final class DetailFactory {
    typealias CoordinatorFunction = (
        _ navController: DSNavigationControllerProtocol?,
        _ viewModel: CharacterViewModel
    ) -> Coordinator

    typealias ViewControllerFunction = (
        _ router: Coordinator?,
        _ viewModel: CharacterViewModel
    ) -> UIViewController

    var makeCoordinator: CoordinatorFunction
    var makeViewController: ViewControllerFunction

    init(
        makeCoordinator: @escaping CoordinatorFunction,
        makeViewController: @escaping ViewControllerFunction
    ) {
        self.makeCoordinator = makeCoordinator
        self.makeViewController = makeViewController
    }

    convenience init() {
        self.init(
            makeCoordinator: {
                DetailCoordinator(navController: $0, viewModel: $1)
            },
            makeViewController: {
                var detail = DetailViewModel(title: $1.name,
                                             description: $1.bio,
                                             path: $1.path)
                detail.router = $0
                return DetailViewController(viewModel: detail)
            }
        )
    }
}
