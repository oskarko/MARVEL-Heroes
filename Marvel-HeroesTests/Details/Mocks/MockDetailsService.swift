//
//  MockDetailsService.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

@testable import Marvel_Heroes
import Foundation

class MockDetailsService: DetailsServiceProtocol {
    
    var characters = [Character]()
    var mockSuccess = true
    
    func fetch(_ request: DetailsRequest, completionHandler: @escaping (ResultResponse<DetailsResponse>) -> Void) {
        if mockSuccess {
            let response = DetailsResponse(status: "Mock status",
                                        copyright: "Mock copyright",
                                        attributionText: "Mock att",
                                        etag: "Mock etag",
                                        data: MarvelResults(items: characters))
            completionHandler(.success(response))
        } else {
            completionHandler(.failure(.init(code: "Mock code", message: "Mock Message")))
        }
    }
}

