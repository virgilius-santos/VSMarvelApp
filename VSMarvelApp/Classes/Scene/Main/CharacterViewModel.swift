//
//  CharacterViewModel.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 26/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation


struct CharacterViewModel {
    var name: String { character.name }
    var path: String { "\(character.thumImage.path)/portrait_xlarge.\(character.thumImage.extension)"  }
    var style: DSCellStyle { DSCellStyle.default }
    var bio: String { character.bio }
    
    let character: Character
    
    init(character: Character) {
        self.character = character
    }
}

extension CharacterViewModel {
    var asset: DSAsset { return DSImage.placeholder }
}
