
import Swinject
import UIKit

let appContainer = AppContainer.shared

final class AppContainer {
    static let shared: AppContainer = {
        $0
    }(AppContainer())

    let container: Container

    init(container: Container) {
        self.container = container
    }

    convenience init() {
        self.init(container: {
            $0.register(UIWindow.self, factory: { _ in
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.apply(style: .default)
                return window
            })

            $0.register(DetailFactory.self, factory: { _ in DetailFactory() })
            $0.register(CharactersFactory.self, factory: { _ in CharactersFactory() })

            return $0
        }(Container()))
    }

    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(type)!
    }

    func resolve<T, R>(_ type: T.Type, arg: R) -> T {
        container.resolve(type, argument: arg)!
    }
}
