//
//  MockHomeService.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

@testable import Marvel_Heroes
import Foundation

class MockHomeService: HomeServiceProtocol {
    
    var characters = [Character]()
    var mockSuccess = true
    
    func fetch(_ request: HomeRequest, completionHandler: @escaping (ResultResponse<HomeResponse>) -> Void) {
        if mockSuccess {
            let response = HomeResponse(status: "Mock status",
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
