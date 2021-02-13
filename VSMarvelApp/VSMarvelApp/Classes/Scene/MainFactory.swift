
import Foundation

final class MainFactory {
    typealias CoordinatorFunction = (
        _ navController: DSNavigationControllerProtocol?
    ) -> Coordinator

    var makeCoordinator: CoordinatorFunction

    init(makeCoordinator: @escaping CoordinatorFunction) {
        self.makeCoordinator = makeCoordinator
    }

    convenience init() {
        self.init(makeCoordinator: {
            MainCoordinator(navController: $0)
        })
    }
}
