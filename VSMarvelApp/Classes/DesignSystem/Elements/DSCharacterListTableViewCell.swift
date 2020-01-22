//
//  CharacterListTableViewCell.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 21/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

final class DSCharacterListTableViewCell: UITableViewCell, DSCellStyleable {
    
    let dsLabel = UILabel()
    let dsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        common()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func common() {
        
        addCellSubViews()
    }
}
