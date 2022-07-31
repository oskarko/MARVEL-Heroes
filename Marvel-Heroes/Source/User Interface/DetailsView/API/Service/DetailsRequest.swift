//
//  DetailsRequest.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum DetailsRequest {
    case character(_ model: DetailsRequestModel?)
}

extension DetailsRequest: APIRequest {

    var path: APIPath {
        switch self {
        case let .character(model): return .character(characterID: model?.ID ?? "")
        }
    }

    var method: HTTPMethod {
        switch self {
        case .character: return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .character:
                return [URLQueryItem(name: "apikey", value: PUBLIC_KEY),
                        URLQueryItem(name: "hash", value: hash),
                        URLQueryItem(name: "ts", value: TIMESTAMP)]
        }
    }
}
