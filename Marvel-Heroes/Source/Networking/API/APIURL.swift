//
//  APIURL.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum APIURL: String {
    #if DEBUG
    case baseURL = "https://gateway.marvel.com/"
    #else
    case baseURL = "https://gateway.marvel.com/"
    #endif

    var convertedURL: URL {
        guard let url = URL(string: rawValue) else {
            assertionFailure("Incorrect format of URL")
            return URL(string: "")!
        }
        
        return url
    }
}
