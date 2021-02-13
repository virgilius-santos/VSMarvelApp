
import UIKit

final class AppFactory {
    typealias CoordinatorFunction = (
        _ window: UIWindow?
    ) -> Coordinator

    var makeCoordinator: CoordinatorFunction

    init(makeCoordinator: @escaping CoordinatorFunction) {
        self.makeCoordinator = makeCoordinator
    }

    convenience init() {
        self.init(makeCoordinator: {
            AppCoordinator(window: $0)
        })
    }
}
