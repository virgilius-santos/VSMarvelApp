//
//  DSNavigationBarStyleProtocol.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation

protocol DSNavigationBarStyleable {
    associatedtype Style
    func apply(style: Style)
}

protocol DSNavigationBarConfigurable {
    associatedtype Image
    func configureRightButton(with icon: Image, target: Any, action: Selector)
}
