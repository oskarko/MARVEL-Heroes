//
//  Thumbnail.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    let path: String?
    let fileExtension: Extension?

    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif
    case jpg
    case png

    var description: String {
        switch self {
        case .gif: return "gif"
        case .jpg: return "jpg"
        case .png: return "png"
        }
    }
}
