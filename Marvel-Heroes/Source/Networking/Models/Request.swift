//
//  Request.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum Request {
    case character(Int)
    case characters(Int, Int)
    case charactersByName(String, Int, Int)
}
