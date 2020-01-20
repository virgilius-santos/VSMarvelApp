//
//  DSColor.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit
import VCore

enum DSColor: CaseIterable {
    case primary, text, secondary
    
    var uiColor: UIColor {
        switch self {
        case .primary:
            return Asset.Colors.primary.color
        case .secondary:
            return Asset.Colors.secondary.color
        case .text:
            return Asset.Colors.text.color
        }
    }
}
