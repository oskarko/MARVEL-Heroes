//
//  HomeRequest.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum HomeRequest {
    case characters(_ model: HomeRequestModel?)
}

extension HomeRequest: APIRequest {

    var path: APIPath {
        switch self {
        case .characters: return .characters
        }
    }

    var method: HTTPMethod {
        switch self {
        case .characters: return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .characters(model):
                return [URLQueryItem(name: "apikey", value: PUBLIC_KEY),
                        URLQueryItem(name: "hash", value: hash),
                        URLQueryItem(name: "ts", value: TIMESTAMP),
                        URLQueryItem(name: "offset", value: model?.offset ?? ""),
                        URLQueryItem(name: "limit", value: model?.limit ?? "")]
        }
    }
}
