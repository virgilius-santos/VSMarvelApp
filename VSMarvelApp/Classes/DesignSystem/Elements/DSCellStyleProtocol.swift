//
//  DSCellStyle.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

protocol DSCellStyleProtocol {
    
    associatedtype Style
    
    var dsLabel: UILabel { get }
    var dsImageView: UIImageView { get }
    
    func apply(style: Style)
}
