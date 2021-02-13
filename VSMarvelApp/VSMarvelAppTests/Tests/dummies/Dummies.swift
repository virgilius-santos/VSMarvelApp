
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

final class CoordinatorSpy: NSObject, Coordinator{
    var startCalled: Bool?
    func start() {
        startCalled = true
    }
}

final class FactorySpy: AppFactory, MainFactory, CharactersFactory {
    var navControllers: [DSNavigationControllerProtocol?] = []
    var viewControllers: [UIViewController] = []
    var characterVMs: [CharacterViewModel] = []
    var coordinatorSpies: [CoordinatorSpy] = []
    var routers: [Coordinator?] = .init()
    var switchActions: [SwitchAction] = .init()
    var goToDetails: [GoToDetail] = .init()
    var charactersCVMs: [CharactersCollectionViewModel] = .init()

    lazy var detailFactory = DetailFactory(
        makeCoordinator: { [weak self] nav, vm in
            self?.characterVMs.append(vm)
            self?.navControllers.append(nav)
            self?.coordinatorSpies.append(.init())
            return self?.coordinatorSpies.last ?? .init()
        },
        makeViewController: { [weak self] coord, vm in
            self?.characterVMs.append(vm)
            self?.routers.append(coord)
            self?.viewControllers.append(.init())
            return self?.viewControllers.first ?? .init()
        }
    )

    func makeApp(navController: DSNavigationControllerProtocol?) -> Coordinator {
        navControllers.append(navController)
        coordinatorSpies.append(.init())
        return coordinatorSpies.last!
    }

    func makeMain(navController: DSNavigationControllerProtocol?) -> Coordinator {
        navControllers.append(navController)
        coordinatorSpies.append(.init())
        return coordinatorSpies.last!
    }

    func makeDetail(navController: DSNavigationControllerProtocol?, viewModel: CharacterViewModel) -> Coordinator {
        characterVMs.append(viewModel)
        navControllers.append(navController)
        coordinatorSpies.append(.init())
        return coordinatorSpies.last!
    }

    func makeDetail(viewModel: CharacterViewModel, router: DetailCoordinator) -> UIViewController {
        characterVMs.append(viewModel)
        routers.append(router)
        viewControllers.append(.init())
        return viewControllers.first!
    }

    func makeCharacters(switchAction: @escaping SwitchAction, goToDetail: @escaping GoToDetail) -> UIViewController {
        switchActions.append(switchAction)
        goToDetails.append(goToDetail)
        viewControllers.append(.init())
        return viewControllers.first!
    }

    func makeCharacters(viewModel: CharactersCollectionViewModel) -> UIViewController {
        charactersCVMs.append(viewModel)
        viewControllers.append(.init())
        return viewControllers.first!
    }
}
