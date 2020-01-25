//
//  AppCoordinator.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    weak var navController: DSNavigationControllerProtocol?
    
    init(navController: DSNavigationControllerProtocol?) {
        self.navController = navController
    }
    
    func start() {
        let coord = MainCoordinator(navController: navController)
        coord.start()
    }
}
