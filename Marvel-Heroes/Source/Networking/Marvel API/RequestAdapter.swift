//
//  RequestAdapter.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation
import UIKit

class RequestAdapter {
    static func request<T: Decodable>(_ url: URL, _ onComplete: @escaping (Result<T>) -> Void) {

        let session = URLSession(configuration: URLSessionConfiguration.default)

        let task = session.dataTask(with: url) { (data, _, requestError) in

            if let requestError = requestError {
                return onComplete(.fail(requestError))
            }
            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                onComplete(.success(response))
            } catch {
                onComplete(.fail(error))
            }
        }
        task.resume()
    }
}
