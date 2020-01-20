//
//  AppDelegate.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit
import VCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WindowStyleProtocol {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let nav = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        apply(style: .default)

        let navController = VSNavigationController(nav: nav)
        let coordinator = AppCoordinator(navController: navController)
        coordinator.start()
        
        return true
    }
}
