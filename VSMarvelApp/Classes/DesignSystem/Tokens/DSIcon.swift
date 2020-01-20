//
//  DSIcon.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

enum DSIcon: CaseIterable {
    case gridIcon, listIcon
    
    var uiImage: UIImage {
        switch self {
        case .listIcon:
            return Asset.Images.listIcon.image
        case .gridIcon:
            return Asset.Images.gridIcon.image
        }
    }
}
