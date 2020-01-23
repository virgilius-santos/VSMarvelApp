//
//  CharacterGridCollectionViewCell.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 21/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit
import YetAnotherAnimationLibrary

final class DSCharacterGridCollectionViewCell: DynamicView, DSCellStyleable {
    
    let dsLabel = UILabel()
    let dsImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        common()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func common() {
        
        addCellSubViews()
    }
    
    func addCellSubViews() {
        self.addSubview(dsImageView)
        dsImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        self.addSubview(dsLabel)
        dsLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(self)
            $0.top.equalTo(self).inset(150)
        }
    }
}
