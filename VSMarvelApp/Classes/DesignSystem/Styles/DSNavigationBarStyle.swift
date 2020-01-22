//
//  NavigationBarStyle.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

struct DSNavigationBarStyle {
    
    var titleColor: DSColor
    var backgroundColor: DSColor
    
    static let `default` = DSNavigationBarStyle(titleColor: .text,
                                                backgroundColor: .primary)
}

extension DSNavigationBarStyleable where Self: UIViewController {
    
    func apply(style: DSNavigationBarStyle) {
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = style.backgroundColor.uiColor
        navBar?.titleTextAttributes = [.foregroundColor: style.titleColor.uiColor]
    }
}

extension DSNavigationBarConfigurable where Self: UIViewController {
    
    func configureRightButton(with icon: UIImage, target: Any, action: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon,
                                                            style: UIBarButtonItem.Style.plain,
                                                            target: target,
                                                            action: action)
    }
}
