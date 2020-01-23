//
//  CharacterListTableViewCell.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 21/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

final class DSCharacterListTableViewCell: DynamicView, DSCellStyleable {
    
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
            $0.top.bottom.leading.equalTo(self)
        }
        
        self.addSubview(dsLabel)
        dsLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalTo(self.self)
            $0.leading.equalTo(self.dsImageView.snp.trailing)
        }
    }
}
