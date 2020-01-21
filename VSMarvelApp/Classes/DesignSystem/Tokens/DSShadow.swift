//
//  DSShadow.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

struct DSShadow {
    var shadowColor: DSColor
    var shadowOpacity: DSAlpha
    var shadowRadius: DSRadius
    
    static var zero = DSShadow(shadowColor: DSColor.secondary,
                               shadowOpacity: DSAlpha.zero,
                               shadowRadius: DSRadius.high)
}
