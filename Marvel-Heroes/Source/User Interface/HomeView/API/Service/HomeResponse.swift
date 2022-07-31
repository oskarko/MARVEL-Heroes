//
//  HomeResponse.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

struct HomeResponse: Codable {
    let status: String
    let copyright: String
    let attributionText: String
    let etag: String
    let data: MarvelResults<Character>

    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case attributionText
        case etag
        case data
    }
}
