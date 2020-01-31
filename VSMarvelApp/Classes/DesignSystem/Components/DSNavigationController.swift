
import Hero
import UIKit

protocol DSNavigationControllerProtocol: AnyObject {
    func navigate(to viewController: UIViewController, using type: DSNavigationType)
}

enum DSNavigationType {
    case push, present, replace
}

final class DSNavigationController: DSNavigationControllerProtocol {
    typealias NavigationFunction = ((UIViewController) -> Void)

    weak var nav: UINavigationController?

    var isHeroEnabled: Bool = true {
        didSet {
            nav?.hero.isEnabled = isHeroEnabled
        }
    }

    let navigationFunctions: [DSNavigationType: NavigationFunction]

    init(nav: UINavigationController?) {
        self.nav = nav
        nav?.hero.isEnabled = true

        navigationFunctions = [
            DSNavigationType.push: { [nav] vc in
                nav?.pushViewController(vc, animated: true)
            },
            DSNavigationType.present: { [nav] vc in
                nav?.present(vc, animated: true, completion: nil)
            },
            DSNavigationType.replace: { [nav] vc in
                nav?.visibleViewController?.hero.replaceViewController(with: vc)
            },
        ]
    }

    func navigate(to viewController: UIViewController, using type: DSNavigationType) {
        if let function = navigationFunctions[type] {
            function(viewController)
        }
    }
}
