//
//  DSNavigationBarStyleProtocol.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation

protocol DSNavigationBarStyleProtocol {
    
    associatedtype Style
    associatedtype Image
    
    func apply(style: Style)
    func configureRightButton(with icon: Image, target: Any, action: Selector)
}
