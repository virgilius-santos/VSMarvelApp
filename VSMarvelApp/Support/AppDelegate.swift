//
//  AppDelegate.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit
import VCore
import Hero

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WindowStyleable {
    var window: UIWindow?
    var navController: DSNavigationController?
    var coordinator: AppCoordinator?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        Hero.shared.containerColor = DSColor.secondary.uiColor
        
        let nav = UINavigationController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = nav
        
        applyWindow(style: .default, in: window)

        let navController = DSNavigationController(nav: nav)
        let coordinator = AppCoordinator(navController: navController)
        
        self.window = window
        self.navController = navController
        self.coordinator = coordinator
        
        coordinator.start()
        window.makeKeyAndVisible()
        
        return true
    }
}
