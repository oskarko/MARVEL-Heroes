//
//  APIPath.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum APIPath {
    case characters
    case character(characterID: String)
    
    var rawValue: String {
        switch self {
        case .characters: return "/v1/public/characters"
        case let .character(characterID): return "/v1/public/characters/\(characterID)"
        }
    }
}
