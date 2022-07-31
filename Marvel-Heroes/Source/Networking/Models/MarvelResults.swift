//
//  MarvelResults.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

struct MarvelResults<T: Codable>: Codable {
    let items: [T]

    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}
