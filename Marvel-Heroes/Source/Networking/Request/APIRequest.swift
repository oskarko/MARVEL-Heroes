//
//  APIRequest.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

protocol APIRequest {
    var url: URL? { get }
    var path: APIPath { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var params: Any? { get }
    var timeoutInterval: TimeInterval { get }
    var hash: String { get }
}

extension APIRequest {
    
    // Default values
    
    var url: URL? { nil }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var params: Any? { nil }
    
    var timeoutInterval: TimeInterval { 10.0 }
    
    var hash: String {
        let combined = "\(TIMESTAMP)\(PRIVATE_KEY)\(PUBLIC_KEY)"
        let md5Hex =  combined.MD5Hash()

        return md5Hex
    }
}
