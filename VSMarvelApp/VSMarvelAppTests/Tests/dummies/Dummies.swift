
import UIKit
import VService
@testable import VSMarvelApp

final class DSNavigationControllerSpy: NSObject, DSNavigationControllerProtocol {
    var viewControllers: [UIViewController] = .init()
    var type: DSNavigationType?

    func navigate(to viewController: UIViewController, using type: DSNavigationType) {
        viewControllers.append(viewController)
        self.type = type
    }
}

extension CharactersCollectionViewModel {
    static let dummy = CharactersCollectionViewModel(type: .grid)
}

extension CharacterViewModel {
    static let dummy = CharacterViewModel(
        character: .dummy
    )
}

extension Character {
    static let dummy = Character(
        id: 0,
        name: "a",
        bio: "b",
        thumImage: ThumbImage(
            path: "arte.jpg"
        )
    )
}

extension DetailViewModel {
    static let dummy = DetailViewModel(
        title: "Spider-Man",
        description: "Teste",
        path: "arte"
    )
}

class SesionMock: VSessionProtocol {
    var cancelSpy: Bool?
    var resquestSpy: VRequestData?
    var responseSpy: Any?
    var errorHandlerSpy: CustomErrorHandler?
    var completionSpy: Any?

    var sessionError: VSessionError?
    var dataReceived: MarvelAPI.DataReceived?

    func request<DataReceived>(resquest requestData: VRequestData,
                               response responseData: @escaping ((Data) throws -> DataReceived),
                               errorHandler: CustomErrorHandler?,
                               completion: ((Result<DataReceived, VSessionError>) -> Void)?)
    {
        resquestSpy = requestData
        responseSpy = responseData
        errorHandlerSpy = errorHandler
        completionSpy = completion
    }

    func cancel() {
        cancelSpy = true
    }
}

class UINavigationControllerSpy: UINavigationController {
    var viewController: UIViewController?
    var animated: Bool?

    var viewControllerToPresent: UIViewController?
    var flag: Bool?

    var vsVC: UIViewController?

    override var visibleViewController: UIViewController? {
        get {
            vsVC = UIViewController()
            return vsVC
        }
        set {}
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.viewController = viewController
        self.animated = animated
    }

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion _: (() -> Void)? = nil) {
        self.viewControllerToPresent = viewControllerToPresent
        self.flag = flag
    }
}

final class ViewControllerFactorySpy: NSObject, ViewControllerFactory {
    var characterVM: CharacterViewModel?
    var charactersCVM: CharactersCollectionViewModel?
    var viewControler1: UIViewController?
    var viewControler2: UIViewController?
    var viewControler3: UIViewController?
    weak var router: DetailCoordinator?
    var switchAction: SwitchAction?
    var goToDetail: GoToDetail?

    func makeDetailViewController(viewModel: CharacterViewModel, router: DetailCoordinator) -> UIViewController {
        characterVM = viewModel
        self.router = router
        return viewControler1 ?? .init()
    }

    func makeCharactersViewController(switchAction: @escaping SwitchAction, goToDetail: @escaping GoToDetail) -> UIViewController {
        self.switchAction = switchAction
        self.goToDetail = goToDetail
        return viewControler2 ?? .init()
    }

    func makeCharactersViewController(viewModel: CharactersCollectionViewModel) -> UIViewController {
        charactersCVM = viewModel
        return viewControler3 ?? .init()
    }
}

final class CoordinatorSpy: NSObject, Coordinator{
    var startCalled: Bool?
    func start() {
        startCalled = true
    }
}

final class CoordinatorFactorySpy: CoordinatorFactory {
    var navControllers: [DSNavigationControllerProtocol?] = []
    var coordinatorSpy: CoordinatorSpy?
    var characterVM: CharacterViewModel?
    func makeApp(navController: DSNavigationControllerProtocol?) -> Coordinator {
        navControllers.append(navController)
        return coordinatorSpy ?? .init()
    }

    func makeMain(navController: DSNavigationControllerProtocol?) -> Coordinator {
        navControllers.append(navController)
        return coordinatorSpy ?? .init()
    }

    func makeDetail(navController: DSNavigationControllerProtocol?, viewModel: CharacterViewModel) -> Coordinator {
        characterVM = viewModel
        navControllers.append(navController)
        return coordinatorSpy ?? .init()
    }
}
