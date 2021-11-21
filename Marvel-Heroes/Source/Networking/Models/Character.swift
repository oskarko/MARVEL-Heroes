//
//  Character.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int
    let digitalID: Int?
    let name: String?
    let description: String?
    let title: String?
    let thumbnail: Thumbnail?

    enum CodingKeys: String, CodingKey {
        case digitalID = "digitalId"
        case description
        case id
        case name
        case title
        case thumbnail
    }
    
    init(id: Int, digitalID: Int?, name: String?, description: String?, title: String?, thumbnail: Thumbnail?) {
        self.id = id
        self.digitalID = digitalID
        self.name = name
        self.description = description
        self.title = title
        self.thumbnail = thumbnail
    }
}
