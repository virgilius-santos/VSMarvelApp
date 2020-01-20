//
//  VSNavigationController.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

protocol VSNavigationControllerProtocol {
    func navigate(to viewController: UIViewController)
}

final class VSNavigationController: VSNavigationControllerProtocol {
    
    weak var nav: UINavigationController?
    
    init(nav: UINavigationController?) {
        self.nav = nav
    }
    
    func navigate(to viewController: UIViewController) {
        nav?.pushViewController(viewController, animated: true)
    }
}
