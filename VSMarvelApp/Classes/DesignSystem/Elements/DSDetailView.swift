//
//  DSDetailView.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 20/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit
import SnapKit

final class DSDetailView: UIView {
    
    let scroll = UIScrollView()
    let contentView = UIView()
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    
    func setup() {
        
        Scroll: do {
            addSubview(scroll)
            scroll.snp.makeConstraints {
                $0.edges.equalTo(self.safeAreaLayoutGuide)
            }
        }
        
        Content: do {
            scroll.addSubview(contentView)
            contentView.snp.makeConstraints {
                $0.edges.equalTo(self.scroll)
                $0.width.equalTo(self.scroll)
                $0.height.equalTo(self).priority(.medium)
            }
        }

        Image: do {
            contentView.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            imageView.snp.makeConstraints {
                $0.top.leading.trailing.equalTo(self.contentView)
                $0.height.equalTo(self.imageView.snp.width)
            }
        }
        
        Label: do {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.adjustsFontForContentSizeCategory = true
            contentView.addSubview(descriptionLabel)
            
            descriptionLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(DSSpacing.medium.value)
                $0.bottom.leading.trailing.equalTo(self.contentView)
            }
        }
    }

}
