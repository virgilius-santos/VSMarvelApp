//
//  NavigationBarStyle.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

protocol NavigationBarStyleProtocol {
    
    func apply(style: NavigationBarStyle)
}

struct NavigationBarStyle {
    
    var titleColor: DSColor
    var backgroundColor: DSColor
    
    static let `default` = NavigationBarStyle(titleColor: .text,
                                              backgroundColor: .primary)
}

extension UIViewController: NavigationBarStyleProtocol {
    func apply(style: NavigationBarStyle) {
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = style.backgroundColor.uiColor
        navBar?.titleTextAttributes = [.foregroundColor: style.titleColor.uiColor]
    }
}
