
import Hero
import UIKit

protocol DSNavigationControllerProtocol: AnyObject {
    func navigate(to viewController: UIViewController, using type: DSNavigationType)
}

struct DSNavigationType {
    typealias NavigatorFunctions = ((UINavigationController?, UIViewController) -> Void)

    let completion: NavigatorFunctions

    static let push = DSNavigationType(completion: { nav, vc in
        nav?.pushViewController(vc, animated: true)
    })

    static let present = DSNavigationType(completion: { nav, vc in
        nav?.present(vc, animated: true, completion: nil)
    })

    static let replace = DSNavigationType(completion: { nav, vc in
        nav?.visibleViewController?.hero.replaceViewController(with: vc)
    })
}

final class DSNavigationController: DSNavigationControllerProtocol {
    typealias NavigationFunction = ((UIViewController) -> Void)

    weak var nav: UINavigationController?

    var isHeroEnabled: Bool = true {
        didSet {
            nav?.hero.isEnabled = isHeroEnabled
        }
    }

    init(nav: UINavigationController?) {
        self.nav = nav
        nav?.hero.isEnabled = true
    }

    func navigate(to viewController: UIViewController, using type: DSNavigationType) {
        type.completion(nav, viewController)
    }
}
