//
//  DSCellStyle.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

struct DSCellStyle {
    
    var titleColor: DSColor
    var titleBackgroundColor: DSColor
    var titleBackgroundAlpha: DSAlpha
    var cornerRadius: DSRadius
    var shadow: DSShadow
    
    static let `default` = DSCellStyle(titleColor: DSColor.text,
                                       titleBackgroundColor: DSColor.secondary,
                                       titleBackgroundAlpha: DSAlpha.medium,
                                       cornerRadius: DSRadius.medium,
                                       shadow: DSShadow.zero)
}

extension DSCellStyleable where Self: UICollectionViewCell {
    
    func apply(style: DSCellStyle) {
        apply(shadow: style.shadow)
        apply(style: style, in: dsLabel)
        layer.cornerRadius = style.cornerRadius.value
    }
    
    func apply(shadow: DSShadow) {
        layer.shadowColor = shadow.shadowColor.uiColor.cgColor
        layer.shadowOpacity = Float(shadow.shadowOpacity.value)
        layer.shadowOffset = .zero
        layer.shadowRadius = shadow.shadowRadius.value
    }
    
    func apply(style: DSCellStyle, in label: UILabel) {
        dsLabel.tintColor = style.titleColor.uiColor
        dsLabel.backgroundColor = style.titleBackgroundColor.uiColor
        dsLabel.alpha = style.titleBackgroundAlpha.value
    }
}
