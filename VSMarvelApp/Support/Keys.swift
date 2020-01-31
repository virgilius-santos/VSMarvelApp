//
//  Keys.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import CryptoSwift
import Foundation
import Keys

private let keys = VSMarvelAppKeys()

enum ApiKeys {
    static let marvelApiKey = keys.marvelApiKey
    static let marvelPrivateKey = keys.marvelPrivateKey
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(marvelPrivateKey)\(marvelApiKey)".md5()
}
