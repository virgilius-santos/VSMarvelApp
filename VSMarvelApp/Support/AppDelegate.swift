//
//  AppDelegate.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .red
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
