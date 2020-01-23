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
    func navigate(to viewController: UIViewController, using type: NavigationTypes)
}

enum NavigationTypes {
    case push, present, replace
}

final class VSNavigationController: VSNavigationControllerProtocol {
    
    typealias NavigationFunction = ((UIViewController)->())
    
    weak var nav: UINavigationController?
    
    let navigationFunctions: [NavigationTypes: NavigationFunction]
    
    init(nav: UINavigationController?) {
        self.nav = nav
        navigationFunctions = [
            NavigationTypes.push: { [nav] vc in
                nav?.pushViewController(vc, animated: true)
            },
            NavigationTypes.present: { [nav] vc in
                nav?.present(vc, animated: true, completion: nil)
            },
            NavigationTypes.present: { [nav] vc in
                nav?.visibleViewController?.hero.replaceViewController(with: vc)
            },
        ]
    }
    
    func navigate(to viewController: UIViewController, using type: NavigationTypes) {
        if let function = navigationFunctions[type] {
            function(viewController)
        }
    }
}
