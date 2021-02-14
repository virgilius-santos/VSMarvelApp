
import RxSwift
import UIKit
import VCore

final class MainCoordinator: Coordinator {
    private weak var navController: DSNavigationControllerProtocol?

    @Inject private var charactersFactory: CharactersFactory

    private let switchAction: SwitchAction
    private let goToDetail: GoToDetail

    init(
        navController: DSNavigationControllerProtocol?,
        switchAction: @escaping SwitchAction,
        goToDetail: @escaping GoToDetail
    ) {
        self.navController = navController
        self.switchAction = switchAction
        self.goToDetail = goToDetail
    }

    convenience init(navController: DSNavigationControllerProtocol?) {
        self.init(
            navController: navController,
            switchAction: { [navController] vm in
                let vc = appContainer.resolve(CharactersFactory.self).rebuildViewController(vm)
                navController?.navigate(to: vc, using: .replace)
            },
            goToDetail: { [navController] vm in
                let coord = appContainer.resolve(DetailFactory.self).makeCoordinator(navController, vm)
                coord.start()
            }
        )
    }

    func start() {
        let vc = charactersFactory.makeViewController(switchAction, goToDetail)
        navController?.navigate(to: vc, using: .push)
    }
}
