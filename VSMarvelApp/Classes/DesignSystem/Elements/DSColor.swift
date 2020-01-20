//
//  DSColor.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

enum DSColor: CaseIterable {
    case primary, text, secondary
    
    var uiColor: UIColor {
        switch self {
        case .primary:
            return UIColor(red: 232, green: 72, blue: 85, alpha: 1)
        case .secondary:
            return UIColor(red: 64, green: 63, blue: 76, alpha: 1)
        case .text:
            return UIColor(red: 255, green: 252, blue: 249, alpha: 1)
        }
    }
}
