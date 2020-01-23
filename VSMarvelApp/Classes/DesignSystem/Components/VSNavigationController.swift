//
//  VSNavigationController.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit
import Hero

protocol VSNavigationControllerProtocol {
    func navigate(to viewController: UIViewController, using type: NavigationType)
}

enum NavigationType {
    case push, present, replace
}

final class VSNavigationController: VSNavigationControllerProtocol {
    
    typealias NavigationFunction = ((UIViewController)->())
    
    weak var nav: UINavigationController?
    
    let navigationFunctions: [NavigationType: NavigationFunction]
    
    init(nav: UINavigationController?) {
        self.nav = nav
        navigationFunctions = [
            NavigationType.push: { [nav] vc in
                nav?.pushViewController(vc, animated: true)
            },
            NavigationType.present: { [nav] vc in
                nav?.present(vc, animated: true, completion: nil)
            },
            NavigationType.replace: { [nav] vc in
                nav?.visibleViewController?.hero.replaceViewController(with: vc)
            },
        ]
    }
    
    func navigate(to viewController: UIViewController, using type: NavigationType) {
        if let function = navigationFunctions[type] {
            function(viewController)
        }
    }
}
