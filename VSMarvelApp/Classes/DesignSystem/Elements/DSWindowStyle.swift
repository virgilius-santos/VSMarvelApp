//
//  DSWindowStyle.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit
import VCore

struct DSWindowStyle {
    var tintColor: DSColor
    var backgroundColor: DSColor
    
    static let `default` = DSWindowStyle(tintColor: DSColor.text,
                                         backgroundColor: DSColor.secondary)
}

extension WindowStyleProtocol where Self: UIApplicationDelegate {
    
    func apply(style: DSWindowStyle) {
        window?.backgroundColor = style.backgroundColor.uiColor
        window?.tintColor = style.tintColor.uiColor
    }
}
