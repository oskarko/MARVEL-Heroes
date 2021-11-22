//
//  mockNetworkService.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

@testable import Marvel_Heroes
import Foundation

class MockNetworkService: NetworkProtocol {
    
    var characters = [Character]()
    var mockSuccess = true
    
    func fetch<T>(ofType: Request, onComplete: @escaping (Result<T>) -> Void) where T : Decodable {
        if (T.self == MarvelData<Character>.self && mockSuccess == true) {
            let results = MarvelResults(items: characters)
            let data = MarvelData(data: results)
            onComplete(.success(data as! T))
        } else {
            let error = NSError(domain: "Testing error - Success? \(mockSuccess)", code: -1, userInfo: nil)
            onComplete(.fail(error))
        }
    }
}
