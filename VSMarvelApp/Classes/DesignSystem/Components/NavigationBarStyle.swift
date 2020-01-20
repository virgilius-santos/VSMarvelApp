//
//  NavigationBarStyle.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

protocol NavigationBarStyleProtocol {
    
    associatedtype Style
    associatedtype Image
    associatedtype Color
    
    func apply(style: Style)
    func configureRightButton(with icon: Image, tint: Color, target: Any, action: Selector)
}

struct NavigationBarStyle {
    
    var titleColor: DSColor
    var backgroundColor: DSColor
    
    static let `default` = NavigationBarStyle(titleColor: .text,
                                              backgroundColor: .primary)
}

extension NavigationBarStyleProtocol where Self: UIViewController {
    
    func apply(style: NavigationBarStyle) {
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = style.backgroundColor.uiColor
        navBar?.titleTextAttributes = [.foregroundColor: style.titleColor.uiColor]
    }
    
    func configureRightButton(with icon: DSIcon, tint: DSColor, target: Any, action: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon.uiImage,
                                                            style: UIBarButtonItem.Style.plain,
                                                            target: target,
                                                            action: action)
    }
}

extension UINavigationItem {
    func configureRightBarButtonItem(with icon: DSIcon,
                                 target: Any,
                                 action: Selector) {
                
        
    }
}
