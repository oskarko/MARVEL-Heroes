//
//  HomeRequestModel.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

struct HomeRequestModel: Codable {
    let limit: String
    let offset: String

    enum CodingKeys: String, CodingKey {
        case limit
        case offset
    }
}
