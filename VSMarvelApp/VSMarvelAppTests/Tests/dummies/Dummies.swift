
import UIKit
import VService
@testable import VSMarvelApp

final class DSNavigationControllerSpy: NSObject, DSNavigationControllerProtocol {
    var viewController: UIViewController?
    var type: DSNavigationType?

    func navigate(to viewController: UIViewController, using type: DSNavigationType) {
        self.viewController = viewController
        self.type = type
    }
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
