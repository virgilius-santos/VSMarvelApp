//
//  AppCoordinator.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    var navController: VSNavigationControllerProtocol
    
    init(navController: VSNavigationControllerProtocol) {
        self.navController = navController
    }
    
    func start() {
        let vc = ViewController()
        self.navController.navigate(to: vc)
    }
}

class ViewController: UIViewController, DSNavigationBarStyleProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        apply(style: .default)
        selected = true
        title = "Character"
    }
    
    var selected: Bool = true {
        didSet {
            let icon = selected ? DSIcon.gridIcon : DSIcon.listIcon
            configureRightButton(with: icon, target: self, action: #selector(accessibilitytes))
        }
    }
    @objc func accessibilitytes() {
        selected.toggle()
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}
